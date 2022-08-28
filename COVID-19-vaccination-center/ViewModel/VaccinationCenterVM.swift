//
//  CenterViewModel.swift
//  COVID-19-vaccination-center
//
//  Created by YHAN on 2022/08/26.
//

import RxCocoa
import RxSwift

final class VaccinationCenterVM {
  private let disposeBag = DisposeBag()
  private let domain: VaccinationCenter = VaccinationCenterImpl()
  
  let items = BehaviorRelay<[Center]>(value: [])
  
  let fetchMoreDatas = PublishSubject<Void>()
  let refreshControlAction = PublishSubject<Void>()
  let refreshControlCompelted = PublishSubject<Void>()
  let isLoadingSpinnerAvaliable = PublishSubject<Bool>()
  
  private var page = 1
  private var isPaginationStillResume = false
  private var isRefreshStillResume = false
  
  init() {
    fetchMoreDatas.subscribe { [weak self] _ in
      guard let self = self else { return }
      self.fetchData(
        page: self.page,
        isRefreshControl: false
      )
    }
    .disposed(by: disposeBag)
    
    refreshControlAction.subscribe { [weak self] _ in
      self?.refreshControlTriggered()
    }
    .disposed(by: disposeBag)
  }
  
  private func fetchData(page: Int, isRefreshControl: Bool) {
    if isPaginationStillResume || isRefreshStillResume { return }
    self.isRefreshStillResume = isRefreshControl
    
    isPaginationStillResume = true
    isLoadingSpinnerAvaliable.onNext(true)
    
    if page == 1 || isRefreshControl {
      isLoadingSpinnerAvaliable.onNext(false)
    }
    
    domain.fetchCenter(page: page)
      .map {
        $0.map {
          Center(
            centerName: $0.centerName,
            facilityName: $0.facilityName,
            address: $0.address,
            updatedAt: $0.updatedAt,
            phoneNumber: $0.phoneNumber,
            lat: $0.lat,
            lng: $0.lng
          )
        }
      }
      .subscribe { [weak self] centers in
        guard let self = self, let datas = centers.element else { return }
        self.handleData(data: datas)
        self.isLoadingSpinnerAvaliable.onNext(false)
        self.isPaginationStillResume = false
        self.isRefreshStillResume = false
        self.refreshControlCompelted.onNext(())
      }
      .disposed(by: disposeBag)
  }
  
  private func handleData(data: [Center]) {
    let oldDatas = items.value
    let descendingOrderList = (oldDatas + data).sorted(by: { $0.updatedAt > $1.updatedAt })
    items.accept(descendingOrderList)
    page += 1
  }
  
  private func refreshControlTriggered() {
    isPaginationStillResume = false
    page = 1
    items.accept([])
    fetchData(
      page: page,
      isRefreshControl: true
    )
  }
}
