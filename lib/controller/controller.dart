import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/doctor_model.dart';

class Controller extends GetxController {
  @override
  void onInit() {
    days = [today.value, tomorrow.value, twoDaysLater.value].obs;
    super.onInit();
  }

  late RxList<DateTime> days;
  var dayIndex = 0.obs;
  Rx<DateTime> today = DateTime.now().obs;
  Rx<DateTime> tomorrow = DateTime.now().add(const Duration(days: 1)).obs;
  Rx<DateTime> twoDaysLater = DateTime.now().add(const Duration(days: 2)).obs;
  RxList<bool> isActiveChipStateList = List<bool>.generate(7, (int index) => false).obs;

  List<DoctorModel> doctors = [
    DoctorModel(
        name: "Prof. Dr. Bruno Fernandes",
        job: "Neurologist",
        doctorImage: const AssetImage("assets/doctor1.jpg")),
    DoctorModel(
        name: "Samet Altınay",
        job: "Brain Surgeon",
        doctorImage: const AssetImage("assets/doctor2.jpg")),
    DoctorModel(
        name: "Nefer Pitou",
        job: "General Surgeon",
        doctorImage: const AssetImage("assets/doctor3.jpg")),
    DoctorModel(
        name: "Yusuf Söyleyici",
        job: "Internal Medicine",
        doctorImage: const AssetImage("assets/doctor4.jpg")),
    DoctorModel(
        name: "Christopher Eccleston",
        job: "The Doctor",
        doctorImage: const AssetImage("assets/doctor5.jpg")),
    DoctorModel(
        name: "Senkuu White",
        job: "Psychiatry",
        doctorImage: const AssetImage("assets/doctor6.jpg")),
    DoctorModel(
        name: "Kenzo Tenma",
        job: "Brain Surgeon",
        doctorImage: const AssetImage("assets/doctor7.jpg")),
    DoctorModel(
        name: "Assoc. Prof. Dr. Midoriya İzuku",
        job: "Brain Surgeon",
        doctorImage: const AssetImage("assets/doctor8.jpg")),
    DoctorModel(
        name: "Levent Atahanlı",
        job: "Brain Surgeon",
        doctorImage: const AssetImage("assets/doctor9.jpg")),
    DoctorModel(
        name: "Lev Haiba",
        job: "Brain Surgeon",
        doctorImage: const AssetImage("assets/doctor10.jpg")),
    DoctorModel(
        name: "Robin Van Persie",
        job: "Orthopedist",
        doctorImage: const AssetImage("assets/doctor11.jpg")),
    DoctorModel(
        name: "Tsubasa Hyuga",
        job: "Orthopedist",
        doctorImage: const AssetImage("assets/doctor12.jpg")),
  ];
  RxList doctorSectionList = [].obs;
  decrement() {
    dayIndex.value == 0 ? null : dayIndex--;
  }

  increment() {
    dayIndex.value == days.length - 1 ? null : dayIndex.value++;
  }

  actionChipPressedFunction({required String job, required int chipNumber}) {
    for (var i = 0; i < isActiveChipStateList.length; i++) {
      if (isActiveChipStateList[chipNumber] == false) {
        i == chipNumber
            ? isActiveChipStateList[chipNumber] = true
            : isActiveChipStateList[i] = false;
        doctorSectionList.clear();
      } else {
        isActiveChipStateList[i] = false;
      }
    }
    isActiveChipStateList[chipNumber]
        ? doctors.map((e) {
            e.job == job ? doctorSectionList.add(e) : null;
          }).toList()
        : doctorSectionList.removeWhere((element) => element.job == job);
  }
}
