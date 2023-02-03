import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grand_11_live/api/dio_client.dart';
import 'package:my_grand_11_live/model/finised_matches.dart';
import 'package:my_grand_11_live/model/upcoming_matches.dart';

class MatchController extends GetxController
    with StateMixin<List<AllMatch>>, GetSingleTickerProviderStateMixin {
  late DioClient dioClient;
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    dioClient = DioClient();

    change(null, status: RxStatus.loading());
    dioClient.getUpcomingMatches().then((UpcomingMatches? value) {
      change(value?.allMatch, status: RxStatus.success());
      if (value?.allMatch?.isEmpty ?? true) {
        change(null, status: RxStatus.empty());
      }
    }).onError((error, stackTrace) {
      change(null, status: RxStatus.error());
    });

    tabController = TabController(length: 5, vsync: this);
    tabController.animateTo(tabController.index);

  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
