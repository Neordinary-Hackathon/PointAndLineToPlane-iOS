//
//  CommunityDotCollectionViewCell.swift
//  PointAndLineToPlane
//
//  Created by 정현우 on 2023/01/17.
//

import UIKit
import SnapKit

class CommunityDotCollectionViewCell: UICollectionViewCell {
	static let identifier = "CommunityDotCollectionViewCell"
    
	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 14, weight: .bold)
		label.textColor = .white
		
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension CommunityDotCollectionViewCell {
	private func configureViews() {
		contentView.backgroundColor = UIColor(named: "MainCollectionViewBackgoundColor")
		contentView.layer.cornerRadius = 16
		contentView.addSubview(titleLabel)
		titleLabel.snp.makeConstraints {
			$0.center.equalToSuperview()
		}
	}
}
