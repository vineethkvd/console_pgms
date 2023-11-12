import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/news_controller.dart';
import '../model/news_model.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final controller = Get.put(NewsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("News data"),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<NewsModel?>(
        future: controller.fetchNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text('No data available'),
            );
          } else {
            // Data is available, display it using a ListView for example
            NewsModel news = snapshot.data!;
            return ListView(
              children: [
                ListTile(
                  title: Text(news.title),
                  subtitle: Text(news.description),
                  // Add other fields as needed
                ),
                // Add more ListTiles for additional news items
              ],
            );
          }
        },
      ),
    );
  }
}
