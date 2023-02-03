import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grand_11_live/api/dio_client.dart';
import 'package:my_grand_11_live/model/finised_matches.dart';
import 'package:my_grand_11_live/model/upcoming_matches.dart';

class MatchDetailTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    tabController.animateTo(tabController.index);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
