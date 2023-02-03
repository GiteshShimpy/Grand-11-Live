import 'dart:convert';

import 'package:my_grand_11_live/model/upcoming_matches.dart';

AllMatches upcomingMatchesFromMap(String str) =>
    AllMatches.fromMap(json.decode(str));

// ignore: non_constant_identifier_names
String AllMatchesToMap(UpcomingMatches data) => json.encode(data.toMap());

class AllMatches {
  AllMatches({
    this.title,
    this.matchtime,
    this.venue,
    this.matchId,
    this.teamA,
    this.teamB,
    this.teamAImage,
    this.matchtype,
    this.teamBImage,
    this.result,
    this.imageUrl,
  });

  String? title;
  String? matchtime;
  String? venue;
  int? matchId;
  String? teamA;
  String? teamB;
  String? teamAImage;
  dynamic matchtype;
  String? teamBImage;
  dynamic result;
  String? imageUrl;

  factory AllMatches.fromMap(Map<String, dynamic> json) => AllMatches(
        title: json["Title"],
        matchtime: json["Matchtime"],
        venue: json["Venue"],
        matchId: json["MatchId"],
        teamA: json["TeamA"],
        teamB: json["TeamB"],
        teamAImage: json["TeamAImage"],
        matchtype: json["Matchtype"],
        teamBImage: json["TeamBImage"],
        result: json["Result"],
        imageUrl: json["ImageUrl"],
      );

  Map<String, dynamic> toMap() => {
        "Title": title,
        "Matchtime": matchtime,
        "Venue": venue,
        "MatchId": matchId,
        "TeamA": teamA,
        "TeamB": teamB,
        "TeamAImage": teamAImage,
        "Matchtype": matchtype,
        "TeamBImage": teamBImage,
        "Result": result,
        "ImageUrl": imageUrl,
      };
}
