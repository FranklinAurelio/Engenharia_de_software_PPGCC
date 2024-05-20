abstract class IHttpClient {
  Future get(String url, {Map<String, dynamic>? headers});
  Future post(String url, {dynamic data, Map<String, dynamic>? headers});
  Future put(String url, {dynamic data, Map<String, dynamic>? headers});
  Future delete(String url, {Map<String, dynamic>? headers});
}
