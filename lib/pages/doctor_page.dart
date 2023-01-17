import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_enes_ozmen/components/action_chip.dart';
import 'package:portfolio_enes_ozmen/components/screens_appbar.dart';
import 'package:portfolio_enes_ozmen/constants.dart';
import 'package:portfolio_enes_ozmen/controller/controller.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({super.key});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());
    return Scaffold(
      backgroundColor: kBlueStarlight,
      appBar: const ScreensAppBarr(title: "Doctor Calendar"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DoctorProfile(),
            const SizedBox(height: 15),
            Expanded(
              child: Calendar(
                  today: controller.today.value,
                  tomorrow: controller.tomorrow.value,
                  twoDaysLater: controller.twoDaysLater.value),
            ),
            const SizedBox(height: 10),
            const CurrentPatient()
          ],
        ),
      ),
    );
  }
}

class Calendar extends StatelessWidget {
  const Calendar({
    Key? key,
    required this.today,
    required this.tomorrow,
    required this.twoDaysLater,
  }) : super(key: key);

  final DateTime today;
  final DateTime tomorrow;
  final DateTime twoDaysLater;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      //We can delete ClipRRect if we want. I just want to make list view scrolling experience better.
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 3, color: kWater),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            buildDayCalendar(
                context: context, day: "${today.day}/${today.month}/${today.year}", current: true),
            const SizedBox(height: 20),
            buildDayCalendar(
                context: context,
                day: "${tomorrow.day}/${tomorrow.month}/${tomorrow.year}",
                current: false),
            const SizedBox(height: 20),
            buildDayCalendar(
                context: context,
                day: "${twoDaysLater.day}/${twoDaysLater.month}/${twoDaysLater.year}",
                current: false),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class CurrentPatient extends StatelessWidget {
  const CurrentPatient({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: buildRoundedCircular30BoxDecoration(),
      child: Column(
        children: [
          const Text("Current Patient - 11:15", style: kMaastrichtBlueTextStyle23),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundColor: kBrilliantAzure,
                radius: 50,
                child: CircleAvatar(foregroundImage: AssetImage("assets/patient1.jpg"), radius: 45),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Johan Liebert",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: kMaastrichtBlueTextStyle23),
                      SizedBox(height: 10),
                      Text(
                        "Psychological disorders",
                        style: TextStyle(color: kMaastrichtBlue, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
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
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kBrilliantAzure,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
                  ),
                  child: const Text("Finish Earlier"),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kBrilliantAzure,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
                  ),
                  child: const Text("Add 15 Min"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

Container buildDayCalendar(
    {required BuildContext context, required String day, required bool current}) {
  return Container(
    child: Column(
      children: [
        Text(day, style: const TextStyle(fontSize: 20)),
        Theme(
          //this widget is used to remove divider. If we want to add divider and change its color, we can do that kind of things.
          data: Theme.of(context).copyWith(dividerColor: kBlueStarlight),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 30,
              columns: [
                //Chip background color will change according the coming API data. When there is appointment on 9:00, that ActionChip's background color will be green.
                buildDataColumn(
                  label: "9:00",
                ),
                buildDataColumn(
                    bgColor: kWater,
                    label: "10:00",
                    onPressed: () {
                      buildAppointmentInfo(time: "10:00");
                    }),
                buildDataColumn(label: "11:00"),
                buildDataColumn(label: "12:00"),
                buildDataColumn(label: "13:00"),
                buildDataColumn(label: "14:00"),
                buildDataColumn(label: "15:00"),
                buildDataColumn(
                    bgColor: kWater,
                    label: "16:00",
                    onPressed: () {
                      buildAppointmentInfo(time: "16:00");
                    }),
              ],
              rows: [
                DataRow(cells: [
                  buildDataCell(label: "9:15"),
                  buildDataCell(label: "10:15"),
                  buildDataCell(
                      label: "11:15",
                      bgColor: current ? Colors.green.shade400 : kWater,
                      onPressed: () {
                        buildAppointmentInfo(time: "11:15");
                      }),
                  buildDataCell(
                      label: "12:15",
                      bgColor: kWater,
                      onPressed: () {
                        buildAppointmentInfo(time: "12:15");
                      }),
                  buildDataCell(label: "13:15"),
                  buildDataCell(label: "14:15"),
                  buildDataCell(
                      label: "15:15",
                      bgColor: kWater,
                      onPressed: () {
                        buildAppointmentInfo(time: "15:15");
                      }),
                  buildDataCell(
                      label: "16:15",
                      bgColor: kWater,
                      onPressed: () {
                        buildAppointmentInfo(time: "16:15");
                      }),
                ]),
                DataRow(cells: [
                  buildDataCell(
                      label: "9:30",
                      bgColor: kWater,
                      onPressed: () {
                        buildAppointmentInfo(time: "9:30");
                      }),
                  buildDataCell(
                      label: "10:30",
                      bgColor: kWater,
                      onPressed: () {
                        buildAppointmentInfo(time: "10:30");
                      }),
                  buildDataCell(label: "11:30"),
                  buildDataCell(label: "12:30"),
                  buildDataCell(label: "13:30"),
                  buildDataCell(
                      label: "14:30",
                      bgColor: kWater,
                      onPressed: () {
                        buildAppointmentInfo(time: "14:30");
                      }),
                  buildDataCell(
                      label: "15:30",
                      bgColor: kWater,
                      onPressed: () {
                        buildAppointmentInfo(time: "15:30");
                      }),
                  buildDataCell(label: "16:30")
                ]),
                DataRow(
                  cells: <DataCell>[
                    buildDataCell(
                        label: "9:45",
                        bgColor: kWater,
                        onPressed: () {
                          buildAppointmentInfo(time: "9:45");
                        }),
                    buildDataCell(label: "10:45"),
                    buildDataCell(
                        label: "11:45",
                        bgColor: kWater,
                        onPressed: () {
                          buildAppointmentInfo(time: "11:45");
                        }),
                    buildDataCell(
                        label: "12:45",
                        bgColor: kWater,
                        onPressed: () {
                          buildAppointmentInfo(time: "12:45");
                        }),
                    buildDataCell(label: "13:45"),
                    buildDataCell(label: "14:45"),
                    buildDataCell(label: "15:45"),
                    buildDataCell(
                        label: "16:45",
                        bgColor: kWater,
                        onPressed: () {
                          buildAppointmentInfo(time: "16:45");
                        }),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

buildAppointmentInfo({required String time /*, required String title */}) {
  return Get.defaultDialog(
    content: Column(
      children: [
        const CircleAvatar(backgroundImage: AssetImage("assets/patient1.jpg"), radius: 45),
        const SizedBox(height: 10),
        Text("Appointment Time: $time"),
        const SizedBox(height: 10),
        const Text("The patient has indicated that he had severe psychological trauma.")
      ],
    ),
/*    title can change according to the API data.
      title : title */
    title: "Johan Liebert",
    cancel: ElevatedButton(
      onPressed: () {
        //New screen will open with the all medical history of the patient.
        Get.back();
      },
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
          backgroundColor: kBrilliantAzure),
      child: Row(
        children: const [
          Icon(Icons.arrow_forward_ios_sharp),
          SizedBox(width: 15),
          Text("Patient Medical History"),
        ],
      ),
    ),
    confirm: ElevatedButton(
      onPressed: () {
        //Appointment cancel function will be added here.
        Get.back();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
      ),
      child: Row(
        children: const [
          Icon(Icons.cancel_outlined),
          SizedBox(width: 15),
          Text("Cancel The Appointment"),
        ],
      ),
    ),
  );
}

DataColumn buildDataColumn({Color? bgColor, required String label, VoidCallback? onPressed}) {
  return DataColumn(
    label: Expanded(
      child: TimeActionChip(
        bgColor: bgColor,
        label: label,
        onPressed: onPressed,
      ),
    ),
  );
}

DataCell buildDataCell({Color? bgColor, required String label, VoidCallback? onPressed}) {
  return DataCell(
    TimeActionChip(
      bgColor: bgColor,
      label: label,
      onPressed: onPressed,
    ),
  );
}

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: buildRoundedCircular30BoxDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundColor: kWater, //We can change the color to add a border.
            radius: 50,
            child: CircleAvatar(foregroundImage: AssetImage("assets/doctor1.jpg"), radius: 45),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Bruno Rodrigues",
                    maxLines: 6,
                    style: kMaastrichtBlueTextStyle23,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Neurologist",
                    style: kMaastrichtBlueTextStyle20,
                  )
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.dehaze_outlined,
              color: kMaastrichtBlue,
            ),
            onPressed: () {
              showDialog(
                barrierDismissible: false, // Preventing outside click to close.
                context: context,
                builder: (context) => AlertDialog(
                  contentPadding: const EdgeInsets.fromLTRB(12, 12, 12,
                      5), //To make check button more closer to the content. Also For better looking, I changed other padding values.
                  backgroundColor: kBlueStarlight,
                  title: const Center(child: Text("Adjusting The Profile")),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 45,
                            backgroundImage: AssetImage("assets/doctor1.jpg"),
                          ),
                          IconButton(
                              onPressed: () {
                                //Image change screen will be open.
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: kBlueStarlight,
                              )),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        onTap: () {
                          //Name change pop up will open.
                        },
                        title: const Text(
                          "Name: Bruno Rodrigues",
                          style: TextStyle(color: kMaastrichtBlue),
                        ),
                        trailing: const Icon(
                          Icons.edit,
                          color: kMaastrichtBlue,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        onTap: () {
                          //Job change pop up will open
                        },
                        title: const Text(
                          "Job: Neurologist",
                          style: TextStyle(color: kMaastrichtBlue),
                        ),
                        trailing: const Icon(
                          Icons.edit,
                          color: kMaastrichtBlue,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.check,
                          color: Colors.green,
                        ))
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

BoxDecoration buildRoundedCircular30BoxDecoration() {
  return const BoxDecoration(
      color: kWater,
      borderRadius: BorderRadius.all(
        Radius.circular(30),
      ),
      boxShadow: [
        BoxShadow(
          color: kBrilliantAzure,
          blurRadius: 1,
        )
      ]);
}
