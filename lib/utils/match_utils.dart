import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/liveline.dart';

class MatchUtils {
  static bool isLive(String jsonData) {
    if (jsonData.toString().isEmpty) return false;
    if (getJsonData(jsonData)?.bowler != "0") {
      return true;
    }
    return false;
  }

  static DateTime getDateTime(String matchTime){
    // 20-Jan-2023 at 11:00AM-Fri
    return DateFormat("dd-MMM-yyyy hh:mma-EEE").parse(matchTime.replaceAll(" at", ""));
  }

  static String getTeamAScore(String jsonData) {
    if (jsonData.toString().isEmpty) return "";
    var liveLineJson = getJsonData(jsonData);
    return "${liveLineJson?.wicketA}"
        "${liveLineJson?.oversA?.contains(",") ?? false ? "" : " (${liveLineJson?.oversA})"}";
  }

  static String getTeamBScore(String jsonData) {
    if (jsonData.toString().isEmpty) return "";
    var liveLineJson =
    getJsonData(jsonData);
    return "${liveLineJson?.wicketB}"
        "${liveLineJson?.oversB?.contains(",") ?? false ? "" : " (${liveLineJson?.oversB})"}";
  }

  static String getTeamUrl(LiveLine liveLine, String type) {
    var liveLineJson  =  getJsonData(liveLine.jsondata);
    if (type == "A") {
      return "${liveLineJson?.imgurl}${liveLineJson?.teamABanner??liveLine.teamAImage}";
    } else {
      return "${liveLineJson?.imgurl}${liveLineJson?.teamBBanner??liveLine.teamBImage}";
    }
  }

  static String getTeamName(String jsonData, String type) {
    var liveLineJson  =  getJsonData(jsonData);
    if (type == "A") {
      return "${liveLineJson?.teamA}";
    } else {
      return "${liveLineJson?.teamB}";
    }
  }

  static String getMatchStatus(LiveLine liveLine) {
    if (liveLine.jsondata.toString().isEmpty) return "";

    return liveLine.result?.isNotEmpty ?? false
        ? "Finished"
        : MatchUtils.isLive(liveLine.jsondata.toString())
            ? "Live"
            : "Upcoming";
  }

  static Color getMatchStatusColor(String status) {
    switch (status) {
      case "Upcoming":
        return Colors.yellow;
      case "Finished":
        return Colors.red;
      case "Live":
        return Colors.green;
      default: {
        return Colors.green;
      }
    }
  }

  static String getTeamARate(String jsonRuns) {
    if (jsonRuns.toString().isEmpty) return "--";
    var liveLineJsonRun = JsonRuns.fromMap(
        jsonDecode(jsonRuns.toString().replaceAll("\n", "")));
    return "${liveLineJsonRun.jsonruns?.rateA}";
  }

  static String getTeamBRate(String jsonRuns) {
    if (jsonRuns.toString().isEmpty) return "--";
    var liveLineJsonRun = JsonRuns.fromMap(
        jsonDecode(jsonRuns.toString().replaceAll("\n", "")));
    return "${liveLineJsonRun.jsonruns?.rateB}";
  }

  static JsonRunsJsonRuns? getJsonRuns(String jsonRuns) {
    if (jsonRuns.toString().isEmpty) return null;
    var liveLineJsonRun =
        JsonRuns.fromMap(jsonDecode(jsonRuns.toString().replaceAll("\n", "")));
    return liveLineJsonRun.jsonruns;
  }

  static JsonDataJsonData? getJsonData(String jsonData) {
    if (jsonData.toString().isEmpty) return null;
    var liveLineJson =
        JsonData.fromMap(jsonDecode(jsonData.toString().replaceAll("\n", "")));

    return liveLineJson.jsondata;
  }

  static String getScore(LiveLine activeLiveMatch){
    if(MatchUtils.getJsonData(activeLiveMatch.jsondata)?.score?.isNotEmpty??false) {
      return MatchUtils.getJsonData(activeLiveMatch.jsondata)?.score?? "";
    }else {
      return "";
    }
  }

  static String? getOnlyToss(LiveLine activeLiveMatch){
      if (activeLiveMatch.jsondata
          .toString()
          .split("Toss")
          .length >= 2) {
        return activeLiveMatch.jsondata.toString().split("Toss")[1].split("\\n")[0].replaceAll("-", "").trim();
      }
      else {
        return null;
      }
  }

  List<String>? getLast6Balls(LiveLine liveLine) {
    if (liveLine.jsondata.isNotEmpty) {
      return MatchUtils.getJsonData(liveLine.jsondata)?.last6Balls?.split("-");
    } else {
      return ["-", "-", "-", "-", "-", "-"];
    }
  }

}
