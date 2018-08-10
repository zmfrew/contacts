//
//  ColorGradient.swift
//  Contacts
//
//  Created by Zachary Frew on 8/10/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit

extension UIView {
    
    /*
     Adds a vertical gradient layer with two UIColors to the UIView.
     -  Parameter topColor: the top UIColor.
     -  Paraemeter bottomColor: the bottom UIColor.
     */
    
    func addVerticalGradientLayer(topColor: UIColor, bottomColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        self.layer.insertSublayer(gradient, at: 0)
    }
    
}

extension UIColor {
    
    static var primaryColor: UIColor {
        return UIColor(red: 226/255, green: 251/255, blue: 241/255, alpha: 1)
        
    }
    
    static var secondaryColor: UIColor {
        return UIColor(red: 126/255, green: 208/255, blue: 197/255, alpha: 1)
    }
    
}
