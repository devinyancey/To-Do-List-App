//
//  Textfield+NoReturn.swift
//  To Do This
//
//  Created by Devin Yancey on 12/3/16.
//  Copyright © 2016 Devin Yancey. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    public func set(color: UIColor) -> UIImage {
        
        var newImage = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(newImage.size, false, newImage.scale)
        color.set()
        newImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
