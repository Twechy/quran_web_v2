class UpdateReadingDto {
  UpdateReadingDto({
    required this.id,
    required this.ayaNumber,
    required this.reader,
    required this.readView,
    required this.holyRead,
    required this.readInfo,
    required this.agreedOn,
  });

  final int id;
  final int ayaNumber;
  final String reader;
  final String readView;
  final String holyRead;
  final String readInfo;
  final bool agreedOn;

  factory UpdateReadingDto.fromJson(Map<String, dynamic> json) =>
      UpdateReadingDto(
        id: json["id"],
        ayaNumber: json["ayaNumber"],
        reader: json["reader"],
        readView: json["readView"],
        holyRead: json["holyRead"],
        readInfo: json["readInfo"],
        agreedOn: json["agreedOn"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ayaNumber": ayaNumber,
        "reader": reader,
        "readView": readView,
        "holyRead": holyRead,
        "readInfo": readInfo,
        "agreedOn": agreedOn,
      };
}
