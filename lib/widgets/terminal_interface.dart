import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quantum_terminal/pages/theme_manager.dart';
import '../commands/command_handler.dart';

class TerminalInterface extends StatefulWidget {
  final TerminalTheme theme;

  const TerminalInterface({super.key, required this.theme});

  @override
  State<TerminalInterface> createState() => _TerminalInterfaceState();
}

class _TerminalInterfaceState extends State<TerminalInterface>
    with SingleTickerProviderStateMixin {
  final List<String> _output = [];
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _cursorController;
  final CommandHandler _commandHandler = CommandHandler();
  int _commandIndex = 0;
  final List<String> _commandHistory = [];

  @override
  void initState() {
    super.initState();
    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _output.add('Quantum Terminal v1.0 initialized');
    _output.add('Type "help" for available commands');
    _output.add('');

    // Auto-focus on terminal
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _cursorController.dispose();
    _controller.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _executeCommand(String command) {
    if (command.trim().isEmpty) return;

    setState(() {
      _output.add('quantum@portfolio:~\$ $command');
      _commandHistory.add(command);
      _commandIndex = _commandHistory.length;

      final response = _commandHandler.execute(command);
      _output.addAll(response.split('\n'));
      _output.add('');

      _controller.clear();
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _navigateHistory(int direction) {
    if (_commandHistory.isEmpty) return;

    setState(() {
      _commandIndex =
          (_commandIndex + direction).clamp(0, _commandHistory.length);
      if (_commandIndex < _commandHistory.length) {
        _controller.text = _commandHistory[_commandIndex];
        _controller.selection =
            TextSelection.collapsed(offset: _controller.text.length);
      } else {
        _controller.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: widget.theme.accentColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Terminal header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: widget.theme.backgroundColor.withOpacity(0.8),
              border: Border(
                  bottom: BorderSide(
                      color: widget.theme.accentColor.withOpacity(0.2))),
            ),
            child: Row(
              children: [
                Text(' </> ',
                    style: TextStyle(
                      fontFamily: widget.theme.fontFamily,
                      color: widget.theme.accentColor,
                      fontSize: 12,
                      shadows: widget.theme.textShadows,
                    )),
                Text(
                  'QUANTUM_TERMINAL',
                  style: TextStyle(
                    fontFamily: widget.theme.fontFamily,
                    color: widget.theme.accentColor,
                    fontSize: 12,
                    shadows: widget.theme.textShadows,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    _buildTerminalButton('─', Colors.yellow),
                    _buildTerminalButton('□', Colors.green),
                    _buildTerminalButton('×', Colors.red),
                  ],
                ),
              ],
            ),
          ),

          // Terminal content
          Expanded(
            child: Container(
              color: widget.theme.backgroundColor.withOpacity(0.95),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: RawKeyboardListener(
                  focusNode: FocusNode(),
                  onKey: (event) {
                    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                      _navigateHistory(-1);
                    } else if (event.logicalKey ==
                        LogicalKeyboardKey.arrowDown) {
                      _navigateHistory(1);
                    }
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _output.length + 1,
                    itemBuilder: (context, index) {
                      if (index < _output.length) {
                        return _buildOutputLine(_output[index]);
                      } else {
                        return _buildInputLine();
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTerminalButton(String symbol, Color color) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          symbol,
          style: TextStyle(
            color: Colors.black,
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildOutputLine(String line) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        line,
        style: TextStyle(
          fontFamily: widget.theme.fontFamily,
          color: widget.theme.textColor,
          fontSize: 14,
          height: 1.2,
          shadows: widget.theme.textShadows,
        ),
      ),
    );
  }

  Widget _buildInputLine() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'quantum@portfolio:~\$ ',
          style: TextStyle(
            fontFamily: widget.theme.fontFamily,
            color: widget.theme.promptColor,
            fontSize: 14,
            height: 1.2,
            shadows: widget.theme.textShadows,
          ),
        ),
        Expanded(
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            style: TextStyle(
              fontFamily: widget.theme.fontFamily,
              color: widget.theme.textColor,
              fontSize: 14,
              height: 1.2,
              shadows: widget.theme.textShadows,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
            onSubmitted: _executeCommand,
            cursorColor: widget.theme.cursorColor,
          ),
        ),
      ],
    );
  }
}
