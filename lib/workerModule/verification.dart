import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workers_inn/workerModule/WorkerMainPage.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final ImagePicker _picker = ImagePicker();
  XFile? profile, frontCnic, backCnic;
  @override
  Widget build(BuildContext context) {
    Size screenSIze = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: screenSIze.height,
        child: Stack(
          children: [
            SizedBox(
              //height: MediaQuery.of(context).size.height * 0.183,
              child: Image.asset(
                "assets/banner2.png",
                height: MediaQuery.of(context).size.height * 0.4,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              top: screenSIze.height * 0.3,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: screenSIze.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    profile == null
                        ? const Text(
                            "",
                          )
                        : const Text(
                            "profile upload done",
                          ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange),
                      onPressed: () async {
                        profile =
                            await _picker.pickImage(source: ImageSource.camera);
                        setState(() {});
                      },
                      child: const Text('Take Photo for Profile'),
                    ),
                    frontCnic == null
                        ? const Text(
                            "",
                          )
                        : const Text(
                            "Cnic upload done",
                          ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange),
                      onPressed: () async {
                        frontCnic =
                            await _picker.pickImage(source: ImageSource.camera);
                        setState(() {});
                      },
                      child:
                          const Text('Take Photo of Front side of your Cnic'),
                    ),
                    backCnic == null
                        ? const Text(
                            "",
                          )
                        : const Text(
                            "Cnic upload done",
                          ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange),
                      onPressed: () async {
                        backCnic =
                            await _picker.pickImage(source: ImageSource.camera);
                        setState(() {});
                      },
                      child: const Text('Take Photo of Back side of your Cnic'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const WorkerMainPage()));
                      },
                      child: const Text('Submit Data'),
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
