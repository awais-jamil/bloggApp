import 'package:bloggapp/PhotoUpload.dart';
import 'package:flutter/material.dart';
import 'HomeTab.dart';
import 'Authentication.dart';

const String page1 = "Home";
const String page2 = "Photo Upload";


class MainTabBar extends StatefulWidget {

  MainTabBar({
    this.auth,
    this.onSignedOut
  });

  final AuthImplementation auth;
  final VoidCallback onSignedOut;

  @override
  State<StatefulWidget> createState() {
    return new _MainTabBarState();
  }
}

class _MainTabBarState extends State<MainTabBar> {

  List<Widget> _pages;
  Widget _home;
  Widget _upload;

  int _currentIndex;
  Widget _currentPage;
  String title = "Home";

  @override
  void initState() {
    super.initState();

    _home = HomeTab();
    _upload = PhotoUpload(onSwitchTab: _switchTab);

    _pages = [_home, _upload];

    _currentIndex = 0;
    _currentPage = _home;
  }

  void _switchTab(){
    changeTab(0);
  }

  void changeTab(int index) {

    String appBarTitle = "";

    if(index == 0){
      appBarTitle = "Home";
    } else if(index == 1){
      appBarTitle = "Photo Upload";
    } else {
      logoutUser();
    }

    setState(() {
      _currentIndex = index;
      _currentPage = _pages[index];
      title = appBarTitle;
    });
  }

  void logoutUser() async {
    try{

      await widget.auth.SignOut();
      widget.onSignedOut();

    } catch(e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: _currentPage,
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => changeTab(index),
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                title: Text("Home"), icon: Icon(Icons.list)),
            BottomNavigationBarItem(
                title: Text("Post"), icon: Icon(Icons.cloud_upload)),
            BottomNavigationBarItem(
                title: Text("Logout"), icon: Icon(Icons.add_to_home_screen))
          ]),
//      drawer: new Drawer(
//        child: new Container(
//          margin: EdgeInsets.only(top: 20.0),
//          child: new Column(
//            children: <Widget>[
//              navigationItemListTitle(page1, 0),
//              navigationItemListTitle(page2, 1),
//            ],
//          ),
//        ),
//      ),
    );
  }
//
//  Widget navigationItemListTitle(String title, int index) {
//    return new ListTile(
//      title: new Text(
//        title,
//        style: new TextStyle(color: Colors.blue[400], fontSize: 22.0),
//      ),
//      onTap: () {
//        Navigator.pop(context);
//        changeTab(index);
//      },
//    );
//  }
}
