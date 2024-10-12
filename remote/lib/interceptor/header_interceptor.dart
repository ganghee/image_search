import 'package:dio/dio.dart';

class HeaderInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.headers.addEntries({
      const MapEntry(
        'Authorization',
        'KakaoAK badd87406263e69e1a97bf19cd931eef',
      ),
    });
    handler.next(options);
  }
}
