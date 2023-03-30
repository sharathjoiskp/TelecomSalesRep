import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:tsr_management/componet_design/appbar.dart';

import '../DatabaseManager/database.dart';

class EmployeProfile extends StatefulWidget {
  const EmployeProfile({super.key});

  @override
  State<EmployeProfile> createState() => _EmployeProfileState();
}

class _EmployeProfileState extends State<EmployeProfile> {
  String uid = '';
  var _date = DateTime.now();
  void initState() {
    getuid();
    super.initState();
  }

  getuid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User user = await auth.currentUser!;
    setState(() {
      uid = user.uid;
    });
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((value) {
      setState(() {
        _date = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var Stream = FirebaseFirestore.instance
        .collection('USER_RESPONSE')
        .doc(uid)
        .collection('userResponse')
        .where('date', isEqualTo: "3/24/2023");

    CollectionReference employee =
        FirebaseFirestore.instance.collection('USER_RESPONSE');

    return Scaffold(
      appBar: appbarDesign(title: 'Profile'),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: employee.doc(uid).get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }

                  if (snapshot.hasData && !snapshot.data!.exists) {
                    return Column(
                      children: [
                        Text(
                          "Profile does not exist",
                          style: GoogleFonts.lato(fontSize: 20),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 25, bottom: 35),
                          child: Text(
                            "Profile will be created automatically then you start making calls ,when onwards you can edit it",
                            style: GoogleFonts.lato(fontSize: 15),
                          ),
                        ),
                      ],
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Positioned(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              width: 400,
                              height: 200,
                              color: Colors.black12,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 50.0, top: 50),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${data['employeeName']}',
                                        style: GoogleFonts.lato(fontSize: 25),
                                      ),
                                      Text(
                                        '${data['number']}',
                                        style: GoogleFonts.lato(fontSize: 20),
                                      ),
                                      Text(
                                        '${data['branch']}',
                                        style: GoogleFonts.lato(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            child: CustomPaint(
                              size: Size(400.0, 200.0),
                              painter: RPSCustomPainter(),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height / 6,
                            left: MediaQuery.of(context).size.width / 1.2,
                            child: IconButton(
                                onPressed: () {
                                  editProfile(uid);
                                },
                                icon: Icon(Icons.edit)),
                          ),
                          Positioned(
                            width: 120,
                            height: 120,
                            top: 30,
                            left: 50,
                            child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('images/profile.jpeg')),
                          ),
                        ],
                      ),
                    );
                  }
                  return Text("loading....");
                }),
            Container(
              child: ListTile(
                leading: Text(
                  'Number of calls on :',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                title: Text(
                  DateFormat.yMd().format(_date) + '   (Click here to change)',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.calendar_today),
                onTap: _showDatePicker,
              ),
            ),
            Container(
              color: Colors.indigo.shade100,
              width: MediaQuery.of(context).size.width / 1.3,
              child: FutureBuilder(
                  future: countDoc(uid, _date),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.connectionState ==
                            ConnectionState.done ||
                        snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else if (snapshot.hasData) {
                        List<dynamic> data = snapshot.data! as List<dynamic>;
                        return Card(
                          child: Column(
                            children: [
                              Label_Data(
                                  icon: Icon(
                                    Icons.android,
                                  ),
                                  label: 'App',
                                  data: '${data[1]}'),
                              Label_Data(
                                icon: Icon(
                                  Icons.web,
                                ),
                                label: 'Web',
                                data: '${data[0]}',
                              ),
                              Label_Data(
                                icon: Icon(
                                  Icons.shop,
                                ),
                                label: 'Digital Marketing',
                                data: '${data[2]}',
                              ),
                              Label_Data(
                                icon: Icon(
                                  Icons.settings_applications,
                                ),
                                label: 'Web And App',
                                data: '${data[4]}',
                              ),
                              Label_Data(
                                icon: Icon(
                                  Icons.ac_unit,
                                ),
                                label: 'Web And Dm',
                                data: '${data[3]}',
                              ),
                              Label_Data(
                                icon: Icon(
                                  Icons.webhook,
                                ),
                                label: 'App And Dm',
                                data: '${data[5]}',
                              ),
                              Label_Data(
                                icon: Icon(
                                  Icons.account_box,
                                ),
                                label: 'Profile sent',
                                data: '${data[6]}',
                              ),
                              Label_Data(
                                icon: Icon(
                                  Icons.call,
                                ),
                                label: 'Call Later',
                                data: '${data[7]}',
                              ),
                              Label_Data(
                                icon: Icon(
                                  Icons.not_interested,
                                ),
                                label: 'Not Intersted',
                                data: '${data[8]}',
                              ),
                              Container(color: Colors.black, height: 0.5),
                              Label_Data(
                                icon: Icon(
                                  Icons.summarize,
                                ),
                                label: 'Total',
                                data: '${data[9]}',
                              ),
                            ],
                          ),
                        );
                      }
                    } else {
                      return Text('Something Went wrong');
                    }
                    return Text('loading');
                  }),
            ),
          ],
        ),
      )),
    );
  }
}

