import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grand_11_live/model/liveline.dart';
import 'package:my_grand_11_live/utils/color.dart';
import 'package:my_grand_11_live/utils/style/app_text_style.dart';
import 'package:my_grand_11_live/views/screens/match_info/score_card.dart';
import 'package:my_grand_11_live/views/screens/match_info/commentary_screen.dart';
import 'package:my_grand_11_live/views/screens/match_info/info_screen.dart';
import 'package:my_grand_11_live/views/screens/match_info/match_detail_tab_controller.dart';

class MatchDetailTabView extends StatelessWidget {
  final LiveLine liveLine;
  const MatchDetailTabView(this.liveLine,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MatchDetailTabController controller = Get.put(MatchDetailTabController());
    return Column(children :[
      TabBar(
        controller: controller.tabController,
        indicatorColor: themeOrange,
        unselectedLabelColor: mat,
        labelPadding: const EdgeInsets.symmetric(horizontal: 4),
        isScrollable: false,
        unselectedLabelStyle: AppTextStyle.white12SemiBold,
        labelStyle: AppTextStyle.white12SemiBold,
        tabs: const [
          Tab(
            text: "Info",
          ),
          Tab(
            text: "Scoreboard",
          ),
          Tab(
            text: "Commentary",
          ),
          // Tab(text: "Predictions"),
        ],
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: 1,
        color: dividerColor,
      ),
      Expanded(
          child: TabBarView(controller: controller.tabController, children: [
            InfoScreen(liveLine),

            //......................
            ScoreCardScreen(),
            CommentaryScreen(liveLine),
            // Padding(
            //   padding:
            //   const EdgeInsets.only(left: 8, right: 8, top: 8),
            //   child: Column(
            //     children: [
            //       // Container(
            //       //   height: MediaQuery.of(context).size.height * 0.3,
            //       //   width: MediaQuery.of(context).size.width,
            //       //   margin: const EdgeInsets.symmetric(vertical: 8),
            //       //   decoration: BoxDecoration(
            //       //     border: Border.all(width: 0.5, color: mat),
            //       //     borderRadius: BorderRadius.circular(8),
            //       //   ),
            //       //   child: Column(
            //       //     mainAxisAlignment:
            //       //     MainAxisAlignment.spaceEvenly,
            //       //     children: [
            //       //       Row(
            //       //         mainAxisAlignment: MainAxisAlignment.center,
            //       //         children: [
            //       //           const Text(
            //       //             "Toss",
            //       //             style: AppTextStyle.white12Normal,
            //       //           ),
            //       //           GestureDetector(
            //       //             onTap: () {
            //       //               widget.flag = !widget.flag;
            //       //               setState(() {
            //       //                 if (widget.flag) {
            //       //                   widget.leftp = 0;
            //       //                   widget.turns = 0;
            //       //                 } else {
            //       //                   widget.leftp = 40;
            //       //                   widget.turns = 120;
            //       //                 }
            //       //               });
            //       //             },
            //       //             child: Container(
            //       //               height: 28,
            //       //               width: 68,
            //       //               padding: const EdgeInsets.all(2),
            //       //               margin: const EdgeInsets.symmetric(
            //       //                   horizontal: 10),
            //       //               decoration: BoxDecoration(
            //       //                 // color: mat,
            //       //                   border: Border.all(
            //       //                       width: 1,
            //       //                       color: Colors.white),
            //       //                   borderRadius:
            //       //                   BorderRadius.circular(50)),
            //       //               child: Stack(
            //       //                 children: [
            //       //                   AnimatedPositioned(
            //       //                       duration: const Duration(
            //       //                           milliseconds: 300),
            //       //                       curve: Curves.linear,
            //       //                       left: widget.leftp,
            //       //                       top: 0,
            //       //                       bottom: 0,
            //       //                       child: AnimatedRotation(
            //       //                         duration: const Duration(
            //       //                             milliseconds: 300),
            //       //                         turns: widget.turns / 360,
            //       //                         curve: Curves.linear,
            //       //                         child: Image.asset(
            //       //                             "asset/images/cricket_ball.png",
            //       //                             height: 20),
            //       //                       )),
            //       //                 ],
            //       //               ),
            //       //             ),
            //       //           ),
            //       //           const Text(
            //       //             "Match",
            //       //             style: AppTextStyle.white12Normal,
            //       //           ),
            //       //         ],
            //       //       ),
            //       //       Text(
            //       //         "questiond",
            //       //         style: AppTextStyle.white12SemiBold,
            //       //       ),
            //       //       Row(
            //       //         mainAxisAlignment:
            //       //         MainAxisAlignment.spaceEvenly,
            //       //         children: [
            //       //           Column(
            //       //             children: [
            //       //               CircularPercentIndicator(
            //       //                   radius: 40,
            //       //                   animation: true,
            //       //                   animationDuration: 1200,
            //       //                   lineWidth: 4.5,
            //       //                   percent: 0.25,
            //       //                   circularStrokeCap:
            //       //                   CircularStrokeCap.butt,
            //       //                   backgroundColor: mat,
            //       //                   progressColor: green,
            //       //                   center: Column(
            //       //                       mainAxisAlignment:
            //       //                       MainAxisAlignment.center,
            //       //                       children: const [
            //       //                         Text(
            //       //                           "25%",
            //       //                           style: AppTextStyle
            //       //                               .white18Bold,
            //       //                         ),
            //       //                         Text(
            //       //                           "Accuracy",
            //       //                           style: TextStyle(
            //       //                               color: Colors.white,
            //       //                               fontFamily:
            //       //                               "Proxima Nova",
            //       //                               fontSize: 10.0),
            //       //                         ),
            //       //                       ])),
            //       //               const Padding(
            //       //                 padding: EdgeInsets.symmetric(
            //       //                     vertical: 5),
            //       //                 child: Text("Total Polls : 20",
            //       //                     style:
            //       //                     AppTextStyle.white12Bold),
            //       //               ),
            //       //               Text(widget.liveLine.teamA!,
            //       //                   style:
            //       //                   AppTextStyle.white10Normal),
            //       //             ],
            //       //           ),
            //       //           Column(
            //       //             children: [
            //       //               CircularPercentIndicator(
            //       //                   radius: 40,
            //       //                   animation: true,
            //       //                   animationDuration: 1200,
            //       //                   lineWidth: 4.5,
            //       //                   percent: 0.75,
            //       //                   circularStrokeCap:
            //       //                   CircularStrokeCap.butt,
            //       //                   backgroundColor: mat,
            //       //                   progressColor: green,
            //       //                   center: Column(
            //       //                       mainAxisAlignment:
            //       //                       MainAxisAlignment.center,
            //       //                       children: const [
            //       //                         Text("75%",
            //       //                             style: AppTextStyle
            //       //                                 .white18Bold),
            //       //                         Text(
            //       //                           "Accuracy",
            //       //                           style: AppTextStyle
            //       //                               .white10Normal,
            //       //                         ),
            //       //                       ])),
            //       //               const Padding(
            //       //                 padding: EdgeInsets.symmetric(
            //       //                     vertical: 5),
            //       //                 child: Text(
            //       //                   "Total Polls : 60",
            //       //                   style: AppTextStyle.white12Normal,
            //       //                 ),
            //       //               ),
            //       //               Text(widget.liveLine.teamB!,
            //       //                   style:
            //       //                   AppTextStyle.white10Normal),
            //       //             ],
            //       //           ),
            //       //         ],
            //       //       ),
            //       //     ],
            //       //   ),
            //       // ),
            //       // Padding(
            //       //   padding:
            //       //   const EdgeInsets.symmetric(vertical: 8.0),
            //       //   child: Row(
            //       //     children: [
            //       //       const Text(
            //       //         "Match Winner is  ",
            //       //         style: AppTextStyle.white12SemiBold,
            //       //       ),
            //       //       Image.asset("asset/images/aus.png",
            //       //           height: 18, width: 18),
            //       //       const Text(" Australia",
            //       //           style: AppTextStyle.white12SemiBold)
            //       //     ],
            //       //   ),
            //       // ),
            //       // Expanded(
            //       //   child: ListView.builder(
            //       //       padding: EdgeInsets.zero,
            //       //       itemCount: 20,
            //       //       itemBuilder:
            //       //           (BuildContext context, int item) {
            //       //         return const PlayerAccuracyCard();
            //       //       }),
            //       // )
            //     ],
            //   ),
            // ),
          ]))
    ]);
  }
}