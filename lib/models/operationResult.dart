class OperationResult {
  OperationResult({
    required this.type,
    required this.messages,
    required this.traceId,
  });

  final int type;
  final List<String> messages;
  final String traceId;

  factory OperationResult.fromJson(Map<String, dynamic> json) =>
      OperationResult(
        type: json["type"],
        messages:  List<String>.from(json["messages"].map((x) => x)),
        traceId: json["traceId"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "messages":  List<dynamic>.from(messages.map((x) => x)),
        "traceId": traceId,
      };
}
