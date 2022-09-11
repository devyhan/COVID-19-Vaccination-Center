//
//  APIClient.swift
//  COVID-19-vaccination-center
//
//  Created by YHAN on 2022/08/25.
//

import Foundation
import RxSwift

public protocol APIClient {
  func buildRequest(url: String) -> RequestBuilder
}

final class APIClientImpl: APIClient {
  func buildRequest(url: String) -> RequestBuilder {
    let url: URL = {
      guard let url = URL(string: url) else { return URL(string: "")! }
      return url
    }()
    let requestURL = URLRequest(url: url)
    
    return RequestBuilderImpl(url: requestURL)
  }
}
