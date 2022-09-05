import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../model/post_model.dart';
import '../pages/detail_page.dart';
import '../services/network_service.dart';

class HomeScoped extends Model{
  List<Post> items = [];
  bool isLoading = false;

  Future<void> apiPostList() async {
    isLoading = true;
    String? response =
    await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null) {
      items = Network.parsePostList(response);
    } else {
      items = [];
    }
    isLoading = false;
    notifyListeners();

  }

  Future<bool> apiPostDelete(Post post) async {
    isLoading = true;
    String? response = await Network.DEL(
        Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
    isLoading = false;
    notifyListeners();

    return response != null;
  }

  void goToDetailPage(BuildContext context) async {
    String? response =
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const DetailPage(
        state: DetailState.create,
      );
    }));
    if (response == "add") {
      apiPostList();
    }
    notifyListeners();

  }
  void goToDetailPageUpdate(Post post,BuildContext context) async {
    String? response =
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return DetailPage(
        post: post,
        state: DetailState.update,
      );
    }));
    if (response == "refresh") {
      apiPostList();
    }
    notifyListeners();

  }
}