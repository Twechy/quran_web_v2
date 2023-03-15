import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show Consumer;

import '../models/index.dart';
import '../utils/index.dart';

class UpdateReadingDialog extends StatefulWidget {
  final ReadingVm reading;

  const UpdateReadingDialog({
    super.key,
    required this.reading,
  });

  @override
  _UpdateReadingDialogState createState() => _UpdateReadingDialogState();
}

class _UpdateReadingDialogState extends State<UpdateReadingDialog> {
  int ayaNumber = 0;
  String readers = '';
  String farsh = '';
  String readView = '';
  String extraInfo = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ayaNumber = widget.reading.ayaNumber;
    readers = widget.reading.readers;
    farsh = widget.reading.holyRead;
    readView = widget.reading.readView;
    extraInfo = widget.reading.readInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      // width: 620,
      // height: 500 / 1.2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppConst.backgroundColor,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          textField(
              key: GlobalKey(),
              label: 'رقم الاية',
              onChanged: (data) {
                setState(() {
                  ayaNumber = int.parse(data);
                });
              },
              initValue: widget.reading.ayaNumber.toString()),
          textField(
              key: GlobalKey(),
              label: 'القارئ',
              onChanged: (data) {
                setState(() {
                  readers = data;
                });
              },
              initValue: widget.reading.readers),
          textField(
              key: GlobalKey(),
              label: 'العرض',
              onChanged: (data) {
                setState(() {
                  readView = data;
                });
              },
              initValue: widget.reading.readView),
          textField(
              key: GlobalKey(),
              label: 'الفرش',
              onChanged: (data) {
                setState(() {
                  farsh = data;
                });
              },
              initValue: widget.reading.holyRead),
          textField(
              key: GlobalKey(),
              label: 'بيانات أضافية',
              onChanged: (data) {
                setState(() {
                  extraInfo = data;
                });
              },
              initValue: widget.reading.holyRead),
          Consumer(
            builder: (context, watch, child) {
              // final _surahBloc = watch.watch(surahBlocProvider);
              return MaterialButton(
                onPressed: () async {
                  // final response = await _surahBloc.updateReading(
                  //   UpdateReadingDto(
                  //     id: widget.reading.id,
                  //     ayaNumber: ayaNumber,
                  //     holyRead: farsh,
                  //     reader: readers,
                  //     readView: readView,
                  //     readInfo: extraInfo,
                  //     agreedOn: widget.reading.agreedOn,
                  //   ),
                  // );
                  //
                  // if (response.type == 1) {
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                  // }
                },
                color: AppConst.secondaryColor,
                child: Text(
                  'تعديل',
                  style: textStyle(
                    textType: TextType.text,
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
