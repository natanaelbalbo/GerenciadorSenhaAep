import 'dart:math';

class Activity {
  final String action;
  final DateTime timestamp;

  Activity(this.action) : timestamp = DateTime.now();
}

class ActivityService {
  final List<Activity> _activityLog = [];
  final int _maxActivities = 10;

  void logActivity(String action) {
    _activityLog.add(Activity(action));

    if (_activityLog.length >= _maxActivities) {
      _detectAnomalies();
    }
  }

  void _detectAnomalies() {
    print('Verificando anomalias nas atividades...');
    List<int> labels = _runIsolationForest();
    if (labels.contains(-1)) {
      print('Atividade suspeita detectada!');
    } else {
      print('Nenhuma anomalia detectada.');
    }
    _activityLog.clear();
  }

  List<int> _runIsolationForest() {
    Random random = Random();
    return List.generate(
        _activityLog.length, (index) => random.nextBool() ? 1 : -1);
  }
}
