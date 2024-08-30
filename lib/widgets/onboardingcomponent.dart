import 'package:dealdiscover/screens/authentication/signin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/colors.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_states.dart';
import '../repo/auth_repo.dart';

class GetStartBtn extends StatefulWidget {
  const GetStartBtn({
    Key? key,
    required this.size,
    required this.textTheme,
  }) : super(key: key);

  final Size size;
  final TextTheme textTheme;

  @override
  State<GetStartBtn> createState() => _GetStartBtnState();
}

class _GetStartBtnState extends State<GetStartBtn> {
  bool isLoading = false;

  void loadingHandler() {
    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2)).then((_) {
      setState(() {
        isLoading = false;
      });

      // Navigate to the SigninScreen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => AuthBloc(LoginInitState(), AuthRepo())),
            ],
            child: const SigninScreen(),
          ),
        ),
      );

    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loadingHandler,
      child: Container(
        margin: const EdgeInsets.only(top: 60),
        width: widget.size.width * 0.6,
        height: widget.size.height * 0.07,
        decoration: BoxDecoration(
          color: MyColors.btnColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.white,
            width: 5,
          ),
        ),
        child: Center(
          child: isLoading
              ? const Center(
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              : Text("Get Started now", style: widget.textTheme.titleLarge),
        ),
      ),
    );
  }
}

class SkipBtn extends StatelessWidget {
  const SkipBtn({
    Key? key,
    required this.size,
    required this.textTheme,
    required this.onTap,
  }) : super(key: key);

  final Size size;
  final TextTheme textTheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 80),
      width: size.width * 0.6,
      height: size.height * 0.07,
      decoration: BoxDecoration(
          color: MyColors.btnColor,
          border: Border.all(
            color: Colors.white,
            width: 5,
          ),
          borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.0),
        onTap: onTap,
        splashColor: MyColors.btnBorderColor,
        child: Center(
          child: Text("Skip", style: textTheme.titleLarge),
        ),
      ),
    );
  }
}
