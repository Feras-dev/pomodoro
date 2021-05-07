import 'package:flutter/material.dart';
import 'package:pomodoro/model/PriorityLevel.dart';
import 'package:pomodoro/model/Storage.dart';
import 'package:pomodoro/model/Task.dart';
import 'package:uuid/uuid.dart';

// Create a Form widget.
class AddTaskForm extends StatefulWidget {
  final Task oldTask;

  AddTaskForm({Key key, @required this.oldTask}) : super(key: key);

  @override
  AddTaskFormState createState() {
    return AddTaskFormState(oldTask);
  }
}

// Method to build and show alert box.
showAlertDialog(BuildContext context, String title, String content, Task task) {
  // Create OK button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
      Navigator.pop(context, task);
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// Create a corresponding State class. This class holds data related to the form.
class AddTaskFormState extends State<AddTaskForm> {
  Task _oldTask; // Only used if this page acts an edtTask page
  List<Task> taskList = [];
  String id = '';
  String _taskName = '';
  String _workInterval = '';
  String _breakInterval = '';
  String isComplete = 'no';
  PriorityLevel _taskPriority = PriorityLevel.LOW;

  String pageTitle = 'Add a new Task';
  String buttonText = 'Add Task';
  String alertTitle = 'Task Added';
  String alertContent = 'New task successfully added.';

  // Constructor with old task object to be used if this page acts as an editTask page
  // Dynamic state change is not always possible through use of widget.oldTask
  AddTaskFormState(this._oldTask) {
    // If the oldTask is not null the user requested to edit a task
    // Otherwise Add task page will be displayed
    if (_oldTask != null) {
      id = _oldTask.id;
      _taskName = _oldTask.name;
      _workInterval = _oldTask.workDuration.toString();
      _breakInterval = _oldTask.breakDuration.toString();
      _taskPriority = _oldTask.priorityLevel;
      pageTitle = 'Edit Task';
      buttonText = 'Update Task';
      alertTitle = 'Task Updated';
      alertContent = 'Task successfully updated';
    }
  }

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  saveData(BuildContext context) async {
    // Whenever user presses Add Task button,
    // we take all the data entered by the user and
    // construct a new Task object with it.
    var uuid = Uuid();
    Task task = Task(
        id: uuid.v4(),
        name: _taskName,
        breakDuration: int.parse(_breakInterval),
        workDuration: int.parse(_workInterval),
        priorityLevel: _taskPriority,
        isComplete: false);

    // Singleton Storage class is used to access the
    // storage.
    bool isSuccess = false;

    if (_oldTask != null) {
      isSuccess = await Storage().updateTask(_oldTask, task);
    } else {
      isSuccess = await Storage().addTask(task);
    }
    // Show alert only if the task has been stored successfully.
    if (isSuccess) {
      showAlertDialog(context, alertTitle, alertContent, task);
    }
  }

  // Regex to confirm that given string is all numbers.
  bool isNumber(String string) {
    final numericRegex = RegExp(r"^[1-9]\d*$");
    return numericRegex.hasMatch(string);
  }

  // Task name input field.
  Widget _buildTaskField() {
    if (_oldTask != null) {
      _taskName = _oldTask.name;
    }
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return "Please enter the task name";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Task Name',
      ),
      initialValue: _taskName,
      onSaved: (String value) {
        setState(() {
          _taskName = value;
        });
      },
    );
  }

  // Work interval input field.
  Widget _buildWorkIntervalField() {
    return TextFormField(
      // Validator gives a value and we need to
      // check that given value for errors.
      // Returning null indicates no errors and
      // validation passes.
      validator: (value) {
        if (value.isEmpty) {
          return "Please enter work interval";
        } else if (!isNumber(value)) {
          return "Please enter a valid number";
        }
        return null;
      },
      // For opening the number keyboard.
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Work Interval',
      ),
      initialValue: _workInterval,
      onSaved: (String value) {
        setState(() {
          _workInterval = value;
        });
      },
    );
  }

  // Break interval input field.
  Widget _buildBreakIntervalField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return "Please enter break interval";
        } else if (!isNumber(value)) {
          return "Please enter a valid number";
        }
        return null;
      },
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Break Interval',
      ),
      initialValue: _breakInterval,
      onSaved: (String value) {
        setState(() {
          _breakInterval = value;
        });
      },
    );
  }

  // A simple static text with padding.
  Widget _priorityText() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 10, 0),
      child: Text(
        "Task Priority",
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }

  // Task Priority dropdown list.
  Widget _buildPriorityLevelList() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 4, 16, 16),
      // Dropdown button bound to PriorityLevel enum
      // Changing PriorityEnum values will automatically
      // change the dropdown options.
      child: DropdownButton<PriorityLevel>(
          // Values selected by the user.
          value: _taskPriority,
          onChanged: (PriorityLevel newValue) {
            setState(() {
              // Newly selected value will be set in the state.
              _taskPriority = newValue;
            });
          },
          // In order to populate the dropdown, we take all the values in the
          // PriorityLevel enum. Since we get values in "PriorityLevel.LOW"
          // format, we need to split it at ".". Here, dropdown should be
          // populated with the second value.
          items: PriorityLevel.values.map((PriorityLevel classType) {
            // Splitting with "." gives us a List<String> containing two values,
            // first is "PriorityLevel" and second is "LOW". Here we take 2nd
            // value (last in the returned List<String>), and process it to show
            // in the dropdown.
            String valUse = classType.toString().split(".").last.toLowerCase();
            valUse = valUse[0].toUpperCase() + valUse.substring(1);
            if (valUse.contains("_")) {
              valUse = valUse.replaceAll(new RegExp('[\\W_]+'), ' ');
            }
            return DropdownMenuItem<PriorityLevel>(
                value: classType, child: Text(valUse));
          }).toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          title: Text(pageTitle),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                // CrossAxisAlignment is used to align dropdown to
                // start of the screen.
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildTaskField(),
                  _buildWorkIntervalField(),
                  _buildBreakIntervalField(),
                  _priorityText(),
                  _buildPriorityLevelList(),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(buttonText),
                      onPressed: () {
                        // Validate the form and show appropriate errors.
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          // Save the data.
                          saveData(context);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
