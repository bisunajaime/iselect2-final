import 'package:embesys_finals/models/categories_model.dart';
import 'package:embesys_finals/provider/ir_list_provider.dart';
import 'package:embesys_finals/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditRemotePage extends StatefulWidget {
  final int index;

  const EditRemotePage({Key key, this.index}) : super(key: key);

  @override
  _EditRemotePageState createState() => _EditRemotePageState();
}

class _EditRemotePageState extends State<EditRemotePage> {
  int _selectedCategory = 0;
  String _selectedCat = "";
  TextEditingController _label;

  @override
  void initState() {
    super.initState();
    _label = TextEditingController(
        text: Provider.of<IRListProvider>(context, listen: false)
                .irRecvList[widget.index]
                .label ??
            "");
    _selectedCat = Provider.of<IRListProvider>(context, listen: false)
        .irRecvList[widget.index]
        .category;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IRListProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit Button'),
            backgroundColor: UiColors.secondaryColor,
          ),
          backgroundColor: UiColors.primaryColor,
          body: ListView(
            children: [
              Text('Edit label'),
              TextFormField(
                controller: _label,
                decoration: InputDecoration(hintText: 'Enter label here'),
              ),
              SizedBox(
                height: 8,
              ),
              Text('Select Category'),
              SizedBox(
                height: 8,
              ),
              DropdownButton<String>(
                value: _selectedCat,
                items: value.categories.map((e) {
                  print(e.name);
                  return DropdownMenuItem<String>(
                    value: e.name,
                    child: Text(e.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCat = value;
                  });
                },
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 45,
                child: FlatButton(
                  color: UiColors.lightTextColor,
                  child: Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {
                    int prevIndex, currIndex;
                    value.categories.asMap().forEach((key, val) {
                      if (_selectedCat == val.name) {
                        print(val.name);
                        currIndex = key;
                      }
                      if (value.irRecvList[widget.index].category != null) {
                        if (value.irRecvList[widget.index].category ==
                            val.name) {
                          print(val.name);
                          prevIndex = key;
                        }
                      }
                    });
                    value.updateLabel(
                      widget.index,
                      _label.text,
                      currIndex,
                      prevIndex,
                    );
                    print('updated');
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
