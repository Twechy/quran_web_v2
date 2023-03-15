import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quran_web_v2/pages/readingViewer.dart';
import 'package:quran_web_v2/pages/surahDescription.dart';
import 'package:quran_web_v2/pages/surahViewer.dart';

import '../models/index.dart';
import '../services/blocs/surahBloc.dart';
import '../services/providers/rewahaProvider.dart';
import '../utils/index.dart';
import '../widgets/surahNameDrawer.dart';

class ViewerPage extends ConsumerStatefulWidget {
  const ViewerPage({super.key});

  @override
  ViewerPageState createState() => ViewerPageState();
}

class ViewerPageState extends ConsumerState<ViewerPage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<ViewerPage> {
  bool searchEnabled = true;
  late SurahBloc _surahBloc;
  RawySurahVm _selectedSurah = RawySurahVm(
    id: 1,
    order: 1,
    name: 'الفاتحة',
    landing: '',
    description: '',
    quranRewat: QuranRewat(
      qalon: [],
      hafs: [],
      wersh: [],
      alBozy: [],
    ),
  );
  late TabController _tabController;
  SearchItemVm _currentSearchedAya = SearchItemVm(
    mostSurahOccuredIn: '',
    mostSurahOccuredInId: 0,
    numberOfSurahOccured: 0,
    searcheAyat: [],
    secondMostSurahOccuredIn: '',
    secondMostSurahOccuredInId: 0,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tabController = TabController(initialIndex: 0, length: 4, vsync: this);
    _surahBloc = ref.read(surahBlocProvider);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<RawySurahVm>(
        stream: _surahBloc.selectedSurah$,
        builder: (context, AsyncSnapshot<RawySurahVm> snapshot) {
          var hasData = snapshot.connectionState == ConnectionState.active;
          RawySurahVm? data = hasData ? snapshot.data : null;

          if (!hasData || data == null)
            return const Center(child: CircularProgressIndicator());

          _selectedSurah = data;

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: _appBar(),
              drawer: Drawer(child: _surahNameBuilder()),
              body: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  _surahViewer(),
                  _readingViewer(),
                  SurahDescription(
                    surahDescriptionVm: SurahDescriptionVm(
                      _selectedSurah.order,
                      _selectedSurah.name,
                      _selectedSurah.description,
                      _selectedSurah.landing,
                    ),
                  ),
                  const Text(
                    " TabBarView placeholder 3",
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w200,
                      fontFamily: "Roboto",
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.4,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppConst.secondaryColor),
      title: searchEnabled
          ? Text(
              'القرأن الكريم',
              style: textStyle(
                textType: TextType.text,
                color: AppConst.mainColor,
                // fontFamily: _viewState.fontFamily,
                fontSize: 28.0,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: _buildTypeAheadField(),
            ),
      bottom: TabBar(
        indicatorColor: AppConst.secondaryColor,
        controller: _tabController,
        tabs: <Widget>[
          Text(
            "قراءة السورة",
            style: textStyle(
              textType: TextType.text,
              color: AppConst.mainColor,
              // fontFamily: _viewState.fontFamily,
              fontSize: 20.0,
            ),
          ),
          Text(
            "عرض القراءات",
            style: textStyle(
              textType: TextType.text,
              color: AppConst.mainColor,
              // fontFamily: _viewState.fontFamily,
              fontSize: 20.0,
            ),
          ),
          Text(
            "بيانات السورة",
            style: textStyle(
              textType: TextType.text,
              color: AppConst.mainColor,
              // fontFamily: _viewState.fontFamily,
              fontSize: 20.0,
            ),
          ),
          Text(
            "تعديل في الأيات",
            style: textStyle(
              textType: TextType.text,
              color: AppConst.mainColor,
              // fontFamily: _viewState.fontFamily,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(searchEnabled ? Icons.search : Icons.close),
          color:
              searchEnabled ? AppConst.mainColor : AppConst.secondaryRedColor,
          onPressed: () {
            setState(() {
              if (!searchEnabled) {
                searchEnabled = true;
              } else {
                searchEnabled = false;
              }
            });
          },
        ),
        // IconButton(
        //   icon: const Icon(Icons.more_vert),
        //   color: AppConst.secondaryColor,
        //   onPressed: () {
        //     showDialog(
        //       context: context,
        //       builder: (context) => ViewSettingDialog(
        //         settings: defaultSetting,
        //         readers: [],
        //         rewayat: [],
        //       ),
        //     );
        //   },
        // ),
      ],
    );
  }

  Widget _buildTypeAheadField() {
    return TypeAheadField<SearchedAyat>(
      textFieldConfiguration: TextFieldConfiguration(
        autofocus: true,
        textDirection: TextDirection.rtl,
        style: textStyle(
          textType: TextType.text,
          fontSize: 18.0,
          color: AppConst.mainColor,
        ),
      ),
      noItemsFoundBuilder: (context) => Text(
        'لا يوجد إيات!!!',
        style: textStyle(
          textType: TextType.text,
          fontSize: 18.0,
          color: AppConst.secondaryRedColor,
        ),
      ),
      errorBuilder: (context, error) {
        return Text(
          'حدث خطأ أثناء البحث!!',
          style: textStyle(
            textType: TextType.text,
            fontSize: 18.0,
            color: AppConst.secondaryRedColor,
          ),
        );
      },
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        shape: const RoundedRectangleBorder(),
        borderRadius: BorderRadius.circular(20.0),
      ),
      suggestionsCallback: (pattern) async {
        final searchedAyat = await searchAyatExtractor(pattern: pattern);

        return searchedAyat.searcheAyat;
      },
      itemBuilder: (context, SearchedAyat suggestion) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: ListTile(
            trailing: Container(
              width: 100.0,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border(
                  left: BorderSide(color: AppConst.secondaryColor, width: 1.0),
                ),
                shape: BoxShape.rectangle,
                backgroundBlendMode: BlendMode.hue,
                color: Colors.black,
              ),
              child: Row(
                textDirection: TextDirection.ltr,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () async =>
                        await FlutterClipboard.copy(suggestion.ayaText),
                    icon: Icon(
                      Icons.copy,
                      color: AppConst.secondaryColor,
                      size: 20.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                      color: AppConst.secondaryRedColor,
                      size: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                suggestion.ayaText,
                style: textStyle(
                  textType: TextType.text,
                  fontSize: 20.0,
                  color: AppConst.mainColor,
                ),
              ),
            ),
            leading: _buildAyaDescription(suggestion),
          ),
        );
      },
      onSuggestionSelected: (suggestion) {},
      autoFlipDirection: true,
      direction: AxisDirection.down,
      hideOnEmpty: true,
      hideOnLoading: true,
    );
  }

  Future<SearchItemVm> searchAyatExtractor(
      {required String pattern, int rawy = 32768}) async {
    _currentSearchedAya = await _surahBloc.searchAyat(pattern, rawy);
    return _currentSearchedAya;
  }

  Widget _buildAyaDescription(SearchedAyat suggestion) {
    return Container(
      width: 175.0,
      margin: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border(
            left: BorderSide(color: AppConst.secondaryColor, width: 1.0),
          ),
          shape: BoxShape.rectangle,
          backgroundBlendMode: BlendMode.hue,
          color: Colors.black),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${suggestion.surahOrder}-${suggestion.surahName}',
                textAlign: TextAlign.start,
                style: textStyle(
                  textType: TextType.text,
                  fontSize: 11.0,
                  color: AppConst.mainColor,
                  fontFamily: ArabicFonts.Cairo,
                ),
              ),
              // SizedBox(width: 4.0),
              Text(
                'الأية-${suggestion.ayaNumber}',
                textAlign: TextAlign.start,
                style: textStyle(
                  textType: TextType.text,
                  fontSize: 11.0,
                  color: AppConst.mainColor,
                  fontFamily: ArabicFonts.Cairo,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'عدد الكلمات-${suggestion.wordCount}',
                textAlign: TextAlign.start,
                style: textStyle(
                  textType: TextType.text,
                  fontSize: 11.0,
                  color: AppConst.mainColor,
                  fontFamily: ArabicFonts.Cairo,
                ),
              ),
              // SizedBox(width: 4.0),
              Text(
                'عدد الحروف-${suggestion.letterCount}',
                textAlign: TextAlign.start,
                style: textStyle(
                  textType: TextType.text,
                  fontSize: 11.0,
                  color: AppConst.mainColor,
                  fontFamily: ArabicFonts.Cairo,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _surahNameBuilder() {
    return StreamBuilder<List<SurahNamesVm>>(
      stream: _surahBloc.surahNames$,
      builder: (context, snapshot) {
        final List<SurahNamesVm>? names = snapshot.hasData ? snapshot.data : [];
        return Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.rectangle,
          ),
          child: SurahNameItem(
            surahName: names!,
            selectedSurahOrder: _selectedSurah.order,
            callbackAction: (SurahNamesVm selectedSurah) async {
              await _surahBloc.handleSelectedSurah(selectedSurah.order);
              await Future.delayed(
                const Duration(milliseconds: 500),
                () => Navigator.of(context).pop(),
              );
              // setState(() {});
            },
          ),
        );
      },
    );
  }

  Widget _surahViewer() {
    return StreamBuilder<AyahVmWithFont>(
      stream: _surahBloc.selectedAyat$,
      builder: (context, snapshot) {
        var hasData = snapshot.connectionState == ConnectionState.active;
        var ayatList = hasData ? snapshot.data : null;

        if (!hasData && ayatList == null)
          return const Center(child: CircularProgressIndicator());

        return _buildRewayaProvider(ayatList!);
      },
    );
  }

  Widget _buildRewayaProvider(AyahVmWithFont ayat) {
    return ref.watch(rewayatData).when(
          data: (List<RewayaVm> rewayat) {
            return SurahViewer(
              key: UniqueKey(),
              surah: _selectedSurah,
              ayat: ayat.ayat,
              keys: ayatKeys(ayat.ayat),
              rewayat: rewayat,
              fontFamily: ayat.fontFamily,
            );
          },
          loading: () => const Center(
              child: CircularProgressIndicator(
            color: Colors.red,
          )),
          error: (error, stackTrace) => Center(child: Text(error.toString())),
        );
  }

  Widget _readingViewer() {
    return StreamBuilder<List<ReadingVm>>(
      stream: _surahBloc.selectedReadings$,
      builder: (context, snapshot) {
        var hasData = snapshot.connectionState == ConnectionState.active;
        List<ReadingVm>? readings = hasData ? snapshot.data : [];

        if (!hasData && readings == null)
          return const Center(child: CircularProgressIndicator());

        return ReadingViewer(readings: readings!);
      },
    );
  }

  List<KeyMapper> ayatKeys(List<AyahVm> ayat) {
    List<KeyMapper> keys = [];
    for (var i = 0; i < ayat.length; i++) {
      keys.add(KeyMapper(ayat[i].ayaNumber, GlobalKey()));
    }
    return keys;
  }

  @override
  bool get wantKeepAlive => true;
}
