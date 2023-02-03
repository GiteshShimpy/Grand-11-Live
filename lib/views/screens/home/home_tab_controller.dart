import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_grand_11_live/api/dio_client.dart';
import 'package:my_grand_11_live/model/finised_matches.dart';
import 'package:my_grand_11_live/model/liveline.dart';
import 'package:my_grand_11_live/model/upcoming_matches.dart';

class HomeTabViewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late DioClient dioClient;
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    dioClient = DioClient();


    tabController = TabController(length: 2, vsync: this);
    tabController.animateTo(tabController.index);

  }







  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }


}
