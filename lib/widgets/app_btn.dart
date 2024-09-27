// import 'package:flutter/material.dart';
//
// import '../themes/colors_theme.dart';
// import 'app_text.dart';
//
// class AppButton extends StatefulWidget {
//   AppButton(
//       {Key? key,
//       required this.title,
//       this.align = false,
//       this.focusNode,
//       this.isFontSize = false,
//       this.titleColor = Colors.white,
//       this.titleFontSize = 16.0,
//       this.titleUnderline = false,
//       this.titleFontWeight = FontWeight.w700,
//       this.paddingHorizontal = 40.0,
//       this.paddingVertical = 8.0,
//       this.buttonBackgroundColor = CarCardColorTheme.textBlack,
//       this.buttonBorderColor = CarCardColorTheme.textBlack,
//       required this.onPressed,
//       this.enableButton = true})
//       : super(key: key);
//   final String title;
//   final bool align;
//   final bool titleUnderline;
//   final bool isFontSize;
//   final Color titleColor;
//   final double titleFontSize;
//   final FocusNode? focusNode;
//   final FontWeight titleFontWeight;
//   final double paddingVertical;
//   final double paddingHorizontal;
//   final Color buttonBackgroundColor;
//   final Color buttonBorderColor;
//   final void Function() onPressed;
//   final bool enableButton;
//
//   @override
//   State<AppButton> createState() => _AppButtonState();
// }
//
// class _AppButtonState extends State<AppButton> with TickerProviderStateMixin {
//   late AnimationController _controller;
//   final Duration _animationDuration = const Duration(milliseconds: 200);
//   final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.8);
//
//   @override
//   void initState() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: _animationDuration,
//     )..addListener(() {
//         setState(() {});
//       });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ScaleTransition(
//       scale: _tween.animate(
//         CurvedAnimation(
//           parent: _controller,
//           curve: Curves.easeOut,
//           reverseCurve: Curves.easeIn,
//         ),
//       ),
//       child: TextButton(
//         focusNode: widget.focusNode,
//         style: TextButton.styleFrom(
//           overlayColor: Colors.transparent,
//           backgroundColor: widget.buttonBackgroundColor,
//           foregroundColor: widget.buttonBackgroundColor,
//           alignment: Alignment.center,
//           padding: EdgeInsets.zero,
//           // Padding
//           disabledBackgroundColor: Colors.grey,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8.0), // Button border radius
//           ),
//         ),
//         onPressed: widget.enableButton
//             ? () async {
//                 await _controller
//                     .forward()
//                     .then((value) => _controller.reverse());
//                 widget.onPressed();
//               }
//             : null,
//         child: Container(
//           padding: EdgeInsets.symmetric(
//               horizontal: widget.paddingHorizontal,
//               vertical: widget.paddingVertical),
//           alignment: widget.align ? Alignment.center : null,
//           child: AppText(widget.title,
//               fontSize: widget.titleFontSize,
//               fontWeight: widget.titleFontWeight,
//               underline: widget.titleUnderline
//                   ? TextDecoration.underline
//                   : TextDecoration.none,
//               color: widget.titleColor),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  const AppButton(
      {super.key,
      this.title = "",
      this.child,
      this.titleColor = Colors.white,
      this.titleFontSize = 16,
      this.borderRadius = 10,
      this.fontFamily = "Raleway",
      this.titleFontWeight = FontWeight.w600,
      required this.onPressed,
      this.isTextBtn = false,
      this.alignment,
      this.disableBtn = false,
      this.height = 40});

  final String title;
  final Widget? child;
  final Alignment? alignment;
  final String fontFamily;
  final bool isTextBtn;

  final Color titleColor;

  final bool disableBtn;

  final double titleFontSize;
  final double borderRadius;
  final FontWeight titleFontWeight;
  final double height;
  final void Function() onPressed;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> with TickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 200);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.8);

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _tween.animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOut,
          reverseCurve: Curves.easeIn,
        ),
      ),
      child: Container(
        alignment: widget.alignment,
        height: widget.isTextBtn ? null : widget.height,
        // constraints:
        //     const BoxConstraints(maxHeight: 40.0, minHeight: 0.0),
        decoration: widget.isTextBtn
            ? null
            : BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF41237E),
                    Color(0xFF41237E),
                    Color(0xFF1B54B7)
                  ],
                ),
              ),
        child: ElevatedButton(
          onPressed: widget.disableBtn
              ? null
              : () async {
                  await _controller
                      .forward()
                      .then((value) => _controller.reverse());

                  widget.onPressed();
                },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            elevation: 0,
            overlayColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            disabledBackgroundColor: Colors.transparent,
            disabledForegroundColor: Colors.transparent,
            minimumSize: const Size(0, 0),
            side: BorderSide.none,
            foregroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
          ),
          child: widget.child ??
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: widget.isTextBtn ? 0.0 : 20.0),
                child: Text(
                  widget.title,
                  style: TextStyle(
                      color: widget.titleColor,
                      fontSize: widget.titleFontSize,
                      fontFamily: widget.fontFamily,
                      fontWeight: widget.titleFontWeight),
                ),
              ),
        ),
      ),
    );
  }
}
