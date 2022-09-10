//
//  Extension.swift
//  COVID-19-vaccination-center
//
//  Created by YHAN on 2022/09/10.
//

import UIKit

extension UIImage {
  convenience init?(assetName: Images) {
    self.init(named: assetName.rawValue)
  }
}

extension UIColor {
  convenience init?(assetName: Colors) {
    self.init(named: assetName.rawValue)
  }
}
