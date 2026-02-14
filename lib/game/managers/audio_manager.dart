import 'package:flame_audio/flame_audio.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  
  bool _musicEnabled = true;
  bool _sfxEnabled = true;

  factory AudioManager() {
    return _instance;
  }

  AudioManager._internal();

  Future<void> initialize() async {
  }

  Future<void> playBackgroundMusic() async {
    if (_musicEnabled) {
      await FlameAudio.bgm.play('background_music.mp3');
    }
  }

  void playSfx(String filename) {
    if (_sfxEnabled) {
      FlameAudio.play(filename);
    }
  }

  void stopBackgroundMusic() {
    FlameAudio.bgm.stop();
  }

  void toggleMusic() {
    _musicEnabled = !_musicEnabled;
    if (!_musicEnabled) {
      stopBackgroundMusic();
    }
  }

  void toggleSfx() {
    _sfxEnabled = !_sfxEnabled;
  }
}