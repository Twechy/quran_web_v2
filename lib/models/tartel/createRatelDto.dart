class CreateRatelDto {
  CreateRatelDto({
    required this.title,
    required this.header,
    required this.fotter,
  });

  final String title;
  final String header;
  final String fotter;

  factory CreateRatelDto.fromJson(Map<String, dynamic> json) => CreateRatelDto(
    title: json["title"],
    header: json["header"],
    fotter: json["fotter"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "header": header,
    "fotter": fotter,
  };
}
