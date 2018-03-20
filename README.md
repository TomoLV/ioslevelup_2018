[![iOS Level Up Spring 2018](assets/logo.png)](https://github.com/DaftMobile/ioslevelup_2018)

![Platforms](https://img.shields.io/badge/platforms-iOS-blue.svg)
![License: Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)
[![Twitter Follow ](https://img.shields.io/twitter/follow/espadrine.svg?style=social&label=Follow)](https://twitter.com/mdab121)
[![Twitter Follow](https://img.shields.io/twitter/follow/espadrine.svg?style=social&label=Follow)](https://twitter.com/DaftMobile)

# iOS Level Up class – MiMUW, Spring 2018


## Classes

### Class 1: UIKit Animations, Gesture Recognition

#### Animations

UIKit animations are simple and easy to master! UIKit is a high level UI Framework, based on Core Animation. Core Animation animations are much more customizable than UIKit's, but UIKit will make it simple to get you started.

[![UIKit](assets/ca_architecture@2x.png)](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/CoreAnimation_guide/Introduction/Introduction.html)

The simplest animation API looks like this:

```swift
let someView = ... // some view
UIView.animate(withDuration: 0.4) {
  someView.alpha = 0.3
}
```

You can also customize your animation timing functions, and add completion closures like this:

```swift
UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
  someView.alpha = 0
}, completion: { completed in
  someView.removeFromSuperview()
})
```

This makes it really easy to chain your animations - just add a new one in the completion closure of the previous one!

There is also a new animation API – `UIViewPropertyAnimator`. It's far more customizable and it's able to handle **interactive** and **interruptible** animations! Both topics are too advanced for this class, but you can learn more [here](https://developer.apple.com/documentation/uikit/uiviewpropertyanimator).

To just use `UIViewPropertyAnimator`, you first create an animator, and then call `startAnimation()` on it.

```swift
let animator = UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut) {
  someView.frame = someView.frame.offsetBy(dx: 100, dy: 0)
}
animator.startAnimation()
```

#### Gestures

Touch detetection on iOS is done using the `UIGestureRecognizer` system. It makes it really simple to handle gesture detection. `UIGestureRecognizer` is an abstract class. To add gesture handling you need three basic steps:

1. Instantiate a concrete Gesture Recognizer (for example `UITapGestureRecognizer`) with a target-action.
2. Optional: configure the gesture
3. Add your gesture to a view.

Gestures on iOS are handled by the gesture system. Each gesture recognizer instance is responsible for recognizing **one** gesture.

There are two types of `UIGestureRecognizer` subclasses. These are discreet and continous gestures. Each gesture operates using a state machine. Discreet gestures are either recognized or failed (tap, swipe). Continous gestures begin at some point, and take a while to complete (for example a pan – user starts panning, continues for a while, and then lifts off their finger). Each gesture state machine looks as following:

![UIGestureRecognizer State Machine](assets/ui_gesture_recognizer_statee_machine.png)

All gestures start in the state `possible`, and then move either to `failed` or `recognized` (discreet gestures) and `began` (for continous gestures). It's a race condition – whichever recognizer recognizes **first** gets to handle the gesture until it's finished. You can override this behaviour for raw gesture handling using methods like `delaysTouchesBegan` for mixing with raw touch handling, or gesture recognizer delegates for interactions between gestures.

You can also subclass `UIGestureRecognizer` and use its API to create your own gestures. You just have to follow this state machine graph, as well as follow the rule *fail as quickly as possible* (which all gestures should do), and you'll get your own gesture recognizer which just works great with the whole gesture system.

See more [here](https://developer.apple.com/documentation/uikit/uigesturerecognizer).

_Workshop:_

See the workshop assignment [here](Class%201/Workshop/workshop1.md).


## Resources

- [Install Swift on Linux](https://swift.org/download/#releases) - we're using version `4.0`
- [Open Source Swift](https://swift.org)
- [Free Swift Book](https://itunes.apple.com/us/book/the-swift-programming-language/id881256329?mt=11)
- [iOS Documentation](https://developer.apple.com/documentation/)
- [Apple Development Videos](https://developer.apple.com/videos/)

## Contact

- [E-mail](mailto:michal.dabrowski+mimuw@daftcode.pl)
- [Twitter](https://twitter.com/mdab121)
