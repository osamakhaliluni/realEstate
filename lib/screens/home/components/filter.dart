import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  RangeValues priceRange = const RangeValues(10, 2000);
  @override
  Widget build(BuildContext context) {
    RangeLabels priceLabels = RangeLabels(
      priceRange.start.toString(),
      priceRange.end.toString(),
    );
    return Column(
      children: [
        const Text(
          "Filter",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            "Price Range",
          ),
        ),
        RangeSlider(
          values: priceRange,
          min: 10,
          max: 2000,
          labels: priceLabels,
          divisions: (priceRange.end / priceRange.start).floor(),
          onChanged: (value) {
            setState(() {
              priceRange = value;
            });
          },
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Apply"),
        ),
      ],
    );
  }
}
