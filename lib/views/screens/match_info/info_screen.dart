import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_grand_11_live/model/get_all_players.dart';
import 'package:my_grand_11_live/model/liveline.dart';
import 'package:my_grand_11_live/utils/color.dart';
import 'package:my_grand_11_live/utils/match_utils.dart';
import 'package:my_grand_11_live/utils/style/app_text_style.dart';
import 'package:my_grand_11_live/views/components/match_status_card.dart';
import 'package:my_grand_11_live/views/components/squad_card.dart';
import 'package:my_grand_11_live/views/screens/home/live_controller.dart';
import 'package:my_grand_11_live/views/screens/match_info/info_controller.dart';

class InfoScreen extends StatelessWidget {
  LiveLine? liveLine;

  InfoScreen(this.liveLine, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LiveController controller = Get.find<LiveController>();
    InfoController infoController = Get.put(InfoController(liveLine?.matchId));
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          controller.obx(
            (state) {
              liveLine = state
                  ?.where((element) => element.matchId == liveLine?.matchId)
                  .first;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            MatchUtils.getOnlyToss(liveLine!)??"",
                            textAlign: TextAlign.center,
                            style: AppTextStyle.yellow12Bold,
                          ),
                          Text(
                            liveLine!.venue!,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.mat12Normal,
                          ),

                        ],

                      ),
                    ),
                  ),
                  PlayingBatsmans(context, liveLine!),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 60,
                        height: 50,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: boxColor,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(50),
                                bottomRight: Radius.circular(50))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                                width: 40,
                                height: 40,
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    child: CachedNetworkImage(
                                      imageUrl: MatchUtils.getTeamUrl(
                                          liveLine!, "A"),
                                      fit: BoxFit.cover,
                                      // placeholder: (_, __) => Center(
                                      //   child: CircularProgressIndicator(),
                                      // ),

                                    ))),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                controller.getLast6Balls(liveLine!)?.length,
                            itemBuilder: (context, index) {
                              String ball =
                                  controller.getLast6Balls(liveLine!)![index];

                              return MatchStatusCard(ball);
                            }),
                      ),
                    ],
                  ),
                  MatchOddsView(liveLine!),
                ],
              );
            },
            onLoading: const Center(child: CircularProgressIndicator()),
            onEmpty: Center(
              child: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: black),
                child: Lottie.asset("asset/images/empty.json",
                    height: 150, width: 150),
              ),
            ),
            onError: (error) => Center(
              child: Container(
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
            ),
          ),
          infoController.obx((state) {
            var map = groupBy(state!, (obj) => obj.teamName);
            String? teamA;
            String? teamB;
            List<Playerslist>? playerTeamA;
            List<Playerslist>? playerTeamB;

              map.entries.forEachIndexed((index, element) {
                teamA = map.entries.first.key;
                teamB = map.entries.last.key;
                playerTeamA = map.entries.first.value;
                playerTeamB = map.entries.last.value;
              });

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(teamA ?? "", style: AppTextStyle.white14SemiBold),
                      SizedBox(
                        height: 4,
                      ),
                      GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, childAspectRatio: 0.95),
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: playerTeamA?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            Playerslist playerItem = playerTeamA![index];
                            return SquadCard(playerItem);
                          }),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(teamB ?? "", style: AppTextStyle.white14SemiBold),
                      SizedBox(
                        height: 4,
                      ),
                      GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, childAspectRatio: 0.95),
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: playerTeamB?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            Playerslist playerItem = playerTeamB![index];
                            return SquadCard(playerItem);
                          }),
                    ]),
              );
            },
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
            ),
          ),
        ],
      ),
    );
  }

  Widget PlayingBatsmans(BuildContext context, LiveLine liveLine) {
    if (liveLine.jsondata.isNotEmpty) {
      JsonData liveLineJsondata = JsonData.fromMap(
          jsonDecode(liveLine.jsondata.toString().replaceAll("\n", "")));

      var striker = liveLineJsondata.jsondata.batsman
          ?.substring(0, liveLineJsondata.jsondata.batsman?.indexOf("|"));
      var nonStriker = liveLineJsondata.jsondata.batsman?.substring(
          (liveLineJsondata.jsondata.batsman?.indexOf("|") ?? 0) + 1);

      var strikerImage = liveLineJsondata.jsondata.batsmanimage?.substring(
          0, (liveLineJsondata.jsondata.batsmanimage?.indexOf("|") ?? 0) - 1);
      var nonStrikerImage = liveLineJsondata.jsondata.batsmanimage?.substring(
          (liveLineJsondata.jsondata.batsmanimage?.indexOf("|") ?? 0) + 1);

      var nonStrikerRuns = "0";
      var strikerRuns = "0";
      var substring = liveLineJsondata.jsondata.oversB
          ?.substring(0, liveLineJsondata.jsondata.oversB?.indexOf("|"));
      if (substring != null && substring.isNotEmpty) {
        var split2 = substring.split(",");
        if (split2.isNotEmpty) {
          nonStrikerRuns = split2[0];
          strikerRuns = split2[1];
        }
      }

      var nonStrikerBalls = "0";
      var strikerBalls = "0";

      String? substring2 = liveLineJsondata.jsondata.oversB?.substring(
          (liveLineJsondata.jsondata.oversB?.indexOf("|") ?? 0) + 1);
      if (substring2 != null && substring2.isNotEmpty) {
        var split3 = substring2.split(",");
        if (split3.isNotEmpty) {
          nonStrikerBalls = (substring2.split(",")[0]);
          strikerBalls = (substring2.split(",")[1]);
        }
      }

      if (!MatchUtils.isLive(liveLine.jsondata!)) {
        return Container();
      }

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: boxColor,
                border: Border.all(
                  color: borderColor,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Row(children: [
                  // SizedBox(
                  //     width: 40,
                  //     height: 40,
                  //     child: ClipRRect(
                  //         borderRadius: const BorderRadius.all(Radius.circular(20)),
                  //         child: CachedNetworkImage(
                  //           imageUrl: "$playerUrl$strikerImage",
                  //           fit: BoxFit.cover,
                  //           placeholder: (_, __) => Center(
                  //             child: CircularProgressIndicator(),
                  //           ),
                  //           errorWidget: (_, __, ___) => Container(
                  //             color: Colors.black12,
                  //             child: Icon(
                  //               Icons.broken_image_outlined,
                  //               color: Colors.grey,
                  //             ),
                  //           ),
                  //         ))),
                  // SizedBox(
                  //   width: 8,
                  // ),
                  Text(
                    striker ?? "",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.white14SemiBold,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 8,
                    ),
                  ),
                  Text(
                    strikerRuns,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.white14SemiBold,
                  ),
                  Text(
                    " (${strikerBalls})",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.white14SemiBold,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                      "SR : ${(int.parse(strikerRuns) / int.parse(strikerBalls) * 100).toStringAsFixed(2)}",
                      textAlign: TextAlign.end,
                      style: AppTextStyle.mat12Normal),
                ]),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    // SizedBox(
                    //     width: 40,
                    //     height: 40,
                    //     child: ClipRRect(
                    //         borderRadius: const BorderRadius.all(Radius.circular(20)),
                    //         child: CachedNetworkImage(
                    //           imageUrl: "$playerUrl$nonStrikerImage",
                    //           fit: BoxFit.cover,
                    //           placeholder: (_, __) => Center(
                    //             child: CircularProgressIndicator(),
                    //           ),
                    //           errorWidget: (_, __, ___) => Container(
                    //             color: Colors.black12,
                    //             child: Icon(
                    //               Icons.broken_image_outlined,
                    //               color: Colors.grey,
                    //             ),
                    //           ),
                    //         ))),
                    // SizedBox(
                    //   width: 8,
                    // ),
                    Text(
                      nonStriker ?? "NO data",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.white14SemiBold,
                    ),
                    Expanded(
                      child: SizedBox(
                        width: 8,
                      ),
                    ),
                    Text(
                      nonStrikerRuns,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.white14SemiBold,
                    ),
                    Text(
                      " (${nonStrikerBalls})",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.white14SemiBold,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                        "SR : ${(int.parse(nonStrikerRuns) / int.parse(nonStrikerBalls) * 100).toStringAsFixed(2)}",
                        textAlign: TextAlign.end,
                        style: AppTextStyle.mat12Normal),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(
                  color: Colors.grey,
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Partnership : ${liveLineJsondata.jsondata.partnership}",
                            style: AppTextStyle.white14SemiBold,
                          ),
                          Text(
                            "RR: ${Get.find<LiveController>().getRunRate(liveLine!)}",
                            style: AppTextStyle.white14SemiBold,
                          ),
                        ],
                      ),
                      VerticalDivider(color: Colors.grey),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "C. Bowler :  ${liveLineJsondata.jsondata.cbowler1} ",
                            style: AppTextStyle.white14SemiBold,
                          ),
                          Text(
                            "Last Wkt : ${liveLineJsondata.jsondata.lastwicket}",
                            style: AppTextStyle.white14SemiBold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      );
    } else {
      return Container();
    }
  }
}

