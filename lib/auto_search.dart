library auto_search;

import 'package:flutter/material.dart';

///Class for adding AutoSearchInput to your project
class AutoSearchInput extends StatefulWidget {
  ///List of data that can be searched through for the results
  final List<String> data;

  ///The max number of elements to be displayed when the TextField is clicked
  final int maxElementsToDisplay;

  ///The color of text which actually appears in the results for which the text
  ///is typed
  final Color selectedTextColor;

  ///The color of text which actually appears in the results for the
  ///remaining text
  final Color unSelectedTextColor;

  ///Color of the border when the TextField is enabled
  final Color enabledBorderColor;

  ///Color of the border when the TextField is disabled
  final Color disabledBorderColor;

  ///Color of the border when the TextField is being interated with
  final Color focusedBorderColor;

  ///Color of the cursor
  final Color cursorColor;

  ///Border Radius of the TextField and the resultant elements
  final double borderRadius;

  ///Font Size for both the text in the TextField and the results
  final double fontSize;

  ///Height of a single item in the resultant list
  final double singleItemHeight;

  ///Number of items to be shown when the TextField is tapped
  final int itemsShownAtStart;

  ///Hint text to show inside the TextField
  final String hintText;

  ///Boolean to set autoCorrect
  final bool autoCorrect;

  ///Boolean to set whether the TextField is enabled
  final bool enabled;

  ///onSubmitted function
  final Function onSubmitted;

  ///onTap function
  final Function onTap;

  ///onChanged function
  final Function onChanged;

  ///onEditingComplete function
  final Function onEditingComplete;

  const AutoSearchInput({
    @required this.data,
    @required this.maxElementsToDisplay,
    this.selectedTextColor,
    this.unSelectedTextColor,
    this.enabledBorderColor,
    this.disabledBorderColor,
    this.focusedBorderColor,
    this.cursorColor,
    this.borderRadius = 10.0,
    this.fontSize = 20.0,
    this.singleItemHeight = 40.0,
    this.itemsShownAtStart = 10,
    this.hintText = 'Enter a name',
    this.autoCorrect = true,
    this.enabled = true,
    this.onSubmitted,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
  }) : assert(data != null, maxElementsToDisplay != null);

  @override
  _AutoSearchInputState createState() => _AutoSearchInputState();
}

class _AutoSearchInputState extends State<AutoSearchInput> {
  List<String> results = [];

  final TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {
        results = widget.data
            .where(
              (element) =>
                  element.toLowerCase().startsWith(_textEditingController.text),
            )
            .toList();
        if (results.length > widget.maxElementsToDisplay) {
          results = results.sublist(0, widget.maxElementsToDisplay);
        }
      });
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Widget _getRichText(String result) {
    return RichText(
      text: _textEditingController.text.length > 0
          ? TextSpan(
              children: [
                if (_textEditingController.text.length > 0)
                  TextSpan(
                    text: result.substring(
                        0,
                        _textEditingController.text.indexOf(
                              _textEditingController.text.substring(
                                  _textEditingController.text.length - 1),
                            ) +
                            1),
                    style: TextStyle(
                      fontSize: widget.fontSize,
                      color: widget.selectedTextColor != null
                          ? widget.selectedTextColor
                          : Colors.black,
                    ),
                  ),
                TextSpan(
                  text: result.substring(
                    _textEditingController.text.indexOf(
                          _textEditingController.text.substring(
                              _textEditingController.text.length - 1),
                        ) +
                        1,
                    result.length,
                  ),
                  style: TextStyle(
                    fontSize: widget.fontSize,
                    color: widget.unSelectedTextColor != null
                        ? widget.unSelectedTextColor
                        : Colors.grey[400],
                  ),
                )
              ],
            )
          : TextSpan(
              text: result,
              style: TextStyle(
                fontSize: widget.fontSize,
                color: widget.unSelectedTextColor != null
                    ? widget.unSelectedTextColor
                    : Colors.grey[400],
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          autocorrect: widget.autoCorrect,
          enabled: widget.enabled,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          onSubmitted: widget.onSubmitted,
          onTap: widget.onTap,
          controller: _textEditingController,
          decoration: InputDecoration(
            hintText: widget.hintText,
            contentPadding: const EdgeInsets.all(10.0),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.disabledBorderColor != null
                      ? widget.borderRadius
                      : Colors.grey[200]),
              borderRadius: BorderRadius.all(
                Radius.circular(widget.borderRadius),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.enabledBorderColor != null
                    ? widget.borderRadius
                    : Colors.grey[200],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(widget.borderRadius),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.focusedBorderColor != null
                      ? widget.borderRadius
                      : Colors.grey[200]),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.borderRadius),
                topRight: Radius.circular(widget.borderRadius),
              ),
            ),
          ),
          style: TextStyle(
            fontSize: widget.fontSize,
          ),
          cursorColor: widget.cursorColor != null
              ? widget.cursorColor
              : Colors.grey[600],
        ),
        Container(
          height: widget.itemsShownAtStart * widget.singleItemHeight,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: results.length,
            itemBuilder: (context, index) {
              return Container(
                height: widget.singleItemHeight,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      index == (results.length - 1) ? widget.borderRadius : 0.0,
                    ),
                    bottomRight: Radius.circular(
                      index == (results.length - 1) ? widget.borderRadius : 0.0,
                    ),
                  ),
                ),
                child: _getRichText(results[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
