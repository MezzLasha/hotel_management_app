import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_management_app/logic/auth/Models/user.dart';
import 'package:hotel_management_app/logic/home/dashboard/repo/dashboard_repository.dart';
import 'package:hotel_management_app/logic/home/models/room.dart';
import 'package:hotel_management_app/presentation/myWidgets/customWidgets.dart';
import 'package:hotel_management_app/presentation/myWidgets/myTapToExpand.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:tap_to_expand/tap_to_expand.dart';

import 'dashboard_bloc.dart';

class DashboardView extends StatefulWidget {
  final User user;

  const DashboardView({super.key, required this.user});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final GroupedItemScrollController itemScrollController =
      GroupedItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: BlocProvider(
          create: (context) {
            return DashboardBloc(
                context.read<DashboardRepository>(), widget.user);
          },
          child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              Set<String> groupset = {};
              for (Room room in state.rooms) {
                (groupset.add(room.group));
              }
              List<String> groupList = groupset.toList();

              return RefreshIndicator(
                  onRefresh: (() async {
                    context.read<DashboardBloc>().add(DashboardRefresh());
                  }),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: ListView.builder(
                      itemCount: groupList.length,
                      itemBuilder: (context, index) {
                        List<Room> sortedRooms = state.rooms
                            .where(
                                (element) => element.group == groupList[index])
                            .toList();

                        return TapToExpandMaterial(
                          borderRadius: 5,
                          content: Align(
                            alignment: Alignment.centerLeft,
                            child: Wrap(
                              children: List.generate(sortedRooms.length + 1,
                                  (index1) {
                                if (index1 == sortedRooms.length) {
                                  return buildAddRoomButton(groupList[index]);
                                } else {
                                  return buildRoomButton(sortedRooms[index1]);
                                }
                              }),
                            ),
                          ),
                          boxShadow: const [],
                          color: Color.lerp(Colors.white,
                              Theme.of(context).primaryColorLight, 0.3),
                          startCollapsed: true,
                          title: Text(
                            groupList[index],
                            style: GoogleFonts.inter(),
                          ),
                        );
                      },
                    ),
                  ));
            },
          ),
        ));
  }

  final _addObjectToGroupKey = GlobalKey<FormState>();

  Widget buildAddRoomButton(String group) {
    var size = (MediaQuery.of(context).size.width - 92) / 3;
    return ScalingButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "Add Object To Group",
                style: GoogleFonts.inter(fontWeight: FontWeight.w500),
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              content: Form(
                key: _addObjectToGroupKey,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  TextFormField(
                    validator: (value) => (value ?? '').length > 2
                        ? null
                        : 'მეტი უნდა იყოს 2 სიმბოლოზე',
                    autofocus: true,
                    decoration: const InputDecoration(
                        labelText: 'ობიექტის სახელი',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) => (value ?? '').length > 2
                        ? null
                        : 'მეტი უნდა იყოს 2 სიმბოლოზე',
                    decoration: const InputDecoration(
                        labelText: 'ობიექტის ინფორმაცია',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    enabled: false,
                    initialValue: group,
                    decoration: const InputDecoration(
                        labelText: 'ჯგუფის სახელი',
                        filled: true,
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'ეს ჯგუფი დაემატება ჯგუფში -> $group',
                    style: GoogleFonts.inter(),
                  ),
                ]),
              ),
              actions: [
                CircularButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                CircularButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      if (_addObjectToGroupKey.currentState != null &&
                          _addObjectToGroupKey.currentState!.validate()) {
                        showSnackBar(context, 'წარმატებით შეიქმნა!');
                      } else {
                        showSnackBar(context, 'ჩაასწორეთ ინფორმაცია');
                      }
                    }),
              ],
            );
            ;
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        height: size,
        width: size,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 230, 230, 230),
            borderRadius:
                SmoothBorderRadius(cornerRadius: 5, cornerSmoothing: 0.6)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(
                Icons.add,
                color: Colors.blueAccent,
              ),
              Text(
                'დამატება',
                style: GoogleFonts.inter(
                    color: Colors.blueAccent, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGroupSeparator(Room room) => Container(
      height: 40,
      alignment: Alignment.center,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: Theme.of(context).primaryColorLight,
              ),
              child: AutoSizeText(
                room.group,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: CircularButton(
                radius: 20,
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(
                  Icons.add_home_work_rounded,
                  color: Theme.of(context).primaryIconTheme.color,
                ),
                onPressed: (() {}),
              ))
        ],
      ));

  Widget buildRoomButton(Room room) {
    var size = (MediaQuery.of(context).size.width - 92) / 3;

    return ScalingButton(
      child: Container(
        margin: const EdgeInsets.all(5),
        height: size,
        width: size,
        decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius:
                SmoothBorderRadius(cornerRadius: 5, cornerSmoothing: 0.6)),
        child: Center(
          child: Text(
            room.name,
            style: GoogleFonts.inter(color: Colors.white),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      toolbarHeight: 80,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircularButton(
            icon: const Icon(Icons.home_filled),
            onPressed: () {
              showSnackBar(context, 'Home!');
            },
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 60,
              margin: const EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(12, 0, 0, 0),
                  borderRadius: SmoothBorderRadius(
                      cornerRadius: 12, cornerSmoothing: 0.5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'DATE',
                    style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          CircularButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
