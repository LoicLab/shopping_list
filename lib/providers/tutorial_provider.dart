import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

///Provider for show the tutorial
class TutorialProvider with ChangeNotifier {

  ///Initialize the tutorial for a screen
  Future<void> initializeTutorial(BuildContext context, List<TargetFocus> targets, String screenName) async {
    //Get specific preference
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isScreenTutorialShown = prefs.getBool('isTutorialShown_$screenName') ?? false;

    //Check tutorial is show
    if (!isScreenTutorialShown) {
      _showTutorial(context, targets, screenName);
    }
  }

  ///Show the tutorial for a screen
  void _showTutorial(BuildContext context, List<TargetFocus> targets, String screenName) {

    //Delayed for show the tutorial
    Future.delayed(Duration(milliseconds: 500), () {
      TutorialCoachMark(
        targets: targets,
        colorShadow: Colors.black,
        textSkip: "Passer",
        alignSkip: Alignment.bottomLeft,
        onFinish: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isTutorialShown_$screenName', true);
          notifyListeners();
        }
      ).show(context: context);
    });
  }

}
