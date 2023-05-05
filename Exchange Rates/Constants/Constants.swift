//
//  Constants.swift
//  Exchange Rates
//
//  Created by sidzhe on 01.05.2023.
//

import Foundation
import UIKit

//MARK: Fonts and Images

enum Constants {
    enum Images {
        static var backgroung: UIImage {
            UIImage(named: "background") ?? UIImage()
        }
        static var bitcoin: UIImage {
            UIImage(named: "bitcoin") ?? UIImage()
        }
        static var litecoin: UIImage {
            UIImage(named: "litecoin") ?? UIImage()
        }
        static var ethereum: UIImage {
            UIImage(named: "ethereum") ?? UIImage()
        }
        static var happy: UIImage {
            UIImage(named: "happy") ?? UIImage()
        }
        static var blockchain: UIImage {
            UIImage(named: "Blockchain") ?? UIImage()
        }
    }
    
    enum Font {
        static var aldrichRegular: UIFont {
            UIFont(name: "Aldrich-Regular", size: 20)!
        }
    }
    
    enum Color {
        static var colorCell: UIColor {
            UIColor(named: "ColorCell")!
        }
    }
    
    enum Str {
        static var exchange = "Exchange"
        static var identifier = "Cell"
    }

}



