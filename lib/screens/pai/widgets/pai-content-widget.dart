import 'package:flutter/material.dart';
import 'package:vegasistent/screens/pai/models/pai-item.dart';

class PAIContentWidget extends StatelessWidget {
  PAIContentWidget({ this.pai });
  final PAIItem pai;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 0, 12, 24),
      child: Text(pai.content)
    );
  }
}