//
//  ViewUtil.swift
//  ReReddit
//
//  Created by nitin muthyala on 25/6/17.
//  Copyright © 2017 Spaceage Labs. All rights reserved.
//

import Foundation
import UIKit
public class ViewUtil{
    
    
    
    /// Primary color based on current theme
    ///
    /// - Returns: Current Primary Color
    static func getPrimaryColor() -> UIColor{
        
        return UIColor(red: 233/255.0, green: 100/255.0, blue: 67/255.0, alpha: 1.0) //
    }
    
    /// Primary color based on current theme
    ///
    /// - Returns: Current Primary Color
    static func getSecondaryColor() -> UIColor{
        
        return UIColor(red: 144/255.0, green: 48/255.0, blue: 149/255.0, alpha: 1.0) //
    }
    
    
    
    /// Get the cell height based on the topic title
    ///
    /// - Parameters:
    ///   - title: topic title
    ///   - view: parent view ( View controllers main view)
    /// - Returns: Cell Height
    static func getCellHeightFor(title:String,view:UIView) -> CGFloat{
        
        let textWidth = view.frame.width - (80) // padding 20 + 15 each side
        let textSize = CGSize(width: textWidth, height: 1000)
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 16)]
        let estimatedFram = NSString(string: title).boundingRect(with: textSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return estimatedFram.height + 90
    }
    
    
    static func popAlertView(vc:UIViewController, title:String,message:String,option:String){
        
        let alert = UIAlertController(title: title  , message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: option, style: UIAlertActionStyle.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    
    
}
