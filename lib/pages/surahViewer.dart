import 'dart:math';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menu_button/menu_button.dart';

import '../models/index.dart';
import '../models/tartel/tartelVm.dart';
import '../services/blocs/surahBloc.dart';
import '../utils/index.dart';
import '../widgets/readingViewDialog.dart';

class KeyMapper {
  final int ayaNumber;
  final GlobalKey<State<StatefulWidget>> keys;

  KeyMapper(
    this.ayaNumber,
    this.keys,
  );
}

class SurahViewer extends ConsumerStatefulWidget {
  final List<AyahVm> ayat;
  final RawySurahVm surah;
  final List<RewayaVm> rewayat;
  final String fontFamily;
  final List<KeyMapper> keys;

  const SurahViewer({
    super.key,
    required this.ayat,
    required this.surah,
    required this.keys,
    required this.rewayat,
    required this.fontFamily,
  });

  @override
  SurahViewerState createState() => SurahViewerState();
}

class SurahViewerState extends ConsumerState<SurahViewer> {
  late SurahBloc _surahBloc;
  late List<Ayat> _highLightedAyat;
  late Reader _currentReader;
  late RewayaVm _selectedRewaya;
  late List<Reader> _readers;

  String get _fontFamily => widget.fontFamily;

  bool get _hasMore => _highLightedAyat.length > 1;
  bool _highLighterActive = false;

  @override
  void initState() {
    super.initState();
    _selectedRewaya = widget.rewayat.first;
    _readers = _selectedRewaya.readers;
    _currentReader = _selectedRewaya.readers.first;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _surahBloc = ref.read(surahBlocProvider);
    PopupMenu.context = context;
    _highLightedAyat = [];
  }

