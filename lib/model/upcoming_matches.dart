import 'dart:convert';

import 'finised_matches.dart';

UpcomingMatches upcomingMatchesFromMap(String str) =>
    UpcomingMatches.fromMap(json.decode(str));

String upcomingMatchesToMap(UpcomingMatches data) => json.encode(data.toMap());

class UpcomingMatches {
  UpcomingMatches({
    this.playerslist,
    this.allMatch,
    this.success,
    this.msg,
  });

  dynamic playerslist;
  List<AllMatch>? allMatch;
  bool? success;
  String? msg;

  factory UpcomingMatches.fromMap(Map<String, dynamic> json) => UpcomingMatches(
        playerslist: json["Playerslist"],
        allMatch: List<AllMatch>.from(
            json["AllMatch"].map((x) => AllMatch.fromMap(x))),
        success: json["success"],
        msg: json["msg"],
      );

  Map<String, dynamic> toMap() => {
        "Playerslist": playerslist,
        "AllMatch": List<dynamic>.from(allMatch!.map((x) => x.toMap())),
        "success": success,
        "msg": msg,
      };
}

// class AllMatch {
//   AllMatch({
//     this.title,
//     this.matchtime,
//     this.venue,
//     this.matchId,
//     this.teamA,
//     this.teamB,
//     this.teamAImage,
//     this.matchtype,
//     this.teamBImage,
//     this.result,
//     this.imageUrl,
//   });
//
//   String? title;
//   String? matchtime;
//   String? venue;
//   int? matchId;
//   String? teamA;
//   String? teamB;
//   String? teamAImage;
//   dynamic matchtype;
//   String? teamBImage;
//   dynamic result;
//   String? imageUrl;
//
//   factory AllMatch.fromMap(Map<String, dynamic> json) => AllMatch(
//         title: json["Title"],
//         matchtime: json["Matchtime"],
//         venue: json["Venue"],
//         matchId: json["MatchId"],
//         teamA: json["TeamA"],
//         teamB: json["TeamB"],
//         teamAImage: json["TeamAImage"],
//         matchtype: json["Matchtype"],
//         teamBImage: json["TeamBImage"],
//         result: json["Result"],
//         imageUrl: json["ImageUrl"],
//       );
//
//   Map<String, dynamic> toMap() => {
//         "Title": title,
//         "Matchtime": matchtime,
//         "Venue": venue,
//         "MatchId": matchId,
//         "TeamA": teamA,
//         "TeamB": teamB,
//         "TeamAImage": teamAImage,
//         "Matchtype": matchtype,
//         "TeamBImage": teamBImage,
//         "Result": result,
//         "ImageUrl": imageUrl,
//       };
// }
