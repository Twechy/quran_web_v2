class TartelVm {
  TartelVm({
    required this.id,
    required this.createdDate,
    required this.updatedAt,
    required this.title,
    required this.header,
    required this.fotter,
    required this.ratelItems,
  });

  final int id;
  final DateTime createdDate;
  final DateTime updatedAt;
  final String title;
  final String header;
  final String fotter;
  final List<RatelItem> ratelItems;

  factory TartelVm.fromJson(Map<String, dynamic> json) => TartelVm(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        title: json["title"],
        header: json["header"],
        fotter: json["fotter"],
        ratelItems: List<RatelItem>.from(
                json["ratelItems"].map((x) => RatelItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": createdDate.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "title": title,
        "header": header,
        "fotter": fotter,
        "ratelItems": List<dynamic>.from(ratelItems.map((x) => x.toJson())),
      };
}

class RatelItem {
  RatelItem({
    required this.id,
    required this.createdDate,
    required this.updatedAt,
    required this.title,
    required this.header,
    required this.fotter,
    required this.ratelId,
    required this.surahOrder,
    required this.surahName,
    required this.ayaNumberView,
    required this.ayat,
    required this.infos,
  });

  final int id;
  final DateTime createdDate;
  final DateTime updatedAt;
  final String title;
  final String header;
  final String fotter;
  final int ratelId;
  final int surahOrder;
  final String surahName;
  final String ayaNumberView;
  final List<Ayat> ayat;
  final List<Info> infos;

  factory RatelItem.fromJson(Map<String, dynamic> json) => RatelItem(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        title: json["title"],
        header: json["header"],
        fotter: json["fotter"],
        ratelId: json["ratelId"],
        surahOrder: json["surahOrder"],
        surahName: json["surahName"],
        ayaNumberView: json["ayaNumberView"],
        ayat: List<Ayat>.from(json["ayat"].map((x) => Ayat.fromJson(x))),
        infos: List<Info>.from(json["infos"].map((x) => Info.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": createdDate.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "title": title,
        "header": header,
        "fotter": fotter,
        "ratelId": ratelId,
        "surahOrder": surahOrder,
        "surahName": surahName,
        "ayaNumberView": ayaNumberView,
        "ayat":List<dynamic>.from(ayat.map((x) => x.toJson())),
        "infos": List<dynamic>.from(infos.map((x) => x.toJson())),
      };
}

class Ayat {
  Ayat({
    required this.ayaNumber,
    required this.aya,
  });

  final int ayaNumber;
  final String aya;

  factory Ayat.fromJson(Map<String, dynamic> json) => Ayat(
        ayaNumber: json["ayaNumber"],
        aya: json["aya"],
      );

  Map<String, dynamic> toJson() => {
        "ayaNumber": ayaNumber,
        "aya": aya,
      };
}

class Info {
  Info({
    required this.id,
    required this.createdDate,
    required this.updatedAt,
    required this.key,
    required this.description,
    required this.type,
  });

  final int id;
  final DateTime createdDate;
  final DateTime updatedAt;
  final String key;
  final String description;
  final int type;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        key: json["key"],
        description: json["description"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate":createdDate.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "key": key,
        "description": description,
        "type": type,
      };
}
