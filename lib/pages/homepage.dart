import 'package:divisibility_calculator/pages/manual.dart';
import 'package:divisibility_calculator/pages/divisibilityCalculator/divisibilityEquationGenerator.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Homepage extends StatefulWidget {
  const Homepage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  PageController page = PageController();
  late List<SideMenuItem> _items;
  final Uri _url = Uri.parse("https://github.com/Papajik");

  @override
  void initState() {
    _items = [
      SideMenuItem(
        // Priority of item to show on SideMenu, lower value is displayed at the top
        priority: 0,
        title: 'Vysvětlivky',
        onTap: () {
          page.jumpToPage(0);
        },
        icon: const Icon(Icons.home),
      ),
      SideMenuItem(
        // Priority of item to show on SideMenu, lower value is displayed at the top
        priority: 1,
        title: 'Dělitelnost',
        onTap: () {
          page.jumpToPage(1);
        },
        icon: const Icon(Icons.calculate),
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
            // title: const SizedBox(
            //     height: 40, child: Center(child: Text('Test dělitelnosti'))),
            footer: SizedBox(
                height: 40, child: Center(child: InkWell(
                child: const Text('Papajik'),
                onTap: () => _launchUrl
            ))),
            onDisplayModeChanged: (mode) {
              print(mode);
            },
            items: _items,
          ),
          Expanded(
            child: PageView(
              controller: page,
              children: const [
                ManualScreen(),
                DivisibilityEquationGeneratorScreen(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
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
      backgroundColor: Colors.grey.shade300,
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
