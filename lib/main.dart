import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ibeacon_flutter/components/json_editor.dart';
import 'package:ibeacon_flutter/model/app_model.dart';
import 'package:ibeacon_flutter/screens/content.dart';
import 'package:ibeacon_flutter/screens/home.dart';
import 'package:ibeacon_flutter/screens/settings.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    ContentScreen(),
    SettingsScreen(),
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  //New
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, appModel, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.perm_media),
              label: "Content",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bluetooth),
              label: "Settings",
            )
          ],
        ),
        body: _pages.elementAt(_selectedIndex),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: _incrementCounter,
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ), //
      ),
    );
  }
}

// return Scaffold(
//   appBar: AppBar(
//     backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//     title: Text(widget.title),
//   ),
//   body: SingleChildScrollView(
//     child: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           JsonEditorWidget(
//             onJsonChanged: (String json) {
//               if (kDebugMode) {
//                 print(json);
//               }
//             },
//           ),
//           const Text(
//             'You have pushed the button this many times:',
//           ),
//           Text(
//             '$_counter',
//             style: Theme.of(context).textTheme.headlineMedium,
//           ),
//         ],
//       ),
//     ),
//   ),
//   floatingActionButton: FloatingActionButton(
//     onPressed: _incrementCounter,
//     tooltip: 'Increment',
//     child: const Icon(Icons.add),
//   ), // This trailing comma makes auto-formatting nicer for build methods.
// );




// SingleChildScrollView(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 JsonEditorWidget(
//                   onJsonChanged: (String json) {
//                     if (kDebugMode) {
//                       print(json);
//                     }
//                   },
//                 ),
//                 const Text(
//                   'You have pushed the button this many times:',
//                 ),
//                 Text(
//                   '$_counter',
//                   style: Theme.of(context).textTheme.headlineMedium,
//                 ),
//               ],
//             ),
//           ),
//         ),