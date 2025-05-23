import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/home/update_data.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => UpdateData()),
        ).then((shouldRefresh) {
          if (shouldRefresh == true) {
            setState(() {
              // Refresh the UI or data here
            });
          }
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, ${LocalStorage.getData(LocalStorage.name)} ',
                style: TextStyles.getTitleTextStyle(
                  color: AppColors.primaryColor,
                ),
              ),
              Text('Have a nice day'),
            ],
          ),
          CircleAvatar(
            radius: 30,
            backgroundImage: FileImage(
              File(LocalStorage.getData(LocalStorage.image)),
            ),
          ),
        ],
      ),
    );
  }
}
