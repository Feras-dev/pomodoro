import 'package:flutter/material.dart';
import 'package:pomodoro/model/PriorityLevel.dart';
import 'package:pomodoro/model/Storage.dart';
import 'package:pomodoro/model/Task.dart';
import 'package:uuid/uuid.dart';

// Create a Form widget
class EditTaskForm extends StatefulWidget {
  final Task oldTask;
  EditTaskForm({Key key, @required this.oldTask}) : super(key: key);

  @override
  EditTaskFormState createState() {
    // Passing old priority level through the constructor
    // to enable access of oldTask priority level in EditTaskFormState
    return EditTaskFormState(oldTask.priorityLevel);
  }
}

// Method to build and show alert box.
showAlertDialog(BuildContext context) {
  // Create OK button
  // TODO: Go back after dismissing the alert.
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pushNamed(context, "/home");
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Task Details Updated"),
    content: Text("Task successfully updated."),
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

// The Edit Task Form state class
// This will hold the old task details upon
// init. The form will be used to update the task
// by sending new details to the Storage
class EditTaskFormState extends State<EditTaskForm> {
  List<Task> taskList = [];
  String id = '';
  String _taskName = '';
  String _workInterval = '';
  String _breakInterval = '';
  String isComplete = 'no';
  PriorityLevel _taskPriority;

  // Constructor with old task priority.
  // Sets old task priority to current state of _taskPriority.
  // Dynamic state change is not possible through use of widget.oldTask.priorityLevel
  // as is the case for other fields because 'value' in '_buildPriorityLevelList'
  // changes dynamically according to _taskPriority and widget cannot be accessed in a
  // initializer
  EditTaskFormState(this._taskPriority);

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  saveData(BuildContext context) async {
    // Whenever user presses Update Task button,
    // we take all the data entered by the user and
    // construct a new Task object with it to update the
    // original list with the changed Task object
    var uuid = widget.oldTask.id;
    Task task = Task(
        id: uuid,
        name: _taskName,
        breakDuration: int.parse(_breakInterval),
        workDuration: int.parse(_workInterval),
        priorityLevel: _taskPriority,
        isComplete: false);

    // Singleton Storage class is used to access the
    // storage.
    // Old task and newly updated task are both sent to the Storage
    // class for updation
    bool isSuccess = await Storage().updateTask(widget.oldTask, task);

    // Show alert only if the task has been stored successfully.
    if (isSuccess) {
      showAlertDialog(context);
    }
  }

  // Regex to confirm that given string is all numbers.
  bool isNumber(String string) {
    final numericRegex = RegExp(r"^[1-9]\d*$");
    return numericRegex.hasMatch(string);
  }

  // Task name input field.
  Widget _buildTaskField() {
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
      initialValue: widget.oldTask.name,
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
      initialValue: widget.oldTask.workDuration.toString(),
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
      initialValue: widget.oldTask.breakDuration.toString(),
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
    //_taskPriority = widget.oldTask.priorityLevel;
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
          title: Text("Edit Task"),
        ),
        body: Form(
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
                    child: const Text('Update Task'),
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
        ));
  }
}
