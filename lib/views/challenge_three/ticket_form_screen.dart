import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:thiran_task/cubits/case_three/case_three_cubit.dart';
import 'package:thiran_task/widgets/thiran_button.dart';

class TicketFormScreen extends StatefulWidget {
  final String userId;

  TicketFormScreen({required this.userId});

  @override
  State<TicketFormScreen> createState() => _TicketFormScreenState();
}

class _TicketFormScreenState extends State<TicketFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _locationController = TextEditingController();

  final TextEditingController _attachmentController = TextEditingController();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String attachmentUrl = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Create Ticket'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Problem Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Problem Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _attachmentController,
                decoration: InputDecoration(labelText: 'Attachment Details'),
              ),
              SizedBox(
                height: 10,
              ),
              ThiranButton(
                  title: "Attachements",
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.33,
                  onTap: () {
                    _pickImage();
                  }),
              SizedBox(
                height: 20,
              ),
              ThiranButton(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.33,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<TicketCubit>().createTicket(
                            title: _titleController.text,
                            description: _descriptionController.text,
                            location: _locationController.text,
                            attachment: attachmentUrl,
                            attachementDetails: _attachmentController.text
                          );
                      showNotification();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Ticket submitted successfully'),
                        ),
                      );
                    }
                  },
                  title: 'Submit'),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile!.path == null) {
      final imageUrl = await _uploadImage(pickedFile.path);
      setState(() {
        attachmentUrl = imageUrl;
        Logger().v(attachmentUrl);
      });
    }
  }

  Future<String> _uploadImage(String imagePath) async {
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('attachments/${DateTime.now()}.png');
      UploadTask uploadTask = storageReference.putFile(File(imagePath));
      await uploadTask.whenComplete(() => print('Image uploaded successfully'));
      return await storageReference.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  void showNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'thiran_task',
      'thiran_task',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Ticket Created',
      'Your ticket request has been created!',
      platformChannelSpecifics,
    );
  }
}
