import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchFunction extends StatefulWidget {
  const SearchFunction({super.key});

  @override
  State<SearchFunction> createState() => _SearchFunctionState();
}

class _SearchFunctionState extends State<SearchFunction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        foregroundColor: Colors.black,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                FontAwesomeIcons.chevronLeft,
                color: Color.fromARGB(255, 103, 103, 103),
              ),
            );
          },
        ),
      ),
      body: Container(
        // color: Colors.red,
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextField(
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                      // prefixIcon: const Icon(
                      //   FontAwesomeIcons.magnifyingGlass,
                      //   color: Color.fromARGB(255, 22, 30, 50),
                      // ),
                      suffixIcon: const Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: Color.fromARGB(255, 22, 30, 50),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
