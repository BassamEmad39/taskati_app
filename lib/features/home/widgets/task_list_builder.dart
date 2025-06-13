import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/features/home/widgets/task_card.dart';

class TaskListBuilder extends StatelessWidget {
  const TaskListBuilder({super.key, required this.selectedDate});
  final String selectedDate;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: LocalStorage.tasksBox.listenable(),
        builder: (context, box, child) {
          List<TaskModel> tasks = [];
          for (var task in box.values) {
            if (task.date == selectedDate) {
              tasks.add(task);
            }
          }
          if (tasks.isEmpty) {
            return Center(child: Lottie.asset('assets/empty.json', width: 400));
          }
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                background: completeTaskUI(),
                secondaryBackground: deleteTaskUI(),
                onDismissed: (direction) {
                  if (direction == DismissDirection.endToStart) {
                    box.delete(tasks[index].id);
                  } else {
                    box.put(
                      tasks[index].id,
                      tasks[index].copyWith(isCompleted: true),
                    );
                  }
                },
                child: TaskCard(model: tasks[index]),
              );
            },
          );
        },
      ),
    );
  }

  Container completeTaskUI() {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      color: AppColors.greenColor,
      child: Row(
        children: [
          Icon(Icons.check, color: Colors.white),
          Gap(10),
           Text(
            "complete".tr(),
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Container deleteTaskUI() {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      color: AppColors.redColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(Icons.delete, color: Colors.white),
          Gap(10),
           Text(
            "delete".tr(),
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
