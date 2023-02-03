import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grand_11_live/api/dio_client.dart';
import 'package:my_grand_11_live/model/liveline.dart';
import 'package:my_grand_11_live/model/match_odds.dart';

class CommentaryController extends GetxController with StateMixin<List<Matchst>>,GetSingleTickerProviderStateMixin{
  late DioClient dioClient;
  Timer? timer;
  int? matchId;
  late TabController tabController;

  CommentaryController(this.matchId);

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 2, vsync: this);
    tabController.animateTo(tabController.index);

    dioClient = DioClient();

    change(null, status: RxStatus.loading());
    dioClient.getMatchOdds(matchId!).then((value) {

      change(value.matchst, status: RxStatus.success());
      if (value.matchst.isEmpty) {
        change(value.matchst, status: RxStatus.empty());
      }
    }).onError((error, stackTrace) {
      change(null, status: RxStatus.error());
    });

    timer = Timer.periodic(const Duration(seconds: 3), (Timer t) {
      dioClient.getMatchOdds(matchId!).then((value) {

        change(value.matchst, status: RxStatus.success());
        if (value.matchst.isEmpty) {
          change(value.matchst, status: RxStatus.empty());
        }
      }).onError((error, stackTrace) {
        change(null, status: RxStatus.error());
      });
    });
  }

  @override
  void onClose() {
    tabController?.dispose();
    timer?.cancel();
    super.onClose();
  }

  @override
  void dispose() {
    tabController?.dispose();
    timer?.cancel();
    super.dispose();
  }
}
