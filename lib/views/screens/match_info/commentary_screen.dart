import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_grand_11_live/model/liveline.dart';
import 'package:my_grand_11_live/model/match_odds.dart';
import 'package:my_grand_11_live/utils/color.dart';
import 'package:my_grand_11_live/utils/style/app_text_style.dart';
import 'package:my_grand_11_live/views/screens/match_info/commentary_controller.dart';

class CommentaryScreen extends StatelessWidget {
  final LiveLine liveLine;

  const CommentaryScreen(this.liveLine, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CommentaryController commentaryController =
    Get.put(CommentaryController(liveLine.matchId));
    return Padding(
        padding:  EdgeInsets.all( 8),
        child: commentaryController.obx(
          (state) {
            var map = groupBy(state!, (obj) => obj.isfirstinning);

            List<Matchst>? oddTeamA;
            List<Matchst>? oddTeamB;

            map.entries.forEachIndexed((index, element) {
              oddTeamA = map.entries.first.value;
              oddTeamB = map.entries.last.value;
            });

            return Column(

              children: [
                PreferredSize(
                  preferredSize: Size(double.infinity, 30),
                  child: TabBar(
                    controller: commentaryController.tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white24),
                    unselectedLabelStyle: AppTextStyle.mat12Normal,
                    tabs:  [
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.white24, width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Tab(
                            text: "First Inning",
                          ),
                        ),
                      ),

                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.white24, width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Tab(
                            text: "Second Inning",
                          ),
                        ),
                      ),
                      // Tab(text: "Predictions"),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Table(
                  defaultVerticalAlignment:
                      TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(children: [
                      Text(
                        "Over",
                        textAlign: TextAlign.center,
                        style: AppTextStyle.mat12Normal,
                      ),
                      Text(
                        "Ball Status",
                        textAlign: TextAlign.center,
                        style: AppTextStyle.mat12Normal,
                      ),
                      Text(
                        "Score",
                        textAlign: TextAlign.center,
                        style: AppTextStyle.mat12Normal,
                      ),
                      Text(
                        "Market Odds",
                        textAlign: TextAlign.center,
                        style: AppTextStyle.mat12Normal,
                      ),
                    ])
                  ],
                ),
                Divider(
                  color: Colors.grey,
                ),
                
                Expanded(
                  child: TabBarView(
                    controller: commentaryController.tabController,
                    children: [
                  SingleChildScrollView(
                    child: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: oddTeamA!.reversed
                          .map((item) => _buildStatsRow(item))
                          .toList(),
                      // other arguments
                    ),
                  ),
                  (oddTeamA==oddTeamB) ?
                Center(
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
                )
                    :
                  SingleChildScrollView(
                    child: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: oddTeamB!.reversed
                          .map((item) => _buildStatsRow(item))
                          .toList(),
                      // other arguments
                    ),
                  ),
                    ],
                  ),
                )
              ],
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
          ),));
  }


  TableRow _buildStatsRow(Matchst matchst) {
    return TableRow(

      decoration: matchst.overs.contains(".")? null :BoxDecoration(
          border: Border.all(color: grey),
          borderRadius: BorderRadius.circular(8), color: boxColor),
      children: [
        Text(
          matchst.overs,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Gilroy Medium',
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        Text(
          matchst.score,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Gilroy Medium',
              fontSize: 14,
              fontWeight: FontWeight.w700),
        ),
        Container(
          margin: EdgeInsets.all(4),
          width: 150,
          height: 35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: black),
          child: Center(
            child: Text(
              "${matchst.teamruns}/${matchst.wickets}",
              textAlign: TextAlign.center,
              style: AppTextStyle.white14SemiBold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                matchst.mrateA,
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
                matchst.mrateB,
                style: AppTextStyle.white12Bold,
              ),
            ),
          ],
        )
      ], // Pass the widgets to be set as the row content.
    );
  }
}
