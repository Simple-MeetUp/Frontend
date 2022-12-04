import 'ContestInfo.dart';

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
