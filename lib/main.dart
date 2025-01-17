import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _showList = false;
  double _balance = 0;
  final formatCurrency = NumberFormat.currency(locale: 'vi_VN', symbol: '');
  List<String> fullName = ["Duong", "Hieu", "Dung", "Hoang", "Kien"];

  void AddMoney() async {
    setState(() {
      _balance += 500000;
      _showList = true;
    });

    final SharedPreferences dataLocal = await SharedPreferences.getInstance();
    await dataLocal.setDouble('Money', _balance);
  }

  void LoadData() async {
    final SharedPreferences dataLocal = await SharedPreferences.getInstance();
    setState(() {
      _balance = dataLocal.getDouble('Money') ?? 0;
      print('$_balance');
      print('ádfasdf');
    });
  }

  void Stringdf(){
    print('sdfsdfsdf');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          centerTitle: true,
          title: Text(
            "Bitcoin",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          color: Colors.blueGrey[700],
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 9,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 0,
                        child: Container(
                          color: Colors.blue,
                          child: Text("So du tai khoan",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                          flex: 0,
                          child: Container(
                            color: Colors.red,
                            child: Text(
                              "${formatCurrency.format(_balance)} VND",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          )),
                      Expanded(
                          flex: 0,
                          child: OutlinedButton(
                              onPressed: LoadData, child: Text("data"))),
                      if (_showList)
                        Expanded(
                            flex: 0,
                            child: Container(
                              color: Colors.grey,
                              child: Text("Ho va ten : $fullName",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19)),
                            ))
                      else
                        Expanded(flex: 0, child: Text("Chua co ten")),
                    ]),
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: Size(double.infinity, 0)),
                    onPressed: AddMoney,
                    child: Text(
                      "Chuyen khoan",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
