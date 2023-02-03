import 'package:flutter/material.dart';
import 'package:my_grand_11_live/views/bottom_bar.dart';

import '../../utils/color.dart';
import '../../utils/style/app_text_style.dart';

class MatchShortCard extends StatefulWidget {
  final String matchName;
  final String matchImage;
  final  int matchIndex;

 const  MatchShortCard(this.matchName, this.matchImage, this.matchIndex, {super.key});

  @override
  State<MatchShortCard> createState() => _MatchShortCardState();
}

class _MatchShortCardState extends State<MatchShortCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BottomBar(widget.matchIndex, true)));
      },
      child: Container(
        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 4, right: 7),
        decoration: BoxDecoration(
            border: Border.all(color: mat, width: 0.5),
            borderRadius: BorderRadius.circular(50)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Image.asset(
                widget.matchImage,
                width: 20,
                height: 20,
              ),
            ),
            Text(
              widget.matchName,
              style: AppTextStyle.white10Normal
            ),
          ],
        ),
      ),
    );
  }
}
