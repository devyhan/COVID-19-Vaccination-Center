//
//  CenterDTO.swift
//  COVID-19-vaccination-center
//
//  Created by YHAN on 2022/09/11.
//

import Foundation

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
