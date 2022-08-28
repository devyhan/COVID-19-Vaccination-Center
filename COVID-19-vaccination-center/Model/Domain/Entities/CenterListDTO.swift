//
//  CenterListDTO.swift
//  COVID-19-vaccination-center
//
//  Created by YHAN on 2022/08/26.
//

import Foundation

struct CenterListDTO<T>: Codable where T: Codable {
  let page: Int //  0,
  let perPage: Int//  0,
  let totalCount: Int//  0,
  let currentCount: Int //  0,
  let matchCount: Int//  0,
  let data: Array<T>//  []
}

struct CenterDTO: Codable {
  let id: Int // 0,
  let centerName: String // "string",
  let sido: String // "string",
  let sigungu: String// "string",
  let facilityName: String// "string",
  let zipCode: String// "string",
  let address: String// "string",
  let lat: String// "string",
  let lng: String// "string",
  let createdAt: String// "string",
  let updatedAt: String// "string",
  let centerType: String// "string",
  let org: String// "string",
  let phoneNumber: String// "string"
}
