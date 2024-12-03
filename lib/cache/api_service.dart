import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:path_provider/path_provider.dart';

class ApiService {
  late Dio _dio;

  ApiService() {
    _initializeDio();
  }

  Future<void> _initializeDio() async {
    // Đường dẫn để lưu cache
    final appDocDir = await getApplicationDocumentsDirectory();
    final cacheStore =
        HiveCacheStore(appDocDir.path, hiveBoxName: 'cache_excample');

    final cacheOptions = CacheOptions(
      store: cacheStore, // Lưu cache trong Hive
      policy: CachePolicy.forceCache, // Lưu mọi yêu cầu GET thành công
      priority: CachePriority.high,
      hitCacheOnErrorExcept: [401, 404],
      keyBuilder: (request) => request.uri.toString(),
      maxStale: const Duration(minutes: 10), // Cache tồn tại trong 10 phút
    );

    _dio = Dio(BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));

    // Thêm Interceptor
    _dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));
  }

  Future<List<dynamic>> fetchPosts({bool refresh = false}) async {
    try {
      final options = Options(extra: {'cache': true, 'refresh': refresh});
      final response = await _dio.get('/posts', options: options);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
