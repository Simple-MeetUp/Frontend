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
  static void resetEmail(String Email){
    userAttribute?.email = Email;
  }
  static void resetNickname(String Nickname){
    userAttribute?.nickname = Nickname;
  }
  static void resetName(String Name){
    userAttribute?.name = Name;
  }
  static void resetGender(bool Gender){
    userAttribute?.gender = Gender;
  }
  static void resetBirthdate(DateTime Birthdate){
    userAttribute?.birthDate = Birthdate;
  }
  static void resetField(String Field){
    userAttribute?.field = Field;
  }
}
