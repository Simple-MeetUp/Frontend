class UserAttribute {
  // UserAuthInfo의 email 필드와 동일한 값
  final String email;
  final String name;
  final bool gender;
  final DateTime birthDate;
  String nickname;
  String field;

  final int joinedCount; // 참여공모전 횟수
  final List<String> joinedContestList; // 참여공모전 목록

  UserAttribute(
      {required this.email,
      required this.nickname,
      required this.name,
      required this.gender,
      required this.birthDate,
      required this.field,
      required this.joinedCount,
      required this.joinedContestList});

  @override
  void show() {
    print("name: $name, field: $field, joinedCount: $joinedCount");
    for (String item in joinedContestList) {
      print("$item ");
    }
  }
}
