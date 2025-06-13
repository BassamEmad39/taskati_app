// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/functions/dialog.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/core/services/local_storage.dart';
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
  var formKey = GlobalKey<FormState>();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();
  TimeOfDay nowTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    dateController.text = DateFormat.yMd().format(DateTime.now());
    startTimeController.text = DateFormat.jm().format(DateTime.now());
    endTimeController.text = DateFormat.jm().format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale.languageCode;
    return Scaffold(
      appBar: AppBar(title: Text("task_add".tr())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
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
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MainButton(
          title: "create_task".tr(),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              final selectedDate = DateFormat.yMd(
                currentLocale,
              ).parse(dateController.text);
              final start = DateTime(
                selectedDate.year,
                selectedDate.month,
                selectedDate.day,
                selectedStartTime.hour,
                selectedStartTime.minute,
              );
              final end = DateTime(
                selectedDate.year,
                selectedDate.month,
                selectedDate.day,
                selectedEndTime.hour,
                selectedEndTime.minute,
              );

              if (start.isAtSameMomentAs(end)) {
                showMainDialog(context, "error1".tr());
                return;
              }

              if (start.isAfter(end)) {
                showMainDialog(context, "error2".tr());
                return;
              }

              String id = titleController.text + DateTime.now().toString();
              LocalStorage.cacheTask(
                id,
                TaskModel(
                  id: id,
                  title: titleController.text,
                  description: descriptionController.text,
                  date: dateController.text,
                  startTime: startTimeController.text,
                  endTime: endTimeController.text,
                  color: selectedColor,
                  isCompleted: false,
                ),
              );
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("task_added".tr())));
              Navigator.pop(context);
            }
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
          "color".tr(),
          style: TextStyles.getBodyTextStyle(
            context,
            fontWeight: FontWeight.w500,
          ),
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
          "title".tr(),
          style: TextStyles.getBodyTextStyle(
            context,
            fontWeight: FontWeight.w500,
          ),
        ),
        Gap(5),
        TextFormField(
          validator: (value) => value!.isEmpty ? "title_error".tr() : null,
          controller: titleController,
          decoration: InputDecoration(
            hintText: "title_hint".tr(),
            hintStyle: TextStyles.getSmallTextStyle(),
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
          "note".tr(),
          style: TextStyles.getBodyTextStyle(
            context,
            fontWeight: FontWeight.w500,
          ),
        ),
        Gap(5),
        TextFormField(
          validator: (value) => value!.isEmpty ? "note_error".tr() : null,
          controller: descriptionController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: "note_hint".tr(),
            hintStyle: TextStyles.getSmallTextStyle(),
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
          "date".tr(),
          style: TextStyles.getBodyTextStyle(
            context,
            fontWeight: FontWeight.w500,
          ),
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
            hintStyle: TextStyles.getSmallTextStyle(),
          ),
        ),
      ],
    );
  }

  void selectTaskDate() {
    final currentLocale = context.locale.languageCode;
    showDatePicker(
      context: context,

      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((value) {
      if (value != null) {
        dateController.text = DateFormat.yMd(currentLocale).format(value);
      }
    });
  }

  Expanded startTime() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "start_time".tr(),
            style: TextStyles.getBodyTextStyle(
              context,
              fontWeight: FontWeight.w500,
            ),
          ),
          Gap(5),
          TextFormField(
            controller: startTimeController,
            readOnly: true,
            onTap: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: selectedStartTime,
              );

              if (picked != null) {
                final currentLocale = context.locale.languageCode;

                final now = TimeOfDay.now();
                final selectedDate = DateFormat.yMd(
                  currentLocale,
                ).parse(dateController.text);
                final today = DateTime.now();

                // Prevent past time only if selected date is today
                if (isSameDate(today, selectedDate) &&
                    (picked.hour < now.hour ||
                        (picked.hour == now.hour &&
                            picked.minute < now.minute))) {
                  showMainDialog(context, "error4".tr());
                  return;
                }

                setState(() {
                  selectedStartTime = picked;
                  startTimeController.text = picked.format(context);
                });
              }
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
            "end_time".tr(),
            style: TextStyles.getBodyTextStyle(
              context,
              fontWeight: FontWeight.w500,
            ),
          ),
          Gap(5),
          TextFormField(
            controller: endTimeController,
            readOnly: true,
            onTap: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: selectedEndTime,
              );

              if (picked != null) {
                final currentLocale = context.locale.languageCode;
                final now = TimeOfDay.now();
                final selectedDate = DateFormat.yMd(
                  currentLocale,
                ).parse(dateController.text);
                final today = DateTime.now();

                if (isSameDate(today, selectedDate) &&
                    (picked.hour < now.hour ||
                        (picked.hour == now.hour &&
                            picked.minute < now.minute))) {
                  showMainDialog(context, "error3".tr());
                  return;
                }

                setState(() {
                  selectedEndTime = picked;
                  endTimeController.text = picked.format(context);
                });
              }
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

  bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
