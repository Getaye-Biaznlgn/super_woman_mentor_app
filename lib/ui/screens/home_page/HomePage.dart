import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_woman_mentor/ui/screens/home_page/components/chat_tab.dart';
import 'package:super_woman_mentor/ui/screens/home_page/components/request_tab.dart';
import '../../../providers/auth.dart';
import '../../../utils/constants.dart';
import 'components/account_tab.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/home-page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// 700
class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions =  <Widget>[
    ChatTab(),
    RequestTab(),
    AccountTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  @override
  void initState() {
    super.initState();
    final Auth auth = Provider.of<Auth>(context, listen: false);
    auth.getUserInfo(token: auth.token);
  }

  @override
  Widget build(BuildContext context) {
    // final Auth auth = Provider.of<Auth>(context);

    return Scaffold(
        appBar: AppBar(
          title: getAppBarTitle(),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.bell),
            )
          ],
        ),
        body: Container(
          child: _widgetOptions[_selectedIndex],
        ),
        bottomNavigationBar: buildBottomNavigationBar());
  }

  Widget getAppBarTitle() {
    switch (_selectedIndex) {
      case 0:
        return const Text('Chat');
      case 1:
        return const Text("Request", );
      case 2:
        return const Text( "Account",);

      default:
        return const Text('');
    }
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Chat"),
        BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined), label: "Request"),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user), label: "Account"),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: kPrimaryColor,
      onTap: _onItemTapped,
    );
  }
}
