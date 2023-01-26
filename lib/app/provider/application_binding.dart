import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:vakinha_app/app/core/rest_client/custom_dio.dart';

class ApplicationBinding extends StatelessWidget {
  const ApplicationBinding({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => CustomDio(),
        ),
      ],
      child: child,
    );
  }
}
