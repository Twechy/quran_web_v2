class SearchItemVm {
  SearchItemVm({
    required this.numberOfSurahOccured,
    required this.mostSurahOccuredIn,
    required this.mostSurahOccuredInId,
    required this.secondMostSurahOccuredIn,
    required this.secondMostSurahOccuredInId,
    required this.searcheAyat,
  });

  final int numberOfSurahOccured;
  final String mostSurahOccuredIn;
  final int mostSurahOccuredInId;
  final String secondMostSurahOccuredIn;
  final int secondMostSurahOccuredInId;
  final List<SearchedAyat> searcheAyat;

  factory SearchItemVm.fromJson(Map<String, dynamic> json) => SearchItemVm(
        numberOfSurahOccured: json["numberOfSurahOccured"],
        mostSurahOccuredIn: json["mostSurahOccuredIn"],
        mostSurahOccuredInId: json["mostSurahOccuredInId"],
        secondMostSurahOccuredIn: json["secondMostSurahOccuredIn"],
        secondMostSurahOccuredInId: json["secondMostSurahOccuredInId"],
        searcheAyat: List<SearchedAyat>.from(
                json["searcheAyat"].map((x) => SearchedAyat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "numberOfSurahOccured":
            numberOfSurahOccured,
        "mostSurahOccuredIn":
            mostSurahOccuredIn,
        "mostSurahOccuredInId":
            mostSurahOccuredInId,
        "secondMostSurahOccuredIn":
            secondMostSurahOccuredIn,
        "secondMostSurahOccuredInId": secondMostSurahOccuredInId,
        "searcheAyat": searcheAyat == null
            ? null
            : List<dynamic>.from(searcheAyat.map((x) => x.toJson())),
      };
}

class SearchedAyat {
  SearchedAyat({
    required this.ayaId,
    required this.surahId,
    required this.surahOrder,
    required this.surahName,
    required this.ayaNumber,
    required this.rawy,
    required this.ayaText,
    required this.wordCount,
    required this.letterCount,
  });

  final int ayaId;
  final int surahId;
  final int surahOrder;
  final String surahName;
  final int ayaNumber;
  final int rawy;
  final String ayaText;
  final int wordCount;
  final int letterCount;

  factory SearchedAyat.fromJson(Map<String, dynamic> json) => SearchedAyat(
        ayaId: json["ayaId"],
        surahId: json["surahId"],
        surahOrder: json["surahOrder"],
        surahName: json["surahName"],
        ayaNumber: json["ayaNumber"],
        rawy: json["rawy"],
        ayaText: json["ayaText"],
        wordCount: json["wordCount"],
        letterCount: json["letterCount"],
      );

  Map<String, dynamic> toJson() => {
        "ayaId": ayaId,
        "surahId": surahId,
        "surahOrder": surahOrder,
        "surahName": surahName,
        "ayaNumber": ayaNumber,
        "rawy": rawy,
        "ayaText": ayaText,
        "wordCount": wordCount,
        "letterCount": letterCount,
      };
}
