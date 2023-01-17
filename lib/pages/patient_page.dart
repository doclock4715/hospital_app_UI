import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_enes_ozmen/components/screens_appbar.dart';
import 'package:portfolio_enes_ozmen/constants.dart';
import 'package:portfolio_enes_ozmen/controller/controller.dart';
import 'package:portfolio_enes_ozmen/model/doctor_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
/*   List<DoctorModel> doctorSectionList = []; */

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());

    return Scaffold(
      backgroundColor: kBlueStarlight,
      appBar: const ScreensAppBarr(title: "Patient Appointment Screen"),
      body: Column(
        children: [
          //1.PArt
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Obx(
              () => Wrap(
                spacing: 10,
                children: [
                  ActionChip(
                    label: const Text("Neurologist"),
                    backgroundColor:
                        controller.isActiveChipStateList[0] ? kWater : Colors.grey.shade300,
                    onPressed: () {
                      controller.actionChipPressedFunction(job: "Neurologist", chipNumber: 0);
                    },
                  ),
                  ActionChip(
                    label: const Text("Brain Surgeon"),
                    backgroundColor:
                        controller.isActiveChipStateList[1] ? kWater : Colors.grey.shade300,
                    onPressed: () {
                      controller.actionChipPressedFunction(job: "Brain Surgeon", chipNumber: 1);
                    },
                  ),
                  ActionChip(
                    label: const Text("General Surgeon"),
                    backgroundColor:
                        controller.isActiveChipStateList[2] ? kWater : Colors.grey.shade300,
                    onPressed: () {
                      controller.actionChipPressedFunction(job: "General Surgeon", chipNumber: 2);
                    },
                  ),
                  ActionChip(
                    label: const Text("Internal Medicine"),
                    backgroundColor:
                        controller.isActiveChipStateList[3] ? kWater : Colors.grey.shade300,
                    onPressed: () {
                      controller.actionChipPressedFunction(job: "Internal Medicine", chipNumber: 3);
                    },
                  ),
                  ActionChip(
                    label: const Text("The Doctor"),
                    backgroundColor:
                        controller.isActiveChipStateList[4] ? kWater : Colors.grey.shade300,
                    onPressed: () {
                      controller.actionChipPressedFunction(job: "The Doctor", chipNumber: 4);
                    },
                  ),
                  ActionChip(
                    label: const Text("Psychiatry"),
                    backgroundColor:
                        controller.isActiveChipStateList[5] ? kWater : Colors.grey.shade300,
                    onPressed: () {
                      controller.actionChipPressedFunction(job: "Psychiatry", chipNumber: 5);
                    },
                  ),
                  ActionChip(
                    label: const Text("Orthopedist"),
                    backgroundColor:
                        controller.isActiveChipStateList[6] ? kWater : Colors.grey.shade300,
                    onPressed: () {
                      controller.actionChipPressedFunction(job: "Orthopedist", chipNumber: 6);
                    },
                  ),
                ],
              ),
            ),
          ),
          //2.PArt
          const SizedBox(
            height: 10,
          ),
          //2.PArt
          Expanded(
            child: Obx(
              () => controller.doctorSectionList.isEmpty
                  ? Column(
                      children: [
                        Container(child: Lottie.asset('assets/LottieLogo1.json')),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            "You can choose a section to see doctors and make an appointment.",
                            style: TextStyle(fontSize: 28, color: Colors.grey),
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: controller.doctorSectionList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: kWater,
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                margin: const EdgeInsets.only(right: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    //doctormodeldan gelmelli
                                    image: controller.doctorSectionList[index].doctorImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /*   FittedBox(
                          //With FittedBox widget we forced to text to decrase its fontSize 
                          //to fit in the given area. According to the wishes, we can make font
                          //size smaller or we can make 2 lines of text ("maxLines:2")
                            fit: BoxFit.cover,
                            child: Text(
                              doctors[index].name,
                              style: kMaastrichtBlueTextStyle.copyWith(fontSize: 23),
                            ),
                          ), */
                                  Text(
                                    controller.doctorSectionList[index].name,
                                    style: kMaastrichtBlueTextStyle23,
                                  ),
                                  Text(
                                    controller.doctorSectionList[index].job,
                                    style: kMaastrichtBlueTextStyle20,
                                  ),
                                  const SizedBox(height: 10),
                                  MakeAppointmentButton(
                                    doctor: controller.doctorSectionList[index],
                                  )
                                ],
                              )),
                              Column(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        launchUrl(Uri(
                                            scheme: 'tel',
                                            path:
                                                "+5325325325" //phone number can be change with setting variable to the doctor model.
                                            ));
                                      },
                                      icon: const Icon(
                                        Icons.call,
                                        color: Colors.green,
                                      )),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.message,
                                        color: Colors.orange[800],
                                      )),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
            ),
          )
        ],
      ),
    );
  }
}

