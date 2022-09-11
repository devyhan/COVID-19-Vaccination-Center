//
//  VaccinationCenter.swift
//  COVID-19-vaccination-center
//
//  Created by YHAN on 2022/08/25.
//

import Foundation
import RxSwift

protocol VaccinationCenter {
  func fetchCenter(page: Int) -> Observable<[Center]>
}
