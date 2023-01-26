import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:provider/provider.dart';

import 'package:vakinha_app/app/core/ui/helpers/loader.dart';
import 'package:vakinha_app/app/core/ui/helpers/message.dart';

abstract class BaseState<T extends StatefulWidget, C extends BlocBase>
    extends State<T> with Loader, Message {
  late final C controller;
  @override
  void initState() {
    super.initState();
    controller = context.read<C>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onReady();
    });
  }

  @override
  void dispose() {
    disposeState();
    super.dispose();
  }

  void onReady() {}

  void disposeState() {}
}
