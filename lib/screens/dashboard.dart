import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_assignments/screens/profile.dart';
import '../controller/get_news_controller.dart';
import 'fav_page.dart';
import 'home_screen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  GetNewsContent getNewsContent = Get.put(GetNewsContent());

  @override
  initState() {
    super.initState();
    print(getNewsContent.listOfNewsVariable.length.toString());
  }

  List<Widget> screens = <Widget>[HomePage(), FavouritePage(), ProfilePage()];
  int currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColorfulSafeArea(
        child: screens[currentScreen],
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blue,
          currentIndex: currentScreen,
          onTap: (index) {
            currentScreen = index;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                label: "favorite", icon: Icon(Icons.favorite)),
            BottomNavigationBarItem(label: "Profile", icon: Icon(Icons.person)),
          ]),
    );
  }
}
