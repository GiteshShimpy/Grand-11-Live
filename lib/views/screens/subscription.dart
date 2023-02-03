import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/style/app_text_style.dart';
import '../../views/components/subscription_plan_card.dart';

class Subscription extends StatefulWidget {
  const Subscription({Key? key}) : super(key: key);

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
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
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () => Get.back(),
                        child: const Text("Subscription",
                            style: AppTextStyle.white18SemiBold)),
                  ],
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      // onTap:()=> Get.back(),
                      child: Row(
                        children: const [
                          Icon(Icons.logout_rounded, color: Colors.white),
                          Text(" Logout", style: AppTextStyle.white12Normal),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("Subscribe & enjoy\nads free cricket match\n",
                          style: AppTextStyle.white18Bold),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: SubscriptionPlanCard(
                          "Silver Plan",
                          "120.0",
                          "1 Month",
                          "Enjoy Ad free cricket match",
                          "Use 1 user at a time",
                          "Get free updates on mobile"),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: SubscriptionPlanCard(
                          "Gold Plan",
                          "200.0",
                          "3 Months",
                          "Enjoy Ad free cricket match",
                          "Use 3 user at a time",
                          "Get free updates on mobile"),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: SubscriptionPlanCard(
                          "Platinum Plan",
                          "600.0",
                          "6 Months",
                          "Enjoy Ad free cricket match",
                          "Use 3 user at a time",
                          "Get free updates on mobile"),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
