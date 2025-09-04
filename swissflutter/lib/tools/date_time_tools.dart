import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/gradient_button.dart';

class DateTimeTools extends StatefulWidget {
  const DateTimeTools({super.key});

  @override
  State<DateTimeTools> createState() => _DateTimeToolsState();
}

class _DateTimeToolsState extends State<DateTimeTools> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  Duration _timerDuration = Duration.zero;
  bool _isTimerRunning = false;
  int _timerSeconds = 0;
  String _timeZone1 = 'UTC';
  String _timeZone2 = 'UTC';
  DateTime? _date1;
  DateTime? _date2;

  final List<String> _timeZones = [
    'UTC',
    'America/New_York',
    'America/Los_Angeles',
    'Europe/London',
    'Europe/Paris',
    'Asia/Tokyo',
    'Asia/Shanghai',
    'Australia/Sydney',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _startTimer() {
    setState(() {
      _isTimerRunning = true;
      _timerDuration = Duration(seconds: _timerSeconds);
    });
  }

  void _stopTimer() {
    setState(() {
      _isTimerRunning = false;
    });
  }

  void _resetTimer() {
    setState(() {
      _isTimerRunning = false;
      _timerDuration = Duration.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ferramentas de Data e Hora'),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Conversor'),
              Tab(text: 'Calculadora'),
              Tab(text: 'Cronômetro'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Conversor de Fusos Horários
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'Conversor de Fusos Horários',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButton<String>(
                          value: _timeZone1,
                          onChanged: (String? newValue) {
                            setState(() {
                              _timeZone1 = newValue!;
                            });
                          },
                          items: _timeZones.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: DropdownButton<String>(
                          value: _timeZone2,
                          onChanged: (String? newValue) {
                            setState(() {
                              _timeZone2 = newValue!;
                            });
                          },
                          items: _timeZones.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GradientButton(
                    text: 'Converter',
                    onPressed: () {
                      // Implementar lógica de conversão de fuso horário
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Resultado da conversão aparecerá aqui',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            
            // Calculadora de Diferença entre Datas
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'Calculadora de Diferença entre Datas',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    title: Text(
                      'Data 1: ${_date1 != null ? "${_date1!.day}/${_date1!.month}/${_date1!.year}" : "Selecionar Data"}',
                    ),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          _date1 = picked;
                        });
                      }
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Data 2: ${_date2 != null ? "${_date2!.day}/${_date2!.month}/${_date2!.year}" : "Selecionar Data"}',
                    ),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          _date2 = picked;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  GradientButton(
                    text: 'Calcular Diferença',
                    onPressed: () {
                      if (_date1 != null && _date2 != null) {
                        final difference = _date2!.difference(_date1!);
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Diferença entre datas'),
                            content: Text(
                              '${difference.inDays.abs()} dias\n'
                              '${(difference.inHours % 24).abs()} horas\n'
                              '${(difference.inMinutes % 60).abs()} minutos',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            
            // Cronômetro e Temporizador
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'Temporizador',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (_timerSeconds >= 60) _timerSeconds -= 60;
                          });
                        },
                      ),
                      Text(
                        '${_timerSeconds ~/ 60}:${(_timerSeconds % 60).toString().padLeft(2, '0')}',
                        style: const TextStyle(fontSize: 24),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            _timerSeconds += 60;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!_isTimerRunning)
                        GradientButton(
                          text: 'Iniciar',
                          onPressed: _startTimer,
                          width: 100,
                        ),
                      if (_isTimerRunning)
                        GradientButton(
                          text: 'Parar',
                          onPressed: _stopTimer,
                          width: 100,
                        ),
                      const SizedBox(width: 20),
                      GradientButton(
                        text: 'Resetar',
                        onPressed: _resetTimer,
                        width: 100,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Cronômetro',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${_timerDuration.inHours.toString().padLeft(2, '0')}:'
                    '${(_timerDuration.inMinutes % 60).toString().padLeft(2, '0')}:'
                    '${(_timerDuration.inSeconds % 60).toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 32),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GradientButton(
                        text: _isTimerRunning ? 'Pausar' : 'Iniciar',
                        onPressed: () {
                          setState(() {
                            _isTimerRunning = !_isTimerRunning;
                          });
                        },
                        width: 100,
                      ),
                      const SizedBox(width: 20),
                      GradientButton(
                        text: 'Resetar',
                        onPressed: () {
                          setState(() {
                            _timerDuration = Duration.zero;
                            _isTimerRunning = false;
                          });
                        },
                        width: 100,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}