import 'dart:convert';

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

  String toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['birthday'] = birthday;
    data['email'] = email;
    data['gender'] = gender;
    data['name'] = name;
    data['nickname'] = nickname;
    data['password'] = password;

    return json.encode(data); // json.encode 적용하여 최종적으로 String 형태로 반환
  }
}

class UserResponse {
  String? birthday;
  String? categories;
  String? email;
  String? gender;
  String? name;
  String? nickname;
  TokenResponse? tokenResponse;

  UserResponse(
      {this.birthday,
      this.categories,
      this.email,
      this.gender,
      this.name,
      this.nickname,
      this.tokenResponse});

  UserResponse.fromJson(Map<String, dynamic> json) {
    birthday = json['birthday'];
    categories = json['categories'].cast<String>().join(' ');
    email = json['email'];
    gender = json['gender'];
    name = json['name'];
    nickname = json['nickname'];
    tokenResponse = json['tokenResponse'] != null
        ? TokenResponse.fromJson(json['tokenResponse'])
        : null;
  }
}

class TokenResponse {
  String? accessToken;
  String? refreshToken;

  TokenResponse(String s, {this.accessToken, this.refreshToken});

  TokenResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    return data;
  }
}

class EmailRequest {
  String? email;

  EmailRequest({this.email});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
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

  String toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return jsonEncode(data);
  }
}

class ModifyRequest {
  String? nickname;
  List<String>? categories;

  ModifyRequest({this.nickname, this.categories});

  String toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nickname'] = nickname;
    data['categories'] = List<String>.from(categories!.map((x) => x));
    data['showParticipationCount'] = true;
    data['showParticipationList'] = true;
    return jsonEncode(data);
  }
}

class CompetitionResponse {
  String? activityDurationFrom;
  String? activityDurationTo;
  String? categories;
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
      this.categories,
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
    categories = json['categories'].cast<String>().join(' ');
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
  List<CompetitionResponse> competitions = [];
  int userId = 0;

  PageCompetitionResponse({required this.competitions, required this.userId});

  PageCompetitionResponse.fromJson(Map<String, dynamic> json) {
    if (json['competitions'] != null) {
      competitions = <CompetitionResponse>[];
      json['competitions'].forEach((v) {
        competitions.add(CompetitionResponse.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activityDurationFrom'] = activityDurationFrom;
    data['activityDurationTo'] = activityDurationTo;
    data['category'] = category;
    data['contents'] = contents;
    data['enrollDurationFrom'] = enrollDurationFrom;
    data['enrollDurationTo'] = enrollDurationTo;
    data['personnelLowerBound'] = personnelLowerBound;
    data['personnelUpperBound'] = personnelUpperBound;
    data['title'] = title;
    return data;
  }
}
