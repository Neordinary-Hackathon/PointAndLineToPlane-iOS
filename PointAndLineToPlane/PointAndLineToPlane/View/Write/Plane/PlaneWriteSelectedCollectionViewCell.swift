//
//  PlaneWriteSelectedCollectionViewCell.swift
//  PointAndLineToPlane
//
//  Created by 정현우 on 2023/01/08.
//

import UIKit
import SnapKit

class PlaneWriteSelectedCollectionViewCell: UICollectionViewCell {
	
	static let identifier = "PlaneWriteSelectedCollectionViewCell"
	
	lazy var contentLabel: UILabel = {
		let label = UILabel()
		label.text = "test test"
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = .black
		
		return label
	}()
	
	
	
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		configureViews()
		contentView.backgroundColor = UIColor(named: "BackgroundColor")
		
		contentView.layer.masksToBounds = true
		contentView.layer.cornerRadius = 20
		
		
	}

	
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configureViews() {
		contentView.addSubview(contentLabel)
		
		
		contentLabel.snp.makeConstraints {
			$0.center.equalToSuperview()
		}
	}
}

