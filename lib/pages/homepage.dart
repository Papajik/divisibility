import 'package:divisibility_calculator/pages/divisibilityCheck.dart';
import 'package:divisibility_calculator/pages/divisibilityCalculator/divisibilityEquationGenerator.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  PageController page = PageController();
  late List<SideMenuItem> _items;

  @override
  void initState() {
    _items = [
      SideMenuItem(
        // Priority of item to show on SideMenu, lower value is displayed at the top
        priority: 0,
        title: 'Generátor vzorce',
        onTap: () {
          page.jumpToPage(0);
        },
        icon: const Icon(Icons.home),
      ),
      SideMenuItem(
        priority: 1,
        title: 'Ověření dělitelnosti',
        onTap: () {
          page.jumpToPage(1);
        },
        icon: const Icon(Icons.settings),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            style: _style,
            controller: page,
            title: const SizedBox(
                height: 40, child: Center(child: Text('Test dělitelnosti'))),
            footer: const SizedBox(
                height: 40, child: Center(child: Text('Papajik'))),
            onDisplayModeChanged: (mode) {
              print(mode);
            },
            items: _items,
          ),
          Expanded(
            child: PageView(
              controller: page,
              children: const [
                DivisibilityEquationGeneratorScreen(),
                DivisibilityCheckScreen(),
              ],
            ),
          )
        ],
      ),
    );
  }

  final _style = SideMenuStyle(
      displayMode: SideMenuDisplayMode.auto,
      //TODO: změnit podle obrazovky
      decoration: const BoxDecoration(),
      openSideMenuWidth: 200,
      compactSideMenuWidth: 50,
      hoverColor: Colors.blue[100],
      selectedColor: Colors.lightBlue,
      selectedIconColor: Colors.white,
      unselectedIconColor: Colors.black54,
      backgroundColor: Colors.grey,
      selectedTitleTextStyle: const TextStyle(color: Colors.white),
      unselectedTitleTextStyle: const TextStyle(color: Colors.black54),
      iconSize: 20,
      itemBorderRadius: const BorderRadius.all(
        Radius.circular(5.0),
      ),
      showTooltip: true,
      itemHeight: 50.0,
      itemInnerSpacing: 8.0,
      itemOuterPadding: const EdgeInsets.symmetric(horizontal: 5.0),
      toggleColor: Colors.black54);
}
