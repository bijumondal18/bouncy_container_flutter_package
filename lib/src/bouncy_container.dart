import 'package:flutter/material.dart';

class BouncyContainer extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? shadowColor;
  final double? padding;
  final double? margin;
  final double? radius;
  final double? blur;
  final Decoration? decoration;
  final VoidCallback? onPressed;
  final Duration? duration;

  const BouncyContainer(
      {Key? key,
      required this.child,
      this.width = 200,
      this.height = 200,
      this.padding = 10,
      this.margin = 10,
      this.decoration,
      this.onPressed,
      this.duration,
      this.backgroundColor = Colors.white,
      this.radius = 10,
      this.blur = 10,
      this.shadowColor})
      : super(key: key);

  @override
  _BouncyContainerState createState() => _BouncyContainerState();
}

class _BouncyContainerState extends State<BouncyContainer>
    with SingleTickerProviderStateMixin {
  //Declare animation controller variable
  AnimationController? _animationController;
  double? _scale;

  @override
  void initState() {
    //initialise animation controller
    _animationController = AnimationController(
        vsync: this,
        duration: widget.duration ?? const Duration(milliseconds: 150),
        lowerBound: 0.0,
        upperBound: 0.06)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    //dispose animation controller
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _animationController!.value;
    return GestureDetector(
        onTap: () {
          _animationController!.forward();
          Future.delayed(const Duration(milliseconds: 100), () {
            _animationController!.reverse();
            widget.onPressed?.call();
          });
        },
        child: Transform.scale(
          scale: _scale,
          child: Container(
            width: widget.width,
            height: widget.height,
            padding: EdgeInsets.all(widget.padding!),
            margin: EdgeInsets.all(widget.margin!),
            decoration: widget.decoration ??
                BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.radius!),
                    color: widget.backgroundColor,
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(2, 2),
                          color: widget.shadowColor ?? Colors.white60,
                          blurRadius: widget.blur!)
                    ]),
            child: widget.child,
          ),
        ));
  }
}
