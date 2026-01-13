import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_house/app/config/string_endpoint.dart';

import '../core/messages/messages.dart';

class Api {
  Api._internal();

  static final Api _singleton = Api._internal();

  factory Api() => _singleton;

  final box = GetStorage();
  late final Dio dio = _createDio(); // single instance

  Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: EndPoint.API_BASE_URL,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        connectTimeout: const Duration(seconds: 50),
        receiveTimeout: const Duration(seconds: 50),
      ),
    );
    _configureDio(dio);
    return dio;
  }

  void _configureDio(Dio dio) {
    dio.interceptors.addAll([
      LogInterceptor(
        requestHeader: true,
        responseHeader: false,
        responseBody: true,
        requestBody: true,
      ),
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = box.read('jwtToken');
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onResponse: (options, handler) {
          return handler.next(options);
        },
        onError: (error, handler) {
          switch (error.type) {
            case DioExceptionType.connectionTimeout:
            case DioExceptionType.receiveTimeout:
              failedSnackBar(message: 'أنتهت مهلة الطلب الرجاء إعادة المحاولة');
              break;
            case DioExceptionType.connectionError:
              failedSnackBar(message: 'لا يوجد اتصال بالانترنت');
              break;
            case DioExceptionType.badResponse:
              final msg =
                  error.response?.data['message'] ?? 'حدث خطأ في الخادم';
              failedSnackBar(message: msg);
              break;
            default:
            failedSnackBar(message: 'حدث خطأ غير متوقع');
          }
          return handler.next(error);
        },
      ),
    ]);
  }
}
