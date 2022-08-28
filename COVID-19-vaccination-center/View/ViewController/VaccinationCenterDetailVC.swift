//
//  VaccinationCenterDetailVC.swift
//  COVID-19-vaccination-center
//
//  Created by YHAN on 2022/08/26.
//

import UIKit
import RxSwift
import RxCocoa

final class VaccinationCenterDetailVC: UIViewController {
  var center: Center? {
    didSet {
      if let center = center {
        centerView.item = .init(image: IConSet.hospital, title: "센터명", subTitle: center.centerName)
        facilityView.item = .init(image: IConSet.building, title: "건물명", subTitle: center.facilityName)
        numberView.item = .init(image: IConSet.telephone, title: "전화번호", subTitle: center.phoneNumber == "" ? "전화번호가 없습니다." : center.phoneNumber)
        updateAtView.item = .init(image: IConSet.chat, title: "업데이트 시간", subTitle: center.updatedAt)
        addressView.item = .init(image: IConSet.placeholder, title: "주소", subTitle: center.address)
      }
    }
  }
  
  private var centerView: ItemInfoView = {
    let view = ItemInfoView()
    return view
  }()
  
  private var facilityView: ItemInfoView = {
    let view = ItemInfoView()
    return view
  }()
  
  private lazy var firstHStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [centerView, facilityView])
    stackView.axis = .horizontal
    stackView.spacing = 40
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  private var numberView: ItemInfoView = {
    let view = ItemInfoView()
    return view
  }()
  
  private var updateAtView: ItemInfoView = {
    let view = ItemInfoView()
    return view
  }()
  
  private lazy var secondHStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [numberView, updateAtView])
    stackView.axis = .horizontal
    stackView.spacing = 40
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  private var addressView: ItemInfoView = {
    let view = ItemInfoView()
    return view
  }()
  
  private lazy var vStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [firstHStackView, secondHStackView, addressView])
    stackView.axis = .vertical
    stackView.spacing = 20
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = ColorSet.gray
    
    setNavigation()
    setConstraints()
  }
  
  private func setNavigation() {
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(leftBarButtonDidTap))
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "지도", style: .plain, target: self, action: #selector(rightBarButtonDidTap))
    let navigationAppearance = UINavigationBarAppearance()
    navigationAppearance.backgroundColor = .white
    self.navigationController?.navigationBar.scrollEdgeAppearance = navigationAppearance
  }
  
  private func setConstraints() {
    let guid = view.safeAreaLayoutGuide
    
    self.view.addSubview(vStackView)
    
    vStackView.snp.makeConstraints { make in
      make.top.equalTo(guid).offset(20)
      make.horizontalEdges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
      make.height.equalTo(UIScreen.main.bounds.height / 1.5)
    }
  }
  
  @objc func leftBarButtonDidTap() {
    self.navigationController?.popViewController(animated: true)
  }
  
  @objc func rightBarButtonDidTap() {
    let viewController = VaccinationCenterMapVC()
    viewController.center = center
    self.navigationController?.pushViewController(viewController, animated: true)
  }
}
