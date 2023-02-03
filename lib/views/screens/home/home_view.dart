
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_grand_11_live/views/controllers/ad_controller.dart';
import 'package:my_grand_11_live/views/screens/account.dart';
import 'package:my_grand_11_live/views/screens/home/home_tab_view.dart';
import 'package:my_grand_11_live/views/screens/home/live_list_view.dart';
import 'package:my_grand_11_live/views/screens/subscription.dart';

import '../../../utils/color.dart';
import '../../../utils/style/app_text_style.dart';
import '../../components/match_short_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AdController adController = Get.find<AdController>();

    return SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/images/bg.png"), fit: BoxFit.fill)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                    elevation: 0.0,
                    backgroundColor: const Color(0xff071F2A),
                    automaticallyImplyLeading: false,
                    leadingWidth: 150,
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Get.to(const AccountScreen()),
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white24,
                              child: Image.asset("asset/images/profile.png",
                                  fit: BoxFit.fill),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          const Text(
                            "MG11",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Montserrat",
                                color: Colors.white),
                          ),
                        ],
                      ),
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
                    ]),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: const [
                          Text("Subscribe & enjoy\nads free cricket match",
                              style: AppTextStyle.white18Bold),
                        ],
                      ),
                    ),
                    adController.isNotSubscribed?
                    Container(
                      alignment: Alignment.center,
                      width: adController.myMediumBanner?.size.width.toDouble(),
                      height: adController.myMediumBanner?.size.height.toDouble(),
                      child: adController.adMediumWidget,
                    ): Container(),
                    LiveListView(),
                    Padding(
                      padding: const EdgeInsets.all( 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          MatchShortCard("T20 Match", "asset/images/ball.png", 1),
                          MatchShortCard(
                              "ODI Match", "asset/images/batleft.png", 3),
                          MatchShortCard(
                              "Test Match", "asset/images/test_match.png", 4)
                        ],
                      ),
                    ),

                    adController.isNotSubscribed?
                    Container(
                      alignment: Alignment.center,
                      width: adController.myBanner?.size.width.toDouble(),
                      height: adController.myBanner?.size.height.toDouble(),
                      child: adController.adWidget,
                    ): Container(),

                    const HomeTabView()
                  ]),
                ),
                // SliverList(delegate: SliverChildBuilderDelegate((context, index) {
                //   return ;
                // }))
              ],
            ),
          ),
        ));
  }
}
