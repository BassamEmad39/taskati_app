import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/features/add_task/add_task_screen.dart';

class TodayHeader extends StatelessWidget {
  const TodayHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale.languageCode;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMd(currentLocale).format(DateTime.now()),
              style: TextStyles.getBodyTextStyle(
                context,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
            Text(
              "today".tr(),
              style: TextStyles.getBodyTextStyle(
                context,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        MainButton(
          width: 137,
          title: "add_task".tr(),
          onPressed: () {
            context.pushTo(AddTaskScreen());
          },
        ),
      ],
    );
  }
}