  @override
  void dispose() {
    _resetHighLightedAya();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Scaffold(
        appBar: AppBar(
          title: _buildSurahName(),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: AppConst.secondaryColor),
        ),
        body: _buildSurahViewer(),
      ),
    );
  }

  Widget _buildSurahViewer() {
    final hasStart =
        (_selectedRewaya.read == Rewayat.hafs && widget.surah.order == 1) ||
            widget.surah.order == 9;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          hasStart
              ? const SizedBox()
              : Text(
                  'بسم الله الرحمن الرحيم',
                  style: textStyle(
                    textType: TextType.text,
                    // fontFamily: _viewState.fontFamily,
                    fontSize: 32.0,
                  ),
                ),
          Padding(
            padding: EdgeInsets.only(top: hasStart ? 4.0 : 2.0),
            child: RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                children: _parseAyat(widget.ayat),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSurahName() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            widget.surah.name,
            style: textStyle(
              textType: TextType.text,
              fontSize: 30.0,
            ),
          ),
        ),
        _highLighterActive
            ? Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () => _resetHighLightedAya(),
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.red.withOpacity(0.6),
                    size: 25.0,
                  ),
                ),
              )
            : const SizedBox(),
        _buildRewayaChangerView(),
      ],
    );
  }

  Widget _buildRewayaChangerView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: SizedBox(
            width: 190.0,
            height: 35.0,
            child: _buildRewayaMenu(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: SizedBox(
            width: 170.0,
            height: 35.0,
            child: _buildReaderMenu(),
          ),
        ),
      ],
    );
  }

  Widget _buildReaderMenu() {
    return MenuButton<Reader>(
      items: _readers,
      topDivider: false,
      itemBuilder: (Reader value) {
        return Container(
          width: 83,
          height: 40,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            value.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: ArabicFonts.El_Messiri,
              package: 'google_fonts_arabic',
              fontSize: 18.0,
            ),
          ),
        );
      },
      toggledChild: Container(
        color: Colors.white,
        child: SizedBox(
          width: 100,
          height: 40,
          child: Container(
            color: AppConst.backgroundColor,
            padding: const EdgeInsets.only(left: 16, right: 11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Text(
                    _currentReader.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: ArabicFonts.El_Messiri,
                      package: 'google_fonts_arabic',
                      fontSize: 18.0,
                      color: AppConst.mainColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                  height: 17,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ), // Widget displayed as the button,
      ),
      onItemSelected: (Reader value) {
        setState(() {
          _currentReader = value;
        });
      },
      scrollPhysics: const AlwaysScrollableScrollPhysics(),
      divider: Container(
        height: 1,
        color: Colors.grey,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: const BorderRadius.all(Radius.circular(3.0)),
        color: AppConst.backgroundColor.withOpacity(0.3),
      ),
      onMenuButtonToggle: (isToggle) {
        if (kDebugMode) {
          print(isToggle);
        }
      },
      child: Container(
        color: AppConst.backgroundColor,
        padding: const EdgeInsets.only(left: 16, right: 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: Text(
                _currentReader.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: ArabicFonts.El_Messiri,
                  package: 'google_fonts_arabic',
                  fontSize: 12.0,
                  color: AppConst.mainColor,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
              height: 17,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<InlineSpan> _parseAyat(
    List<AyahVm> selectedRewaya
  ) {
    final textSpans = <InlineSpan>[];

    for (var i = 0; i < selectedRewaya.length; i++) {
      final aya = selectedRewaya[i];

      final ayaSpan = _ayaSpanParser(
        aya.rawyText.text,
        aya.ayaNumber
      );

      textSpans.add(ayaSpan);

      final counterSpan = _ayaCounterSpan(
        aya,
        widget.keys[i].keys,
      );

      textSpans.add(counterSpan);
    }
    return textSpans;
  }

  InlineSpan _ayaCounterSpan(
    AyahVm aya,
    GlobalKey<State<StatefulWidget>> globalKey,
  ) {
    final notEmpty = aya.readings.isNotEmpty;
    final isEmpty = aya.readings.isEmpty
        ? AppConst.mainColor.withOpacity(0.6)
        : AppConst.secondaryRedColor.withOpacity(0.6);

    return WidgetSpan(
      child: GestureDetector(
        key: globalKey,
        onTapUp: (details) => showPopup(
          details.globalPosition,
          aya.rawyText.text,
          aya.ayaNumber,
        ),
        onLongPress: () {
          if (notEmpty) {
            showDialog(
              context: context,
              builder: (context) =>  Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                child: ReadingViewDialog(readings: aya.readings),
              ),
            );
          }
        },
        child: Container(
          margin: const EdgeInsets.only(left: 7.0, right: 7.0),
          child: ayaCounterView(
            ayaNumber: aya.ayaNumber.toString(),
            counterColor: isEmpty,
            textColor: Colors.white,
            ayaFontFamily: ArabicFonts.Cairo,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  TextSpan _ayaSpanParser(String ayaText, int ayaNumber) {
    Color? backgroundColor ;

    if (_highLighterActive) {
      final maxIndex = _highLightedAyat.map((e) => e.ayaNumber).reduce(max);
      final minIndex = _highLightedAyat.map((e) => e.ayaNumber).reduce(min);

      if ((ayaNumber <= maxIndex) && (ayaNumber >= minIndex)) {
        backgroundColor = AppConst.secondaryRedColor.withOpacity(0.3);
      }
    }

    return TextSpan(
      text: '\u202E$ayaText\u202E'.trim(),
      style: TextStyle(
        color: Colors.black,
        fontFamily: _fontFamily,
        // fontWeight: ViewSettingVm.parseWeight(settings.fontWeight),
        // fontSize: settings.fontSize,
        // height: settings.fontHeight,
        backgroundColor: backgroundColor,
      ),
    );
  }

  void showPopup(Offset offset, String ayaText, int ayaNumber) {
    if (_highLightedAyat.isNotEmpty) {
      _highLightedAyat.sort((a, b) => a.ayaNumber.compareTo(b.ayaNumber));
    }

    PopupMenu(
      backgroundColor: AppConst.backgroundColor,
      lineColor: AppConst.secondaryColor,
      maxColumn: 3,
      items: [
        MenuItem(
          title: 'نسخ',
          textStyle: textStyle(
              textType: TextType.text,
              fontSize: 14.0,
              color: AppConst.mainColor,
              fontWeight: FontWeight.w500),
          image: const Icon(Icons.copy, color: Colors.red, size: 20.0),
        ),
        MenuItem(
          title: 'أضافة رتل',
          textStyle: textStyle(
              textType: TextType.text,
              fontSize: 14.0,
              color: AppConst.mainColor,
              fontWeight: FontWeight.w500),
          image: const Icon(Icons.power, color: Colors.green, size: 20.0),
        ),
        MenuItem(
          title: 'تضليل',
          textStyle: textStyle(
              textType: TextType.text,
              fontSize: 14.0,
              color: AppConst.mainColor,
              fontWeight: FontWeight.w500),
          image:
              Icon(Icons.highlight, color: AppConst.secondaryColor, size: 20.0),
        ),
      ],
      onClickMenu: (item) => onClickMenu(item, ayaText, ayaNumber),
      onDismiss: onDismiss,
    ).show(rect: Rect.fromPoints(offset, offset));
  }

  void onClickMenu(MenuItemProvider item, String ayaText, int ayaNumber) {
    switch (item.menuTitle) {
      case 'نسخ':
        FlutterClipboard.copy(ayaText);
        break;
      case 'أضافة رتل':
        openAddRatelDialog();
        break;
      case 'تضليل':
        _highLightAya(ayaNumber, ayaText);
        break;
      default:
        openAddRatelDialog();
    }
  }

  void onDismiss() {
    if (kDebugMode) {
      print('Menu is dismiss');
    }
  }

  void openAddRatelDialog() {
    final List<Ayat> ayatList = _handleAyatList();
    // showDialog(
    //   context: context,
    //   builder: (context) => Dialog(
    //     backgroundColor: Colors.transparent,
    //     elevation: 0.0,
    //     shape: const RoundedRectangleBorder(),
    //     child: RatelListViewDialog(
    //       ayat: ayatList,
    //       surahName: widget.surah.name,
    //       surahNumber: widget.surah.order,
    //     ),
    //   ),
    // );
  }

  void _highLightAya(int ayaNumber, String aya) {
    setState(() {
      _highLighterActive = true;

      if (_hasMore) {
        _handleHasMoreHighLight(ayaNumber, aya);
      } else {
        _highLightedAyat.add(Ayat(aya: aya, ayaNumber: ayaNumber));
      }
    });
  }

  void _resetHighLightedAya() {
    setState(() {
      _highLighterActive = false;
      _highLightedAyat.clear();
    });
  }

  _handleHasMoreHighLight(int ayaNumber, String aya) {
    if (!_highLightedAyat.map((e) => e.ayaNumber).contains(ayaNumber)) {
      _highLightedAyat.add(Ayat(aya: aya, ayaNumber: ayaNumber));
    }

    final maxIndex = _highLightedAyat.map((e) => e.ayaNumber).reduce(max);
    final minIndex = _highLightedAyat.map((e) => e.ayaNumber).reduce(min);
    _highLightedAyat.clear();

    var minAyaIndex = ayaNumber > minIndex && ayaNumber < maxIndex;

    if (minAyaIndex) {
      _highLightedAyat.add(Ayat(aya: aya, ayaNumber: ayaNumber));
    } else {
      _highLightedAyat.add(Ayat(aya: aya, ayaNumber: minIndex));
    }

    _highLightedAyat.add(Ayat(aya: aya, ayaNumber: maxIndex));
  }

  List<Ayat> _handleAyatList() {
    final List<Ayat> ayat = [];
    final ayatData = widget.ayat;

    final firstAya = _highLightedAyat.first;
    final lastAya = _highLightedAyat.last;

    for (var i = firstAya.ayaNumber; i <= lastAya.ayaNumber; i++) {
      final ayaData = ayatData.firstWhere((element) => element.ayaNumber == i);
      final aya =
          Ayat(aya: ayaData.rawyText.text, ayaNumber: ayaData.ayaNumber);
      ayat.add(aya);
    }

    return ayat;
  }

  Widget _buildRewayaMenu() {
    return MenuButton(
      items: widget.rewayat,
      topDivider: false,
      divider: Container(height: 1, color: Colors.grey),
      onItemSelected: (RewayaVm value) async =>
          await _handleRewayaChange(value),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: const BorderRadius.all(Radius.circular(3.0)),
        color: AppConst.backgroundColor.withOpacity(0.3),
      ),
      onMenuButtonToggle: (isToggle) {
        if (kDebugMode) {
          print(_fontFamily);
        }
      },
      scrollPhysics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (RewayaVm value) => Container(
        width: 83,
        height: 40,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          value.nameView,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: ArabicFonts.El_Messiri,
            package: 'google_fonts_arabic',
            fontSize: 16.0,
          ),
        ),
      ),
      toggledChild: Container(
        color: Colors.white,
        child: SizedBox(
          width: 100,
          height: 40,
          child: Container(
            color: AppConst.backgroundColor,
            padding: const EdgeInsets.only(left: 16, right: 11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Text(
                    _selectedRewaya.nameView,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: ArabicFonts.El_Messiri,
                      package: 'google_fonts_arabic',
                      fontSize: 18.0,
                      color: AppConst.mainColor,
                    ),
                  ),
                ),
                const SizedBox(
                    width: 12,
                    height: 17,
                    child: FittedBox(
                        fit: BoxFit.fill,
                        child:
                            Icon(Icons.arrow_drop_down, color: Colors.grey))),
              ],
            ),
          ),
        ), // Widget displayed as the button,
      ),
      child: Container(
        color: AppConst.backgroundColor,
        padding: const EdgeInsets.only(left: 16, right: 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: Text(
                _selectedRewaya.nameView,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: ArabicFonts.El_Messiri,
                  package: 'google_fonts_arabic',
                  fontSize: 16.0,
                  color: AppConst.mainColor,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
              height: 17,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _handleRewayaChange(RewayaVm value) async {
    await _surahBloc.handleRewayaChange(rewaya: value.read);
    setState(() {
      _selectedRewaya = value;
      _readers = value.readers;
      _currentReader = _readers.first;
    });
  }
}
