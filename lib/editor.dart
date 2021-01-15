import 'package:CodeKaksha/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Editor extends StatefulWidget {
  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor>
    with AutomaticKeepAliveClientMixin<Editor> {
  @override
  bool get wantKeepAlive => true;

  String dropDownValue = "C++";
  var langShortForm = {'C++': 'cpp', 'Java': 'java', 'Python': 'python3'};

  final editorController = TextEditingController();
  final stdinController = TextEditingController();
  String stdoutText = 'Write some code and run to see the output';

  var api = 'https://emkc.org/api/v1/piston/execute';
  var response, stdout;
  executeCode(String lang, String src, String args) async {
    response = await http.post(api,
        body: jsonEncode({'language': lang, 'source': src, 'args': args}));
    stdout = jsonDecode(response.body)['stdout'];
    print('Output: ${stdout.toString()}');
  }

  @override
  void dispose() {
    editorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Flexible(
            //the column or row widget determines the intrinsic size of its non-flexible childen but since
            //the text field is taking up the entire space we need to make it flexible
            child: TextField(
              controller: editorController,
              autofocus: false,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              expands: true,
              decoration: InputDecoration(
                hintText: "Your code goes here",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              //1. maxLines gives infinite writing space
              //2. without expands, language box will stick to the last line you wrote on the editor instead
              //   of staying at the bottom
              //3. setting borders to none gets rid of the line at the bottom of the TextField
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              SizedBox(
                width: 15,
              ),
              DropdownButton(
                value: dropDownValue,
                icon: Icon(Icons.arrow_right),
                iconSize: 28,
                elevation: 16,
                style: TextStyle(
                    color: Colors.black, fontSize: 18, fontFamily: "Quicksand"),
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValue = newValue;
                    FocusScope.of(context).unfocus();
                  });
                },
                items: <String>["C++", "Java", "Python"]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton.icon(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      showBarModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              margin: EdgeInsets.only(left: 15.0, right: 15.0),
                              child: Column(
                                children: [
                                  SizedBox(height: 15),
                                  Text(
                                    "stdin",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Flexible(
                                    child: TextField(
                                      controller: stdinController,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      expands: true,
                                      decoration: InputDecoration(
                                        hintText: "Your input goes here",
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    padding: EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    color: myColor,
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    label: Text(
                      "stdin",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    splashColor: Colors.yellow,
                  ),
                  RaisedButton.icon(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      showBarModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              margin: EdgeInsets.only(left: 15.0, right: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15),
                                  Center(
                                    child: Text(
                                      "stdout",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: "Quicksand",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(stdoutText),
                                ],
                              ),
                            );
                          });
                    },
                    padding: EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    color: myColor,
                    icon: Icon(
                      Icons.assignment,
                      color: Colors.white,
                    ),
                    label: Text(
                      "stdout",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    splashColor: Colors.yellow,
                  ),
                  RaisedButton.icon(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      executeCode(langShortForm[dropDownValue],
                          editorController.text, "");
                    },
                    padding: EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    color: Colors.lightGreenAccent[700],
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Run",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}

class ShowDialogStdIn extends StatefulWidget {
  @override
  _ShowDialogStdInState createState() => _ShowDialogStdInState();
}

class _ShowDialogStdInState extends State<ShowDialogStdIn>
    with AutomaticKeepAliveClientMixin<ShowDialogStdIn> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: Container(
        margin: EdgeInsets.only(left: 15.0, right: 15.0),
        child: Column(
          children: [
            SizedBox(height: 15),
            Text(
              "stdin",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: "Quicksand",
                fontWeight: FontWeight.bold,
              ),
            ),
            Flexible(
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: "Your input goes here",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
