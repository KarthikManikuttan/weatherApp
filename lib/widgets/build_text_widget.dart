import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildTextWidget extends StatefulWidget {
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final Color? color;
  final String? font;
  final FontStyle? fontStyle;

  const BuildTextWidget({
    super.key,
    required this.text,
    this.size,
    this.fontWeight,
    this.color,
    this.font,
    this.fontStyle,
  });

  @override
  State<BuildTextWidget> createState() => _BuildTextWidgetState();
}

class _BuildTextWidgetState extends State<BuildTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.getFont(
        widget.font ?? 'Hind Madurai',
        fontStyle: widget.fontStyle ?? FontStyle.normal,
        fontSize: widget.size,
        fontWeight: widget.fontWeight,
        color: widget.color ?? Colors.white,
      ),
    );
  }
}
