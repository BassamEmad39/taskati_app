import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/home/widgets/home_header.dart';
import 'package:taskati/features/home/widgets/task_list_builder.dart';
import 'package:taskati/features/home/widgets/today_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedDate = '';
  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale.languageCode;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              HomeHeader(),
              Gap(20),
              TodayHeader(),
              Gap(20),
              DatePicker(
                locale: currentLocale,
                height: 100,
                width: 70,
                DateTime.now(),
                dayTextStyle: TextStyles.getBodyTextStyle(context),
                monthTextStyle: TextStyles.getBodyTextStyle(context),
                dateTextStyle: TextStyles.getBodyTextStyle(context),

                initialSelectedDate: DateTime.now(),
                selectionColor: AppColors.primaryColor,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  setState(() {
                    selectedDate = DateFormat.yMd(currentLocale).format(date);
                  });
                },
              ),
              Gap(20),
              TaskListBuilder(selectedDate: selectedDate),
            ],
          ),
        ),
      ),
    );
  }
}
