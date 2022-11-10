import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TagWidget extends StatelessWidget {
  const TagWidget({Key? key ,this.tag}) : super(key: key);

  final String? tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).primaryColor.withOpacity(.8)
      ),
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child:  Center(
        child: AutoSizeText(
          tag ?? 'error',
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 13
          ),
        ),
      ),
    );
  }
}
