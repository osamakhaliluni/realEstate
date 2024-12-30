import 'package:flutter/material.dart';
import 'package:frontend/core/style/colors.dart';
import 'package:frontend/screens/home/components/filter.dart';
import 'package:frontend/utils/size_config.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 5,
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    // Handle search action
                  },
                  icon: Icon(
                    Icons.search,
                    color: primaryColor,
                    size: 30,
                  ),
                ),
                const Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Search...",
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 124, 124, 124),
                        fontSize: 16,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: SizedBox(
            height: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      constraints: BoxConstraints(
                        minHeight: SizeConfig.screenHeight / 5 * 3,
                      ),
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Filter(),
                    );
                  },
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.filter_list),
                  Text("Filters"),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
