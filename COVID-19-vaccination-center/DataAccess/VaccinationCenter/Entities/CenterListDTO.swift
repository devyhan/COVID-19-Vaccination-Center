//
//  CenterListDTO.swift
//  COVID-19-vaccination-center
//
//  Created by YHAN on 2022/08/26.
//

import Foundation

struct CenterListDTO<T>: Codable where T: Codable {
  let page: Int
  let perPage: Int
  let totalCount: Int
  let currentCount: Int
  let matchCount: Int
  let data: Array<T>
}
