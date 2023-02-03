import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grand_11_live/views/components/news_card.dart';
import 'package:my_grand_11_live/views/screens/news/news_controller.dart';

import 'package:lottie/lottie.dart';
import 'package:my_grand_11_live/model/NewsEverything.dart';
import 'package:my_grand_11_live/utils/color.dart';
import 'package:my_grand_11_live/utils/style/app_text_style.dart';
import 'package:my_grand_11_live/views/screens/news/news_controller.dart';

class NewsEverythingView extends StatelessWidget {
  const NewsEverythingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewsController controller = Get.find<NewsController>();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => controller.fetchEverything());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: controller.obx(
                  (state) {
                return ListView.builder(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: state?.length ?? 0,
                    itemBuilder: (context, index) {
                      Article? article = state![index];
                      return NewsCard(article);
                    });
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
              onLoading: const Center(child: CircularProgressIndicator()),

            ),
          )
        ],
      ),
    );
  }
}
