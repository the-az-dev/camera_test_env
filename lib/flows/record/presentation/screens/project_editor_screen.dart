import 'package:camera/camera.dart';
import 'package:camera_dev/common/widgets/app_bars/app_bar_type.dart';
import 'package:camera_dev/common/widgets/dev_scaffold.dart';
import 'package:camera_dev/flows/record/presentation/logic/record/record_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectEditorScreen extends StatelessWidget {
  const ProjectEditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => RecordCubit(),
        child: _ProjectEditorScreen(),
    );
  }
}

class _ProjectEditorScreen extends StatelessWidget {
  const _ProjectEditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordCubit, RecordState>(
      buildWhen: (p, c) => p.isLoading != c.isLoading || p.cameras != c.cameras,
      builder: (context, state) {
        if(state.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if(state.cameraController == null){
          return Center(child: Text("Camera is not accepted! Check permissions on settings!"),);
        }

        return DevScaffold(
          appBarType: AppBarType.titleAction,
          body: Column(
            children: [
              SizedBox(
                child: CameraPreview(state.cameraController!),
              ),
              Row(

              )
            ],
          )
        );
      },
    );
  }
}

