import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'project_state.dart';

class ProjectCubit extends Cubit<ProjectState>{

  ProjectCubit() : super(const ProjectState()){
    _init();
  }

  CameraController? cameraController;

  Future<void> _init() async{
    emit(state.copyWith(status: ProjectStatus.success));

  }

  @override
  Future<void> close() {
    return super.close();
  }

}