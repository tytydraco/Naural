import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:naural/src/audio_control_widget.dart';
import 'package:naural/src/binaural_audio_source.dart';
import 'package:naural/src/freq_slider_widget.dart';

/// Provides options to choose and play a tone.
class ToneScreen extends StatefulWidget {
  /// Creates a new [ToneScreen].
  const ToneScreen({super.key});

  @override
  State<ToneScreen> createState() => _ToneScreenState();
}

class _ToneScreenState extends State<ToneScreen> {
  final _player = AudioPlayer();

  var _baseHzSliderValue = 200.0;
  var _diffHzSliderValue = 40.0;

  Future<void> _playTone() async {
    await _player.pause();
    await _player.setAudioSource(
      BinauralAudioSource(
        baseHz: _baseHzSliderValue,
        diffHz: _diffHzSliderValue,
      ),
    );
    await _player.setLoopMode(LoopMode.all);
    await _player.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500,
            maxHeight: 500,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FreqSliderWidget(
                label: 'Base frequency (Hz)',
                minFreq: 0,
                maxFreq: 1000,
                interval: 20,
                initFreq: 200,
                onChanged: (newValue) => _baseHzSliderValue = newValue,
              ),
              FreqSliderWidget(
                label: 'Binarual frequency (Hz)',
                minFreq: 0,
                maxFreq: 100,
                interval: 1,
                initFreq: 40,
                onChanged: (newValue) => _diffHzSliderValue = newValue,
              ),
              AudioControlWidget(
                onPause: _player.pause,
                onPlay: _playTone,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
