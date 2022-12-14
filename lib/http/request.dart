import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dto.dart';

Future<UserResponse> SignUp(String uri, SignUpRequest signUpRequest) async {
  final response = await http.post(
    Uri(path: uri),
    headers: <String, String> {
      'Content-Type': 'application/json',
    },
    body: signUpRequest.toJson(),
  );
  if (response.statusCode == 200) {
    return UserResponse.fromJson(jsonDecode(response.body));
  } else {
   throw Exception('Failed to post signup');
  }
}

Future<UserResponse> Login(String uri, LoginRequest loginRequest) async {
  final response = await http.post(
    Uri(path: uri),
    headers: <String, String> {
      'Content-Type': 'application/json',
    },
    body: loginRequest.toJson(),
  );
  if (response.statusCode == 200) {
    return UserResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to post login');
  }
}

Future<StringResponse> Reset(String uri, EmailRequest emailRequest) async {
  final response = await http.post(
    Uri(path: uri),
    headers: <String, String> {
      'Content-Type': 'application/json',
    },
    body: emailRequest.toJson(),
  );
  if (response.statusCode == 200) {
    return StringResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to post login');
  }
}

Future<StringResponse> Nickname(String uri, String nickname) async {
  final response = await http.post(
    Uri(
        path: uri,
        queryParameters: <String, String> {
          'nickname' : nickname,
        }
    ),
  );
  if (response.statusCode == 200) {
    return StringResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to post login');
  }
}

Future<StringResponse> Email(String uri, EmailRequest emailRequest) async {
  final response = await http.post(
    Uri(path: uri),
    headers: <String, String> {
      'Content-Type': 'application/json',
    },
    body: emailRequest.toJson(),
  );
  if (response.statusCode == 200) {
    return StringResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to post login');
  }
}

Future<CompetitionResponse> Submit(String uri, String mission) async {
  final response = await http.post(
    Uri(
        path: uri,
        queryParameters: <String, String> {
          'mission' : mission,
        }
    ),
  );
  if (response.statusCode == 200) {
    return CompetitionResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to post login');
  }
}

Future<CompetitionResponse> Set(String uri, CompetitionRequest competitionRequest) async {
  final response = await http.post(
    Uri(path: uri),
    headers: <String, String> {
      'Content-Type': 'application/json',
    },
    body: competitionRequest.toJson(),
  );
  if (response.statusCode == 200) {
    return CompetitionResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to post login');
  }
}

Future<CompetitionResponse> Join(String uri, String mission) async {
  final response = await http.post(
    Uri(
        path: uri,
        queryParameters: <String, String> {
          'mission' : mission,
        }
    ),
  );
  if (response.statusCode == 200) {
    return CompetitionResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to post login');
  }
}

Future<PageCompetitionResponse> Get(String uri, String status) async {
  final response = await http.post(
    Uri(
        path: uri,
        queryParameters: <String, String> {
          'status' : status,
        }
    ),
  );
  if (response.statusCode == 200) {
    return PageCompetitionResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to post login');
  }
}
