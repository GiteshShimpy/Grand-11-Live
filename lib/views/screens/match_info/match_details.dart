
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_grand_11_live/model/liveline.dart';
import 'package:my_grand_11_live/utils/match_utils.dart';
import 'package:my_grand_11_live/views/controllers/ad_controller.dart';
import 'package:my_grand_11_live/views/screens/home/live_controller.dart';
import 'package:my_grand_11_live/views/screens/match_info/match_detail_tab_view.dart';

import '../../../utils/color.dart';
import '../../../utils/style/app_text_style.dart';

class MatchDetailsScreen extends StatelessWidget {
  LiveLine? liveLine;


  MatchDetailsScreen(this.liveLine, {super.key});

  @override
  Widget build(BuildContext context) {
    LiveController controller = Get.find<LiveController>();
    AdController adController = Get.find<AdController>();
    adController.getInterstitialAd();
    return SafeArea(
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(top: 8),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("asset/images/bg.png"),
                    fit: BoxFit.fill)),
          ),
          Scaffold(
              backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: false,
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: const Color(0xff071F2A),
                automaticallyImplyLeading: true,
                title: Text(
                  liveLine?.title??"",
                  style: AppTextStyle.white18SemiBold,
                ),
                actions: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Lottie.asset(
                        "asset/images/Live_logo.json",
                        width: MediaQuery.of(context).size.width * 0.25,
                      )),
                ],
              ),
              // floatingActionButton: FloatingActionButton(
              //   onPressed: () {
              //     // Get.to(const PredictionScreen("asset/images/aus.png", "Aus",
              //     //     "New", "asset/images/newzealand.png"));
              //   },
              //   backgroundColor: themeOrange,
              //   child: const Icon(Icons.add, size: 30, color: Colors.white),
              // ),
              body: SafeArea(
                child: Column(
                  children: [
                    controller.obx(
                      (state) {
                        liveLine = state
                            ?.where((element) =>
                                element.matchId! == liveLine?.matchId!)
                            .first;
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  decoration: BoxDecoration(
                                      color: boxColor,
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(50),
                                          bottomRight: Radius.circular(50))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: ClipRRect(
                                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                                            child: CachedNetworkImage(
                                              imageUrl: MatchUtils.getTeamUrl(
                                                  liveLine!, "A"),
                                              fit: BoxFit.cover,
                                              // placeholder: (_, __) => Center(
                                              //   child: CircularProgressIndicator(),
                                              // ),
                                              // errorWidget: (_, __, ___) => Container(
                                              //   color: Colors.black12,
                                              //   child: Icon(
                                              //     Icons.broken_image_outlined,
                                              //     color: Colors.grey,
                                              //   ),
                                              // ),
                                            ))),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          MatchUtils.getTeamName(
                                              liveLine!.jsondata!, "A"),
                                          textAlign: TextAlign.start,
                                          style: AppTextStyle.white12Normal),
                                      Text(
                                        MatchUtils.getTeamAScore(
                                            liveLine!.jsondata!),
                                        style: AppTextStyle.white14SemiBold,
                                      ),
                                    ],
                                  ),
                                ),



                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                          MatchUtils.getTeamName(
                                              liveLine!.jsondata!, "B"),
                                          textAlign: TextAlign.end,
                                          style: AppTextStyle.white12Normal),
                                      Text(
                                        MatchUtils.getTeamBScore(
                                            liveLine!.jsondata!),
                                        style: AppTextStyle.white14SemiBold,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  decoration: BoxDecoration(
                                      color: boxColor,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(50),
                                          bottomLeft: Radius.circular(50))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 16.0),
                                        child:
                                        SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: ClipRRect(
                                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                child: CachedNetworkImage(
                                                  imageUrl: MatchUtils.getTeamUrl(
                                                      liveLine!, "B"),
                                                  fit: BoxFit.cover,
                                                  // placeholder: (_, __) => Center(
                                                  //   child: CircularProgressIndicator(),
                                                  // ),
                                                  // errorWidget: (_, __, ___) => Container(
                                                  //   color: Colors.black12,
                                                  //   child: Icon(
                                                  //     Icons.broken_image_outlined,
                                                  //     color: Colors.grey,
                                                  //   ),
                                                  // ),
                                                ))),

                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              MatchUtils.getScore(liveLine!),
                              textAlign: TextAlign.center,
                              style: AppTextStyle.white18SemiBold,
                            ),
                          ],
                        );
                      },
                      onLoading: const Center(child: CircularProgressIndicator()),
                        ),


                    Expanded(child: MatchDetailTabView(liveLine!))

                  ],
                ),
              )),
        ],
      ),
    );
  }
}
