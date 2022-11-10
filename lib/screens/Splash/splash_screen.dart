import 'package:altkamul_task/screens/questions/questions_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: 25.0,
                  color: Theme.of(context).primaryColor
                ),
                child: AnimatedTextKit(
                  stopPauseOnTap: true,
                  animatedTexts: [
                    TypewriterAnimatedText('Hello ! \n\nI\'m Ahmed MohammedKhier \n\nAnd This is Test Task \n\nLets start it ',textStyle: const TextStyle(fontWeight: FontWeight.w600),speed: const Duration(milliseconds: 100)),
                  ],
                  isRepeatingAnimation: false,
                  onFinished: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuestionsScreen()));
                  },
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
