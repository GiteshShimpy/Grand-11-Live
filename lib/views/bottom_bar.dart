import 'package:flutter/material.dart';
import 'package:my_grand_11_live/views/screens/finished/finished_match_view.dart';

import '../../utils/color.dart';
import 'screens/home/home_view.dart';
import 'screens/match/match_view.dart';
import 'screens/more.dart';
import 'screens/news/news_view.dart';

class BottomBar extends StatefulWidget {
  final int matchIndex;
  final bool isMatchTabTapped;
  // ignore: use_key_in_widget_constructors
  const BottomBar([this.matchIndex = 0, this.isMatchTabTapped = true]);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar>
    with SingleTickerProviderStateMixin {
  late TabController _bottomBarController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _bottomBarController = TabController(length: 5, vsync: this);
    widget.isMatchTabTapped == true
        ? _bottomBarController.animateTo(1)
        : _bottomBarController.animateTo(0);

    _bottomBarController.addListener(() {
      setState(() {
        _selectedIndex = _bottomBarController.index;

      });
    });
  }

  @override
  void dispose() {
    _bottomBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: TabBarView(
          controller: _bottomBarController,
          children: const [
            HomeView(),
            MatchView(),
            NewsView(),
            FinishedMatchView(),
            MoreScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("asset/images/bottom_bg.png"),
                fit: BoxFit.fill),
          ),
          child: TabBar(
              controller: _bottomBarController,
              unselectedLabelColor: mat,
              labelColor: Colors.white,
              labelStyle: TextStyle(
                  fontSize: 9.0, fontFamily: "Proxima Nova", color: mat),
              unselectedLabelStyle: const TextStyle(fontSize: 7.0),
              indicator:const  UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color:Colors.white,
                    width: 2.0,
                  ),
                  insets:  EdgeInsets.symmetric(horizontal: 14.0)),
              tabs: [
                Tab(
                  icon: Image.asset(
                    _selectedIndex == 0
                        ? "asset/images/homee.png"
                        : "asset/images/homed.png",
                    width: 20,
                    height: 20,
                  ),
                  text: "Home",
                ),
                Tab(
                  icon: Image.asset(
                    _selectedIndex == 1
                        ? "asset/images/matche.png"
                        : "asset/images/matchd.png",
                    width: 20,
                    height: 20,
                  ),
                  text: "Match",
                ),
                Tab(
                  icon: Image.asset(
                    _selectedIndex == 2
                        ? "asset/images/highlights.png"
                        : "asset/images/highlightsd.png",
                    width: 20,
                    height: 20,
                  ),
                  text: "Highlights",
                ),
                Tab(
                  icon: Image.asset(
                    _selectedIndex == 3
                        ? "asset/images/bate.png"
                        : "asset/images/batd.png",
                    width: 20,
                    height: 20,
                  ),
                  text: "Results",
                ),
                Tab(
                  icon: Image.asset(
                    _selectedIndex == 4
                        ? "asset/images/moree.png"
                        : "asset/images/mored.png",
                    width: 20,
                    height: 20,
                  ),
                  text: "More",
                ),
              ]),
        ),
      ),
    );
  }
}
