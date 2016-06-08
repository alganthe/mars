---
layout: docsPage
title: Attributes
group: development
order: 5
---

# What is the attributes framework?
The attributes framework is quite simply a set of code that handles the UI stuff for you. This means you don't have to spend dozens of hours making your own UI dialog just to set some values. Instead you just write a simple attributes config and call the function to open it.

# Why do I have to use it?
A consistent UI design throughout Mars is a main priority and in order to achieve this, _almost_ all dialogs must be created using the attributes framework. Not only that but it centralises the UI code into a single component, as appose to multiple components all doing their own thing when it comes to UI.

# How do I use it?
1. Add a `CfgAttributes.hpp` file to your component's root folder
2. Place the following config in the file
3. Include `CfgAttributes.hpp` in your `config.cpp` **after** the `script_component.hpp` include
4. Go through the various control types available in the sidebar

```c++
class GVARMAIN(attributes) {
    class ADDON {
        class YourAttributeName {
            displayName = "";
            actionConfirm = "";
            actionCancel = "";
            class AttributeCategories {
                class YourCategoryOne {
                    class AttributeItems {
                        class YourItemOne {
                            displayName = "";
                            tooltipText = "";
                            class AttributeControls {
                                class YourControlOne {};
                            };
                        };
                    };
                };
            };
        };
    };
};
```

