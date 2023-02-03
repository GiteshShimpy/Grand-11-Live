import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grand_11_live/views/screens/match_info/info_controller.dart';

import '../../utils/color.dart';
import '../../utils/style/app_text_style.dart';

class MatchStatusCard extends StatelessWidget {
 final String ball;

  const MatchStatusCard(this.ball, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Get.find<InfoController>().getColor(ball),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          ball,
          style: AppTextStyle.white10SemiBold,
        ),
      ),
    );
  }
}
