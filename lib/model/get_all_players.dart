// To parse this JSON data, do
//
//     final getAllPlayers = getAllPlayersFromMap(jsonString);

import 'dart:convert';

GetAllPlayers getAllPlayersFromMap(String str) =>
    GetAllPlayers.fromMap(json.decode(str));

String getAllPlayersToMap(GetAllPlayers data) => json.encode(data.toMap());

class GetAllPlayers {
  GetAllPlayers({
    required this.playerslist,
    required this.allMatch,
    required this.success,
    required this.msg,
  });

  List<Playerslist> playerslist;
  dynamic allMatch;
  bool success;
  String msg;

  factory GetAllPlayers.fromMap(Map<String, dynamic> json) => GetAllPlayers(
        playerslist: List<Playerslist>.from(
            json["Playerslist"].map((x) => Playerslist.fromMap(x))),
        allMatch: json["AllMatch"],
        success: json["success"],
        msg: json["msg"],
      );

  Map<String, dynamic> toMap() => {
        "Playerslist": List<dynamic>.from(playerslist.map((x) => x.toMap())),
        "AllMatch": allMatch,
        "success": success,
        "msg": msg,
      };
}

class Playerslist {
  Playerslist({
    required this.teamName,
    required this.playerName,
    required this.matchId,
    required this.teamRuns,
    required this.playerImage,
    required this.runs,
    required this.teamSide,
    required this.balls,
    required this.four,
    required this.six,
    required this.seqno,
    required this.outby,
    required this.inning,
    required this.isnotout,
  });

  String teamName;
  String playerName;
  int matchId;
  String teamRuns;
  String playerImage;
  int runs;
  String teamSide;
  int balls;
  int four;
  int six;
  int seqno;
  String outby;
  int inning;
  int isnotout;

  factory Playerslist.fromMap(Map<String, dynamic> json) => Playerslist(
        teamName: json["TeamName"],
        playerName: json["PlayerName"],
        matchId: json["MatchId"],
        teamRuns: json["TeamRuns"],
        playerImage: json["PlayerImage"],
        runs: json["Runs"],
        teamSide: json["TeamSide"],
        balls: json["Balls"],
        four: json["four"],
        six: json["six"],
        seqno: json["seqno"],
        outby: json["outby"],
        inning: json["inning"],
        isnotout: json["isnotout"],
      );

  Map<String, dynamic> toMap() => {
        "TeamName": teamName,
        "PlayerName": playerName,
        "MatchId": matchId,
        "TeamRuns": teamRuns,
        "PlayerImage": playerImage,
        "Runs": runs,
        "TeamSide": teamSide,
        "Balls": balls,
        "four": four,
        "six": six,
        "seqno": seqno,
        "outby": outby,
        "inning": inning,
        "isnotout": isnotout,
      };
}
