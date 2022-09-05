import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scoped_pattern/scopes/home_scoped.dart';
import '../home_view/views.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeScoped scoped = HomeScoped();

  @override
  void initState() {
    super.initState();
    scoped.apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<HomeScoped>(
        model: scoped,
        child:
            ScopedModelDescendant<HomeScoped>(builder: (context, child, model) {
          return Scaffold(
              appBar: AppBar(),
              body: Stack(
                children: [
                  ListView.builder(
                      itemCount: scoped.items.length,
                      itemBuilder: (context, index) {
                        return itemsOfPost(scoped.items[index], scoped);
                      }),
                  Visibility(
                    visible: scoped.isLoading,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                onPressed: () => scoped.goToDetailPage(context),
                child: const Icon(Icons.add),
              ));
        },),);
  }
}
