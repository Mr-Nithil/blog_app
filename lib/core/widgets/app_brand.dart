import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBrand extends StatelessWidget {
  final bool compact;
  final bool centered;
  final bool showTagline;

  const AppBrand({
    super.key,
    this.compact = false,
    this.centered = false,
    this.showTagline = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final iconWrapper = Container(
      width: compact ? 34 : 72,
      height: compact ? 34 : 72,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(compact ? 10 : 20),
      ),
      child: Icon(
        Icons.menu_book_rounded,
        size: compact ? 20 : 38,
        color: theme.colorScheme.primary,
      ),
    );

    final nameText = Text(
      'BlogHub',
      style: GoogleFonts.manrope(
        fontSize: compact ? 22 : 36,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.2,
        color: theme.colorScheme.onSurface,
        height: 1.1,
      ),
      textAlign: centered ? TextAlign.center : TextAlign.start,
    );

    final subtitle = Text(
      'Write. Read. Share ideas.',
      style: theme.textTheme.bodySmall,
      textAlign: TextAlign.center,
    );

    if (compact) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [iconWrapper, const SizedBox(width: 10), nameText],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: centered
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        iconWrapper,
        const SizedBox(height: 14),
        nameText,
        if (showTagline) ...[const SizedBox(height: 8), subtitle],
      ],
    );
  }
}
