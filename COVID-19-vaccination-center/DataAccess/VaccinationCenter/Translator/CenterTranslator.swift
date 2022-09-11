//
//  CenterTranslator.swift
//  COVID-19-vaccination-center
//
//  Created by YHAN on 2022/09/11.
//

protocol CenterTranslatorType {
  func translate(_ dto: CenterDTO) -> Center
}

final class CenterTranslator: CenterTranslatorType {
  func translate(_ dto: CenterDTO) -> Center {
    return .init(
      centerName: dto.centerName,
      facilityName: dto.facilityName,
      address: dto.address,
      updatedAt: dto.updatedAt,
      phoneNumber: dto.phoneNumber,
      lat: dto.lat,
      lng: dto.lng
    )
  }
}
