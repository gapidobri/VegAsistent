import 'package:flutter/material.dart';
import 'package:vegasistent/screens/pai/models/pai-item.dart';
import 'package:vegasistent/screens/pai/widgets/pai-content-widget.dart';
import 'package:vegasistent/screens/pai/widgets/pai-widget.dart';
import 'package:vegasistent/utils/data-parser.dart';
import 'package:vegasistent/widgets/loading.dart';

class PAI extends StatefulWidget {
  @override
  _PAIState createState() => _PAIState();
}

class _PAIState extends State<PAI> {

  Widget loading = Loading();
  List<PAIItem> _items = [];

  @override
  void initState() {
    getPAI().then((pai) {
      setState(() {
        loading = null;
        _items = List.from(pai).map((e) {
          return PAIItem(
            teacher: e['author'],
            subject: e['course'],
            category: e['category'],
            date: DateTime.parse(e['date']),
            content: e['text'],
            type: EntryType.values.firstWhere((en) => en.toString() == 'EntryType.' + e['type'])
          );
        }).toList();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading ?? ListView(
      padding: EdgeInsets.all(8),
      children: [
        ExpansionPanelList(
          expansionCallback: (i, isExpanded) {
            setState(() {
              _items[i].isExpanded = !_items[i].isExpanded;
            });
          },
          children: _items.map((PAIItem item) {
            return ExpansionPanel(
              headerBuilder: (context, isExpanded) => PAIWidget(pai: item),
              isExpanded: item.isExpanded,
              body: PAIContentWidget(pai: item),
            );
          }).toList(),
        ),
      ],
    );
  }
}