editProfile(uid) {
  TextEditingController nameController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  return Get.defaultDialog(
      title: 'Edit Your Profile',
      content: Column(
        children: [
          TextFormField(
            maxLines: 1,
            style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w500,
                letterSpacing: 4),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.name,
            controller: nameController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 5)),
                hintText: 'Full Name',
                hintStyle: TextStyle(fontSize: 15)),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            maxLines: 1,
            style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w500,
                letterSpacing: 4),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.name,
            controller: branchController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 5)),
                hintText: 'Branch',
                hintStyle: TextStyle(fontSize: 15)),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            maxLength: 10,
            maxLines: 1,
            style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w500,
                letterSpacing: 4),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.phone,
            controller: phonenumberController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 5)),
                hintText: 'Phone Number',
                hintStyle: TextStyle(fontSize: 15)),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              nameController.text.isEmpty ||
                      branchController.text.isEmpty ||
                      phonenumberController.text.isEmpty
                  ? Fluttertoast.showToast(
                      msg: "Please fill all fields",
                      backgroundColor: Colors.redAccent,
                      fontSize: 18)
                  : editEmployeeProfile(uid,nameController.text,
                      branchController.text, phonenumberController.text,);
            },
            child: Text("Save"))
      ]);
}

class Label_Data extends StatelessWidget {
  Label_Data({
    super.key,
    required this.label,
    required this.data,
    required this.icon,
  });
  String label;
  String data;
  Icon icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7, left: 30, right: 15, top: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          icon,
          Text(
            label,
            style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            data,
            style: TextStyle(
                color: Colors.blue, fontSize: 14, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}

Future<List<dynamic>> countDoc(String uid, DateTime date) async {
  int countWeb = 0;
  int countApp = 0;
  int countDm = 0;
  int countWebnDm = 0;
  int countWebnApp = 0;
  int countAppnDm = 0;
  int countProfile = 0;
  int countCallLater = 0;
  int countNotIntersted = 0;
  int countTotal = 0;
  String todaydate = DateFormat.yMd().format(date);

  await FirebaseFirestore.instance
      .collection('USER_RESPONSE')
      .doc(uid)
      .collection('userResponse')
      .where('date', isEqualTo: todaydate)
      .where('sector', isEqualTo: 'Web')
      .get()
      .then((QuerySnapshot querySnapshot) {
    countWeb = querySnapshot.docs.length;
  });
  await FirebaseFirestore.instance
      .collection('USER_RESPONSE')
      .doc(uid)
      .collection('userResponse')
      .where('date', isEqualTo: todaydate)
      .where('sector', isEqualTo: 'App')
      .get()
      .then((QuerySnapshot querySnapshot) {
    countApp = querySnapshot.docs.length;
  });

  await FirebaseFirestore.instance
      .collection('USER_RESPONSE')
      .doc(uid)
      .collection('userResponse')
      .where('date', isEqualTo: todaydate)
      .where('sector', isEqualTo: 'Digital Marketing')
      .get()
      .then((QuerySnapshot querySnapshot) {
    countDm = querySnapshot.docs.length;
  });
  await FirebaseFirestore.instance
      .collection('USER_RESPONSE')
      .doc(uid)
      .collection('userResponse')
      .where('date', isEqualTo: todaydate)
      .where('sector', isEqualTo: 'Web and Digital Marketing')
      .get()
      .then((QuerySnapshot querySnapshot) {
    countWebnDm = querySnapshot.docs.length;
  });
  await FirebaseFirestore.instance
      .collection('USER_RESPONSE')
      .doc(uid)
      .collection('userResponse')
      .where('date', isEqualTo: todaydate)
      .where('sector', isEqualTo: 'Web and App')
      .get()
      .then((QuerySnapshot querySnapshot) {
    countWebnApp = querySnapshot.docs.length;
  });

  await FirebaseFirestore.instance
      .collection('USER_RESPONSE')
      .doc(uid)
      .collection('userResponse')
      .where('date', isEqualTo: todaydate)
      .where('sector', isEqualTo: 'App and Digital Marketing')
      .get()
      .then((QuerySnapshot querySnapshot) {
    countAppnDm = querySnapshot.docs.length;
  });

  await FirebaseFirestore.instance
      .collection('USER_RESPONSE')
      .doc(uid)
      .collection('userResponse')
      .where('date', isEqualTo: todaydate)
      .where('sector', isEqualTo: 'Profile Sent')
      .get()
      .then((QuerySnapshot querySnapshot) {
    countProfile = querySnapshot.docs.length;
  });
  await FirebaseFirestore.instance
      .collection('USER_RESPONSE')
      .doc(uid)
      .collection('userResponse')
      .where('date', isEqualTo: todaydate)
      .where('sector', isEqualTo: 'Call Later')
      .get()
      .then((QuerySnapshot querySnapshot) {
    countCallLater = querySnapshot.docs.length;
  });
  await FirebaseFirestore.instance
      .collection('USER_RESPONSE')
      .doc(uid)
      .collection('userResponse')
      .where('date', isEqualTo: todaydate)
      .where('sector', isEqualTo: 'Not Intersted')
      .get()
      .then((QuerySnapshot querySnapshot) {
    countNotIntersted = querySnapshot.docs.length;
  });
  await FirebaseFirestore.instance
      .collection('USER_RESPONSE')
      .doc(uid)
      .collection('userResponse')
      .where('date', isEqualTo: todaydate)
      .get()
      .then((QuerySnapshot querySnapshot) {
    countTotal = querySnapshot.docs.length;
  });
  return [
    countWeb,
    countApp,
    countDm,
    countWebnDm,
    countWebnApp,
    countAppnDm,
    countProfile,
    countCallLater,
    countNotIntersted,
    countTotal,
  ];
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = Colors.indigoAccent
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path0 = Path();
    path0.moveTo(199.57, 199.38);
    path0.quadraticBezierTo(44.64, 117.64, 97.8, 21.78);
    path0.quadraticBezierTo(91.32, -1.28, 0.04, -0.18);
    path0.lineTo(-0.96, 198.38);
    path0.lineTo(199.57, 199.38);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
