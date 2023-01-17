import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio_enes_ozmen/constants.dart';
import 'package:get/get.dart';
import 'package:portfolio_enes_ozmen/pages/doctor_page.dart';
import 'package:portfolio_enes_ozmen/pages/patient_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlueStarlight,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: kBlueStarlight,
          title: const Text("Hospital App", style: TextStyle(color: kBrilliantAzure)),
          elevation: 0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => Get.to(() => const DoctorPage()),
                  child: Column(
                    children: [
                      SvgPicture.asset("assets/doctor_white_coat.svg"),
                      const Text("Doctor Page", style: TextStyle(color: kIndigo, fontSize: 20))
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => Get.to(() => const PatientPage()),
                  child: Column(
                    children: [
                      SvgPicture.asset("assets/patient.svg"),
                      const Text("Patient Page", style: TextStyle(color: kIndigo, fontSize: 20))
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
