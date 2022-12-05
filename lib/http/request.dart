import 'dart:convert';
import 'dart:io';

import 'package:dawu_start_from_homescreen/models/Contest.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/ContestInfo.dart';
import 'dto.dart';

Future<UserResponse> SignUp(String uri, SignUpRequest signUpRequest) async {
  final response = await http.post(
    Uri.parse(uri),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: signUpRequest.toJson(),
  );
  if (response.statusCode == 200) {
    return UserResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    // Future 객체의 실행구문에서 error 발생시켜, 호출한 구문의 then() 내부의 onError 콜백 함수가 실행되도록 한다.
    return Future.error(
        '${json.decode(utf8.decode(response.bodyBytes))['status']}: Failed to post signup');
  }
}

Future<UserResponse> Login(String uri, LoginRequest loginRequest) async {
  final response = await http.post(
    Uri.parse(uri),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: loginRequest.toJson(),
  );
  if (response.statusCode == 200) {
    return UserResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    // Future 객체의 실행구문에서 error 발생시켜, 호출한 구문의 then() 내부의 onError 콜백 함수가 실행되도록 한다.
    return Future.error(
        '${json.decode(utf8.decode(response.bodyBytes))['status']}: Failed to post login');
  }
}

Future<UserResponse> Modify(
    String uri, ModifyRequest modifyRequest, String? accessToken) async {
  final response = await http.post(
    Uri.parse(uri),
    headers: <String, String>{
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer ${accessToken!}"
    },
    body: modifyRequest.toJson(),
  );
  if (response.statusCode == 200) {
    return UserResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    // Future 객체의 실행구문에서 error 발생시켜, 호출한 구문의 then() 내부의 onError 콜백 함수가 실행되도록 한다.
    return Future.error(
        '${json.decode(utf8.decode(response.bodyBytes))['status']}: Failed to post login');
  }
}

Future<StringResponse> Reset(String uri, EmailRequest emailRequest) async {
  final response = await http.post(
    Uri(path: uri),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: emailRequest.toJson(),
  );
  if (response.statusCode == 200) {
    return StringResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to post login');
  }
}

Future<StringResponse> Nickname(String uri, String nickname) async {
  final response = await http.post(
    Uri(path: uri, queryParameters: <String, String>{
      'nickname': nickname,
    }),
  );
  if (response.statusCode == 200) {
    return StringResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to post login');
  }
}

Future<StringResponse> Email(String uri, EmailRequest emailRequest) async {
  final response = await http.post(
    Uri(path: uri),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: emailRequest.toJson(),
  );
  if (response.statusCode == 200) {
    return StringResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to post login');
  }
}

Future<CompetitionResponse?> Submit(String uri, Contest contest,
    ContestInfo contestInfo, String? accessToken) async {
  print('[debug] ${json.encode(<String, dynamic>{
        "activityDurationFrom": DateFormat("yyyy-MM-dd")
            .format(contestInfo.activityStartPeriod)
            .toString(),
        "activityDurationTo": DateFormat("yyyy-MM-dd")
            .format(contestInfo.activityDuePeriod)
            .toString(),
        "categories": contestInfo.field.split(" "),
        "contents": contestInfo.description,
        "enrollDurationFrom": DateFormat("yyyy-MM-dd")
            .format(contestInfo.registerStartPeriod)
            .toString(),
        "enrollDurationTo": DateFormat("yyyy-MM-dd")
            .format(contestInfo.registerDuePeriod)
            .toString(),
        "personnelLowerBound": contestInfo.minPeople,
        "personnelUpperBound": contestInfo.maxPeople,
        "title": contest.title
      })}');

  final Uri newUri = Uri.parse(uri);

  final response = await http.post(newUri,
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: "Bearer ${accessToken!}"
      },
      body: json.encode(<String, dynamic>{
        "activityDurationFrom": DateFormat("yyyy-MM-dd")
            .format(contestInfo.activityStartPeriod)
            .toString(),
        "activityDurationTo": DateFormat("yyyy-MM-dd")
            .format(contestInfo.activityDuePeriod)
            .toString(),
        "categories": contestInfo.field.split(" "),
        "contents": contestInfo.description,
        "enrollDurationFrom": DateFormat("yyyy-MM-dd")
            .format(contestInfo.registerStartPeriod)
            .toString(),
        "enrollDurationTo": DateFormat("yyyy-MM-dd")
            .format(contestInfo.registerDuePeriod)
            .toString(),
        "personnelLowerBound": contestInfo.minPeople,
        "personnelUpperBound": contestInfo.maxPeople,
        "title": contest.title
      }));
  if (response.statusCode == 200) {
    print("[debug] submitting successful");
    return CompetitionResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    print("[debug] ${response.statusCode} error on submitting");
    return Future.error(
        '${json.decode(utf8.decode(response.bodyBytes))['status']}: Failed to submit contest');
  }
}

Future<CompetitionResponse> Set(
    String uri, CompetitionRequest competitionRequest) async {
  final response = await http.post(
    Uri(path: uri),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: competitionRequest.toJson(),
  );
  if (response.statusCode == 200) {
    return CompetitionResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to post login');
  }
}

Future<CompetitionResponse> Join(String uri, String mission) async {
  final response = await http.post(
    Uri(path: uri, queryParameters: <String, String>{
      'mission': mission,
    }),
  );
  if (response.statusCode == 200) {
    return CompetitionResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to post login');
  }
}

Future<PageCompetitionResponse> Get(String uri, String status) async {
  final response = await http.post(
    Uri(path: uri, queryParameters: <String, String>{
      'status': status,
    }),
  );
  if (response.statusCode == 200) {
    return PageCompetitionResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to post login');
  }
}
