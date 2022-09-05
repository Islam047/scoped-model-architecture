import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scoped_pattern/scopes/detail_scopes.dart';

import '../model/post_model.dart';
import '../scopes/home_scoped.dart';
import '../services/network_service.dart';

enum DetailState { create, update }

class DetailPage extends StatefulWidget {
  final Post? post;
  final DetailState state;

  const DetailPage({Key? key, this.post, this.state = DetailState.create})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DetailScopes scopes = DetailScopes();

  @override
  void initState() {
    super.initState();
    scopes.init(widget.state,widget.post);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: widget.state == DetailState.create
            ? const Text("Add post")
            : const Text("Update post"),
      ),
      body: ScopedModel<DetailScopes>(
        model: scopes,
        child: ScopedModelDescendant<DetailScopes>(
          builder: (context,child,model){
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: scopes.titleController,
                        decoration: InputDecoration(
                            label: const Text("Title"),
                            hintText: "Title",
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                            ),
                            border: const OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        controller: scopes.bodyController,
                        decoration: InputDecoration(
                            label: const Text("Body"),
                            hintText: "Body",
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            border: const OutlineInputBorder()),
                      ),
                      const SizedBox(height: 20,),
                      MaterialButton(
                        color: Colors.blue,
                        onPressed: () {
                          if (widget.state == DetailState.create) {
                            scopes.addPage(context);
                          } else {
                            scopes.updatePost(context);
                          }
                        },
                        child: const Text("Submit Text"),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: scopes.isLoading,
                  child: const CircularProgressIndicator(
                    color: Colors.red,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}