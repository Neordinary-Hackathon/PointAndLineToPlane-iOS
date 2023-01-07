//
//  LineCell.swift
//  PointAndLineToPlane
//
//  Created by 고명주 on 2023/01/07.
//

import UIKit

class LineCell: UICollectionViewCell {
  static let identifier = "cell2"

  
  lazy var label: UILabel = {
    let label = UILabel()
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    cellSetting()
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setSelected(_ selected : Bool, animated:Bool){
    
    if selected{
      self.contentView.backgroundColor = .blue
    }
    else{
      self.contentView.backgroundColor = .white
    }
  }
  
  
  func cellSetting() {
    self.addSubview(label)
//    if toggle == true {
//      print("토글")
//
//        self.backgroundColor = UIColor(named: "MainCollectionViewBehindColor")
//        self.label.textColor = .black
//    }
//    else {
//      self.backgroundColor = .black
//      self.label.textColor = UIColor(named: "MainCollectionViewBehindColor")
//    }
    self.layer.cornerRadius = 15
    
    label.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
}
