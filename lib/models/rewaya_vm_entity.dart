import 'dart:convert';

enum Rewayat {
  hafs,
  qalon,
  werch,
  albozy,
}

class RewayaVm {
  RewayaVm({
    required this.read,
    required this.nameView,
    required this.readers,
  });

  Rewayat read;
  String nameView;
  List<Reader> readers;

  factory RewayaVm.fromMap(Map<String, dynamic> json) => RewayaVm(
        read: parseRewayaFromInt(json['read']),
        nameView: json['nameView'],
        readers: List<Reader>.from(json['readers'].map((x) => Reader.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'read': parseRewayaToInt(read),
        'nameView': nameView,
        'readers': List<dynamic>.from(readers.map((x) => x.toMap())),
      };

  static Rewayat parseRewayaFromInt(int rewaya) {
    switch (rewaya) {
      case 32768:
        return Rewayat.hafs;
      case 131072:
        return Rewayat.qalon;
      case 262144:
        return Rewayat.werch;
      case 524288:
        return Rewayat.albozy;
      default:
        return Rewayat.hafs;
    }
  }

  static int parseRewayaToInt(Rewayat rewaya) {
    switch (rewaya) {
      case Rewayat.hafs:
        return 32768;
      case Rewayat.qalon:
        return 131072;
      case Rewayat.werch:
        return 262144;
      case Rewayat.albozy:
        return 524288;
      default:
        return 32768;
    }
  }
}

class Reader {
  Reader({
    required this.reader,
    required this.name,
  });

  int reader;
  String name;

  factory Reader.fromJson(String str) => Reader.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Reader.fromMap(Map<String, dynamic> json) => Reader(
        reader: json['reader'],
        name: json['name'],
      );

  Map<String, dynamic> toMap() => {
        'reader': reader,
        'name': name,
      };
}

class ReaderInfo {
  ReaderInfo({
    required this.read,
    required this.name,
    required this.nameView,
    required this.location,
    required this.birthDate,
    required this.deathDate,
    required this.info,
    required this.rowat,
    required this.rawyInfo,
  });

  final int read;
  final String name;
  final String nameView;
  final String location;
  final String birthDate;
  final String deathDate;
  final String info;
  final List<ReaderInfo> rowat;
  final int rawyInfo;

  factory ReaderInfo.fromJson(String str) =>
      ReaderInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReaderInfo.fromMap(Map<String, dynamic> json) => ReaderInfo(
        read: json["read"],
        name: json["name"],
        nameView: json["nameView"],
        location: json["location"],
        birthDate: json["birthDate"],
        deathDate: json["deathDate"],
        info: json["info"],
        rowat: List<ReaderInfo>.from(
                json["rowat"].map((x) => ReaderInfo.fromMap(x))),
        rawyInfo: json["rawyInfo"],
      );

  Map<String, dynamic> toMap() => {
        "read": read,
        "name": name,
        "nameView": nameView,
        "location": location,
        "birthDate": birthDate,
        "deathDate": deathDate,
        "info": info,
        "rowat": List<dynamic>.from(rowat.map((x) => x.toMap())),
        "rawyInfo": rawyInfo,
      };
}
