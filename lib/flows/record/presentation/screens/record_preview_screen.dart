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
                  children: [
                    if (recordState.cameraController != null)
                      Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: SizedBox(
                              height: recordState.cameraController!.value.previewSize!.width * 0.7,
                              width: recordState.cameraController!.value.previewSize!.height,
                              child: CameraPreview(
                                recordState.cameraController!,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 20.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          IconButton(
                                            iconSize: 30.0,
                                            color: Colors.redAccent,
                                            style: ButtonStyle(
                                              backgroundColor: WidgetStateProperty.all<Color>(
                                                  Colors.white,
                                              ),
                                            ),
                                            onPressed: () {},
                                            icon: Icon(Icons.circle),
                                          ),
                                          IconButton(
                                            iconSize: 30.0,
                                            color: Colors.black,
                                            style: ButtonStyle(
                                              backgroundColor: WidgetStateProperty.all<Color>(
                                                  Colors.white,
                                              ),
                                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
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
                          ),
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Align(
                              alignment: Alignment(1.5, 2),
                              child: SizedBox(
                                width: (MediaQuery.of(context).size.width * 0.75),
                                child: Text(
                                  projectState.promptContent,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    shadows: [
                                      Shadow(
                                          blurRadius: 4.0
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      const Center(child: Text('Camera not found')),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Direction
                        TextToolbarComponent(
                          onTap: () {},
                          title: "Direction",
                          icon: Icons.compare_arrows,
                        ),

                        // Font Size
                        TextToolbarComponent(
                          onTap: () {},
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

