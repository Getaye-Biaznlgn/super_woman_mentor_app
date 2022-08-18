import 'package:flutter/material.dart';
import 'package:super_woman_mentor/ui/screens/availability/availability.dart';
import 'package:super_woman_mentor/ui/screens/chat/chat_screen.dart';
import 'package:super_woman_mentor/ui/screens/home_page/HomePage.dart';
import 'package:super_woman_mentor/ui/screens/profile_picture/profile_picture_chooser.dart';
import '../ui/screens/edit_profile/profile.dart';
import '../ui/screens/sign_in/sign_in.dart';

final Map<String, WidgetBuilder> routes = {
  ChatScreen.routeName: ((context) => const ChatScreen()),
  SignIn.routeName: ((context) => const SignIn()),
  HomePage.routeName: ((context) => const HomePage()),
  Profile.routeName: ((context) => const Profile()),
  Availability.routeName: ((context) => const Availability()),
  ProfilePictureChooser.routeName: ((context) => const ProfilePictureChooser()),
};
