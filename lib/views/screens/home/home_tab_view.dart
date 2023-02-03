import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_grand_11_live/model/finised_matches.dart';
import 'package:my_grand_11_live/model/liveline.dart';
import 'package:my_grand_11_live/utils/color.dart';
import 'package:my_grand_11_live/utils/style/app_text_style.dart';
import 'package:my_grand_11_live/views/components/match_brief_card.dart';
import 'package:my_grand_11_live/views/components/match_card.dart';
import 'package:my_grand_11_live/views/screens/home/home_tab_controller.dart';
import 'package:my_grand_11_live/views/screens/home/live_controller.dart';
import 'package:my_grand_11_live/views/screens/match/match_controller.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeTabViewController controller = Get.put(HomeTabViewController());
    controller.tabController.index = 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultTabController(
            length: 2,
            child: Stack(
              children: [
                TabBar(
                  controller: controller.tabController,
                  indicatorColor: themeOrange,
                  unselectedLabelColor: mat,
                  indicatorWeight: 1,
                  isScrollable: true,
                  unselectedLabelStyle: AppTextStyle.white12SemiBold,
                  labelStyle: AppTextStyle.white12SemiBold,
                  tabs: const [
                    Tab(
                      text: "All Matches",
                    ),
                    Tab(
                      text: "Upcoming",
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
          )),
      Get.find<LiveController>().obx((state) =>
          AutoScaleTabBarView(controller: controller.tabController, children: [
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state?.length ?? 0,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    LiveLine liveLine = state![index];
                    return MatchBriefCard(liveLine);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Get.find<MatchController>().obx(
                (state) => ListView.builder(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state?.length ?? 0,
                    itemBuilder: (context, index) {
                      AllMatch? allMatch = state![index];
                      return MatchCard(allMatch);
                    }),
                onLoading: const Center(child: CircularProgressIndicator()),
                // onEmpty: Center(
                //   child: Column(
                //     children: [
                //       Lottie.asset(
                //         "asset/images/empty.json",
                //         height: 150,
                //       ),
                //       Container(
                //         margin: const EdgeInsets.all(8),
                //         padding: const EdgeInsets.all(8),
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(8),
                //             color: black),
                //         child: const Text(
                //           "No data found",
                //           textAlign: TextAlign.center,
                //           style: AppTextStyle.white14SemiBold,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // onError: (error) => Center(
                //   child: Column(
                //     children: [
                //       Lottie.asset(
                //         "asset/images/network.json",
                //         height: 150,
                //       ),
                //       Container(
                //         margin: const EdgeInsets.all(8),
                //         padding: const EdgeInsets.all(8),
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(8),
                //             color: black),
                //         child: const Text(
                //           "Unable to fetch data",
                //           textAlign: TextAlign.center,
                //           style: AppTextStyle.white14SemiBold,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ),
            ),
          ]),onError: (error) => Center(
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
      ),)
    ]);
  }
}
