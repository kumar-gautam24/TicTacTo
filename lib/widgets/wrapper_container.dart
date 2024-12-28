import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../themes/colors.dart';


class WrapperContainer extends StatelessWidget {
  const WrapperContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              GameColors.kGradient1,
              GameColors.kGradient2,
            ],
            stops: [0.5, 0.9],
          ),
        ),
        child: child,
      );
}
