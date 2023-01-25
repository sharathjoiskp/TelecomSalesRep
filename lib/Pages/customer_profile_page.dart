import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomerProfilePage extends StatefulWidget {
  CustomerProfilePage({Key? key, required this.documentId}) : super(key: key);
  var documentId;

  @override
  State<CustomerProfilePage> createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends State<CustomerProfilePage> {
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController organisationController = TextEditingController();

  TextEditingController websiteController = TextEditingController();
  TextEditingController whatsappNoController = TextEditingController();
  void editProfile() async {
    await FirebaseFirestore.instance
        .collection('userResponse')
        .doc('${widget.documentId}')
        .update({
      'customerName': customerNameController.text,
      'organisation': organisationController.text,
      'whatsappNo': whatsappNoController.text,
      'emailId': emailIdController.text,
      'website': websiteController.text,
    });

    Fluttertoast.showToast(msg: "Profile Updated");
    Navigator.pop(context, true);
  }

  void deleteProfile() async {
    await FirebaseFirestore.instance
        .collection('userResponse')
        .doc('${widget.documentId}')
        .delete();
    Navigator.pop(context, true);
    Fluttertoast.showToast(msg: "Profile Deleted");
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference customer =
        FirebaseFirestore.instance.collection('userResponse');

    return FutureBuilder<DocumentSnapshot>(
      future: customer.doc('${widget.documentId}').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Card(
              elevation: 15,
              child: Container(
                color: Colors.brown.shade400,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      rowData("Customer Name :", '${data['customerName']}'),
                      rowData("Sector :", '${data['sector']}'),
                      rowData("Organisation :", '${data['website']}'),
                      rowData("Email Id :", '${data['emailId']}'),
                      rowData("Phone Number :", '${data['contactNumber']} '),
                      rowData("Web Site :", '${data['website']}'),
                      rowData("Whatsapp Number :", '${data['whatsappNo']}'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SingleChildScrollView(
                                      child: Container(
                                        child: AlertDialog(
                                              backgroundColor: Colors.grey.shade600,
                                          content: Column(
                                            children: [
                                              TextField(
                                                controller:
                                                    customerNameController,
                                                decoration: InputDecoration(
                                                  labelText: 'Customer Name',
                                                  labelStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.white),
                                                maxLines: 1,
                                                minLines: 1,
                                              ),
                                              TextField(
                                                controller:
                                                    organisationController,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      'Organisation Name',
                                                  labelStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.white),
                                                maxLines: 1,
                                                minLines: 1,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              TextField(
                                                controller: emailIdController,
                                                decoration: InputDecoration(
                                                  labelText: 'Email Id',
                                                  labelStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.white),
                                                maxLines: 1,
                                                minLines: 1,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              TextField(
                                                controller:
                                                    whatsappNoController,
                                                decoration: InputDecoration(
                                                  labelText: 'Whats App Number',
                                                  labelStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.white),
                                                maxLines: 1,
                                                minLines: 1,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              TextField(
                                                controller: websiteController,
                                                decoration: InputDecoration(
                                                  labelText: 'Web site',
                                                  labelStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.white),
                                                maxLines: 1,
                                                minLines: 1,
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 0.5),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              width: 200,
                                              height: 50,
                                              child: ElevatedButton.icon(
                                                label: Text('Save'),
                                                icon: Icon(
                                                  Icons.save,
                                                  size: 24.0,
                                                ),
                                                onPressed: () {
                                                  editProfile();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary:
                                                      Colors.green.shade400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });

                           
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                              onPressed: () {
                                deleteProfile();
                              },
                              icon: Icon(Icons.delete))
                        ],
                      )
                    ],
                  ),
                ),
              ));
        }

        return Text("loading");
      },
    );
  }

  rowData(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }

  textfield(String label, var tcontroller) {
    return TextField(
      controller: tcontroller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white, fontSize: 15),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.white),
        ),
      ),
      style: TextStyle(fontSize: 25, color: Colors.white),
      maxLines: 1,
      minLines: 1,
    );
  }

}
