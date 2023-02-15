import 'package:flutter/material.dart';

class SigninButton extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;
  final double width;
  final double height;
  final Function? onPressed;
  final bool offButton;
  final bool whiteBackground;

  const SigninButton({
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
    return !offButton
        ? Container(
            width: width,
            height: 50.0,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: whiteBackground?<Color>[
                const Color.fromRGBO(28, 59, 112, 1),
                const Color.fromRGBO(0, 96, 157, 1)
              ]:<Color>[
                Colors.white,
                Colors.white54,
              ],
            )),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: onPressed as void Function()?,
                  child: Center(
                    child: child,
                  )),
            ),
          )
        : CustomPaint(
            painter: _GradientPainter(
                strokeWidth: 4,
                radius: 0,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: whiteBackground?<Color>[
                    Colors.black12,
                    Colors.black26,
                  ]:<Color>[
                    Colors.white,
                    Colors.white54,
                  ],
                )),
            child: Container(
              width: width,
              height: 50.0,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: onPressed as void Function()?,
                child: InkWell(
                    onTap: onPressed as void Function()?,
                    child: Center(
                      child: child,
                    )),
              ),
            ),
          );
  }
}

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradientPainter(
      {required double strokeWidth,
      required double radius,
      required Gradient gradient})
      : this.strokeWidth = strokeWidth,
        this.radius = radius,
        this.gradient = gradient;

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    Rect outerRect = Offset.zero & size;
    var outerRRect =
        RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth,
        size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(
        innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
