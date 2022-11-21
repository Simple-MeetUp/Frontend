import '../models/user_attribute.dart';

class UserAttributeApi {
  static UserAttribute? userAttribute;

  static UserAttribute? getUserAttribute() {
    // TODO: api call get method
    userAttribute ??= UserAttribute(
        email: "email",
        nickname: "nickname",
        name: "name",
        gender: true,
        birthDate: DateTime.now(),
        field: "");

    return userAttribute;
  }

  static void setUserAttribute(UserAttribute newUserAttribute) {
    // TODO: api call post method
    userAttribute = newUserAttribute;
  }
}
