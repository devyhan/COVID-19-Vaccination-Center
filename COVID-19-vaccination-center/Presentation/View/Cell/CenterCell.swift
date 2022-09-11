//
//  Cell.swift
//  COVID-19-vaccination-center
//
//  Created by YHAN on 2022/08/24.
//

import UIKit

class CenterCell: UITableViewCell {
  static let identifier: String = "CenterCell"
  var rowItem: Center? {
    didSet {
      if let rowItem = rowItem {
        centerLabel.text = rowItem.centerName
        facilityLabel.text = rowItem.facilityName
        addressLabel.text = rowItem.address
        updateLabel.text = rowItem.updatedAt
      }
    }
  }
  
  private lazy var centerTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "센터명"
    label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    label.alpha = 0.5
    return label
  }()
  
  private lazy var facilityTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "건물명"
    label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    label.alpha = 0.5
    return label
  }()
  
  private lazy var addressTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "주소"
    label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    label.alpha = 0.5
    return label
  }()
  
  private lazy var updateTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "업데이트 시간"
    label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    label.alpha = 0.5
    return label
  }()
  
  private lazy var titleStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [centerTitleLabel, facilityTitleLabel, addressTitleLabel, updateTitleLabel])
    stackView.axis = .vertical
    stackView.spacing = 10
    stackView.alignment = .leading
    return stackView
  }()
  
  private lazy var centerLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    return label
  }()
  
  private lazy var facilityLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    return label
  }()
  
  private lazy var addressLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    return label
  }()
  
  private lazy var updateLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    return label
  }()
  
  private lazy var descriptionStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [centerLabel, facilityLabel, addressLabel, updateLabel])
    stackView.axis = .vertical
    stackView.spacing = 10
    stackView.alignment = .leading
    return stackView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setLayout()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    self.rowItem = nil
  }
  
  private func setLayout() {
    [titleStackView, descriptionStackView].forEach {
      self.addSubview($0)
    }
  }
  
  private func setConstraints() {
    let verticalEdges = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    
    titleStackView.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(20)
      make.verticalEdges.equalToSuperview().inset(verticalEdges)
      make.width.equalTo(80)
    }
    
    descriptionStackView.snp.makeConstraints { make in
      make.leading.equalTo(titleStackView.snp.trailing).offset(20)
      make.verticalEdges.equalToSuperview().inset(verticalEdges)
      make.trailing.equalToSuperview().offset(-20)
    }
  }
}
