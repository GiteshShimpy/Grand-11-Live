import 'package:dio/dio.dart';
import 'package:my_grand_11_live/model/NewsEverything.dart';

import '../model/finised_matches.dart';
import '../model/get_all_players.dart';
import '../model/liveline.dart';
import '../model/match_odds.dart';
import '../model/upcoming_matches.dart';
import 'logger_interceptor.dart';

const String newsUrl = "https://newsapi.org/v2/";

// https://newsapi.org/v2/everything?q=cricket&apikey=0e616f1090ae42c2a138fcc2b707e500
// https://newsapi.org/v2/top-headlines?country=in&category=sports&apikey=0e616f1090ae42c2a138fcc2b707e500
class DioNewsClient {
  DioNewsClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: newsUrl,
            connectTimeout: 5000,
            receiveTimeout: 3000,
            responseType: ResponseType.json,
          ),
        )..interceptors.addAll([
            LoggerInterceptor(),
          ]);

  late final Dio _dio;

// HTTP request methods will go here

  Future<NewsEverything?> getNewsEverything() async {
    final response = await _dio.get('everything',queryParameters: {"q": "cricket","apikey":"0e616f1090ae42c2a138fcc2b707e500"} );
    return NewsEverything.fromMap(response.data);
  }

  Future<NewsEverything?> getHeadlines() async {
    final response = await _dio.get('top-headlines',queryParameters: {"country": "in","category":"sports","apikey":"0e616f1090ae42c2a138fcc2b707e500"} );
    return NewsEverything.fromMap(response.data);
  }
}
