import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scoped_pattern/model/post_model.dart';
import 'package:scoped_pattern/pages/detail_page.dart';

import '../services/network_service.dart';

class DetailScopes extends Model{
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  bool isLoading = false;

  void init(DetailState state,Post? post) {
    if (state == DetailState.update) {
      titleController = TextEditingController(text: post!.title);
      bodyController = TextEditingController(text: post.body);
    }
  }

  void updatePost(BuildContext context) async {
    String title = titleController.text.trim();
    String body = bodyController.text.trim();
    Post post = Post(
        id: Random().nextInt(100),
        title: title,
        body: body,
        userId: Random().nextInt(100));
    isLoading = true;
    notifyListeners();
    Network.PUT(Network.API_UPDATE, post.toJson()).then((value) {
      Navigator.pop(context, "refresh");
    });
    isLoading = false;
    notifyListeners();
  }

  void addPage(BuildContext context) async {
    String title = titleController.text.trim();
    String body = bodyController.text.trim();
    Post post = Post(
        id: Random().nextInt(100),
        title: title,
        body: body,
        userId: Random().nextInt(100));
    isLoading = true;
    notifyListeners();
    Network.POST(Network.API_UPDATE, post.toJson()).then((value) {
      Navigator.pop(context, "add");
    });
    isLoading = false;
    notifyListeners();
  }
}