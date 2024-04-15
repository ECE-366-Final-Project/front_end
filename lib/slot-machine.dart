import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class SlotMachineController {
  const SlotMachineController({
    required this.start,
    required this.stop,
  });

  final Function({required int? hitRollItemIndex,required List<int> result}) start;
  final Function({required int reelIndex}) stop;
}

class SlotMachine extends StatefulWidget {
  SlotMachine({
    super.key,
    required this.rollItems,
    this.multiplyNumberOfSlotItems = 2,
    this.shuffle = true,
    this.width = 376,
    this.height = 200,
    this.reelWidth = 120,
    this.reelHeight = 200,
    this.reelItemExtent = 100,
    this.reelSpacing = 8,
    required this.onCreated,
    required this.onFinished,
  });

  final List<RollItem> rollItems;
  final int multiplyNumberOfSlotItems;
  final bool shuffle;
  final double width;
  final double height;
  final double reelWidth;
  final double reelHeight;
  final double reelItemExtent;
  final double reelSpacing;
  final Function(SlotMachineController) onCreated;
  final Function(List<int> resultIndexes) onFinished;

  @override
  State<SlotMachine> createState() => SlotMachineState();
}

class SlotMachineState extends State<SlotMachine> {
  late SlotMachineController _slotMachineController;
  Map<int, _ReelController> _reelControllers = {};
  List<RollItem> _actualRollItems = [];
  List<int> _resultIndexes = [];
  List<int> _setIndexes = [2, 6, 3];
  int _stopCounter = 0;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.multiplyNumberOfSlotItems; i++) {
      _actualRollItems.addAll([...widget.rollItems]);
    }

    _slotMachineController = SlotMachineController(
      start: _start,
      stop: _stop,
    );

    widget.onCreated(_slotMachineController);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: widget.width,
          height: widget.height,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Reel(
                reelWidth: widget.reelWidth,
                reelHeight: widget.reelHeight,
                itemExtent: widget.reelItemExtent,
                rollItems: _actualRollItems,
                shuffle: widget.shuffle,
                onCreated: (lc) => _reelControllers[0] = lc,
              ),
              SizedBox(width: widget.reelSpacing),
              _Reel(
                reelWidth: widget.reelWidth,
                reelHeight: widget.reelHeight,
                itemExtent: widget.reelItemExtent,
                rollItems: _actualRollItems,
                shuffle: widget.shuffle,
                onCreated: (lc) => _reelControllers[1] = lc,
              ),
              SizedBox(width: widget.reelSpacing),
              _Reel(
                reelWidth: widget.reelWidth,
                reelHeight: widget.reelHeight,
                itemExtent: widget.reelItemExtent,
                rollItems: _actualRollItems,
                shuffle: widget.shuffle,
                onCreated: (lc) => _reelControllers[2] = lc,
              ),
            ],
          ),
        ),
      ],
    );
  }

  _start({required int? hitRollItemIndex, required List<int> result}) {
    _setIndexes = result;
    _stopCounter = 0;
    _resultIndexes = [];

    final win = hitRollItemIndex != null;
    if (win) {
      final index = hitRollItemIndex;
      _resultIndexes.addAll([index, index, index]);
    } else {
      _resultIndexes = _randomResultIndexes(widget.rollItems.length);
    }
    _reelControllers.forEach((key, _) => _reelControllers[key]!.start());
  }

  _stop({required int reelIndex}) {
    assert(reelIndex >= 0 && reelIndex <= 3);

    final lc = _reelControllers[reelIndex];
    if (lc == null) return;

    lc.stop(to: _setIndexes[reelIndex]);

    _stopCounter++;
    if (_stopCounter == 3) {
      Future.delayed(const Duration(milliseconds: 500), () {
        widget.onFinished(_setIndexes);
      });
    }
  }

  List<int> _randomResultIndexes(int length) {
    bool ok = false;
    List<int> _indexes = [];
    while (!ok) {
      final arr = [
        Random().nextInt(length),
        Random().nextInt(length),
        Random().nextInt(length)
      ];
      if (arr[0] != arr[1] || arr[0] != arr[2] || arr[1] != arr[2]) {
        _indexes = arr;
        ok = true;
      }
    }
    return _indexes;
  }
}

class _ReelController {
  const _ReelController({
    required this.start,
    required this.stop,
  });

  final Function start;
  final Function({required int to}) stop;
}

class _Reel extends StatefulWidget {
  const _Reel({
    Key? key,
    required this.rollItems,
    required this.reelWidth,
    required this.reelHeight,
    required this.itemExtent,
    this.shuffle = true,
    required this.onCreated,
  }) : super(key: key);

  final List<RollItem> rollItems;
  final double reelWidth;
  final double reelHeight;
  final double itemExtent;
  final bool shuffle;
  final Function(_ReelController) onCreated;

  @override
  State<_Reel> createState() => _ReelState();
}

class _ReelState extends State<_Reel> {
  late Timer timer;
  late _ReelController _laneController;
  final _scrollController = FixedExtentScrollController(initialItem: 0);
  int counter = 0;
  List<RollItem> _actualRollItems = [];

  @override
  void initState() {
    super.initState();
    _actualRollItems = widget.rollItems;
    if (widget.shuffle) _actualRollItems.shuffle();

    _laneController = _ReelController(
      start: _start,
      stop: _stop,
    );
    widget.onCreated(_laneController);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      width: widget.reelWidth,
      height: widget.reelHeight,
      child: ListWheelScrollView.useDelegate(
        controller: _scrollController,
        itemExtent: widget.itemExtent,
        physics: FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildLoopingListDelegate(
          children: _actualRollItems.map<Widget>((item) {
            return SizedBox(
              width: widget.reelWidth,
              height: widget.itemExtent,
              child: item.child,
            );
          }).toList(),
        ),
      ),
    );
  }

  _start() {
    counter = 0;
    timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      _scrollController.animateToItem(
        counter,
        duration: Duration(milliseconds: 50),
        curve: Curves.linear,
      );
      counter--;
    });
  }

  _stop({required int to}) {
    try {
      timer.cancel();
      final hitItemIndex =
          _actualRollItems.indexWhere((item) => item.index == to);

      final mod = (-counter) % _actualRollItems.length - 1;
      final addCount = (_actualRollItems.length - mod) +
          (_actualRollItems.length - hitItemIndex) -
          1;

      _scrollController.animateToItem(
        counter - addCount,
        duration: const Duration(milliseconds: 750),
        curve: Curves.decelerate,
      );
    } finally {
      print("Something went wrong, we should probably fix that :)");
    }
  }
}

class RollItem {
  const RollItem({
    required this.index,
    required this.child,
  });

  final int index;
  final Widget child;
}
