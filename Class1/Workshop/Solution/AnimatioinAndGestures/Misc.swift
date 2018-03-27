/*
 * Misc.swift
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

import Foundation
import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        return random(min: 0.0, max: 1.0)
    }

    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        assert(max > min)
        return min + ((max - min) * CGFloat(arc4random()) / CGFloat(UInt32.max))
    }
}

extension UIColor {
    static func randomBrightColor() -> UIColor {
        return UIColor(hue: .random(),
                       saturation: .random(min: 0.5, max: 1.0),
                       brightness: .random(min: 0.7, max: 1.0),
                       alpha: 1.0)
    }
}
