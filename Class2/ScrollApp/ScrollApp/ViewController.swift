/*
 * ViewController.swift
 * Created by Kajetan Dąbrowski on 25/03/2018.
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

class ViewController : UIViewController {

    var scrollView: InfiniteScrollView { return view as! InfiniteScrollView }
    var titleView: UIView?

    private func pathForPhoto(at index: Int) -> String {
        guard let path = Bundle.main.path(forResource: "photo\(index)", ofType: "jpg") else { fatalError("Invalid photo path") }
        return path
    }

    override func loadView() {
        let images = [1, 2, 3, 4, 5].map { pathForPhoto(at: $0) }
        self.view = InfiniteScrollView(photoPaths: images)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self

        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeUp(_:)))
        swipeUp.direction = .up
        swipeUp.delegate = self
        view.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer.init(target: self, action: #selector(swipeDown(_:)))
        swipeDown.direction = .down
        swipeDown.delegate = self
        view.addGestureRecognizer(swipeDown)
    }

    @objc func swipeUp(_ gesture: UISwipeGestureRecognizer) {
        guard self.titleView == nil else { return }
        let titleView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 60.0)))
        titleView.backgroundColor = .red

        view.addSubview(titleView)
        self.titleView = titleView
        positionTitle()
        titleView.frame.origin.y = scrollView.bounds.maxY
        UIView.animate(withDuration: 0.2) {
            self.positionTitle()
        }
    }

    @objc func swipeDown(_ gesture: UISwipeGestureRecognizer) {
        guard let titleView = self.titleView else { return }

        UIView.animate(withDuration: 0.2, animations: {
            titleView.frame.origin.y = self.scrollView.bounds.maxY
        }, completion: { _ in
            titleView.removeFromSuperview()
            self.titleView = nil
        })
    }

    private func positionTitle() {
        guard let titleView = titleView else { return }
        titleView.frame.origin.x = scrollView.contentOffset.x
        titleView.frame.origin.y = scrollView.bounds.maxY - titleView.frame.height
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        scrollView.setup(size: size)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        positionTitle()
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return otherGestureRecognizer is UIPanGestureRecognizer
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let window = view.window else { return false }
        let touchLocation = touch.location(in: window)
        return abs(touchLocation.y - window.bounds.maxY) < 70.0
    }
}
