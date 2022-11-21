class Contest {
  final int id; // PK. 1부터 시작
  final String thumbnail;
  final String title;
  final String subtitle; // subtitle은 contestInfo.field와 같음
  final ContestInfo contestInfo;

  Contest(
      {required this.id,
      required this.thumbnail,
      required this.title,
      required this.subtitle,
      required this.contestInfo});
}

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
