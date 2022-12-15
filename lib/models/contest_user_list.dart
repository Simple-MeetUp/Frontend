class UserInfo {
  List<String>? categories;
  String? name;
  String? nickname;

  UserInfo(
      {
        this.categories,
        this.name,
        this.nickname,});
}
class AppliedList {
  List<UserInfo>? appliedList;
  AppliedList({this.appliedList});
}
class MemberList {
  List<UserInfo>? memberList;
  MemberList({this.memberList});
}