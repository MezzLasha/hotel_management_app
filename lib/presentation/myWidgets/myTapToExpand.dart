import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

class TapToExpandMaterial extends StatefulWidget {
  /// A parameter that is used to show the content of the widget.
  final Widget content;

  /// A parameter that is used to show the title of the widget.
  final Widget title;

  /// A parameter that is used to show the trailing widget.
  final Widget? trailing;

  /// A parameter that is used to set the color of the widget.
  final Color? color;

  /// Used to set the color of the shadow.
  final List<BoxShadow>? boxShadow;

  /// Used to make the widget scrollable.
  final bool? scrollable;

  /// Used for starting expanded or not
  final bool? startCollapsed;

  /// Used to set the height of the widget when it is closed.
  final double? closedHeight;

  /// Used to set the height of the widget when it is opened.
  final double? openedHeight;

  /// Used to set the duration of the animation.
  final Duration? duration;

  /// Used to set the padding of the widget when it is closed.
  final double? onTapPadding;

  /// Used to set the border radius of the widget.
  final double? borderRadius;

  /// Used to set the physics of the scrollable widget.
  final ScrollPhysics? scrollPhysics;

  /// A constructor.
  const TapToExpandMaterial({
    Key? key,
    required this.content,
    required this.title,
    this.color,
    this.scrollable,
    this.closedHeight,
    this.openedHeight,
    this.boxShadow,
    this.duration,
    this.onTapPadding,
    this.borderRadius,
    this.scrollPhysics,
    this.trailing,
    this.startCollapsed,
  }) : super(key: key);

  @override
  _TapToExpandState createState() => _TapToExpandState();
}

class _TapToExpandState extends State<TapToExpandMaterial> {
  bool isExpanded = false;

  @override
  void initState() {
    isExpanded = widget.startCollapsed ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool scrollable = widget.scrollable ?? false;

    /// Used to make the widget clickable.
    return GestureDetector(
      onTap: () {
        /// Changing the state of the widget.
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(
          /// Used to set the padding of the widget when it is closed.
          horizontal: isExpanded ? 0 : widget.onTapPadding ?? 0,
          vertical: 10,
        ),
        padding: const EdgeInsets.all(14),
        curve: Curves.fastLinearToSlowEaseIn,
        duration: widget.duration ?? const Duration(milliseconds: 1200),
        decoration: BoxDecoration(

            /// Used to set the default value of the boxShadow parameter.
            boxShadow: widget.boxShadow ??
                [
                  const BoxShadow(
                    color: Colors.grey,
                    blurRadius: 20,
                    offset: Offset(5, 10),
                  ),
                ],
            color: widget.color ?? Theme.of(context).primaryColor,
            border: Border.all(
              color: Theme.of(context).dividerColor,
              width: 1,
            ),
            borderRadius: SmoothBorderRadius(
              cornerRadius: widget.borderRadius ?? 16,
              cornerSmoothing: 0.6,
            )),
        child: scrollable
            ? ListView(
                physics: widget.scrollPhysics,
                children: [
                  /// Creating a row with two widgets. The first widget is the title widget and the
                  /// second widget is the trailing widget. If the trailing widget is null, then it will
                  /// show an arrow icon.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// A parameter that is used to show the title of the widget.
                      widget.title,

                      /// Checking if the trailing widget is null or not. If it is null, then it will
                      /// show an arrow icon.
                      widget.trailing ??
                          Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up,
                            color: Colors.white,
                            size: 27,
                          ),
                    ],
                  ),

                  /// Used to add some space between the title and the content.
                  isExpanded ? const SizedBox() : const SizedBox(height: 20),

                  /// Used to show the content of the widget.
                  AnimatedCrossFade(
                    firstChild: const Text(
                      '',
                      style: TextStyle(
                        fontSize: 0,
                      ),
                    ),

                    /// Showing the content of the widget.
                    secondChild: widget.content,
                    crossFadeState: isExpanded
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration:
                        widget.duration ?? const Duration(milliseconds: 1200),
                    reverseDuration: Duration.zero,
                    sizeCurve: Curves.fastLinearToSlowEaseIn,
                  ),
                ],
              )
            : Column(
                children: [
                  /// Creating a row with two widgets. The first widget is the title widget and the
                  /// second widget is the trailing widget. If the trailing widget is null, then it will
                  /// show an arrow icon.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.title,
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        color: Theme.of(context).primaryColor,
                        size: 27,
                      ),
                    ],
                  ),

                  /// Used to add some space between the title and the content.
                  isExpanded ? const SizedBox() : const SizedBox(height: 10),

                  /// Used to show the content of the widget.
                  AnimatedCrossFade(
                    firstChild: const Text(
                      '',
                      style: TextStyle(
                        fontSize: 0,
                      ),
                    ),
                    secondChild: widget.content,
                    crossFadeState: isExpanded
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,

                    /// Used to set the duration of the animation.
                    duration:
                        widget.duration ?? const Duration(milliseconds: 1200),
                    reverseDuration: Duration.zero,

                    /// Used to set the curve of the animation.
                    sizeCurve: Curves.fastLinearToSlowEaseIn,
                  ),
                ],
              ),
      ),
    );
  }
}
