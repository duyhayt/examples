import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:testkey/firebase/routes/app_routes.gr.dart';
import 'package:testkey/firebase/services/firebase_options.dart';
import 'package:testkey/firebase/services/firebase_service.dart';

import 'routes/app_routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Received message background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseService().initialize();
  await FirebaseService().settingNotifications();
  await FirebaseService().handleMessages();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'demo_firebase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: appRouter.config(),
      key: navigatorKey,
    );
  }
}

@RoutePage()
class DemoFirebasePage extends StatefulWidget {
  const DemoFirebasePage({super.key});

  @override
  State<DemoFirebasePage> createState() => _DemoFirebasePageState();
}

class _DemoFirebasePageState extends State<DemoFirebasePage> {
  @override
  void initState() {
    super.initState();

    /// Xử lý khi ấn thông báo khi app đang tắt
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        if (mounted) {
          context.router.push(const ThirdRoute());
        }
      }
    });

    /// Xử lý khi ấn thông báo khi app đang chạy
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (mounted) {
        context.router.push(const ThirdRoute());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("Demo firebase"),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            context.router.push(const FirstRoute());
          }),
    );
  }
}
