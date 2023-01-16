import "package:shared_preferences/shared_preferences.dart";
import 'models.dart';

class PreferencesService {
  Future saveSettings(AppData appDat) async{
    //final pref = await SharedPreferences.getInstance();

    //Initialize String Values
    await _initilizeStringValues("SawmNum");
    await _initilizeStringValues("NathiirNum");
    await _initilizeStringValues("ZakatNum");
    await _initilizeStringValues("ZakatElFuthrahNum");
    await _initilizeStringValues("FajirNum");
    await _initilizeStringValues("DhuhrNum");
    await _initilizeStringValues("AsrNum");
    await _initilizeStringValues("MaghribNum");
    await _initilizeStringValues("IshaaNum");

    //Initialize Bool Values
    await _initilizeBoolValues("isOnSawm");
    await _initilizeBoolValues("isOnDarkMode");
    await _initilizeBoolValues("isOnFajir");
    await _initilizeBoolValues("isOnDhuhr");
    await _initilizeBoolValues("isOnAsr");
    await _initilizeBoolValues("isOnMaghrib");
    await _initilizeBoolValues("isOnIshaa");
  }

  /*Future getSettings(Settings settings) async{
    final pref = await SharedPreferences.getInstance();

    //await preferences.setString();
    final curSawmNum = pref.getString("SawmNum");
    final curNathiirNum = pref.getString("NathiirNum");
    final curZakatNum = pref.getString("ZakatNum");
    final curZakatElFutrahNum = pref.getString("ZakatElFuthrahNum");
    final curFajirNum = pref.getString("FajirNum");
    final curDhuhrNum = pref.getString("DhuhrNum");
    final curAsrNum = pref.getString("AsrNum");
    final curMaghribNum = pref.getString("MaghribNum");
    final curIshaaNum = pref.getString("IshaaNum");


    final isOnSawm = pref.getBool("isOnSawm") ?? false;
    final isOnDarkMode = pref.getBool("isOnDarkMode") ?? false;
    final isOnFajir = pref.getBool("isOnFajir") ?? false;
    final isOnDhuhr = pref.getBool("isOnDhuhr") ?? true;
    final isOnAsr = pref.getBool("isOnAsr") ?? false;
    final isOnMaghrib = pref.getBool("isOnMaghrib") ?? false;
    final isOnIshaa = pref.getBool("isOnIshaa") ?? false;



  }
*/


  Future _initilizeStringValues(String curKey) async{
    SharedPreferences.getInstance().then((pref) {
      if(pref.getString(curKey) == null){
        pref.setString(curKey, "0");
        //print(pref.getString(curKey).toString() + "Was Null");
      }
    });
  }

  Future _initilizeBoolValues(String curKey) async{
    SharedPreferences.getInstance().then((pref) {
      if(pref.getBool(curKey) == null){
        pref.setBool(curKey, false);
        //print(pref.getBool(curKey).toString() + "Was Null");
      }
    });
  }
}