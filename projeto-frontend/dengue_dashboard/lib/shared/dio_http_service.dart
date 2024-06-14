import 'package:dengue_dashboard/core/http_client_interface.dart';
import 'package:dio/browser.dart';
import 'package:dio/dio.dart';

class DioHttpService implements IHttpClient {
  late final Dio _dio;

  DioHttpService() {
    _dio = Dio(
      BaseOptions(
        // baseUrl: Constants.,
        contentType: Headers.jsonContentType,
      ),
    );
    // _dio.interceptors.add(DioAccessTokenInterceptor());
    //_dio.httpClientAdapter = BrowserHttpClientAdapter(withCredentials: true);
  }

  @override
  Future delete(String url, {Map<String, dynamic>? headers}) {
    return _dio.delete(url, options: Options(headers: headers));
  }

  @override
  Future get(String url, {Map<String, dynamic>? headers}) {
    return _dio.get(url, options: Options(headers: headers));
  }

  @override
  Future post(String url, {data, Map<String, dynamic>? headers}) {
    return _dio.post(url, data: data, options: Options(headers: headers));
  }

  @override
  Future put(String url, {data, Map<String, dynamic>? headers}) {
    return _dio.put(url, data: data, options: Options(headers: headers));
  }
}
