

import 'package:quran_web_v2/models/index.dart';

class IndexedRawySurahVm {
  IndexedRawySurahVm({
    required this.id,
    required this.index,
    required this.order,
    required this.name,
    required this.quranRewat,
  });

  final int id;
  final int index;
  final int order;
  final String name;
  final QuranRewat quranRewat;

  factory IndexedRawySurahVm.fromMap(Map<String, dynamic> json) =>
      IndexedRawySurahVm(
        id: json["id"],
        order: json["order"],
        name: json["name"],
        quranRewat: QuranRewat.fromMap(json["quranRewat"]),
        index: 0
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "order": order,
        "name": name,
        "quranRewat": quranRewat.toMap(),
      };

  static List<IndexedRawySurahVm> toIndexedSurah(List<RawySurahVm> rewaya) {
    final rewayaList = <IndexedRawySurahVm>[];

    for (var i = 0; i < rewaya.length; i++) {
      final data = rewaya[i];
      rewayaList.add(IndexedRawySurahVm(
        index: i,
        id: data.id,
        order: data.order,
        name: data.name,
        quranRewat: data.quranRewat,
      ));
    }

    return rewayaList;
  }

  static RawySurahVm toSurah(IndexedRawySurahVm rewaya) {
    return RawySurahVm(
      id: rewaya.id,
      order: rewaya.order,
      name: rewaya.name,
      quranRewat: rewaya.quranRewat,
      description: '',
      landing: '',
    );
  }
}

class RawySurahVm {
  RawySurahVm({
    required this.id,
    required this.order,
    required this.name,
    required this.landing,
    required this.description,
    required this.quranRewat,
  });

  final int id;
  final int order;
  final String name;
  final String landing;
  final String description;
  final QuranRewat quranRewat;

  factory RawySurahVm.fromMap(Map<String, dynamic> json) => RawySurahVm(
        id: json["id"],
        order: json["order"],
        name: json["name"],
        landing: json["landing"],
        description: json["description"],
        quranRewat: QuranRewat.fromMap(json["quranRewat"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "order": order,
        "name": name,
        "landing": landing,
        "description": description,
        "quranRewat": quranRewat.toMap(),
      };
}

class QuranRewat {
  QuranRewat({
    required this.qalon,
    required this.hafs,
    required this.wersh,
    required this.alBozy,
  });

  final List<AyahVm> qalon;
  final List<AyahVm> hafs;
  final List<AyahVm> wersh;
  final List<AyahVm> alBozy;

  factory QuranRewat.fromMap(Map<String, dynamic> json) => QuranRewat(
        qalon: List<AyahVm>.from(json["Qalon"].map((x) => AyahVm.fromJson(x))),
        hafs: List<AyahVm>.from(json["Hafs"].map((x) => AyahVm.fromJson(x))),
        wersh: List<AyahVm>.from(json["Wersh"].map((x) => AyahVm.fromJson(x))),
        alBozy:
            List<AyahVm>.from(json["AlBozy"].map((x) => AyahVm.fromJson(x))),
      );

  Map<String, dynamic> toMap() => {
        "Qalon": List<dynamic>.from(qalon.map((x) => x.toJson())),
        "Hafs": List<dynamic>.from(hafs.map((x) => x.toJson())),
        "Wersh": List<dynamic>.from(wersh.map((x) => x.toJson())),
        "AlBozy": List<dynamic>.from(alBozy.map((x) => x.toJson())),
      };
}
