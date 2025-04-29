import 'package:flutter/material.dart';
import 'package:recycle_app/pages/upload_item.dart';
import 'package:recycle_app/services/shared_preferences.dart';
import 'package:recycle_app/services/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? id;

  getthesharedpref() async {
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Image.asset(
                      "images/wave.png",
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Hello, ',
                        style: AppWidget.healinetextstyle(24.0),
                      ),
                    ),
                    Text('User', style: AppWidget.greentextstyle(25.0)),
                    const Spacer(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "images/boy.jpg",
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30.0),
              Center(child: Image.asset("images/home.png")),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Categories",
                  style: AppWidget.healinetextstyle(22.0),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.only(left: 20.0),
                height: 130,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    UploadItem(category: "Plastic", id: id!),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFececf8),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.black45,
                                width: 2.0,
                              ),
                            ),
                            child: Image.asset(
                              "images/plastic.png",
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            "Plastic",
                            style: AppWidget.normaltextstyle(20.0),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFececf8),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.black45,
                              width: 2.0,
                            ),
                          ),
                          child: Image.asset(
                            "images/paper.png",
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text("Paper", style: AppWidget.normaltextstyle(20.0)),
                      ],
                    ),
                    const SizedBox(width: 20.0),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFececf8),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.black45,
                              width: 2.0,
                            ),
                          ),
                          child: Image.asset(
                            "images/battery.png",
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text("Battery", style: AppWidget.normaltextstyle(20.0)),
                      ],
                    ),
                    const SizedBox(width: 20.0),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFececf8),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.black45,
                              width: 2.0,
                            ),
                          ),
                          child: Image.asset(
                            "images/glass.png",
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text("Glass", style: AppWidget.normaltextstyle(20.0)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Pending Request",
                  style: AppWidget.healinetextstyle(22.0),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black45, width: 2.0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.green,
                          size: 30.0,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          "Main Market, Peshawar",
                          style: AppWidget.normaltextstyle(20.0),
                        ),
                      ],
                    ),
                    Divider(),
                    Image.asset(
                      "images/chips.png",
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}
