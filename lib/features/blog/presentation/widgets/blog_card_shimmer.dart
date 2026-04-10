import 'package:blog_app/config/theme/app_palette.dart';
import 'package:flutter/material.dart';

class BlogCardShimmer extends StatefulWidget {
  const BlogCardShimmer({super.key});

  @override
  State<BlogCardShimmer> createState() => _BlogCardShimmerState();
}

class _BlogCardShimmerState extends State<BlogCardShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseColor = theme.colorScheme.surfaceContainerHighest;
    final highlightColor = theme.colorScheme.onSurface.withOpacity(0.16);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(-1.0 + (2.0 * _controller.value), 0),
              end: Alignment(1.0 + (2.0 * _controller.value), 0),
              colors: [
                AppPalette.transparentColor,
                highlightColor,
                AppPalette.transparentColor,
              ],
              stops: const [0.1, 0.4, 0.7],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: child,
        );
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.colorScheme.outline),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
                    _SkeletonChip(width: 72),
                    _SkeletonChip(width: 88),
                    _SkeletonChip(width: 64),
                  ],
                ),
                const SizedBox(height: 14),
                const _SkeletonLine(width: double.infinity, height: 20),
                const SizedBox(height: 10),
                const _SkeletonLine(width: 220, height: 18),
                const SizedBox(height: 10),
                const _SkeletonLine(width: double.infinity, height: 18),
              ],
            ),
            const _SkeletonLine(width: 70, height: 14),
          ],
        ),
      ),
    );
  }
}

class _SkeletonChip extends StatelessWidget {
  const _SkeletonChip({this.width = 58});

  final double width;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface.withOpacity(0.08);

    return Container(
      width: width,
      height: 28,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class _SkeletonLine extends StatelessWidget {
  const _SkeletonLine({required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface.withOpacity(0.08);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
