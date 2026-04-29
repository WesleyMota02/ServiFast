import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:confetti/confetti.dart';
import '../theme/app_theme.dart';

class SuccessFeedbackScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final String nextRoute;

  const SuccessFeedbackScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.nextRoute,
  });

  @override
  State<SuccessFeedbackScreen> createState() => _SuccessFeedbackScreenState();
}

class _SuccessFeedbackScreenState extends State<SuccessFeedbackScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppTheme.successColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: AppTheme.successColor,
                      size: 64,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.subtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 48),
                  ElevatedButton(
                    onPressed: () {
                      context.go(widget.nextRoute);
                    },
                    child: Text(widget.buttonText),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              colors: const [AppTheme.primaryColor, AppTheme.successColor, Colors.white],
              shouldLoop: false,
            ),
          ),
        ],
      ),
    );
  }
}
