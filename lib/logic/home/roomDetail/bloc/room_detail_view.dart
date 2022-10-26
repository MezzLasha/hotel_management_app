import 'package:animations/animations.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_management_app/logic/home/models/room.dart';
import 'package:hotel_management_app/logic/home/roomDetail/chat/bloc/room_chat_view.dart';
import 'package:hotel_management_app/presentation/myWidgets/customWidgets.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class RoomDetail extends StatefulWidget {
  final Room room;

  const RoomDetail({super.key, required this.room});

  @override
  State<RoomDetail> createState() => _RoomDetailState();
}

class _RoomDetailState extends State<RoomDetail> {
  late Widget roomChat;
  final _editButtonKey = GlobalKey<_ToggleEditButtonState>();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    roomChat = RoomChat(room: widget.room);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: _buildAppBar(context),
          body: TabBarView(
            children: [
              _buildMainPage(context),
              const Icon(Icons.directions_transit),
            ],
          ),
          floatingActionButton: _buildActionButton()),
    );
  }

  Widget _buildMainPage(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeroBanner(context),
        const Center(child: DragHandlePill()),
        Container(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: _buildEditableForm(context),
        ),
      ],
    ));
  }

  Widget _buildEditableForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormBuilderRadioGroup(
              name: 'status',
              enabled: false,
              initialValue: widget.room.status == '0'
                  ? 'თავისუფალი'
                  : widget.room.status == '1'
                      ? 'დაკავებული'
                      : widget.room.status == '2'
                          ? 'დასუფთავება'
                          : widget.room.status,
              options: const [
                FormBuilderFieldOption(
                  value: 'თავისუფალი',
                ),
                FormBuilderFieldOption(
                  value: 'დაკავებული',
                ),
                FormBuilderFieldOption(
                  value: 'დასუფთავება',
                )
              ],
              decoration: const InputDecoration(
                  labelText: 'სტატუსი', border: OutlineInputBorder())),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            enabled: false,
            initialValue: widget.room.info,
            decoration: const InputDecoration(
                labelText: 'ინფორმაცია', border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            enabled: false,
            initialValue: widget.room.owner,
            decoration: const InputDecoration(
                labelText: 'მფლობელი', border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            enabled: false,
            initialValue: widget.room.group,
            decoration: const InputDecoration(
                labelText: 'ჯგუფი', border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            enabled: false,
            initialValue: widget.room.info,
            decoration: const InputDecoration(
                labelText: 'კომენტარი', border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 180,
          ),
          SizedBox(
            height: 50,
            child: MyOutlineButton(
                onPressed: () {
                  showMyBottomDialog(
                      context,
                      [
                        Container(
                          alignment: Alignment.topLeft,
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: Text(
                            widget.room
                                .toString()
                                .substring(5, widget.room.toString().length - 1)
                                .replaceAll(',', '\n')
                                .replaceAll(' ', ''),
                            style: GoogleFonts.inter(fontSize: 18),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 70,
                              child: MyOutlineButton(
                                child: const Text('OK'),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              child: MyOutlineButton(
                                icon: const Icon(
                                  Icons.copy,
                                  size: 18,
                                ),
                                child: const Text('COPY'),
                                onPressed: () async {
                                  await Clipboard.setData(ClipboardData(
                                      text: widget.room.toString()));
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                      GlobalKey());
                },
                child: const Text('JSON')),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Hero _buildHeroBanner(BuildContext context) {
    return Hero(
      tag: widget.room.id +
          widget.room.name +
          widget.room.group +
          widget.room.info,
      child: Container(
        height: 100,
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius:
                SmoothBorderRadius(cornerRadius: 5, cornerSmoothing: 0.6),
            color: Theme.of(context).primaryColor),
        child: Center(
          child: DefaultTextStyle(
            style: GoogleFonts.inter(color: Colors.white),
            child: Text(
              widget.room.name,
              style: GoogleFonts.inter(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  OpenContainer<Never> _buildActionButton() {
    return OpenContainer(
      closedBuilder: (context, action) {
        return FloatingActionButton(
          onPressed: () {
            action();
          },
          child: const Icon(Icons.chat),
        );
      },
      openBuilder: (context, action) {
        return roomChat;
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      toolbarHeight: 80,
      bottom: TabBar(
        indicator: MaterialIndicator(
            color: Theme.of(context).colorScheme.primary,
            paintingStyle: PaintingStyle.fill,
            horizontalPadding: MediaQuery.of(context).size.width / 7),
        tabs: [
          Tab(
            height: 55,
            icon: Icon(Icons.insert_drive_file,
                color: Theme.of(context).colorScheme.primary),
          ),
          Tab(
              height: 55,
              icon: Icon(
                Icons.people,
                color: Theme.of(context).colorScheme.primary,
              )),
        ],
      ),
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
              widget.room.name,
              style: GoogleFonts.inter(fontWeight: FontWeight.w500),
            ),
          ),
          ToggleEditButton(
            key: _editButtonKey,
          ),
        ],
      ),
    );
  }
}

class ToggleEditButton extends StatefulWidget {
  const ToggleEditButton({super.key});

  @override
  State<ToggleEditButton> createState() => _ToggleEditButtonState();
}

class _ToggleEditButtonState extends State<ToggleEditButton> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return CircularButton(
      icon: _isSelected
          ? const Icon(Icons.check)
          : const Icon(Icons.edit_outlined),
      onPressed: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
    );
  }
}
