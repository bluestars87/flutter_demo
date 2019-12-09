import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';
import '../services/SearchServices.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _keywords;

  List _historyListData = [];

  @override
  void initState() {
    super.initState();
    this._getHistoryData();
  }

  _getHistoryData() async {
    var historyListData = await SearchServices.getHistoryList();
    setState(() {
      this._historyListData=historyListData;
    });
  }

  _showAlertDialog(keywords) async{
     
    var result= await showDialog(
        barrierDismissible:false,   //表示点击灰色背景的时候是否消失弹出框
        context:context,
        builder: (context){
          return AlertDialog(
            title: Text("提示信息!"),
            content:Text("您确定要删除吗?") ,
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: (){
                  print("取消");
                  Navigator.pop(context,'Cancle');
                },
              ),
              FlatButton(
                child: Text("确定"),
                onPressed: () async{            
                  //注意异步      
                  await SearchServices.removeHistoryData(keywords);
                  this._getHistoryData();
                  Navigator.pop(context,"Ok");
                },
              )
            ],

          );
        }
     );
    //  print(result);
  }

  Widget _historyListWidget() {
    if (this._historyListData.length > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              "历史记录",
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Divider(),
          Column(
            children: this._historyListData.map((value){
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text("${value}"),
                    onLongPress: (){
                      this._showAlertDialog("${value}");
                    },
                  ),
                  Divider(),
                ],
              );
            }).toList()
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
            child: Container(
              width: ScreenAdapter.width(500),
              height: ScreenAdapter.height(64),
              decoration: BoxDecoration(
                  border: Border.all(
                      // color: Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
                      color: Colors.black45,
                      width: 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.delete),
                  Text("清空历史记录"),
                ],
              ),
            ),
            onTap: () {
              //清空历史记录的逻辑
              SearchServices.clearHistoryList();
              this._getHistoryData();
            },
          )
            ],
          )
        ],
      );
    } else {
      return Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              )),
              onChanged: (value) {
                this._keywords = value;
              },
            ),
            height: ScreenAdapter.height(70),
            decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          actions: <Widget>[
            InkWell(
              child: Container(
                height: ScreenAdapter.height(70),
                width: ScreenAdapter.width(80),
                child: Row(
                  children: <Widget>[Text("搜索")],
                ),
              ),
              onTap: () {
                SearchServices.setHistoryData(this._keywords);
                Navigator.pushReplacementNamed(context, '/productList',
                    arguments: {"keywords": this._keywords});
              },
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                child: Text(
                  "热搜",
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              Divider(),
              Wrap(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("连衣裙1"),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("笔记本电脑"),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("连衣裙3"),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("连衣裙4"),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("连衣裙5"),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("连衣裙"),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              //历史记录
              _historyListWidget(),
            ],
          ),
        ));
  }
}
