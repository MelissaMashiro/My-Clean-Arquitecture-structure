import 'package:clean_arquitecture_project/src/presentation/ui/spacing.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key? key,
    this.message,
  }) : super(key: key);

  final String? message;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(
              Spacing.medium,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: Spacing.xlarge,
                  ),
                  Text(message ?? 'Loading…'),
                ],
              ),
            ),
          ),
        ),
      );
}
