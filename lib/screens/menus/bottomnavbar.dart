import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dealdiscover/screens/UserScreens/accueil_screen.dart';
import 'package:dealdiscover/screens/UserScreens/bot_screen.dart';
import 'package:dealdiscover/screens/UserScreens/calendar_screen.dart';
import 'package:dealdiscover/screens/UserScreens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_states.dart';
import '../../blocs/conversation/conv_bloc.dart';
import '../../blocs/conversation/conv_states.dart';
import '../../repo/auth_repo.dart';
import '../../repo/conv_repo.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late AuthBloc Authb;
  List Screens = [
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(LoginInitState(), AuthRepo())),
      ],
      child: const AccueilScreen(),
    ),    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ConvBloc(ConvInitState(), ConvRepo())),
      ],
      child: const BotScreen(),
    ),
    CalendarScreen(),
    ProfileScreen(),
  ];
  int _selectedIndex = 0;
  @override
  void initState() {
    Authb=BlocProvider.of<AuthBloc>(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: MyColors.btnColor,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          Image(
            image: AssetImage('assets/images/home.png'),
            width: 30,
            height: 30,
          ),
          Image(
            image: AssetImage('assets/images/botw.png'),
            width: 35,
            height: 35,
          ),
          Image(
            image: AssetImage('assets/images/calendar.png'),
            width: 30,
            height: 30,
          ),
          Image(
            image: AssetImage('assets/images/user.png'),
            width: 30,
            height: 30,
          ),
        ],
      ),
      body: Screens[_selectedIndex],
    );
  }
}
