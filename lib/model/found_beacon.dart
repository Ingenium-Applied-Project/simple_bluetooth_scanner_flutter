class FoundBeacon {
  final String identifier;
  final String uuid;
  final String major;
  final String minor;
  final String contentId;
  double proximity;
  DateTime lastFoundTime;

  FoundBeacon({
    required this.identifier,
    required this.uuid,
    required this.major,
    required this.minor,
    required this.contentId,
    required this.proximity,
    required this.lastFoundTime,
  });
}
