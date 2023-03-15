import 'package:flutter/material.dart';

import '../models/index.dart';
import '../utils/index.dart';
import '../widgets/updateReadingDialog.dart';

class ReadingViewer extends StatefulWidget {
  final List<ReadingVm> readings;

   const ReadingViewer({
    super.key,
    required this.readings,
  });

  @override
  _ReadingViewerState createState() => _ReadingViewerState();
}

class _ReadingViewerState extends State<ReadingViewer> {
  @override
  Widget build(BuildContext context) {
    var dataTable = DataTable(
      showBottomBorder: true,
      dataRowHeight: 70.0,
      columns: [
        DataColumn(
          label: Center(
            child: Text(
              'رقم الاية',
              textAlign: TextAlign.center,
              style: textStyle(textType: TextType.label, fontSize: 20.0),
            ),
          ),
          numeric: true,
        ),
        DataColumn(
          label: Center(
            child: Text(
              'القارئ',
              textAlign: TextAlign.center,
              style: textStyle(textType: TextType.label, fontSize: 20.0),
            ),
          ),
        ),
        DataColumn(
          label: Center(
            child: Text(
              'عرض الفرش',
              textAlign: TextAlign.center,
              style: textStyle(textType: TextType.label, fontSize: 20.0),
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'الفرش',
            textAlign: TextAlign.center,
            style: textStyle(textType: TextType.label, fontSize: 20.0),
          ),
        ),
        DataColumn(
          label: Text(
            'بيانات',
            textAlign: TextAlign.center,
            style: textStyle(textType: TextType.label, fontSize: 20.0),
          ),
        ),
        const DataColumn(
          label: SizedBox(),
        ),
      ],
      rows: widget.readings.map<DataRow>((ReadingVm reading) {
        return DataRow(cells: <DataCell>[
          DataCell(textView(reading.ayaNumber.toString())),
          DataCell(textView(reading.readers)),
          DataCell(textView(reading.readView)),
          DataCell(textView(reading.holyRead)),
          DataCell(textView(reading.readInfo)),
          DataCell(
            MaterialButton(
                onPressed: () => showDialog(
                      context: context,
                      builder: (context) =>
                          Dialog(child: UpdateReadingDialog(reading: reading)),
                    ),
                child: Icon(Icons.save,
                    size: 25.0, color: AppConst.secondaryColor)),
          ),
          // handleFinanceEvent(context, eventState, financeEvent),
        ]);
      }).toList(),
    );

    return dataTable;
  }

  Widget textView(
    String text, {
    double fontSize = 18.0,
    FontWeight? fontWeight,
  }) {
    return Text(
      text,
      style: textStyle(
        textType: TextType.text,
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: AppConst.mainColor,
      ),
    );
  }
}
