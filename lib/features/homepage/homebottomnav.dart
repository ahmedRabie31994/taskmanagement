import 'package:flutter/material.dart';
import 'package:todoapp/features/categoriespage/categorypage.dart';
import 'package:todoapp/features/homepage/homepage.dart';
import 'package:todoapp/features/homepage/widgets/addingtask.dart';
import 'package:todoapp/features/notifcationpage/notficationpage.dart';
import 'package:todoapp/features/taskspage/taskpage.dart';

class HomeBottomNav extends StatefulWidget {
  const HomeBottomNav({Key? key}) : super(key: key);
  @override
  State<HomeBottomNav> createState() => _HomeBottomNavState();
}

class _HomeBottomNavState extends State<HomeBottomNav> {
  int currentindex = 0;
  final List<Widget> pages = <Widget>[
    HomePage(),
    const TaskPage(),
    const NotificationPag(),
    const CategoryPage(),
  ];
  final TextEditingController _titlecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double totalScreenHeight = MediaQuery.of(context).size.height;
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    double modalHeight = totalScreenHeight -
        kToolbarHeight -
        kBottomNavigationBarHeight -
        keyboardHeight;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xffFAFDF6),
      body: Stack(
        children: [
          IndexedStack(
            index: currentindex,
            children: pages,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: kBottomNavigationBarHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.4),
                    blurRadius: 5,
                    offset: const Offset(0, 26),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.grey,
                unselectedLabelStyle: const TextStyle(color: Colors.red),
                currentIndex: currentindex,
                onTap: (value) {
                  setState(() {
                    currentindex = value;
                  });
                },
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.badge_sharp,
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.notifications,
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.category), label: ''),
                ],
                backgroundColor: const Color(0xffEDECEA),
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                selectedFontSize: 12,
                selectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.w600),
                unselectedFontSize: 12,
                selectedIconTheme: const IconThemeData(size: 25),
              ),
            ),
          ),
          Positioned(
            bottom: 35,
            left: MediaQuery.of(context).size.width / 2 - 20,
            child: CircleAvatar(
              backgroundColor: Colors.amber,
              radius: 20,
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () async {
                  await showModalBottomSheet(
                    context: context,
                    isScrollControlled: false,
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        behavior: HitTestBehavior.opaque,
                        child: SingleChildScrollView(
                          child: Container(
                            height: modalHeight,
                            padding: EdgeInsets.only(bottom: keyboardHeight),
                            child: AddingTaskWidget(
                              titlecontroller: _titlecontroller,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
