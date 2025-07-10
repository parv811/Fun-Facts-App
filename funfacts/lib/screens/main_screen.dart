import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:funfacts/screens/settings_screen.dart';

//API URL :
//https://raw.githubusercontent.com/parv811/flutter_dummy_api/refs/heads/main/facts.json

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> facts = [];
  bool isLoading = true;
  bool isError = false;

  Future<void> getData() async {
    try {
      setState(() {
        isLoading = true;
      });

      Response response = await Dio().get(
        "https://raw.githubusercontent.com/parv811/flutter_dummy_api/refs/heads/main/facts.json",
      );

      facts = jsonDecode(response.data);
      isLoading = false;
      isError = false;
      setState(() {});
    } catch (e) {
      isLoading = false;
      isError = true;
      setState(() {});
    }
  }

  Widget errorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning),
          Text("Cannot connect to server..."),
          ElevatedButton(onPressed: getData, child: Text("Try again")),
        ],
      ),
    );
  }

  Widget factPageWidget() {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: facts.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                facts[index],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Fun Facts"),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SettingsScreen();
                  },
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.settings),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : isError
                ? errorWidget()
                : factPageWidget(),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Swipe left for more"),
            ),
          ),
        ],
      ),
    );
  }
}
