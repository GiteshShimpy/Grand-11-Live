import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grand_11_live/api/dio_news_client.dart';
import 'package:my_grand_11_live/model/NewsEverything.dart';

class NewsController extends GetxController
    with StateMixin<List<Article>> ,GetSingleTickerProviderStateMixin {
  late DioNewsClient dioClient;
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    dioClient = DioNewsClient();
    tabController = TabController(length: 2, vsync: this);
    tabController.animateTo(tabController.index);
  }

  fetchEverything() {
    change(null, status: RxStatus.loading());
    dioClient.getNewsEverything().then((NewsEverything? value) {
      if (value?.articles?.isEmpty ?? true) {
        change(value?.articles, status: RxStatus.empty());
      } else {
        change(value?.articles, status: RxStatus.success());
      }
    }).onError((error, stackTrace) {

    });
  }

  fetchHeadlines() {
    change(null, status: RxStatus.loading());
    dioClient.getHeadlines().then((NewsEverything? value) {
      if (value?.articles?.isEmpty ?? true) {
        change(value?.articles, status: RxStatus.empty());
      } else {
        change(value?.articles, status: RxStatus.success());
      }
    }).onError((error, stackTrace) {
      change(null, status: RxStatus.error());
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
