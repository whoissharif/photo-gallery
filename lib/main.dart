import 'package:flutter/material.dart';
import 'package:photo_gallery/resources/string_resources.dart';
import 'package:photo_gallery/views/screens/photo_grid_screen.dart';
import 'package:provider/provider.dart';
import '/theme.dart';
import 'controllers/photo_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PhotoController>(
          create: (context) => PhotoController(),
        ),
      ],
      child: MaterialApp(
        title: StringResources.appName,
        debugShowCheckedModeBanner: false,
        theme: theme(),
        home: const PhotoGridScreen(),
      ),
    );
  }
}
