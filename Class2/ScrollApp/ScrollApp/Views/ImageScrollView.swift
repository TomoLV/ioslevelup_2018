/*
 * ImageScrollView.swift
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

class ImageScrollView: UIScrollView {

    var index: Int
    var image: UIImage? {
        get { return imageView.image }
        set {
            imageView.image = newValue
            resize()
        }
    }

    private let imageView: UIImageView

    init(image: UIImage?, index: Int) {
        self.index = index
        self.imageView = UIImageView(image: image)
        super.init(frame: CGRect(origin: .zero, size: image?.size ?? .zero))
        addSubview(imageView)
        self.delegate = self
        resize()
        minimumZoomScale = 1.0
        maximumZoomScale = 4.0
    }

    override var frame: CGRect {
        didSet {
            resize()
        }
    }

    private func resize() {
        guard let image = image else { return }
        zoomScale = 1.0
        let widthProportion = bounds.width / image.size.width
        let heightProportion = bounds.height / image.size.height
        let proportion = min(widthProportion, heightProportion)
        imageView.frame.size.width = proportion * image.size.width
        imageView.frame.size.height = proportion * image.size.height
        contentSize = imageView.frame.size
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame.origin.x = imageView.frame.width < bounds.width ? (bounds.width - imageView.frame.width) * 0.5 : 0
        imageView.frame.origin.y = imageView.frame.height < bounds.height ? (bounds.height - imageView.frame.height) * 0.5 : 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension ImageScrollView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? { return imageView }
}
