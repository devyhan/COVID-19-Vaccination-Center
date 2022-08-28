//
//  ItenInfoView.swift
//  COVID-19-vaccination-center
//
//  Created by YHAN on 2022/08/26.
//

import UIKit

struct Item {
  var image: UIImage
  var title: String
  var subTitle: String
}

class ItemInfoView: UIView {
  var item: Item? {
    didSet {
      if let item = item {
        imageView.image = item.image
        titleLable.text = item.title
        subTitleLable.text = item.subTitle
      }
    }
  }
  
  private var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.snp.makeConstraints { make in
      make.width.height.equalTo(50)
    }
    return imageView
  }()
  
  private var titleLable: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
    return label
  }()
  
  private var subTitleLable: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()
  
  private lazy var vStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [imageView, titleLable, subTitleLable])
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = 10
    return stackView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    self.layer.shadowColor = UIColor.gray.cgColor
    self.layer.shadowOpacity = 1.0
    self.layer.shadowOffset = CGSize.zero
    self.layer.shadowRadius = 6
    self.layer.cornerRadius = 10
    self.addSubview(vStackView)
    
    vStackView.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.horizontalEdges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
