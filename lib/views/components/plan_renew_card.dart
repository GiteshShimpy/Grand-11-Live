import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/color.dart';
import '../../utils/style/app_text_style.dart';
import '../../views/screens/subscription.dart';

class PlanRenewCard extends StatefulWidget {
 final  String planName;
 final  String planCharge;
 final  String planDuration;
 final  String expiryDate;

 const PlanRenewCard(
      this.planName, this.planCharge, this.planDuration, this.expiryDate,
      {super.key});

  @override
  State<PlanRenewCard> createState() => _PlanRenewCardState();
}

class _PlanRenewCardState extends State<PlanRenewCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: borderColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.planName,
                style: AppTextStyle.white12SemiBold,
              ),
              Row(
                children: [
                 const Text(
                    "₹ ",
                    style: AppTextStyle.white18SemiBold,
                  ),
                  Text(
                    widget.planCharge,
                    style: AppTextStyle.white18SemiBold,
                  ),
                const  Text(
                    " / ",
                    style: AppTextStyle.white10Normal
                  ),
                  Text(
                    widget.planDuration,
                    style:AppTextStyle.white10Normal
                  ),
                ],
              ),
              Text(
                widget.expiryDate,
                style: AppTextStyle.mat10Normal
              ),
            ],
          ),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(themeOrange),
              ),
              onPressed: () => Get.to(const Subscription()),
              child: const Text(
                "RENEW NOW",
                style:AppTextStyle.white12Normal
              ))
        ],
      ),
    );
  }
}
