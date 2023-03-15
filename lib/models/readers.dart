class ReaderVm {
  int read;
  String name;
  String nameView;
  String location;
  String birthDate;
  String deathDate;
  String info;
  int rowat;
  int rawyInfo;

  ReaderVm({
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

  factory ReaderVm.fromJson(Map<String, dynamic> json) => ReaderVm(
        read: json["read"],
        name: json["name"],
        nameView: json["nameView"],
        location: json["location"],
        birthDate: json["birthDate"],
        deathDate: json["deathDate"],
        info: json["info"],
        rowat: json["rowat"],
        rawyInfo: json["rawyInfo"],
      );

  Map<String, dynamic> toJson() => {
        "read": read,
        "name": name,
        "nameView": nameView,
        "location": location,
        "birthDate": birthDate,
        "deathDate": deathDate,
        "info": info,
        "rowat": rowat,
        "rawyInfo": rawyInfo,
      };
}

enum ReaderType {
  None,
  Nafe3,
  AbnKater,
  Abu3amro,
  Abn3amer,
  Asem,
  Hamza,
  Qesaee,
  AbuJafer,
  Ya3qob,
  Kalaf,
  AlSosy,
  Sho3ba,
  AlDory,
  Qonbol,
  Hesham,
  Hafs,
  Royaes,
  Qalon,
  Wersh,
  AlBozy,
  AbnDakwan,
  Kalad,
  Laith,
  AbnWardan,
  AbnJamaz,
  Rouh,
  Ashak,
  Adress
}

ReaderType parseReader(int readerValue) {
  switch (readerValue) {
    case 1:
      return ReaderType.Nafe3;
    case 2:
      return ReaderType.AbnKater;
    case 4:
      return ReaderType.Abu3amro;
    case 8:
      return ReaderType.Abn3amer;
    case 16:
      return ReaderType.Asem;
    case 32:
      return ReaderType.Hamza;
    case 64:
      return ReaderType.Qesaee;
    case 128:
      return ReaderType.AbuJafer;
    case 256:
      return ReaderType.Ya3qob;
    case 512:
      return ReaderType.Kalaf;

    default:
      return ReaderType.Nafe3;
  }
}
