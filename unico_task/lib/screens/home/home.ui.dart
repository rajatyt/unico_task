import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unico_task/screens/home/home.notifier.dart';

import '../../consts/route.const.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String errorMsg = " ";
    final textFieldController = TextEditingController();
    final textFieldControllerEmail = TextEditingController();
    final state = ref.watch(homePageNotifierProvider);
    final notifier = ref.watch(homePageNotifierProvider.notifier);

    useEffect(() {
      Future.delayed(Duration.zero, () {
        notifier.fetchData();
        notifier.userInfo();
      });
      return null;
    }, const []);
    return Scaffold(
        appBar: AppBar(
          title: Text(state.username),
          elevation: 0.0,
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              tooltip: 'Comment Icon',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        scrollable: true,
                        title: Text("Enter Your Name",
                            textAlign: TextAlign.center),
                        contentPadding: EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 20),
                        content: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            CircleAvatar(
                              maxRadius: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: Image.network(state.profilePic),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              maxLength: 10,
                              keyboardType: TextInputType.text,
                              enableInteractiveSelection: false,
                              controller: textFieldController,
                              decoration:
                                  InputDecoration(hintText: state.username),
                            ),
                            Visibility(
                                visible: errorMsg == "" ? false : true,
                                child: Column(
                                  children: [
                                    Text(
                                      errorMsg,
                                      style: TextStyle(color: Colors.redAccent),
                                    )
                                  ],
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              enableInteractiveSelection: false,
                              controller: textFieldControllerEmail,
                              decoration: InputDecoration(
                                  hintText: state.email, enabled: false),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  notifier
                                      .saveUserData(textFieldController.text);
                                  if (textFieldController.text == " ") {
                                    errorMsg = "Please enter a name";
                                  } else {
                                    errorMsg = " ";
                                    Navigator.pop(context);
                                    context.goNamed(Routes.home);
                                  }
                                },
                                child: Text("Save Data")),
                            SizedBox(
                              height: 15.0,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel"))
                          ],
                        ),
                      );
                    });
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logout Icon',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Do yo want to signout?"),
                        contentPadding: EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 20),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  notifier.googleSignOut();
                                  Navigator.pop(context);
                                  context.goNamed(Routes.login);
                                },
                                child: Text("YES")),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("NO"))
                          ],
                        ),
                      );
                    });
              },
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: state.isLoading
              ? GridView.builder(
                  itemCount: 8,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.9, crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.white,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white, width: 2)),
                        padding: const EdgeInsets.only(bottom: 10, left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 20,
                              width: 100,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : GridView.builder(
                  itemCount: state.products?.products?.length ?? 0,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.9, crossAxisCount: 2),
                  itemBuilder: ((context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(state
                                      .products?.products?[index].thumbnail ??
                                  'https://i.dummyjson.com/data/products/4/thumbnail.jpg')),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(0, 1),
                                blurRadius: 2,
                                spreadRadius: 0)
                          ],
                          color: Colors.white),
                      padding: const EdgeInsets.only(bottom: 10, left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(state.products?.products?[index].title ?? '')
                        ],
                      ),
                    );
                  }),
                ),
        ));
  }
}
