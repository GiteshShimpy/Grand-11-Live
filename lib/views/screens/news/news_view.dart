import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grand_11_live/utils/color.dart';
import 'package:my_grand_11_live/utils/style/app_text_style.dart';
import 'package:my_grand_11_live/views/screens/news/headline_view.dart';
import 'package:my_grand_11_live/views/screens/news/news_controller.dart';
import 'package:my_grand_11_live/views/screens/news/news_everythings_view.dart';
import 'package:my_grand_11_live/views/screens/subscription.dart';

class NewsView extends StatelessWidget {
  const NewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewsController controller = Get.put(NewsController());
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
                  "News",
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
                                text: "Top Headlines",
                              ),
                              Tab(
                                text: "News",
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
                      child: TabBarView(
                          controller: controller.tabController,
                          children: const [
                            HeadlineView(),
                            NewsEverythingView(),
                          ]),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
