import '../models/user_attribute.dart';

class UserAttributeApi {
  static UserAttribute? userAttribute;

  // dummy data
  static UserAttribute? getUserAttribute() {
    // TODO: api call get method
    userAttribute ??= UserAttribute(
        email: "email",
        nickname: "nickname",
        name: "name",
        gender: true,
        birthDate: DateTime.now(),
        field: "프론트엔드",
        joinedCount: 3,
        joinedContestList: ["단국대 경소톤", "다우기술 프로그래밍 경진대회", "창의적 아이디어 경진대회"]);

    return userAttribute;
  }

  static void setUserAttribute(UserAttribute newUserAttribute) {
    // TODO: api call post method
    userAttribute = newUserAttribute;
  }
}
