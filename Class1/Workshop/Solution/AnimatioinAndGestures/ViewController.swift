/*
 * ViewController.swift
 * Created by Kajetan Dąbrowski on 16/03/2018.
 *
 * iOS Level Up 2018
 * Copyright 2018 DaftMobile Sp. z o. o.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or  * implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import UIKit

class ViewController: UIViewController {

    private var grabOffset: [UIView: CGVector] = [:]

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        view.addGestureRecognizer(doubleTap)
    }

    private func spawnCircle(at center: CGPoint, animated: Bool) {
        let side: CGFloat = CGFloat.random(min: 70, max: 100)
        let circle = UIView(frame: CGRect(origin: .zero, size: CGSize(width: side, height: side)))
        circle.layer.cornerRadius = side * 0.5
        circle.backgroundColor = .randomBrightColor()
        circle.center = center
        view.addSubview(circle)

        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        circle.addGestureRecognizer(longPress)

        let tripleTap = UITapGestureRecognizer(target: self, action: #selector(handleTripleTap(_:)))
        tripleTap.numberOfTapsRequired = 3
        circle.addGestureRecognizer(tripleTap)

        if animated {
            circle.alpha = 0
            circle.transform = CGAffineTransform(scaleX: 2, y: 2)
            let animator = UIViewPropertyAnimator(duration: 0.2, dampingRatio: 0.7, animations: {
                circle.alpha = 1
                circle.transform = CGAffineTransform.identity
            })
            animator.startAnimation()
        }
    }

    @objc func handleTripleTap(_ tap: UITapGestureRecognizer) {
        guard let view = tap.view else { return }
        let animator = UIViewPropertyAnimator(duration: 0.2, curve: .easeIn) {
            view.alpha = 0.0
            view.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
        animator.addCompletion { position in
            view.removeFromSuperview()
        }
        animator.startAnimation()
    }

    @objc func handleDoubleTap(_ recognizer: UITapGestureRecognizer) {
        spawnCircle(at: recognizer.location(in: view), animated: true)
    }

    @objc func handleLongPress(_ longPress: UILongPressGestureRecognizer) {
        guard let grabbedView = longPress.view else { return }
        let touchLocation = longPress.location(in: view)
        switch longPress.state {
        case .began:
            grab(view: grabbedView, up: true)
            grabOffset[grabbedView] = CGVector(dx: touchLocation.x - grabbedView.center.x, dy: touchLocation.y - grabbedView.center.y)
        case .changed:
            let grabOffset = self.grabOffset[grabbedView] ?? CGVector.zero
            grabbedView.center = CGPoint(x: touchLocation.x - grabOffset.dx, y: touchLocation.y - grabOffset.dy)
        case .cancelled:
            fallthrough
        case .ended:
            grab(view: grabbedView, up: false)
            grabOffset[grabbedView] = nil
        default:
            return
        }
    }

    private func grab(view: UIView, up: Bool) {
        let animator = UIViewPropertyAnimator(duration: 0.15, curve: .linear) {
            view.transform = up ? CGAffineTransform(scaleX: 1.2, y: 1.2) : CGAffineTransform.identity
            view.alpha = up ? 0.7 : 1.0
        }
        self.view.bringSubview(toFront: view)
        animator.startAnimation()
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return (otherGestureRecognizer as? UITapGestureRecognizer)?.numberOfTapsRequired == 3
    }
}
