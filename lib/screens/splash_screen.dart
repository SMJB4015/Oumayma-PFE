import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dealdiscover/screens/authentication/signin_screen.dart'; // Update with your actual path
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_states.dart';
import '../repo/auth_repo.dart';
import 'menus/bottomnavbar.dart';
import 'onboarding _screen .dart'; // Update with your actual path

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _handleNavigation();
  }

  Future<void> _handleNavigation() async {
    // Simulate splash animation duration with Future.delayed
    await Future.delayed(Duration(seconds: 3)); // Adjust based on your splash duration

    // Retrieve the value from SharedPreferences
    final pref = await SharedPreferences.getInstance();
    final bool isVerified = pref.getString('first') == 'YES';
    final bool isConnected = pref.getString('connected')== 'YES';

    // Navigate based on the value retrieved
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          if (!isVerified){
            return OnboardingScreen() ;
          }else if (isConnected){
            return BottomNavBar();
          }else{
            return MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => AuthBloc(LoginInitState(),AuthRepo())),
                ],child: SigninScreen());

          }
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/background.png'), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
        ),
        AnimatedSplashScreen(
          splash: Image.asset(
            'assets/images/logo.png',
            width: MediaQuery.of(context).size.width *
                2, // Adjust the width as needed
            height: MediaQuery.of(context).size.height *
                2, // Adjust the height as needed
            fit: BoxFit.contain,
          ),
          duration: 3000,
          splashTransition:
          SplashTransition.scaleTransition, // Change the animation here
          backgroundColor: Colors.transparent,
          nextScreen:  Container(),
        ),
      ],
    );
  }
}
