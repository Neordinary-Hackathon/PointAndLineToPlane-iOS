//
//  PlaneCollectionViewCell.swift
//  PointAndLineToPlane
//
//  Created by 고명주 on 2023/01/24.
//

import UIKit
import SnapKit

class PlaneCollectionViewCell: UICollectionViewCell {
  static let identifier = "PlaneCollectionViewCell"
  lazy var view: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 10
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor.black.cgColor
    return view
  }()
  lazy var contentLabel: UILabel = {
    let label = UILabel()
    label.text = "test test"
    label.numberOfLines = 4
    label.font = UIFont.systemFont(ofSize: 14)
    label.textColor = UIColor.black
    return label
  }()
  override init(frame: CGRect) {
    super.init(frame: .zero)
    configureViews()
    contentView.layer.masksToBounds = true
    contentView.layer.cornerRadius = 5
    contentView.layer.borderColor = UIColor.black.cgColor
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  private func configureViews() {
    contentView.addSubview(view)
    view.addSubview(contentLabel)
    view.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.left.equalToSuperview()
      $0.right.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
    contentLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.left.equalToSuperview().offset(25)
      $0.right.equalToSuperview().offset(-25)
    }
  }
}
