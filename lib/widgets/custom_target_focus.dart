import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

///Custom target focus
class CustomTargetFocus {
  final dynamic identify;
  final GlobalKey<State<StatefulWidget>>? keyTarget;
  final ContentAlign align;
  final String targetContentText;

  const CustomTargetFocus(
      this.align,
      this.targetContentText,
      this.identify,
      this.keyTarget
  );

  TargetFocus build(BuildContext context) {
    return TargetFocus(
        identify: identify,
        keyTarget: keyTarget,
        contents: [
          TargetContent(
            align: align,
            child: Text(
                targetContentText,
                style: TextStyle(fontSize: 16, color: Colors.white)
            ),
          ),
        ]
    );
  }

}