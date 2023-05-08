import 'package:adicine/Services/fireDb.dart';
import 'package:flutter/material.dart';

import 'package:svg_icon/svg_icon.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({super.key});

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  final _nameController = TextEditingController();
  final _dossageController = TextEditingController();
  String type = "";
  bool cap = false;
  bool tab = false;
  bool bot = false;
  bool inj = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _dossageController.dispose();
  }

  TimeOfDay _time = TimeOfDay(hour: 0, minute: 00);
  bool clicked = false;

  Future<TimeOfDay> _selectTime() async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _time);
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        clicked = true;
      });
    }

    return picked!;
  }

  final _intervals = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
  ];
  var _selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Add Medicine",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  hintText: "Search Your Medicine here",
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.deepPurple,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, top: 20),
              child: Text(
                "Dossage in mg :",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _dossageController,
                cursorColor: Colors.deepPurple,
                cursorHeight: 25,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 20),
              child: Text(
                "Medicine Type :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      cap = true;
                      tab = false;
                      inj = false;
                      bot = false;
                      type = "Capsule";
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.only(top: 15, left: 10),
                        child: SvgIcon(
                          "assets/logo/capsule.svg",
                          height: 50,
                          color: cap == true ? Colors.deepPurple : Colors.black,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5, left: 9),
                        child: Text(
                          "Capsule",
                          style: TextStyle(
                            color:
                                cap == true ? Colors.deepPurple : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      cap = false;
                      tab = true;
                      inj = false;
                      bot = false;
                      type = "Tablet";
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.only(top: 15, left: 10),
                        child: SvgIcon(
                          "assets/logo/tablets.svg",
                          color: tab == true ? Colors.deepPurple : Colors.black,
                          height: 50,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5, left: 9),
                        child: Text(
                          "Tabltes",
                          style: TextStyle(
                            color:
                                tab == true ? Colors.deepPurple : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      cap = false;
                      tab = false;
                      inj = false;
                      bot = true;
                      type = "Bottle";
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.only(top: 15, left: 10),
                        child: SvgIcon(
                          "assets/logo/bottle.svg",
                          color: bot == true ? Colors.deepPurple : Colors.black,
                          height: 50,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5, left: 9),
                        child: Text(
                          "Bottle",
                          style: TextStyle(
                            color:
                                bot == true ? Colors.deepPurple : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      cap = false;
                      tab = false;
                      inj = true;
                      bot = false;
                      type = "Injection";
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.only(top: 15, left: 10),
                        child: SvgIcon(
                          "assets/logo/injection.svg",
                          color: inj == true ? Colors.deepPurple : Colors.black,
                          height: 50,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5, left: 9),
                        child: Text(
                          "Injection",
                          style: TextStyle(
                            color:
                                inj == true ? Colors.deepPurple : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 2,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 10),
              child: Text(
                "Interval Selection :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 15, left: 10),
                  child: Text(
                    "Remind me every",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: 10),
                  child: DropdownButton(
                    hint: _selected == 0 ? Text("Select an Interval") : null,
                    value: _selected == 0 ? null : _selected,
                    items: _intervals.map((int value) {
                      return DropdownMenuItem<int>(
                        child: Text(value.toString()),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        _selected = newVal!;
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, top: 10),
                  child: Text(
                    _selected == 1 ? "Hour" : "Hours",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 2,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 20),
              child: Text(
                "Starting time :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _selectTime();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple.shade400,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      clicked == false
                          ? "Select time"
                          : "${_time.hour.toString()} : ${_time.minute.toString()}",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple.shade400,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      "Confirm",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
