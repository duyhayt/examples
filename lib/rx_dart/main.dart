import 'package:flutter/material.dart';

import 'rx_dart_page.dart';
/* 
- RxDart là 1 Reactive Progamming Library mở rộng từ Stream của Dart
- RxDart cơ bản bao gồm Stream, BehaviorSubject, ReplaySubject, PublishSubject, AsyncSubject
- Đầu tiên: + Làm quen với Stram và cách sử dụng : Stream, StreamController, ... Lắng nghe sự kiện với Stream.listen
            + Hiểu cách Data flow và Observer pattern hoạt động.
*/

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const RxDartPage(),
    );
  }
}
