//
//  LineDetailCell.swift
//  PointAndLineToPlane
//
//  Created by 고명주 on 2023/01/08.
//

import UIKit

class LineDetailCell: UICollectionViewCell {
  static let identifier = "lineDetailCell"
  
  lazy var label: UILabel = {
    let label = UILabel()
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.cellSetting()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func cellSetting() {
    self.backgroundColor = UIColor(named: "BackgroundColor")
    self.addSubview(label)
    self.layer.cornerRadius = 15
    
    label.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
}
