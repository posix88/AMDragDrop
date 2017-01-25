# AMDragDrop

[![Version](https://img.shields.io/cocoapods/v/AMDragDrop.svg?style=flat)](http://cocoapods.org/pods/AMDragDrop)
[![License](https://img.shields.io/cocoapods/l/AMDragDrop.svg?style=flat)](http://cocoapods.org/pods/AMDragDrop)
[![Platform](https://img.shields.io/cocoapods/p/AMDragDrop.svg?style=flat)](http://cocoapods.org/pods/AMDragDrop)

## Description

AMDragDrop is a simple subclass for UIView that adds in a simple way the drag and drop funtionality.

In order to enable dragging on your view you have to call this:

```swift
dragView.enableDragging(dragDelegate: self, dropViews: [(dropView)])
```
with dropViews is an array of possible UIView in which you could drop your view.

The module expose two protocols you could subscribe to: AMDragDropDelegate and AMHoverDelegate.

##AMDragDropDelegate
This is the protocol you have to subscribe to in order to have the basic information of the drag and drop funtionality.

The only mandatory method is:

```swift
func view(_ view: UIView, wasDroppedOnDrop drop: UIView!)
```

This method informs you that your dragged view was dropped on the drop views that you specified during the initialization.

If you're not interested in using drop views you could use:

```swift
func draggingEnd(forView view:UIView)
```

##AMHoverDelegate
This is the protocol you have to subscribe to in order to have the basic information during the hovering of your view on the drop views that you specified during the initialization. 

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Installation

AMDragDrop is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AMDragDrop"
```

## Author

Antonino Francesco Musolino, ninomusolino@gmail.com

Twitter [@Ninomusolino](https://twitter.com/NinoMusolino)

## License

This is a modified and "Swifty" version of [UIView+DragDrop](https://github.com/ryanmeisters/UIView-DragDrop) by ryanmeisters.

AMDragDrop is available under the MIT license. See the LICENSE file for more info.
