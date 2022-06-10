// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_getx_todo/pages/edit_task/edit_task_controller.dart';
import 'package:get/get.dart';

class EditTaskForm extends StatefulWidget {
  final Map data;
  EditTaskForm({required this.data});

  @override
  State<EditTaskForm> createState() => _EditTaskFormState();
}

class _EditTaskFormState extends State<EditTaskForm> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

      final TextEditingController editTitle = TextEditingController();
  final TextEditingController editDate = TextEditingController();


  final editTaskController = Get.put(EditTaskController());
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
      editDate.text = formatDate.toString();
    });
  }

  edit() async{
    if (!_formKey.currentState!.validate()) {
      return;
    }
    editTaskController.editTask(editTitle.text, editDate.text,widget.data["id"]);
   
  }
  

  @override
  void initState() {
    editTitle.text = widget.data["title"];
    editDate.text = widget.data["date"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                    controller: editTitle,
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
                          Icon(Icons.title_outlined, color: Colors.grey),
                      hintText: "Enter your task title",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.purple,
                        width: 2,
                      )),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
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
                    controller: editDate,
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
                          color: Colors.purple,
                          width: 2,
                        )),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.calendar_today,
                            color: Colors.grey,
                          ),
                          onPressed: pickDate,
                        ))),
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: edit,
                child: Padding(
                  padding: const EdgeInsets.only(left: 35, right: 35),
                  child: Text(
                    "Edit task",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.purple[500]!),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    )),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      )

       ],
    );
  }
}
