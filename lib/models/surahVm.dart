class AyahVm {
  AyahVm({
    required this.id,
    required this.sorahId,
    required this.ayaNumber,
    required this.rawyText,
    required this.readings,
  });

  final int id;
  final int sorahId;
  final int ayaNumber;
  final RawyTextVm rawyText;
  final List<ReadingVm> readings;

  factory AyahVm.fromJson(Map<String, dynamic> json) => AyahVm(
        id: json["id"],
        sorahId: json["sorahId"],
        ayaNumber: json["ayaNumber"],
        rawyText: RawyTextVm.fromJson(json["rawyText"]),
        readings: List<ReadingVm>.from(
            json["readings"].map((x) => ReadingVm.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sorahId": sorahId,
        "ayaNumber": ayaNumber,
        "rawyText": rawyText.toJson(),
        "readings": List<dynamic>.from(readings.map((x) => x.toJson())),
      };
}

class RawyTextVm {
  RawyTextVm({
    required this.id,
    required this.surahId,
    required this.ayahId,
    required this.ayaNumber,
    required this.text,
    required this.rawy,
  });

  final int id;
  final int surahId;
  final int ayahId;
  final int ayaNumber;
  final String text;
  final int rawy;

  factory RawyTextVm.fromJson(Map<String, dynamic> json) => RawyTextVm(
        id: json["id"],
        surahId: json["surahId"],
        ayahId: json["ayahId"],
        ayaNumber: json["ayaNumber"],
        text: json["text"],
        rawy: json["rawy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "surahId": surahId,
        "ayahId": ayahId,
        "ayaNumber": ayaNumber,
        "text": text,
        "rawy": rawy,
      };
}

class ReadingVm {
  ReadingVm({
    required this.id,
    required this.ayahId,
    required this.ayaNumber,
    required this.readers,
    required this.readView,
    required this.holyRead,
    required this.readInfo,
    required this.agreedOn,
  });

  final int id;
  final int ayahId;
  final int ayaNumber;
  final String readers;
  final String readView;
  final String holyRead;
  final String readInfo;
  final bool agreedOn;

  factory ReadingVm.fromJson(Map<String, dynamic> json) => ReadingVm(
        id: json["id"],
        ayahId: json["ayahId"],
        ayaNumber: json["ayaNumber"],
        readers: json["readers"],
        readView: json["readView"],
        holyRead: json["holyRead"],
        readInfo: json["readInfo"],
        agreedOn: json["agreedOn"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ayahId": ayahId,
        "ayaNumber": ayaNumber,
        "readers": readers,
        "readView": readView,
        "holyRead": holyRead,
        "readInfo": readInfo,
        "agreedOn": agreedOn,
      };
}
