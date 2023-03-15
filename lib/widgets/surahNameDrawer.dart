import 'package:flutter/material.dart';

import '../models/index.dart';
import '../utils/index.dart';

class SurahNameItem extends StatelessWidget {
  final Function(SurahNamesVm) callbackAction;
  final List<SurahNamesVm> surahName;
  final int selectedSurahOrder;

  const SurahNameItem({
    super.key,
    required this.callbackAction,
    required this.surahName,
    required this.selectedSurahOrder,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: surahName.length,
      itemBuilder: (context, index) {
        final suras = surahName[index];

        return SizedBox(
          width: 380.0,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              key: UniqueKey(),
              isThreeLine: true,
              dense: true,
              shape: const RoundedRectangleBorder(),
              selected: selectedSurahOrder == suras.order,
              selectedTileColor: AppConst.secondaryColor.withOpacity(0.3),
              focusColor: AppConst.secondaryColor.withOpacity(0.3),
              onTap: () => callbackAction(suras),
              visualDensity: VisualDensity.comfortable,
              leading: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  children: [
                    Text(
                      suras.order.toString(),
                      textAlign: TextAlign.center,
                      style: textStyle(
                        textType: TextType.text,
                        // fontFamily: viewSetting.fontFamily,
                        fontSize: 18.0,
                        color: AppConst.mainColor,
                      ),
                    ),
                    Text(
                      suras.landing == 0 ? 'مكية' : 'مدنية',
                      textAlign: TextAlign.center,
                      style: textStyle(
                        textType: TextType.text,
                        // fontFamily: viewSetting.fontFamily,
                        fontSize: 12.0,
                        color: AppConst.mainColor,
                      ),
                    )
                  ],
                ),
              ),
              title: Text(
                suras.name.toString(),
                textAlign: TextAlign.center,
                style: textStyle(
                  textType: TextType.text,
                  // fontFamily: viewSetting.fontFamily,
                  fontSize: 18.0,
                  color: AppConst.mainColor,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  suras.description.toString(),
                  textAlign: TextAlign.center,
                  style: textStyle(
                    textType: TextType.text,
                    // fontFamily: viewSetting.fontFamily,
                    fontSize: 12.0,
                    color: AppConst.mainColor,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
