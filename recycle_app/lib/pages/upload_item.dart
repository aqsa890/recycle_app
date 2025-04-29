import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:recycle_app/services/database.dart';
import 'package:recycle_app/services/shared_preferences.dart';
import 'package:recycle_app/services/widget_support.dart';

class UploadItem extends StatefulWidget {
  String category, id;
  UploadItem({required this.category, required this.id});

  @override
  State<UploadItem> createState() => _UploadItemState();
}

class _UploadItemState extends State<UploadItem> {
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController quantitycontroller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  String? id, name;

  getthesharedpref() async {
    id = await SharedPreferenceHelper().getUserId();
    name = await SharedPreferenceHelper().getUserName();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getthesharedpref();
  }

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {});
  }

  Future uploadImageToFirebase(File image) async {
    String itemid = randomAlphaNumeric(10);
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
      "items/$itemid",
    );
    UploadTask task = firebaseStorageRef.putFile(image);
    var downloadUrl = await (await task).ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 195, 232, 214),
      body: Container(
        margin: EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(60),
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: const Color.fromARGB(255, 246, 243, 243),
                        size: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 5.5),
                  Text('Upload Item', style: AppWidget.healinetextstyle(25.0)),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Color.fromARGB(255, 195, 232, 214),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.0),
                    selectedImage != null
                        ? Center(
                          child: Container(
                            height: 180,
                            width: 180,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                        : GestureDetector(
                          onTap: () {
                            getImage();
                          },
                          child: Center(
                            child: Container(
                              height: 180,
                              width: 180,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black45,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(Icons.camera_alt_outlined, size: 30),
                            ),
                          ),
                        ),
                    SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Text(
                        'Enter the Address you want the item to be picked.',
                        style: AppWidget.normaltextstyle(20.0),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: addresscontroller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.location_on,
                                color: Colors.green,
                              ),
                              hintText: 'Enter address',
                              hintStyle: AppWidget.normaltextstyle(20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Text(
                        'Enter the quantity of item to be picked.',
                        style: AppWidget.normaltextstyle(20.0),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: quantitycontroller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.inventory,
                                color: Colors.green,
                              ),
                              hintText: 'Enter Quantity',
                              hintStyle: AppWidget.normaltextstyle(20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    GestureDetector(
                      onTap: () async {
                        if (addresscontroller.text.isNotEmpty &&
                            quantitycontroller.text.isNotEmpty) {
                          String itemid = randomAlphaNumeric(10);

                          // If image is selected, store a URL or a placeholder (if you are not using Firebase Storage)
                          String imageUrl = "";
                          if (selectedImage != null) {
                            // For now, you can either upload the image to another server, or use a placeholder URL
                            imageUrl =
                                "https://via.placeholder.com/150"; // Placeholder URL
                          }

                          // Prepare the data for Firestore
                          Map<String, dynamic> addItem = {
                            "Image": imageUrl,
                            "Address": addresscontroller.text,
                            "Quantity": quantitycontroller.text,
                            "UserId": id,
                            "Name": name,
                            "Status": "Pending",
                          };

                          // Add the item to Firestore
                          await DatabaseMethods().addUserUploadItem(
                            addItem,
                            id!,
                            itemid,
                          );
                          await DatabaseMethods().addAdminItem(addItem, itemid);

                          // Show success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(
                                "Item has been Uploaded Successfully!",
                                style: AppWidget.whitetextstyle(22.0),
                              ),
                            ),
                          );
                          setState(() {
                            addresscontroller.text = "";
                            quantitycontroller.text = "";
                            selectedImage = null;
                          });
                        }
                      },
                      child: Center(
                        child: Material(
                          elevation: 3.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width / 1.5,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "Upload",
                                style: AppWidget.whitetextstyle(22.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
