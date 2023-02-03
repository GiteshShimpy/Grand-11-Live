import 'package:flutter/material.dart';

import '../../utils/color.dart';
import '../../utils/style/app_text_style.dart';

class LanguageCard extends StatefulWidget {
  const LanguageCard({Key? key}) : super(key: key);

  @override
  State<LanguageCard> createState() => _LanguageCardState();
}

class _LanguageCardState extends State<LanguageCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text(
          " Select Language",
          style: AppTextStyle.white14SemiBold,
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
            margin: const EdgeInsets.only(bottom: 10, top: 14),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
                color: boxColor,
                border: Border.all(
                  color: borderColor,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(themeOrange),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "ENGLISH",
                      style: AppTextStyle.white12Normal
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side:const BorderSide(color:Colors.white, width: 0.5))),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "HINDI",
                      style: AppTextStyle.white12Normal,
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: const BorderSide(color:Colors.white, width: 0.5))),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "KANNADA",
                      style:AppTextStyle.white12Normal
                    )),
              ],
            )),
      ],
    );
  }
}
