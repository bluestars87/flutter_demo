import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';
import './ProductContent/ProductContentFirst.dart';
import './ProductContent/ProductContentSecond.dart';
import './ProductContent/ProductContentThird.dart';

class ProductContentPage extends StatefulWidget {
  final Map arguments;
  ProductContentPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductContentState createState() => _ProductContentState();
}

class _ProductContentState extends State<ProductContentPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: ScreenAdapter.width(400),
                  child: TabBar(
                    indicatorColor: Colors.red,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: <Widget>[
                      Tab(
                        child: Text("商品"),
                      ),
                      Tab(
                        child: Text("详情"),
                      ),
                      Tab(
                        child: Text("评价"),
                      )
                    ],
                  ),
                )
              ],
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.more_horiz),
                onPressed: () {
                  showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(
                          ScreenAdapter.width(600), 80, 0, 0),
                      items: [
                        PopupMenuItem(
                          child: Row(
                            children: <Widget>[Icon(Icons.home), Text("首页")],
                          ),
                        ),
                        PopupMenuItem(
                          child: Row(
                            children: <Widget>[Icon(Icons.home), Text("首页1")],
                          ),
                        ),
                        PopupMenuItem(
                          child: Row(
                            children: <Widget>[Icon(Icons.home), Text("首页2")],
                          ),
                        )
                      ]);
                },
              )
            ],
          ),
          body: Stack(
            children: <Widget>[
              TabBarView(
                children: <Widget>[
                  ProductContentFirst(),
                  ProductContentSecond(),
                  ProductContentThird(),
                ],
              ),
              Positioned(
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(100),
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Colors.black26,width: 1)
                    )
                  ),
                  
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: ScreenAdapter.height(5)),
                        width: 100,
                        height:ScreenAdapter.height(100) ,
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.shopping_cart),
                            Text("购物车")
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.all(ScreenAdapter.width(10)),
                          padding: EdgeInsets.all(ScreenAdapter.width(10)),
                          width: double.infinity,
                          height: ScreenAdapter.height(80),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(200, 30, 190, 0.9),
                            borderRadius: BorderRadius.circular(ScreenAdapter.width(50))
                          ),
                          child: Center(
                            child: Text("加入购物车"),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.all(ScreenAdapter.width(10)),
                          padding: EdgeInsets.all(ScreenAdapter.width(10)),
                          width: double.infinity,
                          height: ScreenAdapter.height(80),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 1, 0, 0.9),
                            borderRadius: BorderRadius.circular(ScreenAdapter.width(50))
                          ),
                          child: Center(
                            child: Text("立即购买"),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
