import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todoapp/cubit/hometaskcubit.dart';
import 'package:todoapp/cubit/tasksstates.dart';
import 'package:todoapp/features/homepage/widgets/customsearching.dart';
import 'package:todoapp/utilites/constants.dart';
import 'package:todoapp/utilites/widgets/customtext.dart';

class HomePage extends StatelessWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCbit, TasksStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      minRadius: 40,
                      maxRadius: 40,
                      backgroundColor: Colors.cyan[100],
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://www.befunky.com/images/prismic/5ddfea42-7377-4bef-9ac4-f3bd407d52ab_landing-photo-to-cartoon-img5.jpeg?auto=avif,webp&format=jpg&width=863',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const CustomText(
                      text: 'Good evening, lvy',
                      fontSize: 12,
                    ),
                    const SizedBox(height: 18),
                    Container(
                      child: DatePicker(
                        DateTime.now(),
                        height: 100,
                        width: 80,
                        initialSelectedDate: DateTime.now(),
                        selectionColor: Colors.amber,
                        selectedTextColor: Colors.white,
                        dateTextStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomSearchingWidget(
                      contentPadding: EdgeInsets.zero,
                      controller: _searchController,
                      obscureText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the search keyword';
                        }
                        return null;
                      },
                      perfixicon: Icons.search,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 20),
                    const CustomText(
                      text: 'Today tasks',
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 299,
                      child: ListView.builder(
                        itemCount: TasksCbit.get(context).todos.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey),
                              color: Colors.white,
                            ),
                            width: double.infinity,
                            height: 120,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 15,
                                      left: 10,
                                      top: 5,
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 29),
                                          child: Text(
                                            TasksCbit.get(context)
                                                .todos[index]
                                                .creationDate,
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ),
                                        const Spacer(),
                                        const Icon(
                                          Icons.edit_calendar_outlined,
                                          color: Colors.amber,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: TasksCbit.get(context)
                                            .isTaskChecked[index],
                                        onChanged: (val) {
                                          TasksCbit.get(context)
                                              .changeCheckbox(val!, index);
                                        },
                                        activeColor: Colors.amber,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8,
                                      right: 8,
                                      bottom: 4,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 29),
                                            child: CustomText(
                                              text: TasksCbit.get(context)
                                                  .todos[index]
                                                  .title,
                                              decoration: TasksCbit.get(context)
                                                              .isTaskChecked[
                                                          index] ==
                                                      true
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                              fontSize: 14,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: GestureDetector(
                                            onTap: () {
                                              TasksCbit.get(context)
                                                  .deletetasks(
                                                      TasksCbit.get(context)
                                                          .todos[index]);
                                              TasksCbit.get(context).gettasks();
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.amber,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
