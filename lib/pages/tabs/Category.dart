import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import '../../config/Config.dart';
import '../../model/CateModel.dart';
import '../../services/ScreenAdapter.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  int _selectIndex = 0;
  List _leftCateList = [];
  List _rightCateList = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getLeftCateData();
  }

  //获取左侧分类数据
  _getLeftCateData() async {
    var api = "${Config.domain}api/pcate";
    var result = await Dio().get(api);
    var leftCateList = CateModel.fromJson(result.data);
    // print(leftCateList.result);
    setState(() {
      this._leftCateList = leftCateList.result;
    });
    _getRightCateData(leftCateList.result[0].sId);
  }

  //获取右侧分类数据
  _getRightCateData(pid) async {
    var api = "${Config.domain}api/pcate?pid=${pid}";
    var result = await Dio().get(api);
    var rightCateList = CateModel.fromJson(result.data);
    // print(rightCateList.result);
    setState(() {
      this._rightCateList = rightCateList.result;
    });
  }

  Widget _leftCateWidget(leftWidth) {
    if (this._leftCateList.length > 0) {
      return Container(
        width: leftWidth,
        height: double.infinity,
        // color: Colors.red,
        child: ListView.builder(
          itemCount: this._leftCateList.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectIndex = index;
                      this._getRightCateData(this._leftCateList[index].sId);
                    });
                  },
                  child: Container(
                    child: Text(
                      "${this._leftCateList[index].title}",
                      textAlign: TextAlign.center,
                    ),
                    width: double.infinity,
                    height: ScreenAdapter.height(84),
                    padding: EdgeInsets.only(top: ScreenAdapter.height(24)),
                    // color: _selectIndex == index ? Color.fromRGBO(240, 246, 246, 0.9) : Colors.white,
                    color:
                        _selectIndex == index ? Colors.redAccent : Colors.white,
                  ),
                ),
                Divider(height: 1),
              ],
            );
          },
        ),
      );
    } else {
      return Container(
        width: leftWidth,
        height: double.infinity,
      );
    }
  }

  Widget _rightCateWidget(rightItemWidth, rightItemHeight) {
    if (this._rightCateList.length > 0) {
      return Expanded(
        flex: 1,
        child: Container(
            padding: EdgeInsets.all(10),
            height: double.infinity,
            color: Color.fromRGBO(240, 246, 246, 0.9),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: rightItemWidth / rightItemHeight,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: this._rightCateList.length,
              itemBuilder: (context, index) {
                //处理图片
                String pic = this._rightCateList[index].pic;
                pic = Config.domain + pic.replaceAll('\\', '/');
                return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/productList',arguments: {
                        "cid":this._rightCateList[index].sId
                      });
                    },
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          AspectRatio(
                            aspectRatio: 1 / 1,
                            child: Image.network(
                              "${pic}",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            height: ScreenAdapter.height(35),
                            child: Text("${this._rightCateList[index].title}"),
                          ),
                        ],
                      ),
                    ));
              },
            )),
      );
    } else {
      return Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(10),
            height: double.infinity,
            color: Color.fromRGBO(240, 246, 246, 0.9),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    //计算右侧GridView宽高比
    var leftWidth = ScreenAdapter.getScreenWidth() / 4;
    var rightItemWidth =
        (ScreenAdapter.getScreenWidth() - leftWidth - 10 * 2 - 10 * 2) / 3;
    rightItemWidth = ScreenAdapter.width(rightItemWidth);
    var rightItemHeight = rightItemWidth + ScreenAdapter.height(28);

    return Row(
      children: <Widget>[
        _leftCateWidget(leftWidth),
        _rightCateWidget(rightItemWidth, rightItemHeight)
      ],
    );
  }
}
