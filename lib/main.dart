import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_woman_mentor/controller/availability_controller.dart';
import 'package:super_woman_mentor/providers/message_provider.dart';
import 'package:super_woman_mentor/ui/screens/sign_in/sign_in.dart';
import 'controller/request_controller.dart';
import 'providers/auth.dart';
import 'providers/themes.dart';
import 'ui/screens/home_page/HomePage.dart';
import 'utils/routers.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(),
      ),
      ChangeNotifierProvider<Auth>(create: (_) => Auth()),
      ChangeNotifierProvider<MessageController>(
          create: (_) => MessageController()),
      ChangeNotifierProvider<RequestController>(create: (_)=>RequestController(),) ,
      ChangeNotifierProvider<AvailabilityController>(create: (_)=>AvailabilityController(),)    
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context);

    return Consumer<ThemeNotifier>(
        builder: (context, theme, _) => MaterialApp(
            title: 'Super woman',
            theme: theme.getTheme(),
            debugShowCheckedModeBanner: false,
            routes: routes,
            // initialRoute: Login.routeName,
            home: auth.isAuth
                ? const HomePage()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? const CircularProgressIndicator()
                            : const SignIn())));
  }
}
