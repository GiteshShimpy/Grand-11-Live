import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/color.dart';
import '../../utils/style/app_text_style.dart';
import '../../views/screens/subscription.dart';

class SubscriptionPlanCard extends StatefulWidget {
 final String planName;
 final String planCharge;
 final   String planDuration;
 final  String firstService;
 final  String secondService;
 final  String thirdService;

const  SubscriptionPlanCard(this.planName, this.planCharge, this.planDuration,
      this.firstService, this.secondService, this.thirdService,
      {super.key});

  @override
  State<SubscriptionPlanCard> createState() => _SubscriptionPlanCardState();
}

class _SubscriptionPlanCardState extends State<SubscriptionPlanCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
          color: boxColor,
          border: Border.all(
            color: borderColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.planName,
                    style: AppTextStyle.white14SemiBold,
                  ),
                  Row(
                    children: [
                    const  Text(
                        "₹ ",
                        style: AppTextStyle.white26SemiBold
                      ),
                      Text(
                        widget.planCharge,
                        style: AppTextStyle.white26SemiBold
                      ),
                     const Text(
                        " / ",
                        style: AppTextStyle.white14SemiBold
                      ),
                      Text(
                        widget.planDuration,
                        style: AppTextStyle.white14SemiBold,
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(themeOrange),
                  ),
                  onPressed: () => Get.to(const Subscription()),
                  child: const Text(
                    "SUBSCRIBE",
                    style: AppTextStyle.white12Normal
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(
              color: mat,
              height: 1,
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Icon(Icons.check_sharp, color: green, size: 20),
                  ),
                  Text(
                    widget.firstService,
                    style:AppTextStyle.white12Normal
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Icon(Icons.check_sharp, color: green, size: 20),
                  ),
                  Text(
                    widget.secondService,
                    style: AppTextStyle.white12Normal
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Icon(Icons.check_sharp, color: green, size: 20),
                  ),
                  Text(
                    widget.thirdService,
                    style:AppTextStyle.white12Normal
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
