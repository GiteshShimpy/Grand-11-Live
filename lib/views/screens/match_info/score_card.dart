import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_grand_11_live/model/get_all_players.dart';
import 'package:my_grand_11_live/model/liveline.dart';
import 'package:my_grand_11_live/utils/match_utils.dart';
import 'package:my_grand_11_live/views/screens/home/live_controller.dart';
import 'package:my_grand_11_live/views/screens/match_info/info_controller.dart';

import '../../../utils/color.dart';
import '../../../utils/style/app_text_style.dart';

class ScoreCardScreen extends GetView<InfoController>{
  const ScoreCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => controller.fetchData());

    LiveController liveController = Get.find<LiveController>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          controller.obx((state) {
            var map = groupBy(state!, (obj) => obj.teamName);

            List<Playerslist>? playerTeamA;
            List<Playerslist>? playerTeamB;

          String? activeTeamA = MatchUtils.getJsonData(liveController.getLiveMatchById(controller.matchId!).jsondata)?.teamA;
            print("${activeTeamA} == ${map.entries.first.key} ${map.entries.last.key}");

            if(activeTeamA == map.entries.first.key){
              print("$activeTeamA  ${map.entries.first.key}");
              playerTeamA = map.entries.first.value;
              playerTeamB = map.entries.last.value;
            }else{
              print("$activeTeamA  ${map.entries.last.key}");

              map.entries.last.value.forEach((element) {
                print(element.playerName);
              });
              playerTeamB = map.entries.first.value;
              playerTeamA = map.entries.last.value;
            }




            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    liveController.obx((liveState) {
                      LiveLine liveLine = liveState
                          ?.where((element) =>
                      element.matchId == controller.matchId)
                          .first as LiveLine;

                      return Row(
                        children: [
                          CircleAvatar(
                            radius: 15.0,
                            backgroundImage: NetworkImage(
                                MatchUtils.getTeamUrl(
                                    liveLine!, "A")),
                            backgroundColor: Colors.grey,
                          ),

                          SizedBox(width: 8,),
                          Text(
                              MatchUtils.getTeamName(
                                  liveLine!.jsondata!, "A"), style: AppTextStyle.white12SemiBold),

                          Expanded(child: SizedBox(width: 8,)),
                          Text(
                            MatchUtils.getTeamAScore(
                                liveLine!.jsondata!),
                            style: AppTextStyle.white14SemiBold,
                          ),
                        ],
                      );

                    }),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 8, bottom: 16),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: boxColor,
                            border: Border.all(
                              color: borderColor,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Expanded(
                                  flex: 4,
                                  child: Text("",
                                      style: AppTextStyle.orange12Normal),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Text("R",
                                        style: AppTextStyle.orange12Normal)),
                                Expanded(
                                    flex: 1,
                                    child: Text("B",
                                        style: AppTextStyle.orange12Normal)),
                                Expanded(
                                    flex: 1,
                                    child: Text("4s",
                                        style: AppTextStyle.orange12Normal)),
                                Expanded(
                                    flex: 1,
                                    child: Text("6s",
                                        style: AppTextStyle.orange12Normal)),
                                Expanded(
                                    flex: 2,
                                    child: Text("SR",
                                        textAlign: TextAlign.end,
                                        style: AppTextStyle.orange12Normal)),
                              ],
                            ),
                            Divider(
                              color: mat,
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: playerTeamA.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  Playerslist playerItem = playerTeamA![index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${playerItem.playerName}${playerItem.isnotout == 1 ? "*" : ""}",
                                                  style: AppTextStyle.white12SemiBold),

                                              Text(
                                                  "${playerItem.outby}",
                                                  style: AppTextStyle.mat12Normal),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                                playerItem.runs.toString(),
                                                style: AppTextStyle.mat12Normal)),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                                playerItem.balls.toString(),
                                                style: AppTextStyle.mat12Normal)),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                                playerItem.four.toString(),
                                                style: AppTextStyle.mat12Normal)),
                                        Expanded(
                                            flex: 1,
                                            child: Text(playerItem.six.toString(),
                                                style: AppTextStyle.mat12Normal)),
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                                (playerItem.runs /
                                                    playerItem.balls *
                                                    100)
                                                    .toStringAsFixed(2),
                                                textAlign: TextAlign.end,
                                                style: AppTextStyle.mat12Normal)),
                                      ],
                                    ),
                                  );
                                }),

                          ],
                        )),
                    SizedBox(
                      height: 16,
                    ),
                    liveController.obx((liveState) {
                      LiveLine liveLine = liveState
                          ?.where((element) =>
                      element.matchId == controller.matchId)
                          .first as LiveLine;
                      return Row(
                        children: [
                          CircleAvatar(
                            radius: 15.0,
                            backgroundImage: NetworkImage(
                                MatchUtils.getTeamUrl(
                                    liveLine!, "B")),
                            backgroundColor: Colors.grey,
                          ),

                          SizedBox(width: 8,),
                          Text(
                              MatchUtils.getTeamName(
                                  liveLine!.jsondata!, "B"), style: AppTextStyle.white12SemiBold),

                          Expanded(child: SizedBox(width: 8,)),
                          Text(
                            MatchUtils.getTeamBScore(
                                liveLine!.jsondata!),
                            style: AppTextStyle.white14SemiBold,
                          ),
                        ],
                      );

                    }),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 8, bottom: 16),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: boxColor,
                            border: Border.all(
                              color: borderColor,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Expanded(
                                  flex: 4,
                                  child: Text("",
                                      style: AppTextStyle.orange12Normal),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Text("R",
                                        style: AppTextStyle.orange12Normal)),
                                Expanded(
                                    flex: 1,
                                    child: Text("B",
                                        style: AppTextStyle.orange12Normal)),
                                Expanded(
                                    flex: 1,
                                    child: Text("4s",
                                        style: AppTextStyle.orange12Normal)),
                                Expanded(
                                    flex: 1,
                                    child: Text("6s",
                                        style: AppTextStyle.orange12Normal)),
                                Expanded(
                                    flex: 2,
                                    child: Text("SR",
                                        textAlign: TextAlign.end,
                                        style: AppTextStyle.orange12Normal)),
                              ],
                            ),
                            Divider(
                              color: mat,
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: playerTeamB?.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  Playerslist playerItem = playerTeamB![index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${playerItem.playerName}${playerItem.isnotout == 1 ? "*" : ""}",
                                                  style: AppTextStyle.white12SemiBold),

                                              Text(
                                                  "${playerItem.outby}",
                                                  style: AppTextStyle.mat12Normal),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                                playerItem.runs.toString(),
                                                style: AppTextStyle.mat12Normal)),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                                playerItem.balls.toString(),
                                                style: AppTextStyle.mat12Normal)),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                                playerItem.four.toString(),
                                                style: AppTextStyle.mat12Normal)),
                                        Expanded(
                                            flex: 1,
                                            child: Text(playerItem.six.toString(),
                                                style: AppTextStyle.mat12Normal)),
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                                (playerItem.runs /
                                                    playerItem.balls *
                                                    100)
                                                    .toStringAsFixed(2),
                                                textAlign: TextAlign.end,
                                                style: AppTextStyle.mat12Normal)),
                                      ],
                                    ),
                                  );
                                }),

                          ],
                        )),

                    SizedBox(
                      height: 8,
                    ),
                    
                    liveController.obx((state) {
                      LiveLine liveline= liveController.getLiveMatchById(controller.matchId!);
                      JsonDataJsonData? jsondata = MatchUtils.getJsonData(liveline.jsondata);
                      return Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 16),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: boxColor,
                              border: Border.all(
                                color: borderColor,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Expanded(
                                    flex: 4,
                                    child: Text("Bowler",
                                        style: AppTextStyle.orange12Normal),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text("Over",
                                          style: AppTextStyle.orange12Normal)),
                                  Expanded(
                                      flex: 1,
                                      child: Text("Runs",
                                          style: AppTextStyle.orange12Normal)),
                                  Expanded(
                                      flex: 1,
                                      child: Text("Wicket",
                                          style: AppTextStyle.orange12Normal)),
                                  Expanded(
                                      flex: 1,
                                      child: Text("Eco.",
                                          textAlign: TextAlign.end,
                                          style: AppTextStyle.orange12Normal)),
                                ],
                              ),
                              Divider(
                                color: mat,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                        "${jsondata?.bowler1}",
                                        style: AppTextStyle.mat12Normal),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.bover1}",

                                          style: AppTextStyle.mat12Normal)),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.brun1}",

                                          style: AppTextStyle.mat12Normal)),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.bwicket1}",

                                          style: AppTextStyle.mat12Normal)),

                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.beco1}",

                                          textAlign: TextAlign.end,
                                          style: AppTextStyle.mat12Normal)),
                                ],
                              ),
                              SizedBox(height: 4,),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                        "${jsondata?.bowler2}",
                                        style: AppTextStyle.mat12Normal),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.bover2}",

                                          style: AppTextStyle.mat12Normal)),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.brun2}",

                                          style: AppTextStyle.mat12Normal)),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.bwicket2}",

                                          style: AppTextStyle.mat12Normal)),

                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.beco2}",

                                          textAlign: TextAlign.end,
                                          style: AppTextStyle.mat12Normal)),
                                ],
                              ),
                              SizedBox(height: 4,),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                        "${jsondata?.bowler3}",
                                        style: AppTextStyle.mat12Normal),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.bover3}",

                                          style: AppTextStyle.mat12Normal)),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.brun3}",

                                          style: AppTextStyle.mat12Normal)),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.bwicket3}",

                                          style: AppTextStyle.mat12Normal)),

                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.beco3}",

                                          textAlign: TextAlign.end,
                                          style: AppTextStyle.mat12Normal)),
                                ],
                              ),
                              SizedBox(height: 4,),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                        "${jsondata?.bowler4}",
                                        style: AppTextStyle.mat12Normal),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.bover4}",

                                          style: AppTextStyle.mat12Normal)),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.brun4}",

                                          style: AppTextStyle.mat12Normal)),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.bwicket4}",

                                          style: AppTextStyle.mat12Normal)),

                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.beco4}",

                                          textAlign: TextAlign.end,
                                          style: AppTextStyle.mat12Normal)),
                                ],
                              ),
                              SizedBox(height: 4,),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                        "${jsondata?.bowler5}",
                                        style: AppTextStyle.mat12Normal),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.bover5}",

                                          style: AppTextStyle.mat12Normal)),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.brun5}",

                                          style: AppTextStyle.mat12Normal)),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.bwicket5}",

                                          style: AppTextStyle.mat12Normal)),

                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.beco5}",

                                          textAlign: TextAlign.end,
                                          style: AppTextStyle.mat12Normal)),
                                ],
                              ),
                              SizedBox(height: 4,),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                        "${jsondata?.bowler6}",
                                        style: AppTextStyle.mat12Normal),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.bover6}",

                                          style: AppTextStyle.mat12Normal)),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.brun6}",

                                          style: AppTextStyle.mat12Normal)),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.bwicket6}",

                                          style: AppTextStyle.mat12Normal)),

                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.beco6}",

                                          textAlign: TextAlign.end,
                                          style: AppTextStyle.mat12Normal)),
                                ],
                              ),
                              SizedBox(height: 4,),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                        "${jsondata?.bowler7}",
                                        style: AppTextStyle.mat12Normal),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.bover7}",

                                          style: AppTextStyle.mat12Normal)),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.brun7}",

                                          style: AppTextStyle.mat12Normal)),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.bwicket7}",

                                          style: AppTextStyle.mat12Normal)),

                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.beco7}",

                                          textAlign: TextAlign.end,
                                          style: AppTextStyle.mat12Normal)),
                                ],
                              ),
                              SizedBox(height: 4,),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                        "${jsondata?.bowler8}",
                                        style: AppTextStyle.mat12Normal),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.bover8}",

                                          style: AppTextStyle.mat12Normal)),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.brun8}",

                                          style: AppTextStyle.mat12Normal)),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.bwicket8}",

                                          style: AppTextStyle.mat12Normal)),

                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${jsondata?.beco8}",

                                          textAlign: TextAlign.end,
                                          style: AppTextStyle.mat12Normal)),
                                ],
                              ),

                            ],
                          ));
                    })
                    
                    ]),
              );
            },
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
          )
        ],
      ),
    );


  }

}