class MatchOddsView extends StatelessWidget {
  final LiveLine liveLine;

  const MatchOddsView(this.liveLine, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Market Odds",
            style: AppTextStyle.white18SemiBold,
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: boxColor,
                border: Border.all(
                  color: borderColor,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Favourite -${MatchUtils.getJsonRuns(liveLine.jsonruns!)?.fav}",
                        style: AppTextStyle.white12SemiBold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        MatchUtils.getTeamARate(liveLine.jsonruns!),
                        style: AppTextStyle.white12Bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        MatchUtils.getTeamBRate(liveLine.jsonruns!),
                        style: AppTextStyle.white12Bold,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Session",
                          style: AppTextStyle.white12SemiBold,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              margin: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                MatchUtils.getJsonRuns(liveLine.jsonruns!)
                                        ?.sessionA ??
                                    "",
                                style: AppTextStyle.white12Bold,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                MatchUtils.getJsonRuns(liveLine.jsonruns!)
                                        ?.sessionB ??
                                    "",
                                style: AppTextStyle.white12Bold,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Over",
                          style: AppTextStyle.white12SemiBold,
                        ),
                        Text(
                          MatchUtils.getJsonRuns(liveLine.jsonruns!)
                                  ?.sessionOver ??
                              "",
                          style: AppTextStyle.white12SemiBold,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Runs x balls",
                          style: AppTextStyle.white12SemiBold,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              margin: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                MatchUtils.getJsonRuns(liveLine.jsonruns!)
                                        ?.runxa ??
                                    "",
                                style: AppTextStyle.white12Bold,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                MatchUtils.getJsonRuns(liveLine.jsonruns!)
                                        ?.runxb ??
                                    "",
                                style: AppTextStyle.white12Bold,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          MatchUtils.getJsonData(liveLine.jsondata)
                                  ?.testTeamA ??
                              "",
                          style: AppTextStyle.white12SemiBold,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              margin: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                MatchUtils.getJsonData(liveLine.jsondata)
                                        ?.testTeamARate1 ??
                                    "",
                                style: AppTextStyle.white12Bold,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                MatchUtils.getJsonData(liveLine.jsondata)
                                        ?.testTeamARate2 ??
                                    "",
                                style: AppTextStyle.white12Bold,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Draw",
                          style: AppTextStyle.white12SemiBold,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              margin: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                MatchUtils.getJsonData(liveLine.jsondata)
                                        ?.testdrawRate1 ??
                                    "",
                                style: AppTextStyle.white12Bold,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                MatchUtils.getJsonData(liveLine.jsondata)
                                        ?.testdrawRate2 ??
                                    "",
                                style: AppTextStyle.white12Bold,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          MatchUtils.getJsonData(liveLine.jsondata)
                                  ?.testTeamB ??
                              "",
                          style: AppTextStyle.white12SemiBold,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              margin: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                MatchUtils.getJsonData(liveLine.jsondata)
                                        ?.testTeamBRate1 ??
                                    "",
                                style: AppTextStyle.white12Bold,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                MatchUtils.getJsonData(liveLine.jsondata)
                                        ?.testTeamBRate2 ??
                                    "",
                                style: AppTextStyle.white12Bold,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
