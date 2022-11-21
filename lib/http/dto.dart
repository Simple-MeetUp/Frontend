class SignUpRequest {
  String? birthday;
  String? email;
  String? gender;
  String? name;
  String? nickname;
  String? password;

  SignUpRequest(
      {this.birthday,
        this.email,
        this.gender,
        this.name,
        this.nickname,
        this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['birthday'] = this.birthday;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['name'] = this.name;
    data['nickname'] = this.nickname;
    data['password'] = this.password;
    return data;
  }
}


class UserResponse {
  String? birthday;
  String? category;
  String? email;
  String? gender;
  String? name;
  String? nickname;
  TokenResponse? tokenResponse;

  UserResponse(
      {this.birthday,
        this.category,
        this.email,
        this.gender,
        this.name,
        this.nickname,
        this.tokenResponse});

  UserResponse.fromJson(Map<String, dynamic> json) {
    birthday = json['birthday'];
    category = json['category'];
    email = json['email'];
    gender = json['gender'];
    name = json['name'];
    nickname = json['nickname'];
    tokenResponse = json['tokenResponse'] != null
        ? new TokenResponse.fromJson(json['tokenResponse'])
        : null;
  }
}

class TokenResponse {
  String? accessToken;
  String? refreshToken;

  TokenResponse({this.accessToken, this.refreshToken});

  TokenResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}

class EmailRequest {
  String? email;

  EmailRequest({this.email});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    return data;
  }
}

class StringResponse {
  String? message;

  StringResponse({this.message});

  StringResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}

class LoginRequest {
  String? email;
  String? password;

  LoginRequest({this.email, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}

class CompetitionResponse {
  String? activityDurationFrom;
  String? activityDurationTo;
  String? category;
  int? competitionId;
  String? contents;
  String? enrollDurationFrom;
  String? enrollDurationTo;
  int? personnelLowerBound;
  int? personnelUpperBound;
  String? status;
  String? title;

  CompetitionResponse(
      {this.activityDurationFrom,
        this.activityDurationTo,
        this.category,
        this.competitionId,
        this.contents,
        this.enrollDurationFrom,
        this.enrollDurationTo,
        this.personnelLowerBound,
        this.personnelUpperBound,
        this.status,
        this.title});

  CompetitionResponse.fromJson(Map<String, dynamic> json) {
    activityDurationFrom = json['activityDurationFrom'];
    activityDurationTo = json['activityDurationTo'];
    category = json['category'];
    competitionId = json['competitionId'];
    contents = json['contents'];
    enrollDurationFrom = json['enrollDurationFrom'];
    enrollDurationTo = json['enrollDurationTo'];
    personnelLowerBound = json['personnelLowerBound'];
    personnelUpperBound = json['personnelUpperBound'];
    status = json['status'];
    title = json['title'];
  }
}

class PageCompetitionResponse {
  List<CompetitionResponse>? competitions;
  int? userId;

  PageCompetitionResponse({this.competitions, this.userId});

  PageCompetitionResponse.fromJson(Map<String, dynamic> json) {
    if (json['competitions'] != null) {
      competitions = <CompetitionResponse>[];
      json['competitions'].forEach((v) {
        competitions!.add(CompetitionResponse.fromJson(v));
      });
    }
    userId = json['userId'];
  }
}

class CompetitionRequest {
  String? activityDurationFrom;
  String? activityDurationTo;
  String? category;
  String? contents;
  String? enrollDurationFrom;
  String? enrollDurationTo;
  int? personnelLowerBound;
  int? personnelUpperBound;
  String? title;

  CompetitionRequest(
      {this.activityDurationFrom,
        this.activityDurationTo,
        this.category,
        this.contents,
        this.enrollDurationFrom,
        this.enrollDurationTo,
        this.personnelLowerBound,
        this.personnelUpperBound,
        this.title});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activityDurationFrom'] = this.activityDurationFrom;
    data['activityDurationTo'] = this.activityDurationTo;
    data['category'] = this.category;
    data['contents'] = this.contents;
    data['enrollDurationFrom'] = this.enrollDurationFrom;
    data['enrollDurationTo'] = this.enrollDurationTo;
    data['personnelLowerBound'] = this.personnelLowerBound;
    data['personnelUpperBound'] = this.personnelUpperBound;
    data['title'] = this.title;
    return data;
  }
}