class MakeAppointmentButton extends StatelessWidget {
  const MakeAppointmentButton({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          barrierColor: Colors.black12.withOpacity(0.6), // Background color
          barrierLabel: 'Appointment Calendar Screen',
          builder: (context) {
            return AlertDialog(
              insetPadding: const EdgeInsets.all(0),
              titlePadding: const EdgeInsets.all(0),
              backgroundColor: Colors.black12.withOpacity(0.6),
              title: Container(
                decoration:
                    BoxDecoration(color: kBlueStarlight, borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.only(top: 16),
                height: 300,
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          controller.decrement();
                        },
                        icon: const Icon(Icons.arrow_back)),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Obx(() => Text(
                                  "${controller.days[controller.dayIndex.value].day}/${controller.days[controller.dayIndex.value].month}/${controller.days[controller.dayIndex.value].year}",
                                  style: const TextStyle(fontSize: 23),
                                )),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Obx(
                                () => AppointmentCalendar(
                                  doctor: doctor,
                                  day:
                                      "${controller.days[controller.dayIndex.value].day}/${controller.days[controller.dayIndex.value].month}/${controller.days[controller.dayIndex.value].year}",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          controller.increment();
                        },
                        icon: const Icon(Icons.arrow_forward)),
                  ],
                ),
              ),
            );
          },
        ).then((value) {
          //.then code just used for I want to show today's date everytime, when the make appointment calendar is open.
          //Therefore, when the dialog is closed, I always make the value 0 again. Thus, Today's date will be showed first.
          Future.delayed(const Duration(milliseconds: 500))
              .then((value) => controller.dayIndex.value = 0);
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: kBrilliantAzure,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text("Make an appointment"),
    );
  }
}

class AppointmentCalendar extends StatelessWidget {
  const AppointmentCalendar({
    Key? key,
    required this.doctor,
    required this.day,
  }) : super(key: key);

