import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grand_11_live/api/dio_client.dart';
import 'package:my_grand_11_live/model/get_all_players.dart';
class InfoController extends GetxController with StateMixin<List<Playerslist>> {
  late DioClient dioClient;
  int? matchId;

  // Timer? timer;

  InfoController(this.matchId);

  @override
  void onInit() {
    super.onInit();
    dioClient = DioClient();


    change(null, status: RxStatus.loading());
    fetchData();

    // timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
    //   fetchData();
    // });
  }

  Color getColor(String ball) {
    switch (ball.toLowerCase()) {
      case "w":
      return Colors.red;
      case "wb":
        return Colors.black;
      case "nb":
        return Colors.black;
      case "4":
        return Colors.blue;
      case "6":
        return Colors.blue;
      default:
        return Colors.grey;


    }
  }

  void fetchData() {

    dioClient.getAllPlayers(matchId??0).then((value) {

      change(value.playerslist, status: RxStatus.success());
      if (value.playerslist.isEmpty) {
        change(value.playerslist, status: RxStatus.empty());
      }
    }).onError((error, stackTrace) {
      change(null, status: RxStatus.error());
    });
  }

  // @override
  // void onClose() {
  //  timer?.cancel();
  //   super.onClose();
  // }
  //
  // @override
  // void dispose() {
  //   timer?.cancel();
  //   super.dispose();
  // }

}
