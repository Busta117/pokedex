//
//  UIImageView.swift
//  PokeDex
//
//  Created by Santiago Bustamante on 15/05/20.
//  Copyright © 2020 Santiago Bustamante. All rights reserved.
//

import Alamofire
import AlamofireImage
import UIKit

extension UIImageView {
    func cancelImageRequest() {
        af.cancelImageRequest()
    }

    func set(imageUrl url: String?, placeholder: UIImage? = nil, fallbackImage: UIImage? = nil, complete: ((_ imageLoaded: Bool) -> Void)? = nil) {
        if let placeholder = placeholder {
            image = placeholder
        }

        if let urlStr = url, let url = URL(string: urlStr) {
            af.setImage(withURL: url, placeholderImage: placeholder) { response in
                if let _ = response.value {
                    complete?(true)
                } else {
                    if let placeholder = placeholder {
                        self.image = placeholder
                    }
                    if let fallbackImage = fallbackImage {
                        self.image = fallbackImage
                    }
                    complete?(false)
                }
            }
        }
    }
}

extension UIImage {
    open class func from(color: UIColor, size: CGSize = CGSize(width: 10, height: 10)) -> UIImage {
        let imageView = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        imageView.backgroundColor = color

        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newViewImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newViewImage!
    }
}
