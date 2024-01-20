class IngBeacon {
  final String identifier;
  final String uuid;
  final String major;
  final String minor;
  final String contentId;

  IngBeacon({
    required this.identifier,
    required this.uuid,
    required this.major,
    required this.minor,
    required this.contentId,
  });

  factory IngBeacon.fromJson(Map<String, dynamic> json) {
    return IngBeacon(
      identifier: json['identifier'],
      uuid: json['uuid'],
      major: json['major'],
      minor: json['minor'],
      contentId: json['contentId'],
    );
  }
}
