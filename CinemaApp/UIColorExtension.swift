//
//  UIColorExtension.swift
//  CinemaApp
//
//  Created by Владимир Макаров on 25.08.2022.
//

import UIKit

extension UIColor{
    
    static var background: UIColor{
        return UIColor(named: "background") ?? UIColor.clear
    }
    static var backgroundLight: UIColor{
        return UIColor(named: "lightBackground") ?? UIColor.clear
    }
    static var text: UIColor{
        return UIColor(named: "text") ?? UIColor.clear
    }
    static var title: UIColor{
        return UIColor(named: "title") ?? UIColor.clear
    }
    static var infoBackground: UIColor{
        return UIColor(named: "infoBackground") ?? UIColor.clear
    }
    static var dashedLine: UIColor{
        return UIColor(named: "dashedLine") ?? UIColor.clear
    }
    
}
