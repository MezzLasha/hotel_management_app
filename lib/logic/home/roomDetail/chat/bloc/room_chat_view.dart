import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_management_app/logic/home/models/room.dart';

import '../../../../../presentation/myWidgets/customWidgets.dart';

class RoomChat extends StatelessWidget {
  final Room room;

  const RoomChat({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      toolbarHeight: 80,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircularButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: Text(
            room.name,
            style: GoogleFonts.inter(fontWeight: FontWeight.w500),
          )),
        ],
      ),
    );
  }
}
