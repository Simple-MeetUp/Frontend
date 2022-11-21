import '../models/user_auth_info.dart';

class UserAuthInfoApi {
  static UserAuthInfo? userAuthInfo;

  static UserAuthInfo? getUserAuthInfo() {
    // TODO: call API get method
    return userAuthInfo;
  }

  static void setUserAuthInfo(UserAuthInfo newUserAuthInfo) {
    // TODO: call API post method
    userAuthInfo = newUserAuthInfo;
  }
}
