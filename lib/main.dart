import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triptolemus/routes/routes.dart';
import 'package:triptolemus/services/player_service.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => PlayerList())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        initialRoute: 'players',
        routes: appRoutes,
      ),
    );
  }
}
