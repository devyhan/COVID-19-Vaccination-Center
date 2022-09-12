//
//  VaccinationCenterMock.swift
//  COVID-19-vaccination-center
//
//  Created by YHAN on 2022/09/12.
//

import RxSwift

final class VaccinationCenterMock: VaccinationCenter {
  func fetchCenter(page: Int) -> Observable<[Center]> {
    let data = [
      Center(
        centerName : "코로나19 중앙 예방접종센터",
        facilityName : "국립중앙의료원 D동",
        address : "서울특별시 중구 을지로 39길 29",
        updatedAt : "2021-07-16 04:55:07",
        phoneNumber : "02-2260-7114",
        lat : "37.567817",
        lng : "127.004501"
      ),
      Center(
        centerName : "코로나19 중부권역 예방접종센터",
        facilityName : "천안시 실내배드민턴장 1층",
        address : "충청남도 천안시 동남구 천안대로 357",
        updatedAt : "2021-07-16 04:55:08",
        phoneNumber : "",
        lat : "36.779887",
        lng: "127.164717"
      )
    ]
    
    return Observable.just(data)
  }
}
