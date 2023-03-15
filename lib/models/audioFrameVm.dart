class FrameVm {
  final int ayaNumber;
  final String duration;
  late Duration frameDuration;

  FrameVm({
    required this.ayaNumber,
    required this.duration,
  }) {
    frameDuration = parseDuration(duration);
  }

  factory FrameVm.fromMap(Map<String, dynamic> json) => FrameVm(
        ayaNumber: json["ayaNumber"],
        duration: json["duration"],
      );

  Map<String, dynamic> toMap() => {
        "ayaNumber": ayaNumber,
        "duration": duration,
      };

  Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }

    var parse = double.parse(parts[parts.length - 1]);
    micros = (parse * 1000000).round();

    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }
}
