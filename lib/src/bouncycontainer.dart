import 'package:flutter/material.dart';

class BouncyContainer extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Decoration? decoration;
  final VoidCallback? onPressed;
  final Duration? duration;

  const BouncyContainer(
      {Key? key,
      required this.child,
      this.width,
      this.height,
      this.padding,
      this.margin,
      this.decoration,
      this.onPressed,
      this.duration,
      this.backgroundColor})
      : super(key: key);

  @override
  _BouncyContainerState createState() => _BouncyContainerState();
}

class _BouncyContainerState extends State<BouncyContainer>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  double? _scale;

  @override
  void initState() {
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
            width: widget.width ?? MediaQuery.of(context).size.width,
            height: widget.height ?? MediaQuery.of(context).size.height,
            padding: widget.padding ?? EdgeInsets.zero,
            margin: widget.margin ?? EdgeInsets.zero,
            decoration: widget.decoration ??
                BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: widget.backgroundColor ?? Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(2, 2),
                          color: Colors.white60,
                          blurRadius: 6)
                    ]),
            child: widget.child,
          ),
        ));
  }
}
