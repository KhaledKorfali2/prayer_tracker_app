import 'package:synchronized/synchronized.dart';
import 'package:flutter/material.dart';
import 'package:prayer_tracker_app/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

const List<Widget> fruits = <Widget>[
  Text('Yes'),
  Text('No')
];

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

void main() {
  
  
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var darkestGreen = const Color(0xFF3a5043);
    return MaterialApp(
      title: 'Muslim Prayer Tracker',
      /*theme: ThemeData(
        primarySwatch: Colors.brown
      ),*/
      home: const MyHomePage(title: 'Muslim Prayer Tracker'),
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

  //Info about current date
  var curDay = DateTime.now().day.toString();
  var curMonth = DateTime.now().month.toString();
  var curYear = DateTime.now().year.toString();


  List<bool> isSelectedFajir = [true, false];
  int _currentSelectedFajir = 0;

  List<bool> isSelectedDhuhr = [true, false];
  int _currentSelectedDhuhr = 0;

  List<bool> isSelectedAsr = [true, false];
  int _currentSelectedAsr = 0;

  List<bool> isSelectedMaghrib = [true, false];
  int _currentSelectedMaghrib = 0;

  List<bool> isSelectedIshaa = [true, false];
  int _currentSelectedIshaa = 0;


  List<bool> isSelectedSawm = [true, false];
  int _currentSelectedSawm = 0;

//Initializes State of All Elements in App
  void initState() {
    super.initState();

    //Calls Helper function that performs initiations
    _firstStartUpInitialization();

  }


//Helper Function that Calls other functions to initialize app state
  Future _firstStartUpInitialization() async{
    var lock = Lock();
    await lock.synchronized(() async {
      await _InitializeDate();
    });



    //Initialize Toggle Buttons
    getIsSelectedFajir();
    isSelectedFajir = [true, false];

    getIsSelectedDhuhr();
    isSelectedDhuhr = [true, false];

    getIsSelectedAsr();
    isSelectedAsr = [true, false];

    getIsSelectedMaghrib();
    isSelectedMaghrib = [true, false];

    getIsSelectedIshaa();
    isSelectedIshaa = [true, false];

    getIsSelectedSawm();
    isSelectedSawm = [true, false];



    //Initialize Switches
    await getSwitchValues();

    //Get Tally Values
    await _getSawmTally();
    await _getNathiirTally();
    await _getZakatElFutrahTally();
    await _getZakatTally();
    await _getFajirTally();
    await _getDhuhrTally();
    await _getAsrTally();
    await  _getMaghribTally();
    await  _getIshaaTally();

  }

  //Get Tally Values For Sawm
  Future<void> _getSawmTally() async {
    var prefs = await SharedPreferences.getInstance();
    var value = prefs.getString('SawmNum') ?? "0";
    //print('saved tester $value');
    setState(() {
      curSawmNum = value;
    });
  }

  Future<void> _getNathiirTally() async {
    var prefs = await SharedPreferences.getInstance();
    var value = prefs.getString('NathiirNum') ?? "0";
    //print('saved tester $value');
    setState(() {
      curNathiirNum = value;
    });
  }

  Future<void> _getZakatTally() async {
    var prefs = await SharedPreferences.getInstance();
    var value = prefs.getString('ZakatNum') ?? "0";
    //print('saved tester $value');
    setState(() {
      curZakatNum = value;
    });
  }

  Future<void> _getZakatElFutrahTally() async {
    var prefs = await SharedPreferences.getInstance();
    var value = prefs.getString('ZakatElFuthrahNum') ?? "0";
    //print('saved tester $value');
    setState(() {
      curZakatElFutrahNum = value;
    });
  }

  Future<void> _getFajirTally() async {
    var prefs = await SharedPreferences.getInstance();
    var value = prefs.getString('FajirNum') ?? "0";
    //print('saved tester $value');
    setState(() {
      curFajirNum = value;
    });
  }

  Future<void> _getDhuhrTally() async {
    var prefs = await SharedPreferences.getInstance();
    var value = prefs.getString('DhuhrNum') ?? "0";
    //print('saved tester $value');
    setState(() {
      curDhuhrNum = value;
    });
  }

  Future<void> _getAsrTally() async {
    var prefs = await SharedPreferences.getInstance();
    var value = prefs.getString('AsrNum') ?? "0";
    //print('saved tester $value');
    setState(() {
      curAsrNum = value;
    });
  }

  Future<void> _getMaghribTally() async {
    var prefs = await SharedPreferences.getInstance();
    var value = prefs.getString('MaghribNum') ?? "0";
    //print('saved tester $value');
    setState(() {
      curMaghribNum = value;
    });
  }

  Future<void> _getIshaaTally() async {
    var prefs = await SharedPreferences.getInstance();
    var value = prefs.getString('IshaaNum') ?? "0";
    //print('saved tester $value');
    setState(() {
      curIshaaNum = value;
    });
  }

  saveIsSelectedFajir() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setStringList(
        "isSelectedFont",
        isSelectedFajir.map((e) => e ? 'true' : 'false').toList(),
      );
      prefs.setInt('currentFontFamily', _currentSelectedFajir);
    });
    /*await _applyToggleValsToTally(
        fajirController,isSelectedFajir,curFajirNum,"FajirNum", temp);*/
  }

  getIsSelectedFajir() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSelectedFajir = (prefs
          .getStringList('isSelectedFont')
          ?.map((e) => e == 'true' ? true : false)
          ?.toList() ??
          [true, false]);
      _currentSelectedFajir = prefs.getInt('currentFontFamily') ?? 0;
    });
    print("IsSelected" + isSelectedFajir.toString());
    print("curSelected" + _currentSelectedFajir.toString());
  }

  saveIsSelectedDhuhr() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setStringList(
        "isSelectedFont1",
        isSelectedDhuhr.map((e) => e ? 'true' : 'false').toList(),
      );
      prefs.setInt('currentFontFamily1', _currentSelectedDhuhr);
    });
  }

  getIsSelectedDhuhr() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSelectedDhuhr = (prefs
          .getStringList('isSelectedFont1')
          ?.map((e) => e == 'true' ? true : false)
          ?.toList() ??
          [true, false]);
      _currentSelectedDhuhr = prefs.getInt('currentFontFamily1') ?? 0;
    });
    print("Value Saved");
  }

  saveIsSelectedAsr() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setStringList(
        "isSelectedFont2",
        isSelectedAsr.map((e) => e ? 'true' : 'false').toList(),
      );
      prefs.setInt('currentFontFamily2', _currentSelectedAsr);
    });
    print("Value Saved");
  }

  getIsSelectedAsr() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSelectedAsr = (prefs
          .getStringList('isSelectedFont2')
          ?.map((e) => e == 'true' ? true : false)
          ?.toList() ??
          [true, false]);
      _currentSelectedAsr = prefs.getInt('currentFontFamily2') ?? 0;
    });
  }

  saveIsSelectedMaghrib() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setStringList(
        "isSelectedFont3",
        isSelectedMaghrib.map((e) => e ? 'true' : 'false').toList(),
      );
      prefs.setInt('currentFontFamily3', _currentSelectedMaghrib);
    });
  }

  getIsSelectedMaghrib() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSelectedMaghrib = (prefs
          .getStringList('isSelectedFont3')
          ?.map((e) => e == 'true' ? true : false)
          ?.toList() ??
          [true, false]);
      _currentSelectedMaghrib = prefs.getInt('currentFontFamily3') ?? 0;
    });
  }

  saveIsSelectedIshaa() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setStringList(
        "isSelectedFont4",
        isSelectedIshaa.map((e) => e ? 'true' : 'false').toList(),
      );
      prefs.setInt('currentFontFamily4', _currentSelectedIshaa);
    });
  }

  getIsSelectedIshaa() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSelectedIshaa = (prefs
          .getStringList('isSelectedFont4')
          ?.map((e) => e == 'true' ? true : false)
          ?.toList() ??
          [true, false]);
      _currentSelectedIshaa = prefs.getInt('currentFontFamily4') ?? 0;
    });
  }

  saveIsSelectedSawm() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setStringList(
        "isSelectedFont5",
        isSelectedSawm.map((e) => e ? 'true' : 'false').toList(),
      );
      prefs.setInt('currentFontFamily5', _currentSelectedSawm);
    });
  }

  getIsSelectedSawm() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSelectedSawm = (prefs
          .getStringList('isSelectedFont5')
          ?.map((e) => e == 'true' ? true : false)
          ?.toList() ??
          [true, false]);
      _currentSelectedSawm = prefs.getInt('currentFontFamily5') ?? 0;
    });
  }

  getSwitchValues() async {
    isSwitchedSawm = await getSwitchState("switchState");
    isSwitchedDarkMode = await getSwitchState("switchStateDarkMode");
    _updateAppTheme();
    setState(() {});
  }

  Future<bool> saveSwitchState(bool value, String switchKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(switchKey, value);
    //print('Switch Value saved $value');
    await _updateAppTheme();
    setState(() {

    });
    return prefs.setBool(switchKey, value);
  }

  Future<bool> getSwitchState(String switchKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSwitchedFT = prefs.getBool(switchKey) ?? false;
   //print(isSwitchedFT);

    return isSwitchedFT;
  }


  Future<bool> _isDiffrentDate() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tempDay = prefs.getString("curDay");
    //print(tempDay);
    var tempMonth = prefs.getString("curMonth");
    var tempYear = prefs.getString("curYear");

    //print("Temp Day: " + tempDay.toString() + " curDay: " + curDay.toString());
    //print("Temp Month: " + tempMonth.toString() + " curMonth: " + curMonth.toString());
    //print("Temp Year: " + tempYear.toString() + " curYear: " + curYear.toString());
    if(tempDay != curDay) {
        //print("returned True");
        return true;
      }
    if(tempMonth != curMonth) {
        return true;
      }
    if(tempYear != curYear) {
        return true;
      }
    return false;
  }

  Future<void> _InitializeDate() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString("curDay") == null)
      {
        await prefs.setString("curDay", curDay.toString());
        //print("Just Made Dya" + curDay.toString());
        var temp = prefs.getString("curDay") ?? "null";
        //print("THis is get: " + temp.toString());
      }
   if(prefs.getString("curMonth") == null)
     {
       await prefs.setString("curMonth", curMonth.toString());
       //print("Just Made ds");
     }
   if(prefs.getString("curYear") == null)
     {
       await prefs.setString("curYear", curYear.toString());
       //print("Just Made asdfa");
     }

    //Resets Toggle Switches to Default Position and Updates Day
    await _resetToggleButtons();
  }

  Future<void> _SetDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("curDay", curDay.toString());
    await prefs.setString("curMonth", curMonth.toString());
    await prefs.setString("curYear", curYear.toString());
  }

  Future<void> _resetToggleButtons() async {
    // Set toggle buttons to their initial state
    if(await _isDiffrentDate() == true)
      {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('isSelectedFont');
        await prefs.remove('currentFontFamily');
        await prefs.remove('isSelectedFont1');
        await prefs.remove('currentFontFamily1');
        await prefs.remove('isSelectedFont2');
        await prefs.remove('currentFontFamily2');
        await prefs.remove('isSelectedFont3');
        await prefs.remove('currentFontFamily3');
        await prefs.remove('isSelectedFont4');
        await prefs.remove('currentFontFamily4');
        await prefs.remove('isSelectedFont5');
        await prefs.remove('currentFontFamily5');
        setState(() {

        });
        _SetDate();
      }


  }
  
  Future<void> _applyToggleValsToTally(var contr, var isSel, var curNum, var curNumKey, var temp) async{
    SharedPreferences.getInstance().then((pref){
      int tempNum;

      if(isSel.toString() == "[false, true]" && temp != isSel.toString()){
        if(pref.getString(curNumKey) != null){
          tempNum = int.tryParse(pref.getString(curNumKey) ?? "0")!;
          contr.text = (tempNum + 1).toString();
        }else {
          contr.text = "1";
        }
      }else if(isSel.toString() == "[true, false]" && temp != isSel.toString()){
        if(pref.getString(curNumKey) != null) {
          tempNum = int.tryParse(pref.getString(curNumKey) ?? "0")!;
          if (tempNum > 0) {
            contr.text = (tempNum - 1).toString();
          }
        }
      }


      _updateTextField(contr, curNum, curNumKey);

      curFajirNum = pref.getString("FajirNum");
      curDhuhrNum = pref.getString("DhuhrNum");
      curAsrNum = pref.getString("AsrNum");
      curMaghribNum = pref.getString("MaghribNum");
      curIshaaNum = pref.getString("IshaaNum");
      curSawmNum = pref.getString("SawmNum");
      setState(() {

      });
    });

  }



  //Used for debuging: Clears all data in shared pref to simulate experience
  //of a new user
  Future _clearSharedPref() async{
    await SharedPreferences.getInstance().then((pref){
      pref.clear();
    });
  }

  Future _initilizeStringValues(String curKey) async{
    await SharedPreferences.getInstance().then((pref) {
      if(pref.getString(curKey) == null){
        pref.setString(curKey, "0");
        //print(pref.getString(curKey).toString() + "Was Null");
      }
    });
  }

  Future _initilizeBoolValues(String curKey) async{
    await SharedPreferences.getInstance().then((pref) {
      if(pref.getBool(curKey) == null){
        pref.setBool(curKey, false);
       //print(pref.getBool(curKey).toString() + "Was Null");
      }
    });
  }




  Future _updateTextField(var contr, var curNum, String curKey) async{
    await SharedPreferences.getInstance().then((pref) {
      //Initilizes and updates values in text fields
      if (contr.text != "") {
        pref.setString(curKey, contr.text);
      }if(curNum == null){
        pref.setString(curKey, "0");
       //print(pref.getString(curKey).toString() + "Was Null");
      }

      //Clear Text field
      contr.text = "";
    });

    setState(() {

    });

  }


  Future _updateAppTheme() async{
    await SharedPreferences.getInstance().then((pref) {
      var lightGreen = const Color(0xfff8eebf);
      var midGreen = const Color(0xff7f9860);
      var darkGreen = const Color(0xff04373b);
      var darkestGreen = const Color(0xff3a5043);
      var lightYellow = const Color(0xffecf3b0);
      var darkModeButtons = Colors.green[300];
      var darkModeText = const Color(0xffb9eedc);
     if(isSwitchedDarkMode == false)
       {
         textCol = darkestGreen;
         textFieldCol = Colors.black54;
         backgroundCol = lightGreen;
         borderCol = Colors.black;
         elevatedButtonCol = midGreen;
         toggleButtonCol = midGreen;
         saveButtonCol = Colors.brown;
         toggleButtonBorderCol = darkestGreen;
         elevatedButtonBorderCol = darkestGreen;
         activeToggleColor = Colors.brown;
         activeTrackColor = Colors.brown.shade300;
         inavtiveThumbColor = Colors.brown.shade300;
         inavtiveTrackColor = Colors.brown.shade100;
       }
     else if(isSwitchedDarkMode == true)
     {
       textCol = darkModeText;
       textFieldCol = Colors.white54;
       backgroundCol = darkGreen;
       borderCol = Colors.white;
       elevatedButtonCol = darkModeButtons;
       toggleButtonCol = darkModeButtons;
       saveButtonCol = Colors.teal;
       toggleButtonBorderCol = Colors.green[700];
       elevatedButtonBorderCol = Colors.green[700];
       activeToggleColor = darkestGreen;
       activeTrackColor = darkModeButtons;
       inavtiveThumbColor = Colors.blueGrey.shade600;
       inavtiveTrackColor = Colors.grey.shade400;
     }
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

  //Used to save the current state of the boolean buttons in settings
  var isSwitchedSawm = false;
  var isSwitchedDarkMode = false;
  var isOnFajir = false;
  var isOnDhuhr = false;
  var isOnAsr = false;
  var isOnMaghrib = false;
  var isOnIshaa = false;

  //Theme Colors
  var textCol = Colors.black;
  var textFieldCol = Colors.black54;
  var backgroundCol = Colors.white;
  var borderCol = Colors.black;
  var toggleButtonCol = Colors.green[200];
  var elevatedButtonCol = Colors.green[700];
  var saveButtonCol = Colors.brown;
  var toggleButtonBorderCol =  Colors.green[200];
  var elevatedButtonBorderCol = Colors.green[700];
  var activeToggleColor = Colors.green[700];
  var activeTrackColor = Colors.green[200];
  var inavtiveThumbColor = Colors.blueGrey.shade600;
  var inavtiveTrackColor = Colors.grey.shade400;

  //Font sizes and margins
  static const double fontSiz = 25;
  static const double popUpFontSiz = 20;
  static const double textFieldMargins = 15;
  static const double toggleButtonMargins = 10;

  _MyHomePageState(){
    //_clearSharedPref();
  }


  //List that stores whether toggle bottons are yes/no
  final List<bool> _yesNoFajir = <bool>[true, false];
  final List<bool> _yesNoDhuhr = <bool>[true, false];
  final List<bool> _yesNoAsr = <bool>[true, false];
  final List<bool> _yesNoMaghrib = <bool>[true, false];
  final List<bool> _yesNoIshaa = <bool>[true, false];
  final List<bool> _yesNoSawm = <bool>[true, false];







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
      backgroundColor: backgroundCol,
      appBar: AppBar(
        backgroundColor: elevatedButtonCol,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fontSiz,
          color: backgroundCol,
        )
        ),
      ),
       body: Column(
          children: [
            Expanded(//Today Row
              child: Container(
                margin: EdgeInsets.only(left: toggleButtonMargins, right:15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Today',
                      style: TextStyle(
                      decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSiz,
                        color: textCol,
                    ),
                    ),
                    const Spacer(),
                    Text(
                      '${curMonth}/${curDay}/${curYear}',
                      style: //Theme.of(context).textTheme.headline4,
                      TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSiz,
                        color: textCol,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(//Fajir Row
              child: Container(
                margin: EdgeInsets.only(left: toggleButtonMargins,
                    right:toggleButtonMargins),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Fajir',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSiz,
                        color: textCol,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin: EdgeInsets.only(left: toggleButtonMargins),
                      child: ToggleButtons(
                        // logic for button selection below
                        onPressed: (int index) {
                         setState(() {
                            String tempIsSelectedFajir = isSelectedFajir.toString();

                            for (int i = 0; i < isSelectedFajir.length; i++) {
                              isSelectedFajir[i] = i == index;
                            }
                            _currentSelectedFajir = index;
                            saveIsSelectedFajir();
                           //("curFaj" + _currentSelectedFajir.toString());
                           //print("isSelFaj" + isSelectedFajir.toString());
                            _applyToggleValsToTally(fajirController,isSelectedFajir,curFajirNum,"FajirNum", tempIsSelectedFajir);

                          });
                        },
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        borderColor: borderCol,
                        selectedBorderColor: elevatedButtonCol,
                        selectedColor: backgroundCol,
                        fillColor: toggleButtonCol,
                        color: textCol,
                        constraints: const BoxConstraints(
                          minHeight: 40.0,
                          minWidth: 80.0,
                        ),
                        isSelected: isSelectedFajir,
                        children: fruits,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(//Dhuhr Row
              child: Container(
                margin: EdgeInsets.only(left: toggleButtonMargins,
                    right:toggleButtonMargins),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Dhuhr',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSiz,
                        color: textCol,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin: EdgeInsets.only(left: toggleButtonMargins),
                      child: ToggleButtons(
                        // logic for button selection below
                        onPressed: (int index) {
                          setState(() {
                            String tempIsSelectedDhuhr = isSelectedDhuhr.toString();
                            for (int i = 0; i < isSelectedDhuhr.length; i++) {
                              isSelectedDhuhr[i] = i == index;
                            }
                            _currentSelectedDhuhr = index;
                            saveIsSelectedDhuhr();
                            _applyToggleValsToTally(dhuhrController, isSelectedDhuhr, curDhuhrNum, "DhuhrNum", tempIsSelectedDhuhr);
                          });
                        },
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        borderColor: borderCol,
                        selectedBorderColor: elevatedButtonCol,
                        selectedColor: backgroundCol,
                        fillColor: toggleButtonCol,
                        color: textCol,
                        constraints: const BoxConstraints(
                          minHeight: 40.0,
                          minWidth: 80.0,
                        ),
                        isSelected: isSelectedDhuhr,
                        children: fruits,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(//Asr Row
              child: Container(
                margin: EdgeInsets.only(left: toggleButtonMargins,
                    right:toggleButtonMargins),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Asr',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSiz,
                        color: textCol,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin: EdgeInsets.only(left: toggleButtonMargins),
                      child: ToggleButtons(
                        // logic for button selection below
                        onPressed: (int index) {
                          setState(() {
                            String tempIsSelectedAsr = isSelectedAsr.toString();
                            for (int i = 0; i < isSelectedAsr.length; i++) {
                              isSelectedAsr[i] = i == index;
                            }
                            _currentSelectedAsr = index;
                            saveIsSelectedAsr();
                            _applyToggleValsToTally(asrController, isSelectedAsr, curAsrNum, "AsrNum", tempIsSelectedAsr);
                          });
                        },
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        borderColor: borderCol,
                        selectedBorderColor: elevatedButtonCol,
                        selectedColor: backgroundCol,
                        fillColor: toggleButtonCol,
                        color: textCol,
                        constraints: const BoxConstraints(
                          minHeight: 40.0,
                          minWidth: 80.0,
                        ),
                        isSelected: isSelectedAsr,
                        children: fruits,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(//Maghrib Row
              child: Container(
                margin: EdgeInsets.only(left: toggleButtonMargins,
                    right:toggleButtonMargins),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Maghrib',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSiz,
                        color: textCol,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin: EdgeInsets.only(left: toggleButtonMargins),
                      child: ToggleButtons(
                        // logic for button selection below
                        onPressed: (int index) {
                          setState(() {
                            String tempIsSelectedMaghrib = isSelectedMaghrib.toString();
                            for (int i = 0; i < isSelectedMaghrib.length; i++) {
                              isSelectedMaghrib[i] = i == index;
                            }
                            _currentSelectedMaghrib = index;
                            saveIsSelectedMaghrib();
                            _applyToggleValsToTally(maghribController, isSelectedMaghrib, curMaghribNum, "MaghribNum", tempIsSelectedMaghrib);
                          });
                        },
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        borderColor: borderCol,
                        selectedBorderColor: elevatedButtonCol,
                        selectedColor: backgroundCol,
                        fillColor: toggleButtonCol,
                        color: textCol,
                        constraints: const BoxConstraints(
                          minHeight: 40.0,
                          minWidth: 80.0,
                        ),
                        isSelected: isSelectedMaghrib,
                        children: fruits,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(//Ishaa Row
              child: Container(
                margin: EdgeInsets.only(left: toggleButtonMargins,
                    right:toggleButtonMargins),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Isha\'a',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSiz,
                        color: textCol,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin: EdgeInsets.only(left: toggleButtonMargins),
                        child: ToggleButtons(
                        // logic for button selection below
                        onPressed: (int index) {
                          setState(() {
                            String tempIsSelectedIshaa = isSelectedIshaa.toString();
                            for (int i = 0; i < isSelectedIshaa.length; i++) {
                              isSelectedIshaa[i] = i == index;
                            }
                            _currentSelectedIshaa = index;
                            saveIsSelectedIshaa();
                            _applyToggleValsToTally(ishaaController, isSelectedIshaa, curIshaaNum, "IshaaNum", tempIsSelectedIshaa);
                          });
                        },
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        borderColor: borderCol,
                        selectedBorderColor: elevatedButtonCol,
                          selectedColor: backgroundCol,
                        fillColor: toggleButtonCol,
                        color: textCol,
                        constraints: const BoxConstraints(
                          minHeight: 40.0,
                          minWidth: 80.0,
                        ),
                        isSelected: isSelectedIshaa,
                        children: fruits,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Offstage(//Sawm Row
              offstage: !isSwitchedSawm,
                child: Container(
                  margin: EdgeInsets.only(left: toggleButtonMargins,
                      right:toggleButtonMargins),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Sawm',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSiz,
                          color: textCol,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        margin: EdgeInsets.only(left: toggleButtonMargins),
                        child: ToggleButtons(
                          // logic for button selection below
                          onPressed: (int index) {
                            setState(() {
                              String tempIsSelectedSawm = isSelectedSawm.toString();
                              for (int i = 0; i < isSelectedSawm.length; i++) {
                                isSelectedSawm[i] = i == index;
                              }
                              _currentSelectedSawm = index;
                              saveIsSelectedSawm();
                              _applyToggleValsToTally(sawmController, isSelectedSawm, curSawmNum, "SawmNum", tempIsSelectedSawm);
                            });
                          },
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          borderColor: textCol,
                          selectedBorderColor: elevatedButtonCol,
                          selectedColor: backgroundCol,
                          fillColor: toggleButtonCol,
                          color: textCol,
                          constraints: const BoxConstraints(
                            minHeight: 40.0,
                            minWidth: 80.0,
                          ),
                          isSelected: isSelectedSawm,
                          children: fruits,
                        ),
                      ),
                    ],
                  ),
                ),
            ),
            Expanded(//Qada and Sawm Buttons
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 60,
                    width: 175,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(elevatedButtonCol),
                        foregroundColor:  MaterialStateProperty.all(backgroundCol),
                      ),
                      onPressed: (){
                        SharedPreferences.getInstance().then((pref) {
                          curFajirNum = pref.getString("FajirNum") ?? "0";
                          curDhuhrNum = pref.getString("DhuhrNum") ?? "0";
                          curAsrNum = pref.getString("AsrNum") ?? "0";
                          curMaghribNum = pref.getString("MaghribNum") ?? "0";
                          curIshaaNum = pref.getString("IshaaNum") ?? "0";

                        });
                        showDialog(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                  builder: (context, setState){
                                    return  AlertDialog(
                                      backgroundColor: backgroundCol,
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(color: borderCol)),
                                      title: Text('Qada',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold,
                                          fontSize: fontSiz,
                                          color: textCol,
                                        ),
                                      ),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(bottom: textFieldMargins, top: textFieldMargins),
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 50,
                                                      child: Text("Fajir",
                                                        style: TextStyle(
                                                          color: textCol,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: popUpFontSiz,
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(flex: 25,),
                                                    Expanded(
                                                      flex: 25,
                                                      child: TextField(
                                                        controller: fajirController,
                                                        obscureText: false,
                                                        keyboardType: TextInputType.number,
                                                        style: TextStyle(
                                                          decoration: TextDecoration.underline,
                                                          fontWeight: FontWeight.bold,
                                                          color: textFieldCol,
                                                          fontSize: fontSiz,
                                                        ),
                                                        decoration: InputDecoration(
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(color: borderCol),
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(color: borderCol)
                                                          ),
                                                          labelText: "${curFajirNum}",
                                                          labelStyle:
                                                          TextStyle(
                                                            decoration: TextDecoration.underline,
                                                            fontWeight: FontWeight.bold,
                                                            color: textFieldCol,
                                                            fontSize: fontSiz,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ]
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(bottom: textFieldMargins),
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 50,
                                                      child: Text("Dhuhr",
                                                        style: TextStyle(
                                                          color: textCol,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: popUpFontSiz,
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(flex: 25,),
                                                    Expanded(
                                                      flex: 25,
                                                      child: TextField(
                                                        controller: dhuhrController,
                                                        obscureText: false,
                                                        keyboardType: TextInputType.number,
                                                        style: TextStyle(
                                                          decoration: TextDecoration.underline,
                                                          fontWeight: FontWeight.bold,
                                                          color: textFieldCol,
                                                          fontSize: fontSiz,
                                                        ),
                                                        decoration: InputDecoration(
                                                            focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(color: borderCol),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(color: borderCol)
                                                            ),
                                                            labelText: "${curDhuhrNum}",
                                                            labelStyle:
                                                            TextStyle(
                                                              decoration: TextDecoration.underline,
                                                              fontWeight: FontWeight.bold,
                                                              color: textFieldCol,
                                                              fontSize: fontSiz,
                                                            )
                                                        ),
                                                      ),
                                                    ),
                                                  ]
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(bottom: textFieldMargins),
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 50,
                                                      child: Text("Asr",
                                                        style: TextStyle(
                                                          color: textCol,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: popUpFontSiz,
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(flex: 25,),
                                                    Expanded(
                                                      flex: 25,
                                                      child: TextField(
                                                        controller: asrController,
                                                        obscureText: false,
                                                        keyboardType: TextInputType.number,
                                                        style: TextStyle(
                                                          decoration: TextDecoration.underline,
                                                          fontWeight: FontWeight.bold,
                                                          color: textFieldCol,
                                                          fontSize: fontSiz,
                                                        ),
                                                        decoration: InputDecoration(
                                                            focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(color: borderCol),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(color: borderCol)
                                                            ),
                                                            labelText: "${curAsrNum}",
                                                            labelStyle:
                                                            TextStyle(
                                                              decoration: TextDecoration.underline,
                                                              fontWeight: FontWeight.bold,
                                                              color: textFieldCol,
                                                              fontSize: fontSiz,
                                                            )
                                                        ),
                                                      ),
                                                    ),
                                                  ]
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(bottom: textFieldMargins),
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 50,
                                                      child: Text("Maghrib",
                                                        style: TextStyle(
                                                          color: textCol,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: popUpFontSiz,
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(flex: 25,),
                                                    Expanded(
                                                      flex: 25,
                                                      child: TextField(
                                                        controller: maghribController,
                                                        obscureText: false,
                                                        keyboardType: TextInputType.number,
                                                        style: TextStyle(
                                                          decoration: TextDecoration.underline,
                                                          fontWeight: FontWeight.bold,
                                                          color: textFieldCol,
                                                          fontSize: fontSiz,
                                                        ),
                                                        decoration: InputDecoration(
                                                            focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(color: borderCol),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(color: borderCol)
                                                            ),
                                                            labelText: "${curMaghribNum}",
                                                            labelStyle:
                                                            TextStyle(
                                                              decoration: TextDecoration.underline,
                                                              fontWeight: FontWeight.bold,
                                                              color: textFieldCol,
                                                              fontSize: fontSiz,
                                                            )
                                                        ),
                                                      ),
                                                    ),
                                                  ]
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(bottom: textFieldMargins),
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 50,
                                                      child: Text("Isha\'a",
                                                        style: TextStyle(
                                                          color: textCol,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: popUpFontSiz,
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(flex: 25,),
                                                    Expanded(
                                                      flex: 25,
                                                      child: TextField(
                                                        controller: ishaaController,
                                                        obscureText: false,
                                                        keyboardType: TextInputType.number,
                                                        style: TextStyle(
                                                          decoration: TextDecoration.underline,
                                                          fontWeight: FontWeight.bold,
                                                          color: textFieldCol,
                                                          fontSize: fontSiz,
                                                        ),
                                                        decoration: InputDecoration(
                                                            focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(color: borderCol),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(color: borderCol)
                                                            ),
                                                            labelText: "${curIshaaNum}",
                                                            labelStyle:
                                                            TextStyle(
                                                              decoration: TextDecoration.underline,
                                                              fontWeight: FontWeight.bold,
                                                              color: textFieldCol,
                                                              fontSize: fontSiz,
                                                            )
                                                        ),
                                                      ),
                                                    ),
                                                  ]
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          onPressed: () {
                                            _updateTextField(fajirController, curFajirNum, "FajirNum");
                                            _updateTextField(dhuhrController, curDhuhrNum, "DhuhrNum");
                                            _updateTextField(asrController, curAsrNum, "AsrNum");
                                            _updateTextField(maghribController, curMaghribNum, "MaghribNum");
                                            _updateTextField(ishaaController, curIshaaNum, "IshaaNum");

                                            setState(() {
                                              SharedPreferences.getInstance().then((pref) {
                                                curFajirNum = pref.getString("FajirNum");
                                                curDhuhrNum = pref.getString("DhuhrNum");
                                                curAsrNum = pref.getString("AsrNum");
                                                curMaghribNum = pref.getString("MaghribNum");
                                                curIshaaNum = pref.getString("IshaaNum");

                                              });
                                            });



                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Save'),
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(elevatedButtonCol),
                                            foregroundColor:  MaterialStateProperty.all(backgroundCol),
                                          ),

                                        ),
                                      ],
                                    );
                                  });
                            }
                        );
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
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(elevatedButtonCol),
                        foregroundColor:  MaterialStateProperty.all(backgroundCol),
                      ),
                      onPressed: (){
                        SharedPreferences.getInstance().then((pref) {
                          setState(() {
                            curSawmNum = pref.getString("SawmNum") ?? "0";
                            curNathiirNum = pref.getString("NathiirNum") ?? "0";

                            /*print("Sawm (general): " + curSawmNum.toString());
                                   //("Nathiir: " + curNathiirNum.toString());*/
                          });
                        });
                        showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: backgroundCol,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: borderCol)),
                          title: Text('Sawm',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              fontSize: fontSiz,
                              color: textCol,
                            ),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: textFieldMargins),
                                child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    flex: 50,
                                    child: Text("Sawm (General)",
                                      style: TextStyle(
                                        color: textCol,
                                        fontWeight: FontWeight.bold,
                                        fontSize: popUpFontSiz,
                                      ),
                                    ),
                                  ),
                                  Spacer(flex: 25,),
                                  Expanded(
                                    flex: 25,
                                    child: TextField(
                                      controller: sawmController,
                                      obscureText: false,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold,
                                        color: textFieldCol,
                                        fontSize: fontSiz,
                                      ),
                                      decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: borderCol),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: borderCol)
                                          ),
                                        labelText: "${curSawmNum}",
                                        labelStyle:
                                          TextStyle(
                                            decoration: TextDecoration.underline,
                                            fontWeight: FontWeight.bold,
                                            color: textFieldCol,
                                            fontSize: fontSiz,
                                          )
                                      ),
                                    ),
                                ),
                                ]
                          ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: textFieldMargins),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 50,
                                        child: Text("Nathiir",
                                          style: TextStyle(
                                            color: textCol,
                                            fontWeight: FontWeight.bold,
                                            fontSize: popUpFontSiz,
                                          ),
                                        ),
                                      ),
                                      Spacer(flex: 25,),
                                      Expanded(
                                        flex: 25,
                                        child: TextField(
                                          controller: nathiirController,
                                          obscureText: false,
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(
                                            decoration: TextDecoration.underline,
                                            fontWeight: FontWeight.bold,
                                            color: textFieldCol,
                                            fontSize: fontSiz,
                                          ),
                                          decoration:InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: borderCol),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: borderCol)
                                              ),
                                              labelText: "${curNathiirNum}",
                                              labelStyle:
                                              TextStyle(
                                                decoration: TextDecoration.underline,
                                                fontWeight: FontWeight.bold,
                                                color: textFieldCol,
                                                fontSize: fontSiz,
                                              )
                                          ),
                                        ),
                                      ),
                                    ]
                                ),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                //Initilizes and updates values in text fields
                                _updateTextField(sawmController, curSawmNum, "SawmNum");
                                _updateTextField(nathiirController, curNathiirNum, "NathiirNum");

                                SharedPreferences.getInstance().then((pref) {
                                  setState(() {
                                    curSawmNum = pref.getString("SawmNum");
                                    curNathiirNum = pref.getString("NathiirNum");

                                    /*print("Sawm (general): " + curSawmNum.toString());
                                   //("Nathiir: " + curNathiirNum.toString());*/
                                  });
                                });
                                Navigator.of(context).pop();
                              },
                              child: const Text('Save'),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(elevatedButtonCol),
                                foregroundColor:  MaterialStateProperty.all(backgroundCol),
                              ),
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
            Expanded(//Zakat and Settings Buttons
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 60,
                    width: 175,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(elevatedButtonCol),
                        foregroundColor:  MaterialStateProperty.all(backgroundCol),
                      ),
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: backgroundCol,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: borderCol)),
                              title: Text('Zakat',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSiz,
                                  color: textCol,
                                ),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(bottom: textFieldMargins),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                              flex: 35,
                                              child: Text("Zakat (General)",
                                                style: TextStyle(
                                                  color: textCol,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: popUpFontSiz,
                                                ),
                                              ),
                                          ),
                                          Spacer(flex: 15,),
                                          Expanded(
                                            flex: 5,
                                            child: Text("\$",
                                              style: TextStyle(
                                                color: textCol,
                                                fontWeight: FontWeight.bold,
                                                fontSize: popUpFontSiz,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 45,
                                            child: TextField(
                                              controller: zakatController,
                                              obscureText: false,
                                              keyboardType: TextInputType.number,
                                              style: TextStyle(
                                                decoration: TextDecoration.underline,
                                                fontWeight: FontWeight.bold,
                                                color: textFieldCol,
                                                fontSize: fontSiz,
                                              ),
                                              decoration: InputDecoration(
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: borderCol),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: borderCol)
                                                  ),
                                                  labelText: "${curZakatNum}",
                                                  labelStyle:
                                                  TextStyle(
                                                    decoration: TextDecoration.underline,
                                                    fontWeight: FontWeight.bold,
                                                    color: textFieldCol,
                                                    fontSize: fontSiz,
                                                  )
                                              ),
                                            ),
                                          ),
                                        ]
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: textFieldMargins),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                              flex: 50,
                                              child: Text("Zakat El Futrah",
                                                style: TextStyle(
                                                  color: textCol,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: popUpFontSiz,
                                                ),
                                              ),
                                          ),
                                         Spacer(flex: 25,),
                                          Expanded(
                                            flex: 25,
                                            child: TextField(
                                              controller: zakatElFutrahController,
                                              obscureText: false,
                                              keyboardType: TextInputType.number,
                                              style: TextStyle(
                                                decoration: TextDecoration.underline,
                                                fontWeight: FontWeight.bold,
                                                color: textFieldCol,
                                                fontSize: fontSiz,
                                              ),
                                              decoration: InputDecoration(
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: borderCol),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: borderCol),
                                                  ),
                                                  labelText: "${curZakatElFutrahNum}",
                                                  labelStyle:
                                                  TextStyle(
                                                    decoration: TextDecoration.underline,
                                                    fontWeight: FontWeight.bold,
                                                    color: textFieldCol,
                                                    fontSize: fontSiz,
                                                  )
                                              ),
                                            ),
                                          ),
                                        ]
                                    ),
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                   /* _updateTextField(zakatController, curZakatNum, "ZakatNum");
                                    _updateTextField(zakatElFutrahController, curZakatElFutrahNum, "ZakatElFuthrahNum");
                                    */

                                    SharedPreferences.getInstance().then((pref) {
                                      //Initializes and updates values in textfields
                                      if(zakatController.text != ""){
                                        pref.setString("ZakatNum", zakatController.text);
                                      }if(curZakatNum == null){
                                        pref.setString("ZakatNum", "0");
                                      }
                                      if(zakatElFutrahController.text != ""){
                                        pref.setString("ZakatElFuthrahNum", zakatElFutrahController.text);
                                      }if(curZakatElFutrahNum == null){
                                        pref.setString("ZakatElFuthrahNum", "0");
                                      }
                                      curZakatNum = pref.getString("ZakatNum");
                                      curZakatElFutrahNum = pref.getString("ZakatElFuthrahNum");
                                      //print("Zakat (general): " + curZakatNum.toString());
                                      //print("Zakat Ele Futrhah: " + curZakatElFutrahNum.toString());

                                      zakatController.text = "";
                                      zakatElFutrahController.text = "";
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Save'),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(elevatedButtonCol),
                                    foregroundColor:  MaterialStateProperty.all(backgroundCol),
                                  ),
                                ),
                              ],
                            )
                        );
                      },
                      child: const Text(
                          "Zakat"
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 60,
                    width: 175,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(elevatedButtonCol),
                        foregroundColor:  MaterialStateProperty.all(backgroundCol),
                      ),
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                  builder: (context, setState){
                                    return  AlertDialog(
                                      backgroundColor: backgroundCol,
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(color: borderCol)),
                                      title: Text('Settings',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold,
                                          fontSize: fontSiz,
                                          color: textCol,
                                        ),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 50,
                                                  child: Text("Show Sawm Row:",
                                                    style: TextStyle(
                                                      color: textCol,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: popUpFontSiz,
                                                    ),
                                                  ),
                                                ),
                                                Spacer(flex: 25,),
                                                Expanded(
                                                  flex: 25,
                                                  child: Switch(
                                                    // thumb color (round icon)
                                                    activeColor: activeToggleColor,
                                                    activeTrackColor: activeTrackColor,
                                                    inactiveThumbColor: inavtiveThumbColor,
                                                    inactiveTrackColor: inavtiveTrackColor,
                                                    splashRadius: 50.0,
                                                    // boolean variable value
                                                    value: isSwitchedSawm,
                                                    // changes the state of the switch
                                                    onChanged: (bool value) => setState(() {
                                                      isSwitchedSawm = value;
                                                      saveSwitchState(value, "switchState");
                                                    }),
                                                  ),
                                                ),
                                              ]
                                          ),
                                          Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 50,
                                                  child: Text("Dark Mode:",
                                                    style: TextStyle(
                                                      color: textCol,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: popUpFontSiz,
                                                    ),
                                                  ),
                                                ),
                                                Spacer(flex: 25,),
                                                Expanded(
                                                  flex: 25,
                                                  child: Switch(
                                                    // thumb color (round icon)
                                                    activeColor: activeToggleColor,
                                                    activeTrackColor: activeTrackColor,
                                                    inactiveThumbColor: inavtiveThumbColor,
                                                    inactiveTrackColor: inavtiveTrackColor,
                                                    splashRadius: 50.0,
                                                    // boolean variable value
                                                    value: isSwitchedDarkMode,
                                                    // changes the state of the switch
                                                    onChanged: (value) => setState(() {
                                                      isSwitchedDarkMode = value;
                                                      saveSwitchState(value, "switchStateDarkMode");
                                                    }),
                                                  ),
                                                ),
                                              ]
                                          ),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          onPressed: () {
                                            /* SharedPreferences.getInstance().then((pref) {
                                      pref.setBool("SawmSwitch", true);
                                    });*/
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Save'),
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(elevatedButtonCol),
                                            foregroundColor:  MaterialStateProperty.all(backgroundCol),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            }
                        );
                      },
                      child: const Text(
                          "Settings"
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

  void _saveSettings(){
    final newSettings = Settings(

    );
  }
}
