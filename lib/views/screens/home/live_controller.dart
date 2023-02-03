import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:my_grand_11_live/api/dio_client.dart';
import 'package:my_grand_11_live/model/liveline.dart';
import 'package:my_grand_11_live/utils/match_utils.dart';

class LiveController extends GetxController with StateMixin<List<LiveLine>>{
  late DioClient dioClient;
  Timer? timer;
   Rx<LiveLine> activeLiveMatch = LiveLine().obs;
  late List<LiveLine> allLiveMatch;

  @override
  void onInit() {
    super.onInit();

    dioClient = DioClient();

    change(null, status: RxStatus.loading());
    dioClient.getLiveLine().then((value) {
      allLiveMatch = value;
      var liveMatches = value.where((e) =>e.jsondata.isNotEmpty).toList();

      change(liveMatches, status: RxStatus.success());
      if (value.isEmpty) {
        change(value, status: RxStatus.empty());
      }
    }).onError((error, stackTrace) {
      change(null, status: RxStatus.error());
    });

    timer = Timer.periodic(const Duration(seconds: 3), (Timer t) {
      dioClient.getLiveLine().then((value) {
        allLiveMatch = value;
        var liveMatches = value.where((e) =>e.jsondata.isNotEmpty).toList();
        change(liveMatches, status: RxStatus.success());
        if (value.isEmpty) {
          change(value, status: RxStatus.empty());
        }
      }).onError((error, stackTrace) {
        change(null, status: RxStatus.error(error.toString()));
      });
    });
  }

  LiveLine getLiveMatchById(int matchId) {
    activeLiveMatch.value =
        allLiveMatch.firstWhereOrNull((element) => element.matchId == matchId)!;
    return activeLiveMatch.value;
  }


  List<String>? getLast6Balls(LiveLine liveLine) {
    return MatchUtils().getLast6Balls(liveLine);
  }

  String getRunRate(LiveLine liveLine) {
    if (liveLine.jsondata.isNotEmpty) {
      if (liveLine.jsondata.toString()

              .split("C.RR:")
              .length >=
          2) {
        return liveLine.jsondata.toString().split("C.RR:")[1].split("|")[0];
      } else {
        return "--";
      }
    } else {
      return "--";
    }
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
