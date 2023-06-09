import 'package:flutter/material.dart';
import '../styles.dart';

class DropdownInput extends StatefulWidget {
  final String placeholder;
  final List<String> items;
  final String searchIconOn;
  final String searchIconOff;
  final TextEditingController textEditingController;
  final Function(String) onTextChanged;

  const DropdownInput({
    Key? key,
    required this.placeholder,
    required this.items,
    required this.searchIconOn,
    required this.searchIconOff,
    required this.textEditingController,
    required this.onTextChanged,
  }) : super(key: key);

  @override
  State<DropdownInput> createState() => _DropdownInputState();
}

class _DropdownInputState extends State<DropdownInput> {
  String? selectedValue;
  bool showDropdown = false;

  @override
  void initState() {
    super.initState();
    selectedValue = null;
  }

  void toggleDropdown() {
    setState(() {
      showDropdown = !showDropdown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: widget.textEditingController.text.isEmpty
            ? Border.all(color: darkGrey, width: 1)
            : Border.all(color: wColor, width: 1),
        color: grey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 54,
            child: TextField(
              controller: widget.textEditingController,
              style: const TextStyle(color: wColor),
              decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: contentText(color: lightGrey),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 19.5,
                  horizontal: 15,
                ),
                border: InputBorder.none,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.textEditingController.clear();
                      toggleDropdown();
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Image.asset(
                      widget.textEditingController.text.isEmpty
                          ? widget.searchIconOn
                          : widget.searchIconOff,
                      width: 10,
                      height: 10,
                    ),
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  selectedValue = null; // Clear the selected value
                });
                widget.onTextChanged(value);
                if (value.isNotEmpty) {
                  setState(() {
                    showDropdown = true;
                  });
                } else {
                  setState(() {
                    showDropdown = false;
                  });
                }
              },
            ),
          ),
          Container(
            height: 0.5,
            color: showDropdown ? lightGrey : null,
          ),
          if (showDropdown)
            ListView.separated(
              shrinkWrap: true,
              itemCount: widget.items.length,
              separatorBuilder: (context, index) => const Divider(
                color: lightGrey,
                thickness: 0.5,
              ),
              itemBuilder: (context, index) {
                final item = widget.items[index];
                return ListTile(
                  title: Text(
                    item,
                    style: contentText(color: lightGrey),
                  ),
                  onTap: () {
                    setState(() {
                      selectedValue = item;
                      widget.textEditingController.text = item;
                      showDropdown = false;
                    });
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}

class InputField extends StatefulWidget {
  final String placeholder;
  final Function(String) onTextChanged;
  final TextEditingController textEditingController;

  const InputField({
    super.key,
    required this.placeholder,
    required this.onTextChanged,
    required this.textEditingController,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: widget.textEditingController.text.isEmpty
            ? Border.all(color: darkGrey, width: 1.5)
            : Border.all(color: wColor, width: 1.5),
        color: grey,
      ),
      height: 54,
      child: TextField(
        controller: widget.textEditingController,
        style: contentText(color: wColor),
        decoration: InputDecoration(
          hintText: widget.placeholder,
          hintStyle: contentText(),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 19.5,
            horizontal: 15,
          ),
          border: InputBorder.none,
        ),
        onChanged: (value) {
          widget.onTextChanged(value);
        },
      ),
    );
  }
}

class AccessLog extends StatelessWidget {
  final Color bgColor;
  final String
      accessTime; // change this to DateTime, and receive real access time.
  final String gate; // change this to real gate
  final bool isPhone;

  const AccessLog({
    super.key,
    required this.bgColor,
    this.accessTime = '22.12.28  20 : 22',
    this.gate = 'G-05',
    required this.isPhone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: bgColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              height: 34,
              width: 34,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: black,
              ),
              child: Icon(
                isPhone ? Icons.phone_android_outlined : Icons.credit_card,
                color: bColor,
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 17,
                  bottom: 17,
                  right: 20,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        right: 15,
                      ),
                      child: Text(
                        accessTime,
                        style: contentText(
                          color: wColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const VerticalDivider(
                      thickness: 1,
                      width: 19,
                      color: lightGrey,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 12,
                      ),
                      child: Text(
                        gate,
                        style: contentText(
                          color: wColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GateDetection extends StatefulWidget {
  final bool isDetected;

  const GateDetection({
    super.key,
    required this.isDetected,
  });

  @override
  State<GateDetection> createState() => _GateDetectionState();
}

class _GateDetectionState extends State<GateDetection> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          bottom: 20,
        ),
        child: Row(
          children: [
            Container(
              height: 34,
              width: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.isDetected ? bColor : lightGrey,
              ),
              child: Center(
                child: SizedBox(
                  height: 18,
                  child: Image.asset('assets/doorDetection.png'),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Text(
              widget.isDetected ? '출입문 감지' : '출입문 감지 실패',
              style: contentText(
                color: wColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarInput extends StatefulWidget {
  final String placeholder;
  final List<String> items;
  final TextEditingController textEditingController;
  final Function(String) onTextChanged;

  const CarInput({
    Key? key,
    required this.placeholder,
    required this.items,
    required this.textEditingController,
    required this.onTextChanged,
  }) : super(key: key);

  @override
  State<CarInput> createState() => _CarInputState();
}

class _CarInputState extends State<CarInput> {
  String? selectedValue;
  bool showDropdown = false;

  @override
  void initState() {
    super.initState();
    selectedValue = null;
  }

  void toggleDropdown() {
    setState(() {
      showDropdown = !showDropdown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: showDropdown
            ? Border.all(color: wColor, width: 1)
            : Border.all(color: darkGrey, width: 1),
        color: grey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 54,
            child: TextField(
              controller: widget.textEditingController,
              style: const TextStyle(color: wColor),
              decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: contentText(color: lightGrey),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 19.5,
                  horizontal: 15,
                ),
                border: InputBorder.none,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.textEditingController.clear();
                      toggleDropdown();
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: showDropdown ? lightGrey : bColor,
                      ),
                      height: 20,
                      width: 20,
                      child: Icon(
                        showDropdown
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: showDropdown ? bColor : black,
                      ),
                    ),
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  selectedValue = null; // Clear the selected value
                });
                widget.onTextChanged(value);
                if (value.isNotEmpty) {
                  setState(() {
                    showDropdown = true;
                  });
                } else {
                  setState(() {
                    showDropdown = false;
                  });
                }
              },
            ),
          ),
          Container(
            height: 0.5,
            color: showDropdown ? lightGrey : null,
          ),
          if (showDropdown)
            ListView.separated(
              shrinkWrap: true,
              itemCount: widget.items.length,
              separatorBuilder: (context, index) => const Divider(
                color: lightGrey,
                thickness: 0.5,
              ),
              itemBuilder: (context, index) {
                final item = widget.items[index];
                return ListTile(
                  title: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      item,
                      style: contentText(color: wColor),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      selectedValue = item;
                      widget.textEditingController.text = item;
                      showDropdown = false;
                    });
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}

class InfoField extends StatelessWidget {
  final String value;

  const InfoField({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: darkGrey,
          width: 1.5,
        ),
        color: grey,
      ),
      height: 54,
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            value,
            style: contentText(color: wColor),
          ),
        ),
      ),
    );
  }
}
