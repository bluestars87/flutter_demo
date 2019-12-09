import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import 'Home.dart';
import 'Category.dart';
import 'Cart.dart';
import 'User.dart';


class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    this._pageController = new PageController(initialPage: this._currentIndex);
  }

  List<Widget> _pageList = [HomePage(), CategoryPage(), CartPage(), UserPage()];
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: _currentIndex!=3?AppBar(
        leading: IconButton(
          icon: Icon(Icons.center_focus_weak, size: 28, color: Colors.black),
          onPressed: null,
        ),
        // title: Text("wlwshop"),
        title: InkWell(
          child: Container(
            height: ScreenAdapter.height(70),
            decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.only(left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.search),
                Text("十万个为什么",style: TextStyle(fontSize: ScreenAdapter.size(28)),),
              ],
            ),
          ),
          onTap: (){
            Navigator.pushNamed(context, '/search');
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.message, size: 28, color: Colors.black),
            onPressed: null,
          )
        ],
      ):AppBar(
        title:Text("用户中心"),
      ),
      // body: this._pageList[this._currentIndex],
      body: PageView(
        controller: this._pageController,
        children: this._pageList,
        //tab页面左右滑动
        // onPageChanged: (index){
        //   setState(() {
        //     this._currentIndex=index;
        //   });
        // },
        physics: NeverScrollableScrollPhysics(),//禁止pageView滑动
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this._currentIndex,
        onTap: (index) {
          setState(() {
            this._currentIndex = index;
            this._pageController.jumpToPage(index);
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.redAccent,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), title: Text("分类")),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), title: Text("购物车")),
          BottomNavigationBarItem(icon: Icon(Icons.people), title: Text("我的"))
        ],
      ),
    );
  }
}
