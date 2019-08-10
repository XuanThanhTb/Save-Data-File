import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:save_data_flie/modol/data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Save Data File', style: TextStyle(color: Colors.black, fontSize: 24),),
          backgroundColor: Colors.yellow,
        ),
        body: SaveDataFile(storage: CounterStorage()),
      ),
    );
  }
}
class SaveDataFile extends StatefulWidget{

  final CounterStorage storage;
  const SaveDataFile({Key key, this.storage}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SaveDataFileState();
  }
}

class SaveDataFileState extends State<SaveDataFile>{
  List<Data> listResult = [];
  var result;
  @override
  void initState(){
    super.initState();
    widget.storage.readCounter().then((value){
      value.map((item){
        var v = Data.fromJson(item);
        listResult.add(v);
      }).toList();
      setState(() {
       result = listResult; 
      });
    });
  }

  Future<File> _incrementCounter(){
    var list = [
      Data('data', 12),
      Data('data1', 'thanh'),
      Data('data2', 1231),
    ];
    return widget.storage.writeCounter(list);
  }

  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('Hien thi data: ${listResult[0].price}', style: TextStyle(fontSize: 24,),),
            onPressed: _incrementCounter,
          ),
        ],
      ),
    );
  }
}

class CounterStorage{

  //tạo ra một file dạng txt để cho ta ghi dữ liệu vô.
  Future<File> get _localFile async{
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/testStorage.txt');
  }

  //tạo ra một function để đọc dữ liệu từ file trên. (kể cả dữ liệu có hay không có vẫn vào xem bên trong có dữ liệu gì hay không.)
  Future<dynamic> readCounter() async{
    final file = await _localFile;
    String content =  await file.readAsString();
    return jsonDecode(content);
  }

  //từ function này ta có thể viết dữ liệu vào trong file txt mà ta khởi tạo ở hàm trên.
  Future<File> writeCounter(dynamic counter) async{
    String encodedDoughnut = jsonDecode(counter);
    final file = await _localFile;
    return file.writeAsString(encodedDoughnut);
  }

}