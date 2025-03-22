import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'record_state.dart';

class RecordCubit extends Cubit<RecordState>{
  RecordCubit() : super(const RecordState()) {
    _init();
  }

  CameraController? cameraController;

  Future<void> _init() async{
    emit(state.copyWith(status: RecordStatus.loading));

    final List<CameraDescription> _cameras = await availableCameras();
    if(_cameras.isNotEmpty) {

      final CameraController? controller = CameraController(
          _cameras.first,
          ResolutionPreset.medium,
      );

      await controller!.initialize();

      emit(state.copyWith(
        status: RecordStatus.success,
        cameraController: controller,
        cameras: _cameras,
        selectedCamera: _cameras.indexOf(_cameras.first) % _cameras.length
      ));


    } else {
      emit(state.copyWith(
        status: RecordStatus.failure,
        errorMessage: "Error during searching camera! No camera's found!"
      ));
    }
  }

  Future<void> switchCamera() async{
    emit(state.copyWith(status: RecordStatus.loading));
    final _selectedCameraIndex = (state.selectedCamera + 1) % state.cameras.length;
    if (state.cameras.length > 1 && _selectedCameraIndex < 2) {
      final CameraController? _cameraController = CameraController(
        state.cameras[_selectedCameraIndex],
        ResolutionPreset.max,
      );
      await _cameraController!.initialize();
      emit(state.copyWith(
        status: RecordStatus.success,
        cameraController: _cameraController,
        selectedCamera: _selectedCameraIndex
      ));
    }
    else {
      final CameraController? _cameraController = CameraController(
        state.cameras[0],
        ResolutionPreset.max,
      );
      await _cameraController!.initialize();
      emit(state.copyWith(
          status: RecordStatus.success,
          cameraController: _cameraController,
          selectedCamera: 0
      ));
    }
  }


  @override
  Future<void> close() {
    state.cameraController?.dispose();
    return super.close();
  }
}