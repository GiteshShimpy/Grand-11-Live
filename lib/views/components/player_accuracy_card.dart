import 'package:flutter/material.dart';

import '../../utils/color.dart';
import '../../utils/style/app_text_style.dart';

class PlayerAccuracyCard extends StatefulWidget {
  const PlayerAccuracyCard({Key? key}) : super(key: key);

  @override
  State<PlayerAccuracyCard> createState() => _PlayerAccuracyCardState();
}

class _PlayerAccuracyCardState extends State<PlayerAccuracyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
          color: boxColor, borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset("asset/images/profile.png",
                    width: 30, height: 30),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "John Doe",
                    style: AppTextStyle.white12SemiBold,
                  ),
                  Text(
                    "120 Subscribers",
                    style: AppTextStyle.white8Normal
                  ),
                ],
              )
            ],
          ),
          Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: black),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:const [
                Text(
                  "42%",
                  style: AppTextStyle.white14SemiBold,
                ),
                Text(
                  " Accuracy",
                  style: AppTextStyle.white8Normal
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
