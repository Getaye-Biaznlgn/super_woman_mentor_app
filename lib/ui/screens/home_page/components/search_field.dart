import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? Colors.transparent : const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(15),
        border: isDark? Border.all(color: Colors.white): null
      ),
      child: TextField(
        decoration: const InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            icon: Icon(Icons.search)),
        onChanged: (val) {},
      ),
    );
  }
}
