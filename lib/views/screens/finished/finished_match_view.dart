import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_grand_11_live/model/finised_matches.dart';
import 'package:my_grand_11_live/views/components/match_card.dart';
import 'package:my_grand_11_live/views/screens/finished/finished_match_controller.dart';
import 'package:my_grand_11_live/views/screens/match/match_controller.dart';
import 'package:my_grand_11_live/views/screens/subscription.dart';

import '../../../api/dio_client.dart';
import '../../../model/liveline.dart';
import '../../../model/upcoming_matches.dart';
import '../../../utils/color.dart';
import '../../../utils/style/app_text_style.dart';

class FinishedMatchView extends StatelessWidget {
  const FinishedMatchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FinishedMatchController controller =  Get.put(FinishedMatchController());
    return SafeArea(
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("asset/images/bg.png"),
                    fit: BoxFit.fill)),
          ),
          Scaffold(
              backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: const Color(0xff071F2A),
                automaticallyImplyLeading: false,
                title: const Text(
                  "Finished Matches",
                  style: AppTextStyle.white18SemiBold,
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(themeOrange),
                        ),
                        onPressed: () => Get.to(const Subscription()),
                        child: const Text("SUBSCRIBE",
                            style: AppTextStyle.white12Normal)),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          TabBar(
                            controller: controller.tabController,
                            indicatorColor: themeOrange,
                            unselectedLabelColor: mat,
                            indicatorWeight: 2,
                            indicatorPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                            unselectedLabelStyle: AppTextStyle.white12SemiBold,
                            labelStyle: AppTextStyle.white12SemiBold,
                            tabs: const [
                              Tab(
                                text: "All",
                              ),
                              Tab(
                                text: "T20",
                              ),
                              Tab(
                                text: "Series",
                              ),
                              Tab(
                                text: "ODI",
                              ),
                              Tab(
                                text: "Test",
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1,
                              color: dividerColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TabBarView(controller: controller.tabController, children: [
                            controller.obx(
                                  (state) => ListView.builder(
                                  padding:
                                  const EdgeInsets.only(left: 0, right: 0),
                                  shrinkWrap: true,
                                  itemCount: state?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    AllMatch? allMatch =
                                    state![index];
                                    return MatchCard(
                                        allMatch);
                                  }),
                              onLoading: const Center(child: CircularProgressIndicator()),
                              onEmpty: Center(
                                child: Column(
                                  children: [
                                    Lottie.asset(
                                      "asset/images/empty.json",
                                      height: 150,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8), color: black),
                                      child: const Text(
                                        "No data found",
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.white14SemiBold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onError: (error) => Center(
                                child: Column(
                                  children: [
                                    Lottie.asset(
                                      "asset/images/network.json",
                                      height: 150,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8), color: black),
                                      child: const Text(
                                        "Unable to fetch data",
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.white14SemiBold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),  ),
                            controller.obx(
                                  (state) {
                                 state =  state?.where((element) => element.title?.contains("T20")??false).toList();
                                     return ListView.builder(
                                      padding:
                                      const EdgeInsets.only(left: 0, right: 0),
                                      shrinkWrap: true,
                                      itemCount: state?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        AllMatch? allMatch =
                                        state![index];
                                        return MatchCard(
                                            allMatch);
                                      }); },
                              onLoading: const Center(child: CircularProgressIndicator()),
                              onEmpty: Center(
                                child: Column(
                                  children: [
                                    Lottie.asset(
                                      "asset/images/empty.json",
                                      height: 150,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8), color: black),
                                      child: const Text(
                                        "No data found",
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.white14SemiBold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onError: (error) => Center(
                                child: Column(
                                  children: [
                                    Lottie.asset(
                                      "asset/images/network.json",
                                      height: 150,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8), color: black),
                                      child: const Text(
                                        "Unable to fetch data",
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.white14SemiBold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),      ),


                            controller.obx(
                                  (state) {
                                state =  state?.where((element) => element.title?.contains("Series")??false).toList();
                                return ListView.builder(
                                    padding:
                                    const EdgeInsets.only(left: 0, right: 0),
                                    shrinkWrap: true,
                                    itemCount: state?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      AllMatch? allMatch =
                                      state![index];
                                      return MatchCard(
                                          allMatch);
                                    }); },
                              onLoading: const Center(child: CircularProgressIndicator()),
                              onEmpty: Center(
                                child: Column(
                                  children: [
                                    Lottie.asset(
                                      "asset/images/empty.json",
                                      height: 150,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8), color: black),
                                      child: const Text(
                                        "No data found",
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.white14SemiBold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onError: (error) => Center(
                                child: Column(
                                  children: [
                                    Lottie.asset(
                                      "asset/images/network.json",
                                      height: 150,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8), color: black),
                                      child: const Text(
                                        "Unable to fetch data",
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.white14SemiBold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),   ),
                            controller.obx(
                                  (state) {
                                state =  state?.where((element) => element.title?.contains("ODI")??false).toList();
                                return ListView.builder(
                                    padding:
                                    const EdgeInsets.only(left: 0, right: 0),
                                    shrinkWrap: true,
                                    itemCount: state?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      AllMatch? allMatch =
                                      state![index];
                                      return MatchCard(
                                          allMatch);
                                    }); },
                              onLoading: const Center(child: CircularProgressIndicator()),
                              onEmpty: Center(
                                child: Column(
                                  children: [
                                    Lottie.asset(
                                      "asset/images/empty.json",
                                      height: 150,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8), color: black),
                                      child: const Text(
                                        "No data found",
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.white14SemiBold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onError: (error) => Center(
                                child: Column(
                                  children: [
                                    Lottie.asset(
                                      "asset/images/network.json",
                                      height: 150,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8), color: black),
                                      child: const Text(
                                        "Unable to fetch data",
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.white14SemiBold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),   ),
                            controller.obx(
                                  (state) {
                                state =  state?.where((element) => element.title?.contains("Test")??false).toList();
                                return ListView.builder(
                                    padding:
                                    const EdgeInsets.only(left: 0, right: 0),
                                    shrinkWrap: true,
                                    itemCount: state?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      AllMatch? allMatch =
                                      state![index];
                                      return MatchCard(
                                          allMatch);
                                    }); },
                              onLoading: const Center(child: CircularProgressIndicator()),
                              onEmpty: Center(
                                child: Column(
                                  children: [
                                    Lottie.asset(
                                      "asset/images/empty.json",
                                      height: 150,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8), color: black),
                                      child: const Text(
                                        "No data found",
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.white14SemiBold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onError: (error) => Center(
                                child: Column(
                                  children: [
                                    Lottie.asset(
                                      "asset/images/network.json",
                                      height: 150,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8), color: black),
                                      child: const Text(
                                        "Unable to fetch data",
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.white14SemiBold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),   ),
                          ]),
                        ))
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
