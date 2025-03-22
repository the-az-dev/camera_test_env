import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupCameras();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }


  List<CameraDescription> cameras = [];
  CameraController? _cameraController;
  int _selectedCameraIndex = 0;

  Future<void> _initializeCamera(int cameraIndex) async {
    _cameraController = CameraController(
      cameras[cameraIndex],
      ResolutionPreset.max,
    );
    await _cameraController!.initialize();
    if (mounted) setState(() {});
  }

  Future<void> setupCameras() async {
    try{
      final _cameras = await availableCameras();
      if(_cameras.isNotEmpty){
        setState(() {
          cameras = _cameras;
          _initializeCamera(_selectedCameraIndex);
        });
        await _cameraController!.initialize();
      }
      else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(title: Text("Error"),
              content: Text('No cameras detected!'),
              actions: [
                TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("Close"))
              ],
            ));
      }
    }
    catch(e){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text("Error"),
        content: Text(e.toString()),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("Close"))
        ],
      ));
    }
  }

  void _switchCamera() {
    print(cameras.length);
    if (cameras.length > 1 && _selectedCameraIndex < 3) {
      _selectedCameraIndex = (_selectedCameraIndex + 1) % cameras.length;
      print('Selected camera: ${_selectedCameraIndex}');
      _initializeCamera(_selectedCameraIndex);
    }
    else {
      _selectedCameraIndex = 0;
      _initializeCamera(_selectedCameraIndex);
      _initializeCamera(_selectedCameraIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ui(),
    );
  }


  Widget ui(){
    if(_cameraController == null || !_cameraController!.value.isInitialized)
      return Center(
        child: CircularProgressIndicator(),
      );
    return SafeArea(
        child: Column(
          children: [
            CameraPreview(_cameraController!),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () => _switchCamera(), child: Icon(Icons.flip)),
                ElevatedButton(onPressed: () => _cameraController!.setZoomLevel(1.0), child: Icon(Icons.zoom_out)),
                ElevatedButton(onPressed: () => _cameraController!.setZoomLevel(2.0), child: Icon(Icons.zoom_in)),
                ElevatedButton(onPressed: () => _cameraController!.startVideoRecording(), child: Icon(Icons.play_arrow)),
                ElevatedButton(onPressed: () => _cameraController!.stopVideoRecording(), child: Icon(Icons.stop)),
              ],
            )
          ],
        ),
    );
  }
}
