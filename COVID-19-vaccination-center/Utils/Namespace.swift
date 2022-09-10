//
//  ColorSet.swift
//  COVID-19-vaccination-center
//
//  Created by YHAN on 2022/08/26.
//

import UIKit

enum Images: String {
  case building, chat, hospital, telephone, placeholder
  case topAlignment = "top-alignment"
  
  var image: UIImage {
    return UIImage(named: self.rawValue) ?? UIImage()
  }
}

enum Colors: String {
  case red, blue, gray
  
  var color: UIColor {
    return UIColor(named: self.rawValue) ?? .clear
  }
}
