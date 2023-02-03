import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';


import '../../utils/color.dart';
import '../../utils/style/app_text_style.dart';
import '../../views/components/plan_renew_card.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                      child: const Text(
                        "My Account",
                        style: AppTextStyle.white18SemiBold,
                      ),
                    ),
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
                          Text(
                            "Logout",
                            style: AppTextStyle.white12Normal,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),



              body: Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8,top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AccountScreen()));
                          },
                          child: Lottie.asset("asset/images/user.json",
                              width: 80, height: 80),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("User12345", style: AppTextStyle.white14SemiBold),
                            Text(
                              "Silver Plan",
                              style: AppTextStyle.mat10Normal,
                            ),
                          ],
                        )
                      ],
                    ),

                    const PlanRenewCard("Silver Plan", "120.0", "Month",
                        "Expire on: 28 Dec 2022")
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
