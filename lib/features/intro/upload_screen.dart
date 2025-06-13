import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/functions/dialog.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/features/home/home_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? path;
  var nameController = TextEditingController();
  bool isDarkMode = LocalStorage.getData(LocalStorage.isDarkMode) ?? false;
  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            setState(() {
              if (currentLocale.languageCode == 'en') {
                context.setLocale(Locale('ar'));
              } else {
                context.setLocale(Locale('en'));
              }
            });
          },
          child: Text(
            "btn_txt".tr(),
            style: TextStyles.getBodyTextStyle(context),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (path != null && nameController.text.isNotEmpty) {
                LocalStorage.cacheData(LocalStorage.name, nameController.text);
                LocalStorage.cacheData(LocalStorage.image, path!);
                context.pushReplacementTo(HomeScreen());
              } else if (path == null && nameController.text.isNotEmpty) {
                showMainDialog(context, "select_image".tr());
              } else if (path != null && nameController.text.isEmpty) {
                showMainDialog(context, "select_name".tr());
              } else {
                showMainDialog(context, "select_image_name".tr());
              }
            },
            child: Text(
              "done".tr(),
              style: TextStyles.getBodyTextStyle(context),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showUploadBottomSheet(context);
                },
                child: Stack(
                  children: [
                    path != null
                        ? ClipOval(
                          child: Image.file(
                            File(path ?? ''),
                            width: 140,
                            height: 140,
                            fit: BoxFit.cover,
                          ),
                        )
                        : const CircleAvatar(
                          radius: 70,
                          backgroundColor: AppColors.primaryColor,
                          backgroundImage: AssetImage(AppImages.user),
                        ),
                    const Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 17,
                        backgroundColor: AppColors.whiteColor,
                        child: Icon(
                          Icons.camera_alt,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20),
              const Divider(),
              const Gap(20),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(hintText: "enter_name".tr()),
              ),
              Gap(20),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "dark_mode".tr(),
                    style: TextStyles.getBodyTextStyle(context),
                  ),
                  Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        LocalStorage.cacheData(LocalStorage.isDarkMode, value);
                        isDarkMode = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  showUploadBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MainButton(
                title: "upload_camera".tr(),
                onPressed: () {
                  uploadImage(true);
                },
              ),
              const Gap(10),
              MainButton(
                title: "upload_gallery".tr(),
                onPressed: () {
                  uploadImage(false);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  uploadImage(bool isCamera) async {
    var imagePicker = ImagePicker();
    var pickedImage = await imagePicker.pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        path = pickedImage.path;
      });
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }
}
