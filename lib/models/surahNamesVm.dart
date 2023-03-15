class SurahNamesVm {
  SurahNamesVm({
    required this.id,
    required this.name,
    required this.order,
    required this.landing,
    required this.description,
    required this.ayaCount,
  });

  final int id;
  final String name;
  final int order;
  final int landing;
  final String description;
  final int ayaCount;

  factory SurahNamesVm.fromJson(Map<String, dynamic> json) => SurahNamesVm(
        id: json['id'],
        name: json["name"],
        order: json["order"],
        landing: json["landing"],
        description: json["description"],
        ayaCount: json["ayaCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "order": order,
        "landing": landing,
        "description": description,
        "ayaCount": ayaCount,
      };
}
