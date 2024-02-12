import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:go_moon/models/app_config.dart';

class HTTPService {
  final Dio dio = Dio();

  AppConfig? _appConfig;
  String? _base_url;
  String? _trivia_url;

  HTTPService() {
    _appConfig = GetIt.instance.get<AppConfig>();
    _base_url = _appConfig!.COIN_API_BASE_URL;
    _trivia_url = _appConfig!.TRIVIA_API_BASE_URL;
  }
  Future<Response?> get(String path) async {
    try {
      String url = "$_base_url$path";
      Response response = await dio.get(url);
      return response;
    } catch (e) {
      print("HttpService: get request failed");
      print(e);
    }
    return null;
  }

  Future<Response?> getQuestions(String difficulty) async {
    try {
      String url = "$_trivia_url?amount=10&difficulty=$difficulty&type=boolean";
      Response response = await dio.get(url);
      return response;
    } catch (e) {
      print("HttpService: get request failed");
      print(e);
    }
    return null;
  }
}
