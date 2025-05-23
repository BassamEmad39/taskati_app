import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/main_button.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  int selectedColor = 0;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var dateController = TextEditingController();
  var startTimeController = TextEditingController();
  var endTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateController.text = DateFormat.yMd().format(DateTime.now());
    startTimeController.text = DateFormat.jm().format(DateTime.now());
    endTimeController.text = DateFormat.jm().format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title(),
              Gap(10),
              description(),
              Gap(10),
              date(),
              Gap(10),
              Row(children: [startTime(), Gap(10), endTime()]),
              Gap(10),
              color(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MainButton(
          title: 'Add Task',
          onPressed: () {
            // Add your task adding logic here
          },
        ),
      ),
    );
  }

  Column color() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: TextStyles.getBodyTextStyle(fontWeight: FontWeight.w500),
        ),
        Row(
          children: List.generate(3, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: CircleAvatar(
                  backgroundColor:
                      index == 0
                          ? AppColors.primaryColor
                          : index == 1
                          ? AppColors.redColor
                          : AppColors.orangeColor,
                  child:
                      selectedColor == index
                          ? const Icon(Icons.check, color: Colors.white)
                          : null,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Column title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Title',
          style: TextStyles.getBodyTextStyle(fontWeight: FontWeight.w500),
        ),
        Gap(5),
        TextFormField(
          controller: titleController,
          decoration: InputDecoration(
            hintText: 'Enter title here',
            hintStyle: TextStyles.getSmallTextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  Column description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          'Note',
          style: TextStyles.getBodyTextStyle(fontWeight: FontWeight.w500),
        ),
        Gap(5),
        TextFormField(
          controller: descriptionController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Enter note here',
            hintStyle: TextStyles.getSmallTextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  Column date() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date',
          style: TextStyles.getBodyTextStyle(fontWeight: FontWeight.w500),
        ),
        Gap(5),
        TextFormField(
          readOnly: true,
          onTap: () {
            selectTaskDate();
          },
          controller: dateController,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.calendar_month_outlined),
            hintStyle: TextStyles.getSmallTextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  void selectTaskDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((value) {
      if (value != null) {
        dateController.text = DateFormat.yMd().format(value);
      }
    });
  }

  Expanded startTime() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Start Time',
            style: TextStyles.getBodyTextStyle(fontWeight: FontWeight.w500),
          ),
          Gap(5),
          TextFormField(
            controller: startTimeController,
            readOnly: true,
            onTap: () {
              showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              ).then((value) {
                if (value != null) {
                  startTimeController.text = value.format(context);
                }
              });
            },
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.access_time),
              hintStyle: TextStyles.getSmallTextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Expanded endTime() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'End Time',
            style: TextStyles.getBodyTextStyle(fontWeight: FontWeight.w500),
          ),
          Gap(5),
          TextFormField(
            readOnly: true,
            onTap: () {
              showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              ).then((value) {
                if (value != null) {
                  endTimeController.text = value.format(context);
                }
              });
            },
            controller: endTimeController,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.access_time),
              hintStyle: TextStyles.getSmallTextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
