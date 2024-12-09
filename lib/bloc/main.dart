import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testkey/bloc/pages/bloc_example_bloc.dart';
import 'package:testkey/bloc/pages/bloc_example_page.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [BlocProvider(create: (context) => BlocExampleBloc())],
    child: const MyApp(),
  ));
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
      home: const BlocExamplePage(),
    );
  }
}
