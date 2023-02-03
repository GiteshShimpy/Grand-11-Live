import 'package:flutter/material.dart';

import '../../utils/color.dart';
import '../../utils/style/app_text_style.dart';

class OptionCard extends StatefulWidget {
  final String optionImg;
  final String optionName;
  final VoidCallback onpress;

  const OptionCard(this.optionImg, this.optionName, this.onpress, {super.key});

  @override
  State<OptionCard> createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onpress,
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(widget.optionImg, width: 25, height: 25),
            const SizedBox(height: 8),
            Text(widget.optionName,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: AppTextStyle.white12Normal),
            const SizedBox(height: 8),
            Container(
              width: 30,
              height: 3,
              decoration: BoxDecoration(
                color: mat,
                borderRadius: BorderRadius.circular(5),
              ),
            )
          ],
        ),
      ),
    );
  }
}
