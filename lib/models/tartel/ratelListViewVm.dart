class RatelListViewVm {
  RatelListViewVm({
    required this.ratelId,
    required this.title,
    required this.indexedRatels,
  });

  final int ratelId;
  final String title;
  final int indexedRatels;

  factory RatelListViewVm.fromJson(Map<String, dynamic> json) =>
      RatelListViewVm(
        ratelId: json["ratelId"],
        title: json["title"],
        indexedRatels:
            json["indexedRatels"],
      );

  Map<String, dynamic> toJson() => {
        "ratelId": ratelId,
        "title": title,
        "indexedRatels": indexedRatels,
      };
}
