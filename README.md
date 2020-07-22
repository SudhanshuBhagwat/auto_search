# Auto Search 

Add a simple Auto Completing TextFeild to you project to spice up the user experience.

## A much more easier way to add create an auto search field
Creating it is as simple as

```
    List<String> listOfNames = ['Sample', 'Sample2', 'Sample3', ...so on];

    AutoSearchInput(
        data: listOfNames,                    
        maxElementsToDisplay: 10,
        onItemTap: (int index) {
          //Do something cool
        }
    )
```

#### It also has some of the TextField controls that would help you have a much more fine grained controls over the search field

### Following are the properties that you can work with: 

* data -> @Required
* maxElementsToDisplay -> @Required
* onItemTap -> @Required
* selectedTextColor
* unSelectedTextColor
* enabledBorderColor
* disabledBorderColor
* focusedBorderColor
* cursorColor
* borderRadius (Default value = 10.0)
* fontSize (Default value = 20.0)
* singleItemHeight (Default value = 40.0)
* itemsShownAtStart (Default value = 10)
* hintText (Default vallue = 'Enter a name')
* autoCorrect (Default vallue = true)
* enabled (Default vallue = true)
* onSubmitted
* onEditingComplete

## Let's have a look at the complete Example Widget

```
class HomePage extends StatelessWidget {
  final List<String> names = [
    "Ayden Ram",
    "Rowan Trevon",
    "Garrison Faisal",
    "Bridie Ford",
    "Rameel Xavier",
    "Abriel Yestin",
    "Cal Heston",
    "Ryland Nick",
    "Orson Kaylen",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: AutoSearchInput(
        data: names, 
        maxElementsToDisplay: 10,
        onItemTap: (int index) {
          //Do something cool
        }
      ),
    );
  }
}
```

## Want to add custom logic when the items are tapped?

### The onItemTap function lets you add custom logic. It contains index as an argument which is basically the index of the item from the original data array which is passed.

## Output
![Sample Example App Output](https://i.imgur.com/TtqCVPY.gif)