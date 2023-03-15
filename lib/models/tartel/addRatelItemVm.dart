
import 'package:quran_web_v2/models/tartel/tartelVm.dart';

class AddRatelItemVm {
  AddRatelItemVm({
    required this.ratelId,
    required this.title,
    required this.header,
    required this.fotter,
    required this.ayat,
    required this.surahName,
    required this.surahNumber,
  });

  final int ratelId;
  final String title;
  final String header;
  final String fotter;
  final List<Ayat> ayat;
  final String surahName;
  final int surahNumber;

  factory AddRatelItemVm.fromJson(Map<String, dynamic> json) => AddRatelItemVm(
        ratelId: json["ratelId"],
        title: json["title"],
        header: json["header"],
        fotter: json["fotter"],
        ayat: List<Ayat>.from(json["ayat"].map((x) => Ayat.fromJson(x))),
        surahName: json["surahName"],
        surahNumber: json["surahNumber"],
      );

  Map<String, dynamic> toJson() => {
        "ratelId": ratelId,
        "title": title,
        "header": header,
        "fotter": fotter,
        "ayat": List<dynamic>.from(ayat.map((x) => x.toJson())),
        "surahName": surahName,
        "surahNumber": surahNumber,
      };
}

