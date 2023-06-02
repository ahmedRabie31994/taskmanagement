import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/cubit/hometaskcubit.dart';
import 'package:todoapp/cubit/tasksstates.dart';
import 'package:todoapp/features/homepage/widgets/customsearching.dart';
import 'package:todoapp/models/taskmodel.dart';
import 'package:todoapp/utilites/constants.dart';
import 'package:todoapp/utilites/widgets/custombutton.dart';
import 'package:todoapp/utilites/widgets/customtext.dart';
import 'package:todoapp/utilites/widgets/showdialog.dart';
import 'package:intl/intl.dart';

class AddingTaskWidget extends StatefulWidget {
  const AddingTaskWidget({
    Key? key,
    required TextEditingController titlecontroller,
  })  : _titlecontroller = titlecontroller,
        super(key: key);

  final TextEditingController _titlecontroller;

  @override
  State<AddingTaskWidget> createState() => _AddingTaskWidgetState();
}

class _AddingTaskWidgetState extends State<AddingTaskWidget> {
  final TextEditingController datecontroller = TextEditingController();

  final formkey = GlobalKey<FormState>();
  DateTime dateTime = DateTime.now();
  TimeOfDay? newtime;
  DateTime? newDatetime;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCbit, TasksStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return SingleChildScrollView(
          child: Container(
              height: 400,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: 'Tell us about the task',
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    const CustomText(
                      text: 'write the title and date of task',
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        CustomSearchingWidget(
                          contentPadding: EdgeInsets.zero,
                          controller: widget._titlecontroller,
                          hintText: 'Title*',
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the title';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomSearchingWidget(
                          onTap: () async {
                            DateTime? newdate = await showDatePicker(
                              context: context,
                              initialDate: dateTime,
                              firstDate: DateTime(2023),
                              lastDate: DateTime(2100),
                            );

                            if (newdate != null) {
                              newtime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                    hour: dateTime.hour,
                                    minute: dateTime.minute),
                              );

                              if (newtime != null) {
                                newDatetime = DateTime(
                                  newdate.year,
                                  newdate.month,
                                  newdate.day,
                                  newtime!.hour,
                                  newtime!.minute,
                                );
                                formattedDateTime =
                                    DateFormat('dd/MM/yyyy hh:mm a')
                                        .format(newDatetime!);

                                datecontroller.text = formattedDateTime;
                              }
                            }
                          },
                          contentPadding: EdgeInsets.zero,
                          controller: datecontroller,
                          hintText: 'Date and time',
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a date and time';
                            }
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const CustomText(
                      text: '*mandatory fields',
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: SizedBox(
                        width: 200,
                        child: CustomButton(
                            buttonText: '+Save task',
                            onPressed: () {
                              if (widget._titlecontroller.text == '') {
                                ShowMyDialog.showMsg(
                                    context, 'please adding the task title');
                              } else if (datecontroller.text == '') {
                                ShowMyDialog.showMsg(
                                    context, 'please adding the date of task');
                              } else {
                                TasksCbit.get(context).inserttasks(Todo(
                                  id: DateTime.now().millisecondsSinceEpoch,
                                  title: widget._titlecontroller.text,
                                  creationDate: formattedDateTime,
                                  isChecked:
                                      TasksCbit.get(context).ischecked ?? true,
                                ));
                                TasksCbit.get(context).gettasks();
                                setState(() {
                                  widget._titlecontroller.clear();
                                  datecontroller.clear();
                                });
                                Navigator.pop(context);
                              }
                            }),
                      ),
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
}
