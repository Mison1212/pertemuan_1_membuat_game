import 'package:flame_audio/flame_audio.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();

  bool _musicEnabled = true;
  bool _sfxEnabled = true;
  double _musicVolume = 0.5; 
  double _sfxVolume = 0.5;

  factory AudioManager() {
    return _instance;
  }

  AudioManager._internal();

  Future<void> initialize() async {}

  Future<void> playBackgroundMusic() async {
    if (_musicEnabled) {
      try {
        print('=== STARTING MUSIC ===');
        print('File path: audio/musik/background_music.mp3');
        print('Volume: $_musicVolume');
        await FlameAudio.bgm.play(
          'audio/musik/background_music.mp3',
          volume: _musicVolume,
        );
        print('✓ Music started successfully!');
      } catch (e) {
        print('✗ ERROR playing music: $e');
      }
    } else {
      print('Music is disabled');
    }
  }

  void playSfx(String filename) {
    if (_sfxEnabled) {
      try {
        FlameAudio.play('audio/sfx/$filename', volume: _sfxVolume);
      } catch (e) {
        print('Error playing sfx: $e');
      }
    }
  }

  void stopBackgroundMusic() {
    FlameAudio.bgm.stop();
  }

  void setMusicVolume(double volume) {
    _musicVolume = volume.clamp(0.0, 1.0);
    FlameAudio.bgm.stop();
    playBackgroundMusic();
  }

  void setSfxVolume(double volume) {
    _sfxVolume = volume.clamp(0.0, 1.0);
  }

  double getMusicVolume() => _musicVolume;
  double getSfxVolume() => _sfxVolume;

  void toggleMusic() {
    _musicEnabled = !_musicEnabled;
    if (!_musicEnabled) {
      stopBackgroundMusic();
    } else {
      playBackgroundMusic();
    }
  }

  void toggleSfx() {
    _sfxEnabled = !_sfxEnabled;
  }
}
