import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  int _currentBottomBarIndex = 0;
  bool _showBottomBar = false;

  final _tabs = [
    Center(child: Text('Bottom Tab 1')),
    Center(child: Text('Bottom Tab 2')),
  ];

  Widget _changeUpperTab(upperTabIdx, isBottomBar) {
    setState(() {
      _showBottomBar = isBottomBar;
    });

    if (_showBottomBar) {
      return Scaffold(
        body: _tabs[_currentBottomBarIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentBottomBarIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
                backgroundColor: Colors.yellow),
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.red),
          ],
          onTap: (index) {
            setState(() {
              _currentBottomBarIndex = index;
            });
          },
        ),
      );
    } else {
      return Center(child: Text('Tab ' + upperTabIdx.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Test App'),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                  child: Text(
                'Upper Tab 1',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              Tab(
                  child: Text(
                'Upper Tab 2',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              Tab(
                  child: Text(
                'Upper Tab 3',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _changeUpperTab(1, false),
            _changeUpperTab(2, false),
            _changeUpperTab(3, true),
          ],
        ),
      ),
    );
  }
}
