class UserAttribute {
  // UserAuthInfo의 email 필드와 동일한 값
  final String email;
  final String name;
  final bool gender;
  final DateTime birthDate;
  String nickname;
  String field;

  UserAttribute(
      {required this.email,
      required this.nickname,
      required this.name,
      required this.gender,
      required this.birthDate,
      required this.field});
}
