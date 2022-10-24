import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_management_app/logic/auth/Models/user.dart';
import 'package:hotel_management_app/logic/auth/form_submission_status.dart';
import 'package:hotel_management_app/logic/auth/login/login_view.dart';
import 'package:hotel_management_app/logic/home/profile/bloc/profile_bloc.dart';
import 'package:hotel_management_app/logic/home/profile/repo/profile_repo.dart';
import 'package:hotel_management_app/presentation/myWidgets/customWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  final User user;

  const ProfileView({super.key, required this.user});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _changePasswordKey = GlobalKey<FormState>();
  final _changeNameKey = GlobalKey<FormState>();
  final _changePhoneNumberKey = GlobalKey<FormState>();
  final _changeIDKey = GlobalKey<FormState>();
  final _changeCommentKey = GlobalKey<FormState>();
  final _changeLanguageKey = GlobalKey<FormState>();

  var blocUser;

  @override
  void initState() {
    blocUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(context.read<ProfileRepo>(), blocUser),
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) async {
          var formState = state.formState;

          if (formState is SubmissionSuccess) {
            final prefs = await SharedPreferences.getInstance();
            final success = await prefs.remove('savedUser');
            if (success) {
              showSnackBar(context, 'გთხოვთ შეხვიდეთ ანგარიშზე ახლიდან');
            }

            //data changed, logout and remove userInstance from cache
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginView(),
                ));
          } else if (formState is SubmissionFailed) {
            showSnackBar(context, formState.exception.toString());
          }
        },
        child: Scaffold(
          appBar: buildAppBar(context),
          body: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 42, left: 16.0, right: 16.0, bottom: 16),
                    child: Text(
                      'ანგარიშის ინფორმაცია',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                  ListTile(
                    title: const Text('სახელი'),
                    onTap: () {
                      var nameTextController = TextEditingController();
                      showMyBottomDialog(
                          context,
                          [
                            TextFormField(
                              validator: (value) => (value ?? '').length > 2
                                  ? null
                                  : 'მეტი უნდა იყოს 2 სიმბოლოზე',
                              autofocus: true,
                              controller: nameTextController,
                              decoration: const InputDecoration(
                                  labelText: 'სახელი',
                                  border: OutlineInputBorder()),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 40,
                                  child: MyOutlineButton(
                                    child: const Text('უკან'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: MyOutlineButton(
                                    child: const Text('შეცვლა'),
                                    onPressed: () {
                                      if (_changeNameKey.currentState != null &&
                                          _changeNameKey.currentState!
                                              .validate()) {
                                        context.read<ProfileBloc>().add(
                                            ProfileUserDataChanged(
                                                user: state.user.copyWith(
                                                    name: nameTextController
                                                        .text)));
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                          _changeNameKey);
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(state.user.name),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.navigate_next_rounded,
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    title: const Text('პაროლი'),
                    onTap: () {
                      var passwordTextController = TextEditingController();
                      showMyBottomDialog(
                          context,
                          [
                            TextFormField(
                              validator: (value) => (value ?? '').length > 2
                                  ? null
                                  : 'მეტი უნდა იყოს 2 სიმბოლოზე',
                              autofocus: true,
                              controller: passwordTextController,
                              decoration: const InputDecoration(
                                  labelText: 'ახალი პაროლი',
                                  border: OutlineInputBorder()),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              validator: (value) =>
                                  (value ?? '') == state.user.password
                                      ? null
                                      : 'არასწორი პაროლი',
                              autofocus: true,
                              obscureText: true,
                              initialValue: '',
                              decoration: const InputDecoration(
                                  labelText: 'ძველი პაროლი',
                                  border: OutlineInputBorder()),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 40,
                                  child: MyOutlineButton(
                                    child: const Text('უკან'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: MyOutlineButton(
                                    child: const Text('შეცვლა'),
                                    onPressed: () {
                                      if (_changePasswordKey.currentState !=
                                              null &&
                                          _changePasswordKey.currentState!
                                              .validate()) {
                                        context.read<ProfileBloc>().add(
                                            ProfileUserDataChanged(
                                                user: state.user.copyWith(
                                                    password:
                                                        passwordTextController
                                                            .text),
                                                oldPassword:
                                                    state.user.password));
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                          _changePasswordKey);
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text('***'),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.navigate_next_rounded,
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    title: const Text('ელ. ფოსტა'),
                    enabled: false,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(state.user.mail),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.navigate_next_rounded,
                          color: Color.lerp(Colors.grey[400],
                              Theme.of(context).primaryColor, 0.3),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 2,
                    width: double.infinity,
                    color: const Color(0xffD8DDDB),
                    margin: const EdgeInsets.only(top: 16),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 22, left: 16.0, right: 16.0, bottom: 16),
                    child: Text(
                      'დამატებითი ინფორმაცია',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                  ListTile(
                    title: const Text('ტელ. ნომერი'),
                    onTap: () {
                      var phoneTextController = TextEditingController();
                      showMyBottomDialog(
                          context,
                          [
                            TextFormField(
                              validator: (value) => (value ?? '').length == 9
                                  ? null
                                  : 'შეიყვანეთ სწორი ნომერი',
                              autofocus: true,
                              controller: phoneTextController,
                              decoration: const InputDecoration(
                                  labelText: 'ტელ. ნომერი',
                                  border: OutlineInputBorder()),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 40,
                                  child: MyOutlineButton(
                                    child: const Text('უკან'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: MyOutlineButton(
                                    child: const Text('შეცვლა'),
                                    onPressed: () {
                                      if (_changePhoneNumberKey.currentState !=
                                              null &&
                                          _changePhoneNumberKey.currentState!
                                              .validate()) {
                                        context.read<ProfileBloc>().add(
                                            ProfileUserDataChanged(
                                                user: state.user.copyWith(
                                                    phone: phoneTextController
                                                        .text)));
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                          _changePhoneNumberKey);
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(state.user.phone),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.navigate_next_rounded,
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    title: const Text('საიდენტიფიკაციო'),
                    onTap: () {
                      var idTextController = TextEditingController();
                      showMyBottomDialog(
                          context,
                          [
                            TextFormField(
                              validator: (value) => (value ?? '').length == 11
                                  ? null
                                  : 'შეიყვანეთ სწორი საიდენტიფიკაციო',
                              autofocus: true,
                              controller: idTextController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  labelText: 'საიდენტიფიკაციო',
                                  border: OutlineInputBorder()),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 40,
                                  child: MyOutlineButton(
                                    child: const Text('უკან'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: MyOutlineButton(
                                    child: const Text('შეცვლა'),
                                    onPressed: () {
                                      if (_changeIDKey.currentState != null &&
                                          _changeIDKey.currentState!
                                              .validate()) {
                                        context.read<ProfileBloc>().add(
                                            ProfileUserDataChanged(
                                                user: state.user.copyWith(
                                                    identification:
                                                        idTextController
                                                            .text)));
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                          _changeIDKey);
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(state.user.identification),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.navigate_next_rounded,
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    title: const Text('კომენტარი'),
                    onTap: () {
                      var commentTextController = TextEditingController();
                      commentTextController.text = state.user.comment;
                      showMyBottomDialog(
                          context,
                          [
                            TextFormField(
                              maxLines: 8,
                              validator: (value) => (value ?? '').length <= 500
                                  ? null
                                  : 'კომენტარი 500 სიმბოლოზე ნაკლები უნდა იყოს',
                              autofocus: true,
                              controller: commentTextController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  labelText: 'კომენტარი',
                                  border: OutlineInputBorder()),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 40,
                                  child: MyOutlineButton(
                                    child: const Text('უკან'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: MyOutlineButton(
                                    child: const Text('შეცვლა'),
                                    onPressed: () {
                                      if (_changeCommentKey.currentState !=
                                              null &&
                                          _changeCommentKey.currentState!
                                              .validate()) {
                                        context.read<ProfileBloc>().add(
                                            ProfileUserDataChanged(
                                                user: state.user.copyWith(
                                                    comment:
                                                        commentTextController
                                                            .text)));
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                          _changeCommentKey);
                    },
                    trailing: Icon(
                      Icons.navigate_next_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                    dense: false,
                    subtitle: Text(
                      state.user.comment,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  ),
                  ListTile(
                    title: const Text('ენა'),
                    onTap: () {
                      var commentTextController = TextEditingController();
                      commentTextController.text = state.user.comment;
                      showMyBottomDialog(
                          context,
                          [
                            FormBuilderRadioGroup(
                              decoration: const InputDecoration(
                                  labelText: 'ენა',
                                  border: OutlineInputBorder()),
                              name: 'my_language',
                              validator: FormBuilderValidators.required(),
                              initialValue: 'ქართული',
                              options: [
                                'ქართული',
                                'English',
                                'Русский',
                              ]
                                  .map((lang) =>
                                      FormBuilderFieldOption(value: lang))
                                  .toList(growable: false),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 40,
                                  child: MyOutlineButton(
                                    child: const Text('უკან'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: MyOutlineButton(
                                    child: const Text('შეცვლა'),
                                    onPressed: () {
                                      if (_changeLanguageKey.currentState !=
                                              null &&
                                          _changeLanguageKey.currentState!
                                              .validate()) {
                                        context.read<ProfileBloc>().add(
                                            ProfileUserDataChanged(
                                                user: state.user.copyWith(
                                                    comment:
                                                        commentTextController
                                                            .text)));
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                          _changeLanguageKey);
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(state.user.lang),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.navigate_next_rounded,
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {},
            label: const Text('ანგარიშიდან გასვლა'),
            icon: const Icon(Icons.logout_outlined),
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
            'ანგარიში',
            style: GoogleFonts.inter(fontWeight: FontWeight.w500),
          )),
        ],
      ),
    );
  }
}
