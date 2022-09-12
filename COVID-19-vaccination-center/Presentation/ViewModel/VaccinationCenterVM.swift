//
//  CenterViewModel.swift
//  COVID-19-vaccination-center
//
//  Created by YHAN on 2022/08/26.
//

import RxCocoa
import RxSwift

protocol ViewModelType {
  associatedtype Input
  associatedtype Output
  
  func transform(input: Input) -> Output
}

final class VaccinationCenterVM: ViewModelType {
  private let domain: VaccinationCenter
  private var page = 1
  private var isPaginationStillResume = false
  private var isRefreshStillResume = false
  
  private let disposeBag = DisposeBag()
  private let items = BehaviorRelay<[Center]>(value: [])
  private let refreshControlCompelted = BehaviorRelay<Void>(value: ())
  private let isLoadingSpinnerAvaliable = BehaviorRelay<Bool>(value: false)
  
  struct Input {
    var fetchMoreDatas: Observable<Void>
    var refreshControlAction: Observable<Void>
  }

  struct Output {
    var vaccinationItems: Driver<[Center]>
    var refreshControlCompelted: Driver<Void>
    var isLoadingSpinnerAvaliable: Driver<Bool>
  }
  
  init(domain: VaccinationCenter = VaccinationCenterImpl()) {
    self.domain = domain
  }

  func transform(input: Input) -> Output {
    input.fetchMoreDatas
      .subscribe { [weak self] _ in
        guard let self = self else { return }
        self.fetchData(
          page: self.page,
          isRefreshControl: false
        )
      }
      .disposed(by: disposeBag)
    
    input.refreshControlAction
      .subscribe { [weak self] _ in
        guard let self = self else { return }
        self.refreshControlTriggered()
      }
      .disposed(by: disposeBag)
    
    return Output(
      vaccinationItems: items.asDriver(onErrorJustReturn: []),
      refreshControlCompelted: refreshControlCompelted.asDriver(),
      isLoadingSpinnerAvaliable: isLoadingSpinnerAvaliable.asDriver()
    )
  }
  
  private func fetchData(page: Int, isRefreshControl: Bool) {
    if isPaginationStillResume || isRefreshStillResume { return }
    self.isRefreshStillResume = isRefreshControl
    
    isPaginationStillResume = true
    isLoadingSpinnerAvaliable.accept(true)
    
    if page == 1 || isRefreshControl {
      isLoadingSpinnerAvaliable.accept(false)
    }
    
    // VaccinationCenterImpl.swift에 Translator를 추가하여 기존 로직에서 CenterDTO to Center과정 삭제
    domain.fetchCenter(page: page)
      .subscribe { [weak self] centers in
        guard let self = self, let datas = centers.element else { return }
        self.handleData(data: datas)
        self.isLoadingSpinnerAvaliable.accept(false)
        self.isPaginationStillResume = false
        self.isRefreshStillResume = false
        self.refreshControlCompelted.accept(())
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
