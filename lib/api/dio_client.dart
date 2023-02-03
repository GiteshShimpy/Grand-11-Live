import 'package:dio/dio.dart';
import 'package:my_grand_11_live/model/NewsEverything.dart';

import '../model/finised_matches.dart';
import '../model/get_all_players.dart';
import '../model/liveline.dart';
import '../model/match_odds.dart';
import '../model/upcoming_matches.dart';
import 'logger_interceptor.dart';

const String baseUrl = "http://cricpro.cricnet.co.in/api/values/";
const String playerUrl = "http://cricnet.co.in/ManagePlaying/PlayerImage/";
const String teamUrl = "http://cricnet.co.in/ManagePlaying/TeamImages/";
const String newsUrl = "https://newsapi.org/v2/";

// https://newsapi.org/v2/everything?q=cricket&apikey=0e616f1090ae42c2a138fcc2b707e500
// https://newsapi.org/v2/top-headlines?country=in&category=sports&apikey=0e616f1090ae42c2a138fcc2b707e500
class DioClient {
  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: 30000,
            receiveTimeout: 10000,
            responseType: ResponseType.json,
          ),
        )..interceptors.addAll([
            LoggerInterceptor(),
          ]);

  static Dio dioClient() => Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: 5000,
          receiveTimeout: 3000,
          responseType: ResponseType.json,
        ),
      )..interceptors.addAll([
          LoggerInterceptor(),
        ]);

  late final Dio _dio;

// HTTP request methods will go here
  Future<UpcomingMatches?> getUpcomingMatches() async {
    final response = await _dio.get('upcomingMatches');
    return UpcomingMatches.fromMap(response.data);
  }

  Future<List<LiveLine>> getLiveLine() async {
    final response = await _dio.get('LiveLine');
    return (response.data as List).map((x) => LiveLine.fromMap(x)).toList();
  }

  Future<List<LiveLine>> getLiveLineMatch() async {
    final response = await _dio.get('LiveLine_Match');
    return (response.data as List).map((x) => LiveLine.fromMap(x)).toList();
  }

  Future<FinishedMatches> getFinishedMatches() async {
    final response =
        await _dio.post('MatchResults', data: {"start": 1, "end": 30});
    return FinishedMatches.fromMap(response.data);
  }

  Future<GetAllPlayers> getAllPlayers(int matchid) async {
    final response =
        await _dio.post('GetAllPlayers', data: {"MatchId": matchid});
    return GetAllPlayers.fromMap(response.data);
  }

  Future<MatchOdds> getMatchOdds(int matchid) async {
    final response = await _dio.post('MatchOdds', data: {"MatchId": matchid});
    return MatchOdds.fromMap(response.data);
  }


  Future<NewsEverything?> getNewsEverything() async {
    final response = await _dio.get('everything',queryParameters: {"q": "cricket","apikey":"0e616f1090ae42c2a138fcc2b707e500"} );
    return NewsEverything.fromMap(response.data);
  }

  Future<NewsEverything?> getHeadlines() async {
    final response = await _dio.get('top-headlines',queryParameters: {"country": "in","category":"sports","apikey":"0e616f1090ae42c2a138fcc2b707e500"} );
    return NewsEverything.fromMap(response.data);
  }
}
