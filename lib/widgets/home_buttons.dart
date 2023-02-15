import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeButtons extends StatelessWidget{
  final Widget child;
  final Gradient? gradient;
  final double width;
  final double height;
  final Function? onPressed;
  final bool offButton;
  final bool whiteBackground;

  const HomeButtons({
    Key? key,
    required this.child,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    this.onPressed,
    this.offButton = false,
    this.whiteBackground = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: whiteBackground?<Color>[
              const Color.fromRGBO(0, 96, 157, 1),
              const Color.fromRGBO(28, 59, 112, 1),
            ]:<Color>[
              Colors.white,
              Colors.white
            ],
          )),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onPressed as void Function()?,
        child: InkWell(
            onTap: onPressed as void Function()?,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}

