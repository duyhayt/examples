// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// Future<void> getCertificates() async {
//   final url = Uri.parse('https://backloop.dev/pack.json');

//   try {
//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);

//       final certPath = '${Directory.systemTemp.path}/server.crt';
//       final keyPath = '${Directory.systemTemp.path}/server.pem';

//       await File(certPath).writeAsString(data['cert']);
//       await File(keyPath).writeAsString(data['key']);

//       print('Chứng chỉ được lưu tại: $certPath');
//     } else {
//       print('Không thể tải chứng chỉ, lỗi ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Lỗi khi tải chứng chỉ: $e');
//   }
// }


// void main() {
//   runApp(
//     const MyApp(),
//   );

// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         useMaterial3: true,
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const RxDartPage(),
//     );
//   }
// }
