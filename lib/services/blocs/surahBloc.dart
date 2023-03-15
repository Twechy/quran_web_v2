import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/index.dart';
import '../http/clients.dart';

final surahBlocProvider = Provider.autoDispose<SurahBloc>((ref) {
  ref.keepAlive();

  return SurahBloc();
});

class SurahBloc {
  final CompositeSubscription _subscription = CompositeSubscription();
  final SurasClient _surasClient = SurasClient();

  Future suras() async {
    final subscription = Stream.fromFuture(_surasClient.suras())
        .listen((List<RawySurahVm> data) {
      _suras.add(data);
      final fateha = data[0];
      _selectedSurah.add(fateha);

      final selectedAyat = _handleViewSettingChange(
        fateha.quranRewat,
        Rewayat.hafs,
      );

      _selectedAyat.add(AyahVmWithFont(
        ayat: fateha.quranRewat.hafs,
        fontFamily: 'hafs',
      ));

      _selectedReadings.add(_getReadings(selectedAyat));
    });

    _subscription.add(subscription);
  }

  void getRewayat() {
    final subscription = Stream.fromFuture(_surasClient.rewayat())
        .listen((List<RewayaVm> data) => _rewayat.add(data));

    _subscription.add(subscription);
  }

  void surahNames() {
    final subscription = Stream.fromFuture(_surasClient.surahNames())
        .listen((List<SurahNamesVm> data) {
      _surahNames.add(data);
    });
    _subscription.add(subscription);
  }

  Future<OperationResult> updateReading(
          UpdateReadingDto updateReadingDto) async =>
      await _surasClient.updateReading(updateReadingDto);

  String _parseFontFamily(int selectedRewaya) {
    switch (selectedRewaya) {
      case 32768:
        return 'hafs';
      case 131072:
        return 'qalon';
      case 262144:
        return 'wersh';
      case 524288:
        return 'alBozy';
      default:
        return 'qalon';
    }
  }

  Future handleRewayaChange({Rewayat rewaya = Rewayat.qalon}) async {
    var ayat = <AyahVm>[];

    final selectedSurah = getSurah(_selectedSurah.value.order);

    final selectedRewaya = getRewaya(rewaya);

    final fontFamily = _parseFontFamily(RewayaVm.parseRewayaToInt(rewaya));

    _selectedRewayat.add(selectedRewaya);

    switch (rewaya) {
      case Rewayat.hafs:
        ayat = selectedSurah.quranRewat.hafs;
        break;
      case Rewayat.qalon:
        ayat = selectedSurah.quranRewat.qalon;
        break;
      case Rewayat.werch:
        ayat = selectedSurah.quranRewat.wersh;
        break;
      case Rewayat.albozy:
        ayat = selectedSurah.quranRewat.alBozy;
        break;
    }

    _selectedReadings.add(_getReadings(ayat));
    _selectedAyat.add(AyahVmWithFont(ayat: ayat, fontFamily: fontFamily));
  }

  RewayaVm getRewaya(Rewayat selectedRewaya) {
    var rewayat = _rewayat.value ?? [];

    if (rewayat.isNotEmpty) {
      var rewaya =
          rewayat.firstWhere((element) => element.read == selectedRewaya);
      return rewaya;
    }

    return null!;
  }

  RawySurahVm getSurah(int surahOrder) {
    var suras = _suras.value ?? [];

    if (suras.isNotEmpty) {
      var surah = suras.firstWhere((element) => element.order == surahOrder);
      return surah;
    }

    return null!;
  }

  List<AyahVm> _handleViewSettingChange(
      QuranRewat quranRewat, Rewayat rewayat) {
    switch (rewayat) {
      case Rewayat.hafs:
        return quranRewat.hafs;
      case Rewayat.qalon:
        return quranRewat.qalon;
      case Rewayat.werch:
        return quranRewat.wersh;
      case Rewayat.albozy:
        return quranRewat.alBozy;
      default:
        return quranRewat.hafs;
    }
  }

  Future<RawySurahVm> handleSelectedSurah(int surahOrder,
      {Rewayat rewaya = Rewayat.hafs}) async {
    final surah = getSurah(surahOrder);
    _selectedSurah.add(surah);
    await handleRewayaChange(rewaya: rewaya);
    return surah;
  }

  List<ReadingVm> _getReadings(List<AyahVm> ayat) {
    final readings = <ReadingVm>[];
    for (final aya in ayat) {
      if (aya.readings.isNotEmpty) readings.addAll(aya.readings);
    }
    return readings;
  }

  void dispose() {
    _subscription.clear();
    _suras.close();
    _selectedSurah.close();
    _selectedAyat.close();
    _rewayat.close();
    _selectedRewayat.close();
    _selectedReadings.close();
  }

  final _surahNames = BehaviorSubject<List<SurahNamesVm>>.seeded([]);

  Stream<List<SurahNamesVm>> get surahNames$ => _surahNames.stream;

  final _suras = BehaviorSubject<List<RawySurahVm>>.seeded([]);

  Stream<List<RawySurahVm>> get suras$ => _suras.stream;

  final _selectedSurah = BehaviorSubject<RawySurahVm>.seeded(RawySurahVm(
    id: 1,
    order: 1,
    name: 'الفاتحة',
    landing: 'مكية',
    description: 'فاتحة الكتاب',
    quranRewat: QuranRewat(
      qalon: [],
      hafs: [],
      wersh: [],
      alBozy: [],
    ),
  ));

  Stream<RawySurahVm> get selectedSurah$ => _selectedSurah.stream;

  final _rewayat = BehaviorSubject<List<RewayaVm>>.seeded([]);

  Stream<List<RewayaVm>> get rewayat$ => _rewayat.stream;

  final _selectedRewayat = BehaviorSubject<RewayaVm>();

  Stream<RewayaVm> get selectedRewaya$ => _selectedRewayat.stream;

  final _selectedAyat = BehaviorSubject<AyahVmWithFont>();

  Stream<AyahVmWithFont> get selectedAyat$ => _selectedAyat.stream;

  final _selectedReadings = BehaviorSubject<List<ReadingVm>>();

  Stream<List<ReadingVm>> get selectedReadings$ => _selectedReadings.stream;

  Future<SearchItemVm> searchAyat(String searchTerm, int rawy) async =>
      await _surasClient.search(
        term: searchTerm,
        rawy: rawy,
      );
}

class AyahVmWithFont {
  final List<AyahVm> ayat;
  final String fontFamily;

  const AyahVmWithFont({
    required this.ayat,
    required this.fontFamily,
  });
}
