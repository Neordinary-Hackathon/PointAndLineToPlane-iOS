//
//  PlaneWriteCollectionViewCell.swift
//  PointAndLineToPlane
//
//  Created by 정현우 on 2023/01/08.
//

import UIKit
import SnapKit

class PlaneWriteCollectionViewCell: UICollectionViewCell {
	
	static let identifier = "PlaneWriteCollectionViewCell"
	
	lazy var contentLabel: UILabel = {
		let label = UILabel()
		label.text = "test test"
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = UIColor(named: "MainCollectionViewBehindColor")
		
		return label
	}()
	
	override var isSelected: Bool {
		   didSet{
			   if isSelected {
				   contentLabel.textColor = .black
				   contentView.backgroundColor = UIColor(named: "BackgroundColor")
			   }
			   else {
				   contentLabel.textColor = UIColor(named: "MainCollectionViewBehindColor")
				   contentView.backgroundColor = .black
			   }
		   }
	   }
	
	
	
	
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		configureViews()
		contentView.backgroundColor = .black
		
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