A more fuller example can be found [here](https://github.com/jameslkingsley/Mars/blob/master/addons/environment/CfgAttributes.hpp).

# Controls

{::options parse_block_html="true" /}

## Combo

### Properties
{: .no-margin}

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Type</th>
            <th>Default</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>condition</td>
            <td>string</td>
            <td>"true"</td>
            <td>Condition that must return true to show the control. Arguments passed to the condition are <code>[selection&lt;ARRAY&gt;]</code></td>
        </tr>
        <tr>
            <td>values</td>
            <td>string/array</td>
            <td>[]</td>
            <td>Values to use for each combo box item (<a href="https://community.bistudio.com/wiki/lbSetData">lbSetData</a>). You can either provide an array of values or a code string that returns an array of values</td>
        </tr>
        <tr>
            <td>labels</td>
            <td>string/array</td>
            <td>[]</td>
            <td>Text to use for each combo box item. You can either provide an array of strings or a code string that returns an array of strings</td>
        </tr>
        <tr>
            <td>selected</td>
            <td>number/string</td>
            <td>""</td>
            <td>Default selected option when first creating the control. It must match the data type of the items in <code>values</code>. If it’s a string then it’s <code>call compile</code>'d and must return the value</td>
        </tr>
        <tr>
            <td>expression</td>
            <td>string</td>
            <td>""</td>
            <td>Code to run when the user presses the final OK button. It will only run if the value of the control changes</td>
        </tr>
    </tbody>
</table>

### Events
<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>onLBSelChanged</td>
            <td>Fires when the selection in the combo box has changed. The left mouse button has been released and the new selection is fully made.</td>
        </tr>
    </tbody>
</table>

### Examples
```c++
class Range {
    condition = "true";
    type = "COMBO";
    values[] = {1000, 2000, 3000, 4000, 5000};
    labels[] = {"1000m", "2000m", "3000m", "4000m", "5000m"};
    selected = 1000;
    expression = QUOTE([ARR_2(_this, 'range')] call FUNC(doThisFunction));
    onLBSelChanged = QUOTE(systemChat str _this);
};

class Years {
    condition = "true";
    type = "COMBO";
    values = "_years = []; for '_i' from 1982 to 2050 do {_years pushBack _i}; _years";
    labels = "_years = []; for '_i' from 1982 to 2050 do {_years pushBack str _i}; _years";
    selected = "date select 0";
    expression = QFUNC(doThisFunction);
};
```

## Slider

### Properties
{: .no-margin}

<table>
	<thead>
		<tr>
			<th>Name</th>
			<th>Type</th>
			<th>Default</th>
			<th>Description</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>condition</td>
			<td>string</td>
			<td>"true"</td>
			<td>Condition that must return true to show the control. Arguments passed to the condition are <code>[selection&lt;ARRAY&gt;]</code></td>
		</tr>
		<tr>
			<td>range</td>
			<td>array</td>
			<td>[]</td>
			<td>Min and max range for the slider</td>
		</tr>
		<tr>
			<td>step</td>
			<td>number</td>
			<td>0</td>
			<td>Step to use when pressing left/right on the slider</td>
		</tr>
		<tr>
			<td>position</td>
			<td>number/string</td>
			<td>""</td>
			<td>Default position when first creating the control. It must be within the range. If it’s a string then it’s <code>call compile</code>'d and must return the position number</td>
		</tr>
		<tr>
			<td>expression</td>
			<td>string</td>
			<td>""</td>
			<td>Code to run when the user presses the final OK button. It will only run if the position of the control changes</td>
		</tr>
	</tbody>
</table>

### Events
<table>
	<thead>
		<tr>
			<th>Name</th>
			<th>Description</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>onSliderPosChanged</td>
			<td>Fires when changing the position of the slider.</td>
		</tr>
	</tbody>
</table>

### Examples
```c++
class Overcast {
    condition = "true";
    type = "SLIDER";
    range[] = {0, 1};
    step = 0.1;
    position = "overcast";
    expression = "";
    onSliderPosChanged = QUOTE(\
        _ctrl = _this select 0;\
        _ctrl ctrlSetTooltip str (sliderPosition _ctrl);\
    );
};

class Range {
    condition = "true";
    type = "SLIDER";
    range[] = {0, 1000};
    step = 100;
    position = 500;
    expression = "";
    onSliderPosChanged = "";
};
```

## Edit

### Properties
{: .no-margin}

<table>
	<thead>
		<tr>
			<th>Name</th>
			<th>Type</th>
			<th>Default</th>
			<th>Description</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>condition</td>
			<td>string</td>
			<td>"true"</td>
			<td>Condition that must return true to show the control. Arguments passed to the condition are <code>[selection&lt;ARRAY&gt;]</code></td>
		</tr>
		<tr>
			<td>rows</td>
			<td>number</td>
			<td>0</td>
			<td>Number of rows to draw (more than 1 will result in a multi-line edit box)</td>
		</tr>
		<tr>
			<td>textPlain</td>
			<td>string</td>
			<td>""</td>
			<td>Text value to be placed into the edit box</td>
		</tr>
		<tr>
			<td>textCode</td>
			<td>string</td>
			<td>""</td>
			<td>Code that returns the text value to be placed into the edit box</td>
		</tr>
		<tr>
			<td>expression</td>
			<td>string</td>
			<td>""</td>
			<td>Code to run when the user presses the final OK button. It will only run if the value of the control changes</td>
		</tr>
	</tbody>
</table>

### Events
<table>
	<thead>
		<tr>
			<th>Name</th>
			<th>Description</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>onSetFocus</td>
			<td>Input focus is on control. It now begins to accept keyboard input.</td>
		</tr>
		<tr>
			<td>onKillFocus</td>
			<td>Input focus is no longer on control. It no longer accepts keyboard input.</td>
		</tr>
		<tr>
			<td>onKeyDown</td>
			<td>Pressing any keyboard key. Fired before the onKeyUp event.</td>
		</tr>
		<tr>
			<td>onKeyUp</td>
			<td>Releasing any keyboard key. Fired after the onKeyDown event.</td>
		</tr>
	</tbody>
</table>

### Examples
```c++
class Summary {
    condition = "true";
    type = "EDIT";
    rows = 5;
    textPlain = "";
    expression = "";
};

class Name {
    condition = "true";
    type = "EDIT";
    rows = 1;
    textCode = "name player";
    expression = "";
};
```

## Date

### Properties
{: .no-margin}

<table>
	<thead>
		<tr>
			<th>Name</th>
			<th>Type</th>
			<th>Default</th>
			<th>Description</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>condition</td>
			<td>string</td>
			<td>"true"</td>
			<td>Condition that must return true to show the control. Arguments passed to the condition are <code>[selection&lt;ARRAY&gt;]</code></td>
		</tr>
		<tr>
			<td>year</td>
			<td>number/string</td>
			<td>0</td>
			<td>Default year value. If code string, it must return a number</td>
		</tr>
		<tr>
			<td>month</td>
			<td>number/string</td>
			<td>0</td>
			<td>Default month value. If code string, it must return a number</td>
		</tr>
		<tr>
			<td>day</td>
			<td>number/string</td>
			<td>0</td>
			<td>Default day value. If code string, it must return a number</td>
		</tr>
		<tr>
			<td>expression</td>
			<td>string</td>
			<td>""</td>
			<td>Code to run when the user presses the final OK button. It will only run if the value of the control changes</td>
		</tr>
	</tbody>
</table>

### Events
<table>
	<thead>
		<tr>
			<th>Name</th>
			<th>Description</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>onLBSelChanged</td>
			<td>Fires when the selection in the combo box has changed. The left mouse button has been released and the new selection is fully made.</td>
		</tr>
	</tbody>
</table>

### Examples
```c++
class Date {
    condition = "true";
    type = "DATE";
    year = "date select 0";
    month = "date select 1";
    day = "date select 2";
    expression = QFUNC(setDateTime);
};

class FixedDate {
    condition = "true";
    type = "DATE";
    year = 1945;
    month = 11;
    day = 11;
    expression = QFUNC(setDateTime);
};
```