import 'package:flutter/material.dart';

class ThiranButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? title;
  final double? width;
  final double? height;
  final double? fontSize;
  const ThiranButton(
      {this.onTap, this.title, this.width, this.height, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.red,
        ),
        alignment: Alignment.center,
        height: height != null ? height : null,
        width: width != null ? width : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: fontSize ?? fontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
