import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:techstore_app/core/constants/app_colors.dart';
import 'package:techstore_app/features/home/home.screen.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  bool _showText = false;
  bool _showTagline = false;
  bool _startCircleTransition = false;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOut),
    );

    _scaleController.forward();

    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) setState(() => _showText = true);
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) setState(() => _showTagline = true);
    });

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) setState(() => _startCircleTransition = true);
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.primary,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Gap(180),
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Image.asset(
                    "img/Splash.png",
                    height: 250,
                    width: 250,
                  ),
                ),
                const SizedBox(height: 5),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 800),
                  opacity: _showText ? 1.0 : 0.0,
                  child: Text(
                    'TechStore',
                    style: GoogleFonts.luckiestGuy(
                      fontSize: 55,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Gap(220),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 800),
                  opacity: _showTagline ? 1.0 : 0.0,
                  child: const Text(
                    'Your smart electronics hub',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),

        if (_startCircleTransition)
          const _CircleTransition(
            targetPage: HomeScreen(),
            color: Colors.white,
          ),
      ],
    );
  }
}

class _CircleTransition extends StatefulWidget {
  final Widget targetPage;
  final Color color;

  const _CircleTransition({
    required this.targetPage,
    required this.color,
  });

  @override
  State<_CircleTransition> createState() => _CircleTransitionState();
}

class _CircleTransitionState extends State<_CircleTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _animation = Tween<double>(begin: 0.0, end: 3.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 700), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => widget.targetPage),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color,
            ),
          ),
        );
      },
    );
  }
}