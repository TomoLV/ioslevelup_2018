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

## Resources

- [Install Swift on Linux](https://swift.org/download/#releases) - we're using version `4.0`
- [Open Source Swift](https://swift.org)
- [Free Swift Book](https://itunes.apple.com/us/book/the-swift-programming-language/id881256329?mt=11)
- [iOS Documentation](https://developer.apple.com/documentation/)
- [Apple Development Videos](https://developer.apple.com/videos/)

## Contact

- [E-mail](mailto:michal.dabrowski+mimuw@daftcode.pl)
- [Twitter](https://twitter.com/mdab121)
