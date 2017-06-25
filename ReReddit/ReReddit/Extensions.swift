//
//  Extensions.swift
//  ReReddit
//
//  Created by nitin muthyala on 26/6/17.
//  Copyright © 2017 Spaceage Labs. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    public func customSetup(title:String,view:UIView){
        self.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100.0)
        
        // Setup Height
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height + 20)
        
        // Apply Gradient
        let color1 = ViewUtil.getPrimaryColor().cgColor
        let color2 = ViewUtil.getSecondaryColor().cgColor
        gradient.colors = [color1, color2]
        gradient.startPoint = .zero
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        let gradImage = getImageFromGradient(layer: gradient)
        
        self.setBackgroundImage(gradImage, for: .default)
        self.shadowImage = UIImage() // Remove Shadow
        self.backgroundColor = .clear
        self.tintColor = .white // For white title
        
        // Left Large title setup
        let fontSize:CGFloat = 36;
        let font:UIFont = UIFont.boldSystemFont(ofSize: fontSize);
        let attributes:[String : Any] = [NSFontAttributeName: font];
        
        let item = UIBarButtonItem.init();
        item.title = title;
        item.setTitleTextAttributes(attributes, for: UIControlState.normal);
        
        let navigationItem = UINavigationItem()
        navigationItem.leftBarButtonItem = item
        self.items = [navigationItem]
        
    }
    
    // MARK :- Helper methods
    
    /// Converts Gradiant to image
    ///
    /// - Parameter layer: Gradiant layer
    /// - Returns: Gradian Image
    func getImageFromGradient(layer:CAGradientLayer) ->UIImage?{
        UIGraphicsBeginImageContext(layer.frame.size)
        if UIGraphicsGetCurrentContext() != nil {
            layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        
        return nil
    }
    
}


extension UIView {
    
    public func applyBackground(){
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        
        let color1 = UIColor(displayP3Red: 251/255, green: 251/255, blue: 251/255, alpha: 1).cgColor
        let color2 = UIColor(displayP3Red: 230/255, green: 226/255, blue: 226/255, alpha: 1).cgColor
        gradient.colors = [color1, color2]
        gradient.startPoint = .zero
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        self.backgroundColor = .clear
        self.layer.insertSublayer(gradient, at: 0)
    }
    
}



