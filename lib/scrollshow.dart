import 'dart:async';
import 'package:anomweb/responsive.dart';
import 'package:flutter/material.dart';

class ScrollingImageStrip extends StatefulWidget {
  final List<String> imageUrls;

  ScrollingImageStrip({required this.imageUrls});

  @override
  _ScrollingImageStripState createState() => _ScrollingImageStripState();
}

class _ScrollingImageStripState extends State<ScrollingImageStrip> {
  late ScrollController _controller;
  late Timer _timer;
  double _scrollPosition = 0;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _startScrolling();
  }

  void _startScrolling() {
    const duration = Duration(milliseconds: 50);
    _timer = Timer.periodic(duration, (_) {
      if (_controller.hasClients) {
        _scrollPosition += 1;
        if (_scrollPosition >= _controller.position.maxScrollExtent) {
          _scrollPosition = 0;
          _controller.jumpTo(0);
        } else {
          _controller.jumpTo(_scrollPosition);
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: ListView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final image = widget.imageUrls[index % widget.imageUrls.length];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            child: HoverImage(imagePath: image),
          );
        },
      ),
    );
  }
}

class HoverImage extends StatefulWidget {
  final String imagePath;

  const HoverImage({required this.imagePath});

  @override
  _HoverImageState createState() => _HoverImageState();
}

class _HoverImageState extends State<HoverImage> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child:
            _hovering
                ? Container(
                  // <<<<<< DIFFERENT ROOT WIDGET
                  key: ValueKey('${widget.imagePath}_hovered'),
                  child: Image.asset(
                    widget.imagePath,
                    width: 120,
                    height: returnHeightforSliderImage(context),
                    fit: BoxFit.fitHeight,
                  ),
                )
                : Container(
                  // <<<<<< DIFFERENT ROOT WIDGET
                  key: ValueKey('${widget.imagePath}_normal'),
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.matrix(<double>[
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0,
                      0,
                      0,
                      1,
                      0,
                    ]),
                    child: Image.asset(
                      widget.imagePath,
                      width: 120,
                      height: returnHeightforSliderImage(context),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
      ),
    );
  }
}
