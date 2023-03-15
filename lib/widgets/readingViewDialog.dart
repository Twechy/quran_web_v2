import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

import '../models/index.dart';
import '../utils/index.dart';

class ReadingViewDialog extends StatefulWidget {
  final List<ReadingVm> readings;

  const ReadingViewDialog({super.key,  required this.readings}) ;

  @override
  _ReadingViewDialogState createState() => _ReadingViewDialogState();
}

class _ReadingViewDialogState extends State<ReadingViewDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
            margin:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'الأية ',
                      style: TextStyle(
                        color: AppConst.mainColor,
                        fontFamily: ArabicFonts.Amiri,
                        package: 'google_fonts_arabic',
                        fontSize: 24.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: widget.readings.first.ayaNumber.toString(),
                      style: TextStyle(
                        color: AppConst.mainColor,
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ]),
                ),
                Divider(
                  color: AppConst.mainColor.withOpacity(0.4),
                  height: 3.5,
                  thickness: 1.0,
                  indent: 35.0,
                  endIndent: 35.0,
                ),
              ],
            ),
          ),
          ListView.builder(
            itemCount: widget.readings.length,
            shrinkWrap: true,
            itemBuilder: (context, index) =>
                readingView(widget.readings[index], index),
          ),
        ],
      ),
    );
  }

  Widget readingView(ReadingVm reading, int index) {
    var labelStyle = TextStyle(
      color: AppConst.mainColor,
      fontFamily: ArabicFonts.Harmattan,
      package: 'google_fonts_arabic',
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                child: TextView(
                  index: index,
                  label: 'القراءة',
                  labelStyle: labelStyle,
                  text: reading.readView,
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontFamily: ArabicFonts.Harmattan,
                    package: 'google_fonts_arabic',
                    fontSize: 22.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: TextView(
                  index: index,
                  label: 'الفرش',
                  labelStyle: labelStyle,
                  text: reading.holyRead,
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontFamily: ArabicFonts.Amiri,
                    package: 'google_fonts_arabic',
                    fontSize: 26.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: TextView(
                  index: index,
                  label: 'القارئ',
                  labelStyle: labelStyle,
                  text: reading.readers,
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontFamily: ArabicFonts.Harmattan,
                    package: 'google_fonts_arabic',
                    fontSize: 22.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
