import 'package:flutter/material.dart';

const List<Widget> fruits = <Widget>[
  Text('Yes'),
  Text('No')
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Prayer Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  final List<bool> _yesNoFajir = <bool>[true, false];
  final List<bool> _yesNoDhuhr = <bool>[true, false];
  final List<bool> _yesNoAsr = <bool>[true, false];
  final List<bool> _yesNoMaghrib = <bool>[true, false];
  final List<bool> _yesNoIshaa = <bool>[true, false];



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
       body: Row(
          children: [
            Expanded(
              child: Column(
                children: <Widget>[
                  const Text(
                    'Today',
                    style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                  ),
                  Text(
                    'Fajir',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    'Dhuhr',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    'Asr',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    'Maghrib',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    'Isha\'a',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Container(
                    margin: EdgeInsets.all(3),
                    child: ElevatedButton(
                      onPressed: (){

                      },
                      child: Text(
                          "Qada"
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(3),
                    child: ElevatedButton(
                      onPressed: (){

                      },
                      child: Text(
                          "Zakat"
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  ToggleButtons(//Toggle for Fajir
                    onPressed: (int index) {
                      setState(() {
                        // The button that is tapped is set to true, and the others to false.
                        for (int i = 0; i < _yesNoFajir.length; i++) {
                          _yesNoFajir[i] = i == index;
                        }
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor: Colors.red[700],
                    selectedColor: Colors.white,
                    fillColor: Colors.red[200],
                    color: Colors.red[400],
                    constraints: const BoxConstraints(
                      minHeight: 40.0,
                      minWidth: 80.0,
                    ),
                    isSelected: _yesNoFajir,
                    children: fruits,
                  ),
                  ToggleButtons(//toggle for Dhuhr
                    onPressed: (int index) {
                      setState(() {
                        // The button that is tapped is set to true, and the others to false.
                        for (int i = 0; i < _yesNoDhuhr.length; i++) {
                          _yesNoDhuhr[i] = i == index;
                        }
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor: Colors.red[700],
                    selectedColor: Colors.white,
                    fillColor: Colors.red[200],
                    color: Colors.red[400],
                    constraints: const BoxConstraints(
                      minHeight: 40.0,
                      minWidth: 80.0,
                    ),
                    isSelected: _yesNoDhuhr,
                    children: fruits,
                  ),
                  ToggleButtons(//Toggle for Asr
                    onPressed: (int index) {
                      setState(() {
                        // The button that is tapped is set to true, and the others to false.
                        for (int i = 0; i < _yesNoAsr.length; i++) {
                          _yesNoAsr[i] = i == index;
                        }
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor: Colors.red[700],
                    selectedColor: Colors.white,
                    fillColor: Colors.red[200],
                    color: Colors.red[400],
                    constraints: const BoxConstraints(
                      minHeight: 40.0,
                      minWidth: 80.0,
                    ),
                    isSelected: _yesNoAsr,
                    children: fruits,
                  ),
                  ToggleButtons(// Toggle for Maghrib
                    onPressed: (int index) {
                      setState(() {
                        // The button that is tapped is set to true, and the others to false.
                        for (int i = 0; i < _yesNoMaghrib.length; i++) {
                          _yesNoMaghrib[i] = i == index;
                        }
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor: Colors.red[700],
                    selectedColor: Colors.white,
                    fillColor: Colors.red[200],
                    color: Colors.red[400],
                    constraints: const BoxConstraints(
                      minHeight: 40.0,
                      minWidth: 80.0,
                    ),
                    isSelected: _yesNoMaghrib,
                    children: fruits,
                  ),
                  ToggleButtons(//Toggle for Ishaa
                    onPressed: (int index) {
                      setState(() {
                        // The button that is tapped is set to true, and the others to false.
                        for (int i = 0; i < _yesNoIshaa.length; i++) {
                          _yesNoIshaa[i] = i == index;
                        }
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor: Colors.red[700],
                    selectedColor: Colors.white,
                    fillColor: Colors.red[200],
                    color: Colors.red[400],
                    constraints: const BoxConstraints(
                      minHeight: 40.0,
                      minWidth: 80.0,
                    ),
                    isSelected: _yesNoIshaa,
                    children: fruits,
                  ),
                  Container(
                    margin: EdgeInsets.all(3),
                    child: ElevatedButton(
                      onPressed: (){

                      },
                      child: Text(
                          "Sawm"
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(3),
                    child: ElevatedButton(
                      onPressed: (){

                      },
                      child: Text(
                          "Setting"
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
