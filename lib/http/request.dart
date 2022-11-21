import 'dart:html';

import 'package:http/http.dart' as http;

// Future<http.Response> fetchPost(String uri) async {
//     final response =
//     await http.get(Uri(path: uri, ));
//
//     if (response.statusCode == 200) {
//       // 만약 서버가 OK 응답을 반환하면, JSON을 파싱합니다.
//       return Post.fromJson(json.decode(response.body));
//     } else {
//       // 만약 응답이 OK가 아니면, 에러를 던집니다.
//       throw Exception('Failed to load post');
//     }
//   }
// }