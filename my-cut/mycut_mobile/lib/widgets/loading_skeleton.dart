import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class LoadingSkeleton extends StatefulWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const LoadingSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  State<LoadingSkeleton> createState() => _LoadingSkeletonState();
}

class _LoadingSkeletonState extends State<LoadingSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppTheme.surfaceVariant,
                AppTheme.surfaceVariant.withOpacity(0.5),
                AppTheme.surfaceVariant,
              ],
              stops: [
                _animation.value - 0.3,
                _animation.value,
                _animation.value + 0.3,
              ].map((stop) => stop.clamp(0.0, 1.0)).toList(),
            ),
          ),
        );
      },
    );
  }
}

class BarberCardSkeleton extends StatelessWidget {
  const BarberCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: AppTheme.textPrimary.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const LoadingSkeleton(
                  width: 70,
                  height: 70,
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LoadingSkeleton(width: 120, height: 20),
                      const SizedBox(height: 8),
                      const LoadingSkeleton(width: 80, height: 16),
                    ],
                  ),
                ),
                const LoadingSkeleton(width: 24, height: 24),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const LoadingSkeleton(width: 60, height: 24, borderRadius: BorderRadius.all(Radius.circular(12))),
                const SizedBox(width: 8),
                const LoadingSkeleton(width: 50, height: 24, borderRadius: BorderRadius.all(Radius.circular(12))),
                const SizedBox(width: 8),
                const LoadingSkeleton(width: 70, height: 24, borderRadius: BorderRadius.all(Radius.circular(12))),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const LoadingSkeleton(width: 40, height: 20, borderRadius: BorderRadius.all(Radius.circular(8))),
                const SizedBox(width: 12),
                const LoadingSkeleton(width: 50, height: 20, borderRadius: BorderRadius.all(Radius.circular(8))),
                const Spacer(),
                const LoadingSkeleton(width: 60, height: 20, borderRadius: BorderRadius.all(Radius.circular(8))),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const LoadingSkeleton(width: 8, height: 8, borderRadius: BorderRadius.all(Radius.circular(4))),
                const SizedBox(width: 8),
                const LoadingSkeleton(width: 80, height: 16),
                const Spacer(),
                const LoadingSkeleton(width: 70, height: 24, borderRadius: BorderRadius.all(Radius.circular(12))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
