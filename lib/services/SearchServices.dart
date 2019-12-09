import 'dart:convert';

import 'Storage.dart';

class SearchServices {
  static setHistoryData(keywods) async {
    //1.获取本地存储的数据 searchList
    try {
      List searchListData = json.decode(await Storage.getString('searchList'));
      print(searchListData);
      var hasData = searchListData.any((v) {
        return v == keywods;
      });
      if (!hasData) {
        searchListData.add(keywods);
        await Storage.setString('searchList', jsonEncode(searchListData));
      }
    } catch (e) {
      List tempList = new List();
      tempList.add(keywods);
      await Storage.setString('searchList', jsonEncode(tempList));
    }
  }

  static getHistoryList() async {
    try {
      List searchListData = json.decode(await Storage.getString('searchList'));
      return searchListData;
    } catch (e) {
      return [];
    }
  }

  static clearHistoryList() async{
    await Storage.remove('searchList');
  }

  static removeHistoryData(keywords) async{
    List searchListData = json.decode(await Storage.getString('searchList'));
    searchListData.remove(keywords);
    await Storage.setString('searchList', jsonEncode(searchListData));
  }
}
