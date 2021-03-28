//
//  UIImageExtension.swift
//  AthenaApp
//
//  Created by Arun Satyavan on 28/03/21.
//

import UIKit

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
