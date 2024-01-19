import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              _buildShimmerContainer(100.0, 100.0),
            ],
          ),
          const SizedBox(height: 20.0),
          Column(
            children: [
              _buildShimmerContainer(300.0, 200.0),
            ],
          ),
          const SizedBox(height: 20.0),
          Column(
            children: [
              _buildShimmerContainer(300.0, 170.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerContainer(double width, double height) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
