<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->


## Features

Custom Container with bouncing click effect. You can use it anywhere inside your flutter application.

## Installation

1: Add the latest version of the package to your pubspec.yaml (and run `dart pub get`): 

```yaml

dependencies:
    bouncy_container: ^0.0.3

```


2: Import the package and use it in your Flutter app.

```dart

import 'package:bouncy_container/bouncy_container.dart';

```



## Example

There are multiple properties that you can modify : 

    - height
    - width
    - backgroundColor
    - shadowColor
    - padding
    - margin
    - decoration
    - duration
    - radius
 
<hr>




<table>


<tr>


<td>


```dart
class BouncyContainer extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? height;
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
      this.duration})
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
                    color: Colors.white,
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

```

</td>



<td>


<img src="https://github.com/bijumondal18/bouncy_container_flutter_package/blob/main/lib/src/BouncingContainer.png" alt="Sample Image">


</td>

</tr>

</table>



## Next Goals

- [x] Add more animation effect.

- [x] Add more custom containers to the package.
