import 'package:flutter/material.dart';
import 'package:inclass_test/components/theme.dart';
import 'package:inclass_test/crud/create.dart' as firstTab;
import 'package:inclass_test/crud/delete.dart' as thirdTab;
import 'package:inclass_test/crud/read.dart' as  secondTab;


class Navbar extends StatefulWidget {
  @override
  HomeWidget createState() => HomeWidget();
}

class HomeWidget extends State<Navbar> {
  int _selectedTab = 0;

  final PageController _navPage = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: PageView(
        controller: _navPage,
        onPageChanged: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        children: <Widget>[
          firstTab.CreateDetails(),
          secondTab.ReadDetails(),
          thirdTab.DeleteDetails(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        shape: const CircularNotchedRectangle(),
        color: bgColor,
        child: Container(
          color: bgColor,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                iconSize: 25,
                icon: Icon(
                  _selectedTab == 0 ? Icons.add : Icons.add_outlined,
                  color: _selectedTab == 0 ? accentColor : null,
                ),
                onPressed: () {
                  setState(() {
                    _navPage.jumpToPage(0);
                  });
                },
              ),
              IconButton(
                iconSize: 25,
                icon: Icon(
                  _selectedTab == 1 ? Icons.read_more : Icons.read_more_outlined,
                  color: _selectedTab == 1 ? accentColor : null,
                ),
                onPressed: () {
                  setState(() {
                    _navPage.jumpToPage(1);
                  });
                },
              ),
              IconButton(
                iconSize: 25,
                icon: Icon(
                  _selectedTab == 2 ? Icons.delete : Icons.delete_outlined,
                  color: _selectedTab == 2 ? accentColor : null,
                ),
                onPressed: () {
                  setState(() {
                    _navPage.jumpToPage(2);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