  final DoctorModel doctor;
  final String day;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 10,
      columns: [
        //Chip background color will change according the coming API data. When there is appointment on 9:00, that ActionChip's background color will be green.
        buildDataColumn(
          bgColor: kWater,
          label: const Text("9:00"),
          onPressed: () {
            buildAppointmentApprovalFunction(context: context, time: "9:00");
          },
        ),
        buildDataColumn(
          label: const Text("10:00"),
        ),
        buildDataColumn(
          bgColor: kWater,
          label: const Text("11:00"),
          onPressed: () {
            buildAppointmentApprovalFunction(context: context, time: "11:00");
          },
        ),
        buildDataColumn(
          bgColor: kWater,
          label: const Text("12:00"),
          onPressed: () {
            buildAppointmentApprovalFunction(context: context, time: "12:00");
          },
        ),
        buildDataColumn(
          label: const Text("13:00"),
        ),
        buildDataColumn(
          bgColor: kWater,
          label: const Text("14:00"),
          onPressed: () {
            buildAppointmentApprovalFunction(context: context, time: "14:00");
          },
        ),
        buildDataColumn(
          bgColor: kWater,
          label: const Text("15:00"),
          onPressed: () {
            buildAppointmentApprovalFunction(context: context, time: "15:00");
          },
        ),
        buildDataColumn(
          label: const Text("16:00"),
        ),
      ],
      rows: [
        DataRow(cells: [
          buildDataCell(
            label: const Text("9:15"),
            bgColor: kWater,
            onPressed: () {
              buildAppointmentApprovalFunction(context: context, time: "9:15");
            },
          ),
          buildDataCell(
            label: const Text("10:15"),
            bgColor: kWater,
            onPressed: () {
              buildAppointmentApprovalFunction(context: context, time: "10:15");
            },
          ),
          buildDataCell(
            label: const Text("11:15"),
          ),
          buildDataCell(
            label: const Text("12:15"),
          ),
          buildDataCell(
            label: const Text("13:15"),
          ),
          buildDataCell(
            label: const Text("14:15"),
            bgColor: kWater,
            onPressed: () {
              buildAppointmentApprovalFunction(context: context, time: "14:15");
            },
          ),
          buildDataCell(
            label: const Text("15:15"),
          ),
          buildDataCell(
            label: const Text("16:15"),
          ),
        ]),
        DataRow(cells: [
          buildDataCell(
            label: const Text("9:30"),
          ),
          buildDataCell(
            label: const Text("10:30"),
          ),
          buildDataCell(
            label: const Text("11:30"),
            bgColor: kWater,
            onPressed: () {
              buildAppointmentApprovalFunction(context: context, time: "11:30");
            },
          ),
          buildDataCell(
            label: const Text("12:30"),
            bgColor: kWater,
            onPressed: () {
              buildAppointmentApprovalFunction(context: context, time: "12:30");
            },
          ),
          buildDataCell(
            label: const Text("13:30"),
          ),
          buildDataCell(
            label: const Text("14:30"),
          ),
          buildDataCell(
            label: const Text("15:30"),
          ),
          buildDataCell(
            label: const Text("16:30"),
            bgColor: kWater,
            onPressed: () {
              buildAppointmentApprovalFunction(context: context, time: "16:30");
            },
          )
        ]),
        DataRow(
          cells: <DataCell>[
            buildDataCell(
              label: const Text("9:45"),
            ),
            buildDataCell(
              label: const Text("10:45"),
              bgColor: kWater,
              onPressed: () {
                buildAppointmentApprovalFunction(context: context, time: "10:45");
              },
            ),
            buildDataCell(
              label: const Text("11:45"),
            ),
            buildDataCell(
              label: const Text("12:45"),
            ),
            buildDataCell(
              label: const Text("13:45"),
            ),
            buildDataCell(
              label: const Text("14:45"),
              bgColor: kWater,
              onPressed: () {
                buildAppointmentApprovalFunction(context: context, time: "14:45");
              },
            ),
            buildDataCell(
              label: const Text("15:45"),
              bgColor: kWater,
              onPressed: () {
                buildAppointmentApprovalFunction(context: context, time: "15:45");
              },
            ),
            buildDataCell(
              label: const Text("16:45"),
            ),
          ],
        ),
      ],
    );
  }

  Future<dynamic> buildAppointmentApprovalFunction(
      {required BuildContext context, required String time}) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        //rc30 can be given.
        title: Text("Appointment in $time"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Patient: Rocky Balboa", style: kMaastrichtBlueTextStyle20),
            const SizedBox(
              height: 5,
            ),
            Text("Doctor: ${doctor.name}", style: kMaastrichtBlueTextStyle20),
            const SizedBox(
              height: 10,
            ),
            const Text("Are you sure you want to set an appointment?",
                style: TextStyle(color: kMaastrichtBlue, fontSize: 16))
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.back();
              buildAppointmentConfirmedFunction(context: context, time: time, day: day);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<dynamic> buildAppointmentConfirmedFunction(
      {required BuildContext context, required String time, required String day}) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 5),
        backgroundColor: kBlueStarlight,
        title: const Icon(
          Icons.check,
          size: 100,
          color: Colors.green,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Your appointment set successfully.",
              style: kMaastrichtBlueTextStyle23,
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(
                Icons.calendar_month_outlined,
                size: 36,
              ),
              title: Text("Doctor: ${doctor.name}"),
              subtitle: Text('Time: $time on $day'),
              isThreeLine: true,
            ),
          ],
        ),
      ),
    );
  }
}

DataColumn buildDataColumn({Color? bgColor, required Widget label, VoidCallback? onPressed}) {
  return DataColumn(
    label: Expanded(
      child: ActionChip(
        backgroundColor: bgColor ?? Colors.grey[250],
        label: label,
        onPressed: onPressed,
        disabledColor: Colors.grey[350],
      ),
    ),
  );
}

DataCell buildDataCell({Color? bgColor, required Widget label, VoidCallback? onPressed}) {
  return DataCell(
    ActionChip(
      backgroundColor: bgColor ?? Colors.grey[250],
      label: label,
      onPressed: onPressed,
      disabledColor: Colors.grey[350],
    ),
  );
}
