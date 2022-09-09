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

struct CenterDTO: Codable {
  let id: Int
  let centerName: String
  let sido: String
  let sigungu: String
  let facilityName: String
  let zipCode: String
  let address: String
  let lat: String
  let lng: String
  let createdAt: String
  let updatedAt: String
  let centerType: String
  let org: String
  let phoneNumber: String
}
