import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_grand_11_live/views/bottom_bar.dart';
import 'package:my_grand_11_live/views/screens/account.dart';
import 'package:my_grand_11_live/views/screens/subscription.dart';

import '../../utils/color.dart';
import '../../utils/style/app_text_style.dart';
import '../../views/components/option_card.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}



class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("asset/images/bg.png"),
                      fit: BoxFit.fill))),
          Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor:const  Color(0xff071F2A),
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Text(
                        "MyGrand 11 ",
                        style: AppTextStyle.white18SemiBold,
                      ),
                      Lottie.asset(
                        "asset/images/Live_logo.json",
                        width: MediaQuery.of(context).size.width * 0.25,
                      )
                    ],
                  ),
                ],
              ),

            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 50.0,bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              OptionCard(
                                  "asset/images/account.png",
                                  "My Account",
                                  () => Get.to(  const AccountScreen())),
                              OptionCard(
                                  "asset/images/subscriptions.png",
                                  "Subscriptions",
                                  () =>Get.to( const Subscription())),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              OptionCard(
                                  "asset/images/matche.png",
                                  "Upcoming Matches",
                                  () => Get.to(const BottomBar(0))),
                              OptionCard(
                                  "asset/images/shareapp.png",
                                  "Share App",
                                      () =>Get.to( const Subscription())),
                              // OptionCard(
                              //     "asset/images/stories.png",
                              //     "Stories",
                              //     () =>Get.to( const StoriesScreen()))
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     OptionCard(
                          //         "asset/images/ranking.png",
                          //         "Rankings",
                          //         () => Get.to( const Subscription())),
                          //     OptionCard(
                          //         "asset/images/settings.png",
                          //         "Settings",
                          //         () => Get.to( const Subscription())),
                          //   ],
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //
                          //     // OptionCard(
                          //     //     "asset/images/feedback.png",
                          //     //     "Feedback",
                          //     //     () =>Get.to( const Subscription())),
                          //   ],
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              OptionCard(
                                  "asset/images/rateus.png",
                                  "Rate Us",
                                  () =>Get.to( const Subscription())),
                              OptionCard(
                                  "asset/images/privacypolicy.png",
                                  "Privacy Policy",
                                  () =>Get.to( const Subscription())),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    margin: const EdgeInsets.only(top: 60, bottom: 30),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 130, vertical: 5),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        // Where the linear gradient begins and ends
                        begin: Alignment.bottomRight,
                        end: Alignment.bottomLeft,
                        // Add one stop for each color. Stops should increase from 0 to 1
                        colors: [
                          // Colors are easy thanks to Flutter's Colors class.
                          Color(0x0dffffff),
                          Color(0x32ffffff),
                          Color(0x0dffffff),
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("asset/images/facebook.png",
                            height: 25, width: 25),
                        Image.asset("asset/images/instagram.png",
                            height: 25, width: 25),
                        Image.asset("asset/images/youtube.png",
                            height: 25, width: 25),
                      ],
                    ),
                  ),
                // const  Text(
                //     "Version ${Build}",
                //     style: AppTextStyle.mat12Normal,
                //   ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
