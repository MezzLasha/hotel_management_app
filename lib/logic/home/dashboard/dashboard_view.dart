import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_management_app/presentation/myWidgets/customWidgets.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      'DATE_TIME',
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
      ),
    );
  }
}
