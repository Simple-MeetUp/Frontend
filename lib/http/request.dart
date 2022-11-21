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