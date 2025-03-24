import 'package:camera/camera.dart';
import 'package:camera_dev/flows/record/presentation/logic/project/project_cubit.dart';
import 'package:camera_dev/flows/record/presentation/logic/record/record_cubit.dart';
import 'package:camera_dev/flows/record/presentation/widgets/text_toolbar_component_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordPreviewScreen extends StatelessWidget {
  const RecordPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => RecordCubit(),
        child: _RecordPreviewScreen(),
    );
  }
}

class _RecordPreviewScreen extends StatelessWidget {
  const _RecordPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProjectCubit>(create: (_) => ProjectCubit()),
        BlocProvider<RecordCubit>(create: (_) => RecordCubit()),
      ],
      child: BlocBuilder<ProjectCubit, ProjectState>(
        buildWhen: (previous, current) => previous.isLoading != current.isLoading,
        builder: (context, projectState) {
          if (projectState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(projectState.projectName),
              actions: [
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.edit_note_outlined),
                ),
              ],
            ),
            body: BlocBuilder<RecordCubit, RecordState>(
              buildWhen: (previous, current) =>
              previous.isLoading != current.isLoading ||
                  previous.cameras != current.cameras,
              builder: (context, recordState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (recordState.cameraController != null)
                      Padding(
                        padding: EdgeInsets.all(
                            20.0,
                        ),
                        child: Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.75,
                              child: CameraPreview(
                                recordState.cameraController!,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    BlocBuilder<ProjectCubit, ProjectState>(
                                      builder: (context, state) {
                                        if(state.isPositionSlider)
                                        {
                                          return Padding(
                                            padding: EdgeInsets.all(20.0),
                                            child:Slider(
                                              value: state.promptPosition,
                                              min: -1.0,
                                              max: 1.25,
                                              onChanged: (value) => context.read<ProjectCubit>().changeTextPosition(value),
                                            ),
                                          );
                                        }
                                        if(state.isFontSizeSlider)
                                        {
                                          return Padding(
                                            padding: EdgeInsets.all(20.0),
                                            child:Slider(
                                              value: state.fontSize,
                                              min: 15,
                                              max: 30,
                                              onChanged: (value) => context.read<ProjectCubit>().changeFontSize(value),
                                            ),
                                          );
                                        }
                                        return SizedBox();
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 20.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                            width: 50.0,
                                          ),
                                          IconButton(
                                            iconSize: 30.0,
                                            color: Colors.grey,
                                            style: ButtonStyle(
                                              backgroundColor: WidgetStateProperty
                                              .all<Color>(
                                                Colors.white,
                                              ),
                                            ),
                                            onPressed: () {},
                                            icon: Icon(Icons.circle_outlined),
                                          ),
                                          IconButton(
                                            iconSize: 30.0,
                                            color: Colors.grey,
                                            style: ButtonStyle(
                                              backgroundColor: WidgetStateProperty
                                              .all<Color>(
                                                Colors.white,
                                              ),
                                            ),
                                            onPressed: () {
                                              context.read<RecordCubit>().switchCamera();
                                            },
                                            icon: Icon(Icons.restart_alt),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            BlocBuilder<ProjectCubit, ProjectState>(
                              builder: (context, projectState) {
                                return Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Align(
                                    alignment: Alignment(projectState.promptPosition, 0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      height: 300,
                                      child: ListView(
                                        children: [
                                          Text(
                                            projectState.promptContent,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              shadows: [
                                                Shadow(blurRadius: 4.0),
                                              ],
                                              fontSize: projectState.fontSize,
                                            ),
                                          ),
                                        ],
                                      )
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    else
                      const Center(child: Text('Camera not found! '
                          'Please, check permissions!')),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Direction
                        TextToolbarComponent(
                          onTap: () {
                            context.read<ProjectCubit>().openPositionSlider(!(projectState.isPositionSlider));
                          },
                          title: "Position",
                          icon: Icons.compare_arrows,
                        ),

                        // Font Size
                        TextToolbarComponent(
                          onTap: () {
                            context.read<ProjectCubit>().openFontSizeSlider(!(projectState.isFontSizeSlider));
                          },
                          title: "Font size",
                          icon: Icons.font_download_outlined,
                        ),

                        // Speed
                        TextToolbarComponent(
                          onTap: () {},
                          title: "Speed",
                          icon: Icons.speed,
                        ),

                        // Start point
                        TextToolbarComponent(
                          onTap: () {},
                          title: "Start point",
                          icon: Icons.start_outlined,
                        ),

                        // Countdown
                        TextToolbarComponent(
                          onTap: () {},
                          title: "Countdown",
                          icon: Icons.timer_outlined,
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

