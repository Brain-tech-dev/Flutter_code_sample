import 'package:flutter_demo/utils/global_constants.dart';
import 'package:flutter_demo/utils/common_enums.dart';
import 'package:flutter/material.dart';

final labelLight = TextStyle(fontFamily: GlobalConstants.fontFamily, fontWeight: FontWeight.w300);
final labelRegular = TextStyle(fontFamily: GlobalConstants.fontFamily, fontWeight: FontWeight.w400);
final labelMedium = TextStyle(fontFamily: GlobalConstants.fontFamily, fontWeight: FontWeight.w500);
final labelSemiBold = TextStyle(fontFamily: GlobalConstants.fontFamily, fontWeight: FontWeight.w600);

class Label extends StatelessWidget {
  final String text;
  final int? maxLines;
  final double? fontSize;
  final Color? textColor;
  final TextAlign? align;
  final TextStyleType style;
  const Label({super.key, required this.text, required this.style, this.maxLines, this.fontSize, this.textColor, this.align});

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle();
    switch (style) {
      case TextStyleType.light:
        textStyle = labelLight;
        break;
      case TextStyleType.regular:
        textStyle = labelRegular;
        break;
      case TextStyleType.medium:
        textStyle = labelMedium;
        break;
      case TextStyleType.semibold:
        textStyle = labelSemiBold;
        break;
    }
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: textStyle.copyWith(color: textColor, fontSize: fontSize),
    );
  }
}
