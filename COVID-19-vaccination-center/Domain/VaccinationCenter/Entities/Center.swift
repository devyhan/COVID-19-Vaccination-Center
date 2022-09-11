//
//  Center.swift
//  COVID-19-vaccination-center
//
//  Created by YHAN on 2022/08/28.
//

// DTO를 사용하는 이유는 Model(Entity)를 어디에도 종속적이지 않게 만들 수 있고 DataAccess layer를 통해 받는 데이터 응답이 달라질때마다 DTO만 수정하면 되고, Domain model은 수정할 필요가 없게 만들어 유지보수를 더 쉽게 만들기 떄문에 사용
struct Center {
  var centerName: String
  var facilityName: String
  var address: String
  var updatedAt: String
  var phoneNumber: String
  var lat: String
  var lng: String
}
