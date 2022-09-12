//
//  Tests.swift
//  Tests
//
//  Created by YHAN on 2022/09/12.
//

import XCTest
import RxSwift
import RxCocoa
import RxNimble
import Nimble
import RxTest
@testable import COVID_19_vaccination_center

class Tests: XCTestCase {
  var disposeBag: DisposeBag!
  var scheduler: TestScheduler!
  var viewModel: VaccinationCenterVM!
  var fetchMoreDatas: PublishSubject<Void>!
  var refreshControlAction: PublishSubject<Void>!
  var output: VaccinationCenterVM.Output!
  let data = [
    Center(
      centerName : "코로나19 중부권역 예방접종센터",
      facilityName : "천안시 실내배드민턴장 1층",
      address : "충청남도 천안시 동남구 천안대로 357",
      updatedAt : "2021-07-16 04:55:08",
      phoneNumber : "",
      lat : "36.779887",
      lng: "127.164717"
    ),
    Center(
      centerName : "코로나19 중앙 예방접종센터",
      facilityName : "국립중앙의료원 D동",
      address : "서울특별시 중구 을지로 39길 29",
      updatedAt : "2021-07-16 04:55:07",
      phoneNumber : "02-2260-7114",
      lat : "37.567817",
      lng : "127.004501"
    )
  ]
  
  // Given
  override func setUp() {
    disposeBag = DisposeBag()
    scheduler = TestScheduler(initialClock: 0)
    viewModel = VaccinationCenterVM(domain: VaccinationCenterMock())
    fetchMoreDatas = PublishSubject<Void>()
    refreshControlAction = PublishSubject<Void>()
    output = viewModel.transform(
      input: .init(
        fetchMoreDatas: fetchMoreDatas,
        refreshControlAction: refreshControlAction
      )
    )
  }
  
  // 리스트에 데이터가 추가되는지, 받아오는 데이터의 정렬이 되는지 검증
  func test_fetchMoreDatas() {
    // When
    scheduler.createColdObservable(
      [
        .next(1, ()),
        .next(2, ())
      ]
    )
    .bind(to: fetchMoreDatas)
    .disposed(by: disposeBag)
    
    // Then
    expect(self.output.vaccinationItems)
      .events(scheduler: scheduler, disposeBag: disposeBag)
      .to(equal([
        .next(0, []),
        .next(1, data),
        .next(2, (data + data).sorted(by: { $0.updatedAt > $1.updatedAt }))
      ]))
  }
  
  // Pull down refresh를 할 떄 refreshConrol의 state가 변경이 잘 되는지 검증
  func test_refreshControlAction() {
    // When
    scheduler.createColdObservable(
      [.next(1, ())]
    )
    .bind(to: refreshControlAction)
    .disposed(by: disposeBag)
    
    // Then
    expect(self.output.isLoadingSpinnerAvaliable)
      .events(scheduler: scheduler, disposeBag: disposeBag)
      .to(equal([
        .next(0, false),
        .next(1, true),
        .next(1, false),
        .next(1, false)
      ]))
  }
}
