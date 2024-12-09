import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:testkey/ads/ads_page.dart';

/*
1. Banner Ads:
Quảng cáo nhỏ xuất hiện ở trên cùng hoặc dưới cùng màn hình.
Dễ triển khai và không làm gián đoạn trải nghiệm người dùng.

2. Interstitial Ads:
Quảng cáo toàn màn hình xuất hiện ở các điểm chuyển tiếp, như sau khi kết thúc một cấp độ.
Người dùng phải tương tác (đóng hoặc nhấn) để tiếp tục.

3. Rewarded Ads:
Quảng cáo mà người dùng nhận được phần thưởng (như điểm, xu, vật phẩm) khi xem.
Tốt cho các ứng dụng trò chơi hoặc ứng dụng có mô hình khuyến khích.
*/
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

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
      home: const AdsPage(),
    );
  }
}
