/*
 * InfiniteScrollView.swift
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

class InfiniteScrollView: UIScrollView {

    private let photoPaths: [String]
    private let imageContainerView = UIView()

    private var visiblePhotos: [ImageScrollView] = []
    private var recycledViews: Set<ImageScrollView> = Set<ImageScrollView>()

    init(photoPaths: [String]) {
        self.photoPaths = photoPaths
        super.init(frame: .zero)
        addSubview(imageContainerView)
        isPagingEnabled = true
    }

    override var frame: CGRect {
        didSet {
            setup(size: bounds.size)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    func setup(size: CGSize) {
        contentSize = CGSize(width: size.width * 3, height: size.height)
        imageContainerView.frame = CGRect(origin: .zero, size: contentSize)
        backgroundColor = .black
        indicatorStyle = .white

        recycledViews.formUnion(visiblePhotos)
        visiblePhotos.forEach { $0.removeFromSuperview() }
        visiblePhotos.removeAll()
        contentOffset.x = (contentSize.width - bounds.width) / 2.0
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        recenterIfNecessary()

        let visibleBounds = convert(bounds, to: imageContainerView)
        tileImages(from: visibleBounds.minX, to: visibleBounds.maxX)
    }

    private func image(at index: Int) -> UIImage? {
        guard index >= 0 && index < photoPaths.count else { return nil }
        return UIImage(contentsOfFile: photoPaths[index])
    }

    private func getOrRecycleImage(index: Int) -> ImageScrollView {
        let image = self.image(at: index)
        if let recycledPhoto: ImageScrollView = recycledViews.popFirst() {
            recycledPhoto.index = index
            recycledPhoto.image = image
            return recycledPhoto
        }
        return ImageScrollView(image: image, index: index)
    }

    private func placeNewPhotoOnTheRight(index: Int, edge: CGFloat) -> ImageScrollView {
        let image = getOrRecycleImage(index: index)
        image.frame.size = bounds.size
        image.frame.origin.x = edge
        image.frame.origin.y = imageContainerView.bounds.minY
        visiblePhotos.append(image)
        imageContainerView.addSubview(image)
        return image
    }

    private func placeNewPhotoOnTheLeft(index: Int, edge: CGFloat) -> ImageScrollView {
        let image = getOrRecycleImage(index: index)
        image.frame.size = bounds.size
        image.frame.origin.x = edge - image.frame.width
        image.frame.origin.y = imageContainerView.bounds.minY
        visiblePhotos.insert(image, at: 0)
        imageContainerView.addSubview(image)
        return image
    }

    private func index(after index: Int) -> Int {
        return (index + 1) % photoPaths.count
    }

    private func index(before index: Int) -> Int {
        return index - 1 >= 0 ? index - 1 : photoPaths.count - 1
    }

    private func recenterIfNecessary() {
        let currentOffset = contentOffset
        let contentWidth = contentSize.width
        let centerOffsetX = (contentWidth - bounds.width) / 2.0
        let distanceFromCenter = fabs(currentOffset.x - centerOffsetX)

        if distanceFromCenter >= bounds.width {
            contentOffset.x = centerOffsetX
            for image in visiblePhotos {
                var center = imageContainerView.convert(image.center, to: self)
                center.x += centerOffsetX - currentOffset.x
                image.center = convert(center, to: imageContainerView)
            }
        }
    }

    private func tileImages(from minX: CGFloat, to maxX: CGFloat) {
        if visiblePhotos.count == 0 { _ = placeNewPhotoOnTheRight(index: 0, edge: 0.0) }

        var lastVisiblePhoto = visiblePhotos.last!
        while lastVisiblePhoto.frame.maxX < maxX {
            lastVisiblePhoto = placeNewPhotoOnTheRight(index: index(after: lastVisiblePhoto.index), edge: lastVisiblePhoto.frame.maxX)
        }

        var firstVisiblePhoto = visiblePhotos.first!
        while firstVisiblePhoto.frame.minX > minX {
            firstVisiblePhoto = placeNewPhotoOnTheLeft(index: index(before: firstVisiblePhoto.index), edge: firstVisiblePhoto.frame.minX)
        }

        for (index, image) in visiblePhotos.reversed().enumerated() {
            if image.frame.maxX <= minX || image.frame.minX >= maxX {
                visiblePhotos.remove(at: visiblePhotos.count - 1 - index)
                image.removeFromSuperview()
                recycledViews.insert(image)
            }
        }
    }
}
