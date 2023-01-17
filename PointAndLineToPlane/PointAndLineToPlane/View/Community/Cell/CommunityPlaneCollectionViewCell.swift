//
//  CommunityPlaneCollectionViewCell.swift
//  PointAndLineToPlane
//
//  Created by 정현우 on 2023/01/17.
//

import UIKit
import SnapKit

class CommunityPlaneCollectionViewCell: UICollectionViewCell {
    static let identifier = "CommunityPlaneCollectionViewCell"
	
	lazy var textView: UITextView = {
		let textView = UITextView()
		textView.isEditable = false
		textView.backgroundColor = .clear
		textView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
		textView.font = .systemFont(ofSize: 14, weight: .medium)
		return textView
	}()
	
	lazy var rankView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor(named: "TabBarBackgroundColor")
		
		return view
	}()
	
	lazy var rankLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "Kefa-Regular", size: 20)
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

extension CommunityPlaneCollectionViewCell {
	private func configureViews() {
		contentView.backgroundColor = .clear
		
		textView.layer.cornerRadius = 8
		textView.layer.borderColor = UIColor.black.cgColor
		textView.layer.borderWidth = 1
		[textView, rankView]
			.forEach {contentView.addSubview($0)}

		textView.snp.makeConstraints {
			$0.top.equalToSuperview().inset(12)
			$0.trailing.equalToSuperview().inset(7)
			$0.leading.bottom.equalToSuperview()
		}
		rankView.snp.makeConstraints{
			$0.width.equalTo(95)
			$0.height.equalTo(32)
			$0.top.trailing.equalToSuperview()
		}
		rankView.layer.cornerRadius = 16
		
		rankView.addSubview(rankLabel)
		rankLabel.snp.makeConstraints {
			$0.center.equalToSuperview()
		}
	}
}
