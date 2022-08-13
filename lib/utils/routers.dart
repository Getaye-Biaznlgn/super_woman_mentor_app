import 'package:flutter/material.dart';
import 'package:super_woman_mentor/ui/screens/chat/chat_screen.dart';
import 'package:super_woman_mentor/ui/screens/home_page/HomePage.dart';
import '../ui/screens/sign_in/sign_in.dart';

final Map<String, WidgetBuilder> routes = {
  ChatScreen.routeName: ((context) => const ChatScreen()),
  SignIn.routeName: ((context) => const SignIn()),
  HomePage.routeName: ((context)=>const HomePage())
};
