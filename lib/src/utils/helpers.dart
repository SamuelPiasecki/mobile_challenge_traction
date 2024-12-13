import 'package:flutter/material.dart';
import 'package:mobile_challenge_traction/src/data/models/asset.dart';
import 'package:mobile_challenge_traction/src/data/models/location.dart';

class Helpers {
  static String selectIcon(TreeSliverNode<dynamic> node) {
    if (node.content is Location) {
      return 'lib/src/assets/location.svg';
    } else if (node.content is Asset && node.content.sensorId == null) {
      return 'lib/src/assets/asset.svg';
    } else {
      return 'lib/src/assets/component.png';
    }
  }

  static displaySnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
      ),
    );
  }
}
