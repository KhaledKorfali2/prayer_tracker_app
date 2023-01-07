import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  //Used to save the current state of textfields and toggle buttons
  var curSawmNum;
  var curNathiirNum;
  var curZakatNum;
  var curZakatElFutrahNum;
  var curFajirNum;
  var curDhuhrNum;
  var curAsrNum;
  var curMaghribNum;
  var curIshaaNum;
  _MyHomePageState(){
    SharedPreferences.getInstance().then((pref) {
      curSawmNum = pref.getString("SawmNum");
      curNathiirNum = pref.getString("NathiirNum");
      curZakatNum = pref.getString("ZakatNum");
      curZakatElFutrahNum = pref.getString("ZakatElFuthrahNum");
      curFajirNum = pref.getString("FajirNum");
      curDhuhrNum = pref.getString("DhuhrNum");
      curAsrNum = pref.getString("AsrNum");
      curMaghribNum = pref.getString("MaghribNum");
      curIshaaNum = pref.getString("IshaaNum");




    });
  }


  //List that stores whether toggle bottons are yes/no
  final List<bool> _yesNoFajir = <bool>[true, false];
  final List<bool> _yesNoDhuhr = <bool>[true, false];
  final List<bool> _yesNoAsr = <bool>[true, false];
  final List<bool> _yesNoMaghrib = <bool>[true, false];
  final List<bool> _yesNoIshaa = <bool>[true, false];


  //Info about current date
  var curDay = DateTime.now().day.toString();
  var curMonth = DateTime.now().month.toString();
  var curYear = DateTime.now().year.toString();

  //Font sizes
  static const double fontSiz = 25;


  //Text Editing Controllers
  TextEditingController fajirController = TextEditingController();
  TextEditingController dhuhrController = TextEditingController();
  TextEditingController asrController = TextEditingController();
  TextEditingController maghribController = TextEditingController();
  TextEditingController ishaaController = TextEditingController();
  TextEditingController zakatController = TextEditingController();
  TextEditingController zakatElFutrahController = TextEditingController();
  TextEditingController sawmController = TextEditingController();
  TextEditingController nathiirController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      //backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
       body: Column(
          children: [
            Expanded(//Today Row
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Today',
                    style: TextStyle(
                    decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSiz,
                  ),
                  ),
                  const Spacer(),
                  Text(
                    '${curMonth}/${curDay}/${curYear}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            Expanded(//Fajir Row
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Fajir',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSiz,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    child: ToggleButtons(//Toggle for Fajir
                      onPressed: (int index) {
                        setState(() {
                          // The button that is tapped is set to true, and the others to false.
                          for (int i = 0; i < _yesNoFajir.length; i++) {
                            _yesNoFajir[i] = i == index;
                          }
                        });
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      selectedBorderColor: Colors.green[700],
                      selectedColor: Colors.white,
                      fillColor: Colors.green[200],
                      color: Colors.red[400],
                      constraints: const BoxConstraints(
                        minHeight: 40.0,
                        minWidth: 80.0,
                      ),
                      isSelected: _yesNoFajir,
                      children: fruits,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(//Dhuhr Row
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Dhuhr',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSiz,
                    ),
                  ),
                  const Spacer(),
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
                    selectedBorderColor: Colors.green[700],
                    selectedColor: Colors.white,
                    fillColor: Colors.green[200],
                    color: Colors.red[400],
                    constraints: const BoxConstraints(
                      minHeight: 40.0,
                      minWidth: 80.0,
                    ),
                    isSelected: _yesNoDhuhr,
                    children: fruits,
                  ),
                ],
              ),
            ),
            Expanded(//Asr Row
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Asr',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSiz,
                    ),
                  ),
                  const Spacer(),
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
                    selectedBorderColor: Colors.green[200],
                    selectedColor: Colors.white,
                    fillColor: Colors.green[700],
                    color: Colors.red[400],
                    constraints: const BoxConstraints(
                      minHeight: 40.0,
                      minWidth: 80.0,
                    ),
                    isSelected: _yesNoAsr,
                    children: fruits,
                  ),
                ],
              ),
            ),
            Expanded(//Maghrib Row
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Maghrib',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSiz,
                    ),
                  ),
                  const Spacer(),
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
                    selectedBorderColor: Colors.green[700],
                    selectedColor: Colors.white,
                    fillColor: Colors.green[200],
                    color: Colors.red[400],
                    constraints: const BoxConstraints(
                      minHeight: 40.0,
                      minWidth: 80.0,
                    ),
                    isSelected: _yesNoMaghrib,
                    children: fruits,
                  ),
                ],
              ),
            ),
            Expanded(//Ishaa Row
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Isha\'a',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSiz,
                    ),
                  ),
                  const Spacer(),
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
                    selectedBorderColor: Colors.green[700],
                    selectedColor: Colors.white,
                    fillColor: Colors.green[200],
                    color: Colors.red[400],
                    constraints: const BoxConstraints(
                      minHeight: 40.0,
                      minWidth: 80.0,
                    ),
                    isSelected: _yesNoIshaa,
                    children: fruits,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 60,
                    width: 175,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green[700]),
                      ),
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content:const Text("Qada"),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Row")
                                ),
                              ],
                            ));
                      },
                      child: const Text(
                          "Qada"
                      ),
                    ),
                  ),
                  //const Spacer(),
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 60,
                    width: 175,
                    child: ElevatedButton(
                      onPressed: (){
                        showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Sawm'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  flex: 50,
                                    child: Text("Sawm (General)")
                                ),
                                Expanded(
                                  flex: 25,
                                    child: const Spacer()
                                ),
                                Expanded(
                                  flex: 25,
                                  child: TextField(
                                    controller: sawmController,
                                    obscureText: false,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "${curSawmNum}",
                                      labelStyle:
                                        TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold,
                                          fontSize: fontSiz,
                                        )
                                    ),
                                  ),
                              ),
                              ]
                          ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 50,
                                      child: const Text("Nathiir")
                                    ),
                                    Expanded(
                                      flex: 25,
                                      child: const Spacer()
                                    ),
                                    Expanded(
                                      flex: 25,
                                      child: TextField(
                                        controller: nathiirController,
                                        obscureText: false,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "${curNathiirNum}",
                                            labelStyle:
                                            TextStyle(
                                              decoration: TextDecoration.underline,
                                              fontWeight: FontWeight.bold,
                                              fontSize: fontSiz,
                                            )
                                        ),
                                      ),
                                    ),
                                  ]
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                SharedPreferences.getInstance().then((pref) {
                                  if(sawmController.text != ""){
                                    pref.setString("SawmNum", sawmController.text);
                                  }
                                  if(nathiirController.text != ""){
                                    pref.setString("NathiirNum", nathiirController.text);
                                  }
                                  curSawmNum = pref.getString("SawmNum");
                                  curNathiirNum = pref.getString("NathiirNum");
                                  print("Sawm (general): " + curSawmNum.toString());
                                  print("Nathiir: " + curNathiirNum.toString());

                                  sawmController.text = "";
                                  nathiirController.text = "";
                                });
                                Navigator.of(context).pop();
                              },
                              child: const Text('Save'),
                            ),
                          ],
                        )
                        );
                      },
                      child: const Text(
                          "Sawm"
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(3),
                    child: ElevatedButton(
                      onPressed: (){

                      },
                      child: const Text(
                          "Zakat"
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.all(3),
                    child: ElevatedButton(
                      onPressed: (){

                      },
                      child: const Text(
                          "Setting"
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }
}
