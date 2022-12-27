import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_app/boxes/boxes.dart';
import 'package:task_app/model/notes_model.dart';
import 'package:task_app/view/search_screen.dart';
import 'package:task_app/view/search_screen.dart';
// import 'package:task_app/database/db_handler.dart';
// import 'package:task_app/model/notes_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //  late DBHelper dbHelper;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   dbHelper = DBHelper();
  // }

  @override
  Widget build(BuildContext context) {
    int _index = 0;
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 9, 19, 63),
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://images.pexels.com/photos/1559486/pexels-photo-1559486.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
              ),
            ),
            ListTile(
              title: Text(
                'Hidayat Bukhari',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.plus,
                color: Colors.white,
              ),
              title: Text(
                'Create Task',
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Roboto', fontSize: 15),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(
                FontAwesomeIcons.gripLines,
                color: Color.fromARGB(255, 103, 103, 103),
              ),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchFunction()));
              },
              icon: Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: Color.fromARGB(255, 103, 103, 103),
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.bell,
                color: Color.fromARGB(255, 103, 103, 103),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(left: 5, top: 10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'What\'s up Hidayat!',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 30,
                            color: Color.fromARGB(255, 22, 30, 50)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Categories',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: Color.fromARGB(255, 103, 103, 103),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 135, // card height
                        child: PageView.builder(
                          itemCount: 10,
                          controller: PageController(viewportFraction: 0.9),
                          onPageChanged: (int index) =>
                              setState(() => _index = index),
                          itemBuilder: (_, i) {
                            return Transform.scale(
                              scale: i == _index ? 1 : 1,
                              child: Card(
                                shadowColor: Color.fromARGB(255, 22, 30, 50),
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Text(
                                    "+ ${i + 1}",
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        'All Tasks',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: Color.fromARGB(255, 103, 103, 103),
                        ),
                      ),
                    ),
                    ValueListenableBuilder<Box<NotesModel>>(
                      valueListenable: Boxes.getData().listenable(),
                      builder: (context, box, _) {
                        var data = box.values.toList().cast<NotesModel>();
                        return SingleChildScrollView(
                          child: ListView.builder(
                              reverse: true,
                              shrinkWrap: true,
                              itemCount: box.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              data[index].title.toString(),
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const Spacer(),
                                            InkWell(
                                                onTap: () =>
                                                    delete(data[index]),
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: Color.fromARGB(
                                                      255, 22, 30, 50),
                                                )),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            InkWell(
                                                onTap: () => update(
                                                    data[index],
                                                    data[index]
                                                        .title
                                                        .toString(),
                                                    data[index]
                                                        .description
                                                        .toString()),
                                                child: const Icon(
                                                  Icons.edit,
                                                  color: Colors.grey,
                                                ))
                                          ],
                                        ),
                                        Text(
                                          data[index].description.toString(),
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 22, 30, 50),
        onPressed: () async {
          _alertBox();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _alertBox() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add Notes'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                        hintText: 'Enter Title', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                        hintText: 'Enter Description',
                        border: OutlineInputBorder()),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    final data = NotesModel(
                        title: titleController.text,
                        description: descriptionController.text);
                    final box = Boxes.getData();
                    box.add(data);
                    data.save();
                    Navigator.pop(context);
                    titleController.clear();
                    descriptionController.clear();
                  },
                  child: const Text('Add')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
            ],
          );
        });
  }

  Future<void> update(NotesModel notesModel, String title, String description) {
    titleController.text = title;
    descriptionController.text = description;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add Notes'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      hintText: 'Enter Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                        hintText: 'Enter Description',
                        border: OutlineInputBorder()),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    notesModel.title = titleController.text.toString();
                    notesModel.description =
                        descriptionController.text.toString();
                    notesModel.save();
                    titleController.clear();
                    descriptionController.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Edit')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
            ],
          );
        });
  }

  void delete(NotesModel notesModel) async {
    await notesModel.delete();
  }
}
