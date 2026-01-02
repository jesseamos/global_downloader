import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotify_downloader/core/utils/utils.dart';

/// A reusable widget for displaying currency amounts with the Naira symbol (₦).
///
/// This widget uses Roboto font to ensure the Naira symbol displays correctly,
/// while the rest of the app uses Albert Sans font.
///
/// Example usage:
/// ```dart
/// CurrencyText(
///   amount: '5000.00',
///   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
/// )
/// ```
class CurrencyText extends StatelessWidget {
  /// The amount to display. Can be a String or num (int/double).
  final dynamic amount;

  /// Optional text style to apply to the currency text.
  /// The fontFamily will be overridden to use Roboto.
  final TextStyle? style;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// An optional maximum number of lines for the text to span.
  final int? maxLines;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// Whether the text should break at soft line breaks.
  final bool? softWrap;

  /// The number of font pixels for each logical pixel.
  final double? textScaleFactor;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  final Locale? locale;

  /// The strut style to use. Strut style defines the strut, which sets minimum
  /// vertical layout metrics.
  final StrutStyle? strutStyle;

  /// Defines how to apply TextStyle.height over and under text.
  final TextHeightBehavior? textHeightBehavior;

  /// The directionality of the text.
  final TextDirection? textDirection;

  /// Whether to show the Naira symbol. Defaults to true.
  final bool showSymbol;

  /// Custom separator between symbol and amount. Defaults to a space.
  final String separator;

  const CurrencyText({
    super.key,
    required this.amount,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textScaleFactor,
    this.locale,
    this.strutStyle,
    this.textHeightBehavior,
    this.textDirection,
    this.showSymbol = true,
    this.separator = ' ',
  });

  @override
  Widget build(BuildContext context) {
    // Convert amount to string if it's a number
    final String amountStr = amount.toString();

    // Build the display text
    final String displayText = showSymbol
        ? '₦$separator${formatNumber(num.tryParse(amountStr))}'
        : amountStr;

    // Apply Roboto font to the provided style
    final TextStyle effectiveStyle = GoogleFonts.roboto(textStyle: style);

    return Text(
      displayText,
      style: effectiveStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textScaleFactor: textScaleFactor,
      locale: locale,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
      textDirection: textDirection,
    );
  }
}
