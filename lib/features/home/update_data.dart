import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/main_button.dart';

class UpdateData extends StatefulWidget {
  const UpdateData({super.key});

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  String path = LocalStorage.getData(LocalStorage.image);
  String name = LocalStorage.getData(LocalStorage.name);
  bool isEditing = false;
  bool isDarkMode = false;
  var updatedNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    updatedNameController = TextEditingController(text: name);
  }

  @override
  void dispose() {
    updatedNameController.dispose();
    super.dispose();
  }

  void toggleEdit() {
    setState(() {
      if (isEditing) {
        name = updatedNameController.text;
      }
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.dark_mode, color: AppColors.whiteColor),
            onPressed: () {
              bool themeMode = LocalStorage.getData(LocalStorage.isDarkMode)?? false;
              LocalStorage.cacheData(
                LocalStorage.isDarkMode,
                !themeMode,
              );
            },
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
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: FileImage(File(path)),
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
              Row(
                children: [
                  Expanded(
                    child:
                        isEditing
                            ? TextFormField(
                              controller: updatedNameController,
                              decoration: const InputDecoration(
                                hintText: 'Enter your name',
                              ),
                            )
                            : Text(
                              name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                  ),
                  const Gap(5),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryColor, // Border color
                        width: 2, // Border width
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(isEditing ? Icons.check : Icons.edit),
                      color: AppColors.primaryColor,
                      onPressed: () {
                        setState(() {
                          toggleEdit();
                        });
                      },
                    ),
                  ),
                ],
              ),
              const Gap(40),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 32,
                  ),
                ),
                onPressed: () {
                  LocalStorage.cacheData(LocalStorage.image, path);
                  LocalStorage.cacheData(LocalStorage.name, name);
                  Navigator.pop(context, true);
                },
                child: Text('Done', style: TextStyles.getTitleTextStyle()),
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
                title: 'Upload From Camera',
                onPressed: () {
                  uploadImage(true);
                },
              ),
              const Gap(10),
              MainButton(
                title: 'Upload From Gallery',
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
