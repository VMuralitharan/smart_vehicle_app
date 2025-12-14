class AlertModel {
  final String id;
  final String title;
  final String description;
  final DateTime timestamp;

  AlertModel({
    required this.id,
    required this.title,
    required this.description,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}
