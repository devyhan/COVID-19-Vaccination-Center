//
//  VaccinationCenter.swift
//  COVID-19-vaccination-center
//
//  Created by YHAN on 2022/08/25.
//

import Foundation
import RxSwift

protocol VaccinationCenter {
  func fetchCenter(page: Int) -> Observable<[CenterDTO]>
}

class VaccinationCenterImpl: VaccinationCenter {
  let apiClient: APIClient
  
  init() {
    self.apiClient = APIClientImpl()
  }
  
  func fetchCenter(page: Int) -> Observable<[CenterDTO]> {
    let url = "https://api.odcloud.kr/api/15077586/v1/centers?page=\(page)&perPage=10&serviceKey=bNmSjmL3NWL%2FmAmsQV0SyDT%2B8DCdZckhVg5%2FtSsmJHa47eBZBE%2BaFvCHYxeM1Dsz2FcgQ64elqYL3mr6GUyjOg%3D%3D"
    
    return apiClient
      .buildRequest(url: url)
      .add(method: .get)
      .fetch()
      .map { data in
        guard let response = try? JSONDecoder().decode(CenterListDTO<CenterDTO>.self, from: data) else {
          throw NSError(domain: "Decoding error", code: -1, userInfo: nil)
        }
        return response.data
      }
  }
}





