import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';

class TaskListBuilder extends StatelessWidget {
  const TaskListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),

            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Flutter Task -1',
                        style: TextStyles.getBodyTextStyle(
                          color: AppColors.whiteColor,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            color: Colors.white,
                            size: 18,
                          ),
                          Gap(10),
                          Text(
                            '10:00 AM',
                            style: TextStyles.getSmallTextStyle(
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                      Gap(5),
                      Text(
                        'bshdbs',
                        style: TextStyles.getBodyTextStyle(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(width: 1, height: 50, color: AppColors.whiteColor),
                Gap(10),
                RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    'TODO',
                    style: TextStyles.getBodyTextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
