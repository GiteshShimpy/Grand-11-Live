// To parse this JSON data, do
//
//     final matchOdds = matchOddsFromMap(jsonString);

import 'dart:convert';

MatchOdds matchOddsFromMap(String str) => MatchOdds.fromMap(json.decode(str));

String matchOddsToMap(MatchOdds data) => json.encode(data.toMap());

class MatchOdds {
  MatchOdds({
    required this.matchst,
    required this.success,
    required this.msg,
  });

  List<Matchst> matchst;
  bool success;
  String msg;

  factory MatchOdds.fromMap(Map<String, dynamic> json) => MatchOdds(
        matchst:
            List<Matchst>.from(json["Matchst"].map((x) => Matchst.fromMap(x))),
        success: json["success"],
        msg: json["msg"],
      );

  Map<String, dynamic> toMap() => {
        "Matchst": List<dynamic>.from(matchst.map((x) => x.toMap())),
        "success": success,
        "msg": msg,
      };
}

class Matchst {
  Matchst({
    required this.score,
    required this.sessionA,
    required this.sessionB,
    required this.overs,
    required this.matchId,
    required this.battingteam,
    required this.wickets,
    required this.mrateA,
    required this.mrateB,
    required this.favourite,
    required this.isfirstinning,
    required this.subdate,
    required this.teamruns,
    required this.id,
  });

  String score;
  String sessionA;
  String sessionB;
  String overs;
  int matchId;
  String battingteam;
  String wickets;
  String mrateA;
  String mrateB;
  String favourite;
  String isfirstinning;
  String subdate;
  String teamruns;
  int id;

  factory Matchst.fromMap(Map<String, dynamic> json) => Matchst(
        score: json["Score"],
        sessionA: json["SessionA"],
        sessionB: json["SessionB"],
        overs: json["overs"],
        matchId: json["MatchId"],
        battingteam: json["Battingteam"],
        wickets: json["wickets"],
        mrateA: json["MrateA"],
        mrateB: json["MrateB"],
        favourite: json["favourite"],
        isfirstinning: json["isfirstinning"],
        subdate: json["subdate"],
        teamruns: json["Teamruns"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "Score": score,
        "SessionA": sessionA,
        "SessionB": sessionB,
        "overs": overs,
        "MatchId": matchId,
        "Battingteam": battingteam,
        "wickets": wickets,
        "MrateA": mrateA,
        "MrateB": mrateB,
        "favourite": favourite,
        "isfirstinning": isfirstinning,
        "subdate": subdate,
        "Teamruns": teamruns,
        "id": id,
      };
}
