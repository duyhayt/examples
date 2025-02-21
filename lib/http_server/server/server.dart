
// import 'package:flutter/material.dart';
// import 'package:shelf/shelf.dart';
// import 'package:shelf/shelf_io.dart' as shelf_io;

// Future<void> runServer(String certPath, String keyPath) async {
//   const router = Router();

//   // API test endpoint
//   router.get('/ping', (Request request) {
//     return Response.ok('pong');
//   });

//   // Cấu hình SecurityContext với chứng chỉ đã tải
//   final securityContext = SecurityContext()
//     ..useCertificateChain(certPath)
//     ..usePrivateKey(keyPath);

//   final server = await shelf_io.serve(
//     router,
//     InternetAddress.anyIPv4,
//     8443, // Chạy trên cổng HTTPS 8443
//     securityContext: securityContext, // Kích hoạt HTTPS
//   );

//   print('Server HTTPS chạy tại: https://${server.address.host}:${server.port}');
// }
