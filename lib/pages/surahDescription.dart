import 'package:flutter/material.dart';

class SurahDescriptionVm {
  final int order;
  final String arName;
  final String description;
  final String landing;

  SurahDescriptionVm(
    this.order,
    this.arName,
    this.description,
    this.landing,
  );
}

class SurahDescription extends StatelessWidget {
  final SurahDescriptionVm surahDescriptionVm;

  const SurahDescription({super.key,
    required this.surahDescriptionVm,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('order ${surahDescriptionVm.order}'),
        Text('arName ${surahDescriptionVm.arName}'),
        Text('description ${surahDescriptionVm.description}'),
        Text('landing ${surahDescriptionVm.landing}'),
      ],
    );
  }
}
