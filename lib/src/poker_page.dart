import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/poker_bloc.dart';
import 'util/app_splash.dart';
import 'widgets/table.dart';

class PokerPage extends StatefulWidget {
  const PokerPage({super.key, required this.title});

  final String title;

  @override
  State<PokerPage> createState() => _PokerPageState();
}

class _PokerPageState extends State<PokerPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
    ).whenComplete(
      () => AppSplash.remove(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (_) => PokerBloc(),
          child: const WidgetTable(),
        ),
      ),
    );
  }
}
