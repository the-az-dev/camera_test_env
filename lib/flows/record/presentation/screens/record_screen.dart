import 'package:camera/camera.dart';
import 'package:camera_dev/flows/record/presentation/logic/record/record_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RecordCubit(),
      child: _RecordScreen(),
    );
  }
}

class _RecordScreen extends StatelessWidget {
  const _RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RecordCubit, RecordState>(
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
          return Stack(
            fit: StackFit.expand,
            children: [
              if (state.cameraController != null && state.cameraController!.value.isInitialized)
                FittedBox(
                  fit: BoxFit.cover,
                  child:SizedBox(
                    width: state.cameraController!.value.previewSize!.height,
                    height: state.cameraController!.value.previewSize!.width,
                    child:  CameraPreview(state.cameraController!),
                    ),
                  ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 45.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        iconSize: 30.0,
                        color: Colors.black,
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        icon: Icon(Icons.pause),
                      ),
                      IconButton(
                        iconSize: 30.0,
                        color: Colors.redAccent,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () {},
                        icon: Icon(Icons.circle),
                      ),
                      IconButton(
                        iconSize: 30.0,
                        color: Colors.black,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
              )
            ],
          );
        },
      ),
    );
  }
}

