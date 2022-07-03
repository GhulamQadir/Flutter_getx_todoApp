// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_todo/pages/add_task/add_task_controller.dart';
import 'package:flutter_getx_todo/pages/add_task/loading_screen.dart';
import 'package:get/get.dart';

class AddTaskForm extends StatefulWidget {
  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final addTaskController = Get.put(AddTaskController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;
  DateTime now =  DateTime.now();
//   DateTime convertedDateTime = DateTime.now();
// Timestamp convertedDateTimeStamp = Timestamp.fromDate(convertedDateTime);

  add() async{
    print("${now.year} ${now.month} ${now.day}");

    if (!_formKey.currentState!.validate()) {
      return;
    }
await addTaskController.addTask(addTaskController.titleController.text, addTaskController.dateController.text);
   
    Navigator.of(context).pop();
  }
  
  DateTime date = DateTime(2022, 04, 18);

  pickDate() async {
    DateTime? newDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      initialDate: date,
      lastDate: DateTime(2100)
      builder: (context, child) {

        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                // primary: btnTextColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (newDate == null) return;
    setState(() {
      date = newDate;
      var formatDate = "${date.month}/${date.day}/${date.year}";
      addTaskController.dateController.text = formatDate.toString();
    });
  }

  @override
  void initState() {
    addTaskController.dateController.text = "${date.month}/${date.day}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return   Column(children: [
      Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            children: [
              SizedBox(
                height: 22,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Title",
                    style: TextStyle(
                        fontSize: 22,
                        wordSpacing: 1.3,
                        fontWeight: FontWeight.w500),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 7, right: 20),
                child: SizedBox(
                  height: 75,
                  child: TextFormField(
                    controller: addTaskController.titleController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your task title';
                      } else if (value.length < 3) {
                        return "Your task title is too short";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.title_outlined, color: Color(0xff092f82)),
                      hintText: "Enter your task title",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xff092f82),
                        width: 2,
                      )),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff092f82), width: 1 ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Date Picker",
                    style: TextStyle(
                        fontSize: 19,
                        wordSpacing: 1.3,
                        fontWeight: FontWeight.w500),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 7, right: 20),
                child: TextFormField(
                    controller: addTaskController.dateController,
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your task date';
                      } else if (value.length < 6) {
                        return "Your task date is too short";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Pick Date",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xff092f82),
                          width: 2,
                        )),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff092f82), width: 1),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.calendar_today,
                            color: Color(0xff092f82),
                          ),
                          onPressed: pickDate,
                        ))),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextButton(
                      onPressed: add,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "Add task",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff092f82)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          )))),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      )
    ]);
  }
}
