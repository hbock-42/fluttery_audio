import 'package:flutter/widgets.dart';
import 'package:fluttery_audio/fluttery_audio.dart';
import 'package:fluttery_audio/src/_audio_visualizer.dart';
import 'package:logging/logging.dart';

final _log = new Logger('Visualizer');

class Visualizer extends StatefulWidget {

  final Function(BuildContext context, List<double> fft) builder;

  Visualizer({
    this.builder,
  });

  @override
  _VisualizerState createState() => new _VisualizerState();
}

class _VisualizerState extends State<Visualizer> {

  AudioVisualizer visualizer;
  List<double> fft = const [];

  @override
  void initState() {
    super.initState();
    visualizer = FlutteryAudio.audioVisualizer()
      ..activate()
      ..addListener(
          fftCallback: (List<double> samples) {
            _log.fine('Got FFT samples: $samples');
            setState(() => fft = samples);
          }
      );
  }

  @override
  void dispose() {
    visualizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, fft);
  }
}