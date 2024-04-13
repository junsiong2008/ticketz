import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[100],
        child: Center(
          child: SizedBox(
            height: 300,
            child: Lottie.asset('assets/animations/loading-paperplane.json'),
          ),
        ),
      ),
    );
  }
}
