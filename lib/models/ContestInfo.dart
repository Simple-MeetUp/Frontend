class ContestInfo {
  final String description;
  final String field;
  final int minPeople;
  final int maxPeople;
  final DateTime activityStartPeriod;
  final DateTime activityDuePeriod;
  final DateTime registerStartPeriod;
  final DateTime registerDuePeriod;

  ContestInfo(
      {required this.description,
      required this.field,
      required this.minPeople,
      required this.maxPeople,
      required this.activityStartPeriod,
      required this.activityDuePeriod,
      required this.registerStartPeriod,
      required this.registerDuePeriod});
}
