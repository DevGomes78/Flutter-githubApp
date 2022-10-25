import 'package:flutter/material.dart';

import '../constants/string_constants.dart';

class PopularTextList extends StatelessWidget {
  const PopularTextList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        height: 25,
        child: Row(
          children: const [
            Icon(Icons.star_border, color: Colors.white, size: 30),
            SizedBox(width: 10),
            Text(
              StringConstants.popular,
              style: TextStyle(
                  fontSize: 20, color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}