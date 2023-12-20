import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'account_informantion.dart';
import 'apply_leave.dart';
import 'blank_page.dart';
import 'dashboard.dart';
import 'my_leave_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedLabelforBottomNavigationBar = 'Home';

  Widget selectedScreen() {
    switch(selectedLabelforBottomNavigationBar){
      case 'Kudos' :
        {
          return const BlankPage();
        }
      case 'Motivate' :
        {
          return const BlankPage();
        }
      default:
        {
          return const DashboardScreen();
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: selectedScreen(),
      bottomNavigationBar: bottomNavigationBox(),
    );
  }

  Widget bottomNavigationBox(){
    return Material (
      elevation: 20,
      color: Colors.white,
      shadowColor: Colors.grey,
      child: SizedBox(
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: (){
                  setState((){
                    selectedLabelforBottomNavigationBar = 'Home';
                  });
                },
                child: bottomNavigationItem('assets/svgs/logo.svg', 'Home', selectedLabelforBottomNavigationBar, 'assets/svgs/logo.svg')),
            GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: (){
                  setState((){
                    selectedLabelforBottomNavigationBar = 'Kudos';
                  });
                },
                child: bottomNavigationItem('assets/svgs/kudosBlack.svg', 'Kudos', selectedLabelforBottomNavigationBar, 'assets/svgs/kudosOnClick.svg')),
            GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: (){
                  setState((){
                    selectedLabelforBottomNavigationBar = 'Motivate';
                  });
                },
                child: bottomNavigationItem('assets/svgs/motivateBlack.svg', 'Motivate', selectedLabelforBottomNavigationBar, 'assets/svgs/motivationOnClick.svg')),
            GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountInfo()));
                  setState((){
                    selectedLabelforBottomNavigationBar = 'Menu';
                  });
                },
                child: bottomNavigationItem('assets/svgs/menu.svg', 'Menu', selectedLabelforBottomNavigationBar, 'assets/svgs/menu.svg'))
          ],
        ),
      ),
    );
  }

  Widget bottomNavigationItem(String svgPath, String label, String selectedLabel, String altSvgPath){
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(label == selectedLabel ? altSvgPath : svgPath, height: label == 'Menu' ? 22 : 25,width:label == 'Menu' ? 22 : 25),
          const SizedBox(height: 10),
          Text(label,style: TextStyle(fontFamily: 'Recoleta',fontWeight: FontWeight.bold, color: label == selectedLabel ? const Color(0xffF78D28): Colors.black,))
        ],
      ),
    );
  }
}
