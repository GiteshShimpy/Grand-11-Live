import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_grand_11_live/model/liveline.dart';
import 'package:my_grand_11_live/utils/match_utils.dart';
import 'package:my_grand_11_live/utils/style/app_text_style.dart';
import 'package:my_grand_11_live/views/components/match_brief_card.dart';
import 'package:my_grand_11_live/views/screens/home/live_controller.dart';

import '../../../utils/color.dart';

class LiveListView extends StatelessWidget {
  const LiveListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LiveController controller = Get.put(LiveController());

    return controller.obx(
      (state) {
        var liveMatches = state?.where((e) =>e.jsondata.isNotEmpty && MatchUtils.isLive(e.jsondata)).toList();

        return Container(
          width: MediaQuery.of(context).size.width,
          height: 220,
          child:
          liveMatches?.isNotEmpty??false ?
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: liveMatches?.length ?? 0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  LiveLine liveLine = liveMatches![index];
                  return MatchBriefCard(liveLine);
                }),
          ):
          Center(
            child: Column(
              children: [
                Lottie.asset(
                  "asset/images/empty.json",
                  height: 100,
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
        );
      },
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
      //             borderRadius: BorderRadius.circular(8), color: black),
      //         child: const Text(
      //           "No data found",
      //           textAlign: TextAlign.center,
      //           style: AppTextStyle.white14SemiBold,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
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
    );
  }
}
