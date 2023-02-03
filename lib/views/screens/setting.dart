import 'package:flutter/material.dart';
import 'package:my_grand_11_live/views/components/language_card.dart';

import '../../utils/color.dart';
import '../../utils/style/app_text_style.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("asset/images/bg.png"),
                    fit: BoxFit.fill)),),
          Scaffold(
            backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: true,
                title: Row(
                  children:const  [
                     Text(
                      "Settings",
                      style: AppTextStyle.white18SemiBold
                    ),
                  ],
                ),

              ),
            body:
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [

                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                       const    Text(
                             " Notiifications",
                             style: AppTextStyle.white14SemiBold
                           ),
                           Switch(
                             inactiveTrackColor: mat,
                             activeTrackColor: mat,
                             activeColor: green,
                             value: isSwitched ?? true,
                             onChanged: (value) {
                               setState(() {
                                 isSwitched = value;
                               });
                             },
                           ),
                         ],
                       ),
                       const LanguageCard(),
                     ],
                   ),
                 )),
        ],
      ),
    );
  }
}
