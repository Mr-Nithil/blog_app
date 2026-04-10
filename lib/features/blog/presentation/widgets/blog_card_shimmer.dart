import 'package:blog_app/config/theme/app_palette.dart';
import 'package:flutter/material.dart';

class BlogCardShimmer extends StatefulWidget {
  const BlogCardShimmer({super.key, required this.color});

  final Color color;

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
                AppPalette.whiteColor.withOpacity(0.28),
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
        height: 200,
        margin: EdgeInsets.all(15).copyWith(bottom: 4),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: widget.color.withOpacity(0.28),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: const [
                      _SkeletonChip(),
                      SizedBox(width: 8),
                      _SkeletonChip(),
                      SizedBox(width: 8),
                      _SkeletonChip(width: 72),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                const _SkeletonLine(width: double.infinity, height: 20),
                const SizedBox(height: 10),
                const _SkeletonLine(width: 200, height: 18),
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
    return Container(
      width: width,
      height: 28,
      decoration: BoxDecoration(
        color: AppPalette.whiteColor.withOpacity(0.16),
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
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppPalette.whiteColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
