//
//  UIColor+Extension.swift
//  GraphMaker
//
//  Created by Tatiana Bernatskaya on 2018-09-22.
//  Copyright © 2018 Tatiana Bernatskaya. All rights reserved.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
