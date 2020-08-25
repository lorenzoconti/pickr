import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsRow extends StatefulWidget {
  final String title;
  final List<Object> options;
  final Function callback;
  SettingsRow({this.title, this.options, this.callback});

  @override
  _SettingsRowState createState() => _SettingsRowState();
}

class _SettingsRowState extends State<SettingsRow> {
  Object _selected;

  @override
  Widget build(BuildContext context) {
    return Row(children: _makeOptions());
  }

  List<Widget> _makeOptions() {
    List<Widget> _options = List<Widget>();
    _options.add(Container(child: Text(widget.title)));
    _options.add(SizedBox(width: 10));
    this.widget.options.forEach((element) {
      _options.add(GestureDetector(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                  color: _selected == element
                      ? Colors.green.shade200
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8)),
              child: Text(element.toString())),
          onTap: () {
            setState(() {
              widget.callback(widget.title, element);
              _selected = element;
            });
          }));
    });

    return _options;
  }
}
