//
//  VaccinationCenterImpl.swift
//  COVID-19-vaccination-center
//
//  Created by YHAN on 2022/09/11.
//

import Combine
import RxSwift

final class VaccinationCenterImpl: VaccinationCenter {
  let apiClient: APIClient
  let translator: CenterTranslatorType
  
  init() {
    self.apiClient = APIClientImpl()
    self.translator = CenterTranslator()
  }
  
  func fetchCenter(page: Int) -> Observable<[Center]> {
    let url = "https://api.odcloud.kr/api/15077586/v1/centers?page=\(page)&perPage=10&serviceKey=bNmSjmL3NWL%2FmAmsQV0SyDT%2B8DCdZckhVg5%2FtSsmJHa47eBZBE%2BaFvCHYxeM1Dsz2FcgQ64elqYL3mr6GUyjOg%3D%3D"
    
    return apiClient
      .buildRequest(url: url)
      .add(method: .get)
      .fetch()
      .map { [weak self] data in
        guard
          let self = self,
          let response = try? JSONDecoder().decode(CenterListDTO<CenterDTO>.self, from: data)
        else { throw NSError(domain: "Decoding error", code: -1, userInfo: nil) }
        let data = response.data.map { self.translator.translate($0) }
        return data
      }
  }
}
