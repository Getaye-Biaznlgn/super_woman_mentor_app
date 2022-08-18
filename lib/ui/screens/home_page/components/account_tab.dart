import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:super_woman_mentor/ui/screens/availability/availability.dart';
import 'package:super_woman_mentor/ui/screens/edit_profile/profile.dart';
import 'package:super_woman_mentor/ui/screens/profile_picture/profile_picture_chooser.dart';
import '../../../../providers/auth.dart';
import '../../../../providers/themes.dart';
import '../../../../utils/constants.dart';

class AccountTab extends StatelessWidget {
  const AccountTab({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context);
    final auth = Provider.of<Auth>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ProfileWidget(),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('You got 4 request'),
              trailing: IconButton(
                icon: const Icon(Icons.play_arrow),
                onPressed: () {},
              ),
            ),
            ListTile(
                leading: const Icon(FontAwesomeIcons.user),
                title: const Text('Edit Profile'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.pushNamed(context, Profile.routeName);
                }),
            ListTile(
                leading: const Icon(FontAwesomeIcons.userNinja),
                title: const Text('Security'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigator.pushNamed(context);
                }),
            ListTile(
              leading: const Icon(FontAwesomeIcons.inbox),
              title: const Text('Availability'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Availability.routeName,
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.remove_red_eye_outlined),
              title: const Text('Dark Mode'),
              contentPadding: const EdgeInsets.only(right: 0, left: 15),
              trailing: SizedBox(
                height: 30,
                width: 100,
                child: FlutterSwitch(
                    value: themeNotifier.isDark,
                    activeColor: kSecondaryColor,
                    onToggle: (value) {
                      if (value) {
                        themeNotifier.setDarkMode();
                      } else {
                        themeNotifier.setLightMode();
                      }
                    }),
              ),
            ),

            SizedBox(
              child: ListTile(
                onTap: () {
                  auth.logout();
                },
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Stack(
            children:[
              auth.profilePicture == null
            ? CircleAvatar(
                radius: 30,
                backgroundColor: kPrimaryColor,
                child: Text(
                  auth.firstName?.substring(0, 1).toUpperCase() ?? '',
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )
            : CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(auth.profilePicture!),
              ),
              Positioned(
              bottom: 0,
              right: 0,
              child:  IconButton(icon: const Icon(FontAwesomeIcons.camera, size: 30, color: Colors.white,),
               onPressed: (){
                Navigator.pushNamed(context, ProfilePictureChooser.routeName);
               },))
            ]
          ),
        ),
        
        const SizedBox(
          height: 10,
        ),
        Text(
          '${auth.firstName} ${auth.lastName}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Text('${auth.experience?.position}, ${auth.experience?.org}'),
        const SizedBox(
          height: 10,
        ),
        Text('${auth.noOfMentee} mentee'),
        const SizedBox(
          height: 10,
        ),
        Text(
          '${auth.bio}',
          maxLines: 3,
          textAlign: TextAlign.center,
          softWrap: true,
        )
      ],
    );
  }
}
