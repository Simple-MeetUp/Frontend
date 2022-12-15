import 'package:dawu_start_from_homescreen/http/dto.dart';

import '../models/contest_user_list.dart';

class ContestAppliedListApi {
  static AppliedList? appliedList;

  static AppliedList? getUserList() {
    // TODO: api call get method
    appliedList ??= AppliedList(
        appliedList: []);
    //  GetUserInfo 실행
    return appliedList;
  }
  static void appendUserList(UserResponses NewUser){
    UserInfo newUser=UserInfo(
      categories: NewUser.categories,
      nickname: NewUser.nickname,
      name: NewUser.name,
    );
    if(appliedList != null) {
      appliedList?.appliedList!.add(newUser);
    }
  }
  static void setUserList(AppliedList newUserList) {
    // TODO: api call post method
    appliedList = newUserList;
  }
}
class ContestMemberListApi {
  static MemberList? memberList;

  static MemberList? getUserList() {
    // TODO: api call get method
    memberList ??= MemberList(
        memberList: []);
    //  GetUserInfo 실행
    return memberList;
  }
  static void appendUserList(UserResponses NewUser){
    UserInfo newUser=UserInfo(
      categories: NewUser.categories,
      nickname: NewUser.nickname,
      name: NewUser.name,
    );
    if(memberList != null) {
      memberList?.memberList!.add(newUser);
    }
  }
  static void setUserList(MemberList newUserList) {
    // TODO: api call post method
    memberList = newUserList;
  }
}