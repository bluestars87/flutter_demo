import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../services/ScreenAdapter.dart';

//轮播图类模型
import '../../model/FocusModel.dart';
//猜你喜欢类模型
import '../../model/ProductModel.dart';
import 'package:dio/dio.dart';

import '../../config/Config.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List _focusData = [];
  List _hotProductData = [];
  List _bestProductData = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getFoucsData();
    _getHotProductData();
    _getBestProductData();

    //测试
    // SearchServices.setSearchData('abdddddd');
  }

  //获取轮播图数据
  _getFoucsData() async {
    var api = "${Config.domain}api/focus";
    var result = await Dio().get(api);
    var focusList = FocusModel.fromJson(result.data);
    // print(focusList.result);
    setState(() {
      this._focusData = focusList.result;
    });
  }

  //获取猜你喜欢的数据
  _getHotProductData() async {
    var api = "${Config.domain}api/plist?is_hot=1";
    var result = await Dio().get(api);
    var hotProductList = ProductModel.fromJson(result.data);
    print(hotProductList.result);
    setState(() {
      this._hotProductData = hotProductList.result;
    });
  }

  //获取热门推荐的数据
  _getBestProductData() async {
    var api = "${Config.domain}api/plist?is_best=1";
    var result = await Dio().get(api);
    var bestProductList = ProductModel.fromJson(result.data);
    print(bestProductList.result);
    setState(() {
      this._bestProductData = bestProductList.result;
    });
  }

  //轮播图
  Widget _swiperWidget() {
    if (this._focusData.length > 0) {
      return Container(
        child: AspectRatio(
          aspectRatio: 2 / 1,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              String pic = this._focusData[index].pic;
              pic = Config.domain + pic.replaceAll('\\', '/');
              return new Image.network(pic, fit: BoxFit.fill);
            },
            itemCount: this._focusData.length,
            pagination: new SwiperPagination(),
            autoplay: true,
          ),
        ),
      );
    } else {
      return Text("loading~~~");
    }
  }

  Widget _titleWidget(value) {
    return Container(
      height: ScreenAdapter.height(32),
      margin: EdgeInsets.only(left: ScreenAdapter.width(20)),
      padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
      decoration: BoxDecoration(
          border: Border(
        left: BorderSide(
          color: Colors.redAccent,
          width: ScreenAdapter.width(10),
        ),
      )),
      child: Text(
        value,
        style: TextStyle(color: Colors.black54),
      ),
    );
  }

  //猜你喜欢
  Widget _youLoveWidget() {
    if (this._hotProductData.length > 0) {
      return Container(
        height: ScreenAdapter.height(200),
        padding: EdgeInsets.fromLTRB(
            ScreenAdapter.width(20), 0, ScreenAdapter.width(20), 0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            String sPic = this._hotProductData[index].sPic;
            sPic = Config.domain + sPic.replaceAll('\\', '/');
            return Column(
              children: <Widget>[
                Container(
                  height: ScreenAdapter.height(150),
                  width: ScreenAdapter.width(150),
                  margin: EdgeInsets.only(right: ScreenAdapter.width(10)),
                  child: Image.network(
                    sPic,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  // color: Colors.red,
                  height: ScreenAdapter.height(40),
                  width: ScreenAdapter.width(150),
                  margin: EdgeInsets.only(right: ScreenAdapter.width(10)),
                  child: Text(
                    "￥${this._hotProductData[index].price}",
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            );
          },
          itemCount: this._hotProductData.length,
        ),
      );
    } else {
      return Text("loading~~~");
    }
  }

  //热门推荐
  Widget _hotRecommandWidget() {
    return Container(
      padding: EdgeInsets.all(ScreenAdapter.width(20)),
      child: Wrap(
        runSpacing: ScreenAdapter.width(20),
        spacing: ScreenAdapter.width(20),
        children: this._bestProductData.map((value) {
          String sPic = value.sPic;
          sPic = Config.domain + sPic.replaceAll('\\', '/');
          var itemWidth =
              (ScreenAdapter.getScreenWidth() - ScreenAdapter.width(60)) / 2;
          return InkWell(
            onTap: (){
              Navigator.pushReplacementNamed(context, '/productContent',arguments: {
                "id":value.sId
              });
            },
            child: Container(
              padding: EdgeInsets.all(ScreenAdapter.width(10)),
              width: itemWidth,
              // height: ScreenAdapter.height(400),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(233, 233, 233, 0.9),
                      width: ScreenAdapter.width(1))),
              child: Column(
                children: <Widget>[
                  Container(
                      width: double.infinity,
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.network(
                          "${sPic}",
                          fit: BoxFit.cover,
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
                    child: Text(
                      "${value.title}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "￥${value.price}",
                            style: TextStyle(
                                color: Colors.redAccent, fontSize: 16),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "￥${value.oldPrice}",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //传入设计稿的宽度和高度
    ScreenAdapter.init(context);
    return ListView(
      children: <Widget>[
        _swiperWidget(),
        SizedBox(
          height: 10,
        ),
        _titleWidget("猜你喜欢"),
        SizedBox(
          height: 10,
        ),
        _youLoveWidget(),
        _titleWidget("热门推荐"),
        _hotRecommandWidget(),
      ],
    );
  }
}
