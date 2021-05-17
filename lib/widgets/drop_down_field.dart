import 'package:envirocar/theme/colors_cario.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_container/overlay_container.dart';

class DropDownField extends FormField<String> {
  final dynamic value;
  final Widget icon;
  final String hintText;
  final TextStyle hintStyle;
  final String labelText;
  final TextStyle labelStyle;
  final TextStyle textStyle;
  final bool required;
  final Icon prefixIcon;
  final TextInputType keyBoardType;
  final List<TextInputFormatter> textInputFormatter;
  final List<dynamic> items;
  final FormFieldSetter<dynamic> setter;
  final ValueChanged<dynamic> onValueChanged;
  final TextEditingController textEditingController;
  final FocusNode focusNode;

  DropDownField({
      Key key,
      this.value,
      this.icon,
      this.hintText,
      this.hintStyle: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w400,
      ),
      this.labelText,
      this.labelStyle: const TextStyle(
        color: const Color(0xFF455A64),
        fontWeight: FontWeight.w400,
      ),
      this.textStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      this.required: false,
      this.prefixIcon,
      this.keyBoardType : TextInputType.text,
      this.textInputFormatter,
      this.items,
      this.setter,
      this.onValueChanged,
      this.textEditingController,
      this.focusNode})
      : super(
        key: key,
        initialValue: textEditingController != null ? textEditingController.text : '',
        builder: (FormFieldState<String> formFieldState) {
          final DropDownFieldState state = formFieldState;
          final ScrollController scrollController = ScrollController();
          bool showHintText = false;
          final labelStyleWithFocus = TextStyle(
            color: Color(0xFF0065A0),
            fontWeight: FontWeight.normal,
            fontSize: 15
          );
          focusNode.addListener(() {
            if (!focusNode.hasFocus) {
              state._showDropDown = false;
              showHintText = true;
            }
          });

          final InputDecoration inputDecoration = InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            hintText: showHintText ? hintText : '',
            hintStyle: hintStyle,
            labelText: labelText,
            labelStyle: labelStyle,
            focusColor: CarioColors.blueLightCario,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.shade700),
            ),
            isDense: true,
            prefixIcon: prefixIcon,
            suffixIcon: IconButton(
              icon: Icon(Icons.arrow_drop_down),
              onPressed: state.toggleDropDownVisibility,
              highlightColor: CarioColors.pressedCario,
              splashColor: CarioColors.pressedCario,
              color: Colors.grey.shade700,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: CarioColors.blueDarkCario, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: CarioColors.blueDarkCario, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.shade700),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: CarioColors.blueDarkCario),
            ),
          );
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Container(
                  child: TextFormField(
                    focusNode: focusNode,
                    controller: state._effectiveController,
                    decoration: inputDecoration,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    keyboardType: keyBoardType,
                    cursorColor: CarioColors.blueDarkCario,
                    autofocus: false,
                    obscureText: false,
                    maxLines: 1,
                    validator: (value) {
                      if (value.isEmpty || value.trim().length == 0)
                        return 'This field is required.';
                      return null;
                    },
                    inputFormatters: textInputFormatter ?? null,
                    onSaved: setter,
                    enabled: true,
                  ),
                ),
              ),
              OverlayContainer(
                show: state._showDropDown,
                asWideAsParent: true,
                position: OverlayContainerPosition(0, 28),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.topCenter,
                  width: MediaQuery.of(state.context).size.width,
                  child: Scrollbar(
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      controller: scrollController,
                      children: items.isNotEmpty
                          ? ListTile.divideTiles(
                          context: state.context,
                          tiles: state._getChildren(state._items)).toList()
                          : List(),
                    ),
                  ),
                ),
              ),
            ],
          );
    }
  );

  @override
  DropDownFieldState createState() => DropDownFieldState();
}

class DropDownFieldState extends FormFieldState<String> {
  TextEditingController _controller;
  bool _showDropDown = false;
  bool _isSearching = true;
  String _searchText = '';

  @override
  DropDownField get widget => super.widget;
  TextEditingController get _effectiveController => widget.textEditingController ?? _controller;

  List<String> get _items => widget.items;

  @override
  void initState() {
    _isSearching = false;
    if (widget.textEditingController == null)
      _controller = TextEditingController();

    _effectiveController.addListener(_handleControllerChanged);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant DropDownField oldWidget) {
    if (widget.textEditingController != oldWidget.textEditingController) {
      oldWidget.textEditingController?.removeListener(_handleControllerChanged);
      widget.textEditingController?.addListener(_handleControllerChanged);

      if (oldWidget.textEditingController != null && widget.textEditingController == null) {
        _controller = TextEditingController.fromValue(oldWidget.textEditingController.value);
      }

      if (widget.textEditingController != null) {
        setValue(widget.textEditingController.text);
        if (oldWidget.textEditingController == null)
          _controller = null;
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  void clearValue() {
    setState(() {
      _effectiveController.text = '';
    });
  }

  void toggleDropDownVisibility() {
    setState(() {
      _showDropDown = !_showDropDown;
    });
  }

  @override
  void dispose() {
    widget.textEditingController?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void reset() {
    setState(() {
      _controller.text = '';
    });
    super.reset();
  }

  List<ListTile> _getChildren(List<String> items) {
    List<ListTile> childItems = List();
    for(var item in _items) {
      if (_searchText.isNotEmpty) {
        if (item.toLowerCase().contains(_searchText.trim().toLowerCase())) {
          childItems.add(_getListTile(item));
        }
      }
      else {
        childItems.add(_getListTile(item));
      }
    }
    // ignore: unnecessary_statements
    _isSearching ? childItems : List();
    return childItems;
  }

  ListTile _getListTile(String text) {
    return ListTile(
      tileColor: CarioColors.whiteCario,
      dense: true,
      title: Text(
        text,
      ),
      onTap: () {
        setState(() {
          _effectiveController.text = text;
          _handleControllerChanged();
          _showDropDown = false;
          _isSearching = false;
          if (widget.onValueChanged != null)
            widget.onValueChanged(text);
        });
      },
    );
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }

    if (_effectiveController.text.isEmpty) {
      setState(() {
        _isSearching = false;
        _searchText = '';
      });
    }
    else {
      setState(() {
        _isSearching = true;
        _searchText = _effectiveController.text;
        _showDropDown = true;
      });
    }
  }
}

/*
* RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.globalToLocal(Offset.zero);

    List<ListTile> childItems = List();
    for(var item in _items) {
      if (_searchText.isNotEmpty) {
        if (item.toLowerCase().contains(_searchText.trim().toLowerCase())) {
          childItems.add(_getListTile(item));
        }
      }
      else {
        childItems.add(_getListTile(item));
      }
    }
    _isSearching ? childItems : List();
    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 5,
        width: size.width,
        child: Material(
          elevation: 4.0,
          child: ListView(
            shrinkWrap: true,
            children: childItems,
          ),
        ),
      ),
    );
 */