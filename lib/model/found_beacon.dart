class FoundBeacon {
  final String identifier;
  final String uuid;
  final String major;
  final String minor;
  final String contentId;
  final double proximity;

  FoundBeacon({
    required this.identifier,
    required this.uuid,
    required this.major,
    required this.minor,
    required this.contentId,
    required this.proximity,
  });
}
