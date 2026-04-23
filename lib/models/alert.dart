class Alert {
  final String senderName;
  final String event;
  final int start;
  final int end;
  final String description;

  Alert({
    required this.senderName,
    required this.event,
    required this.start,
    required this.end,
    required this.description,
  });

  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
      senderName: json['sender_name'] ?? '',
      event: json['event'] ?? '',
      start: json['start'] ?? 0,
      end: json['end'] ?? 0,
      description: json['description'] ?? '',
    );
  }
}