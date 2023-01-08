//
//  PointWriteCollectionViewCell.swift
//  PointAndLineToPlane
//
//  Created by 정현우 on 2023/01/07.
//

import UIKit
import SnapKit

class PointWriteCollectionViewCell: UICollectionViewCell {
	
	static let identifier = "PointWriteCollectionViewCell"
	
	lazy var textField: UITextField = {
		let textField = UITextField()
		textField.backgroundColor = .black
		textField.textColor = .black
		// 입력시 왼쪽 여백
//		textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
//		textField.leftViewMode = .always

		// placeholder 설정
		let centeredParagraphStyle = NSMutableParagraphStyle()
		centeredParagraphStyle.alignment = .center
		textField.attributedPlaceholder = NSAttributedString(string: "단어 입력하기", attributes: [NSAttributedString.Key.foregroundColor : UIColor(named: "MainCollectionViewBehindColor") ?? .white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), .paragraphStyle: centeredParagraphStyle])

		textField.layer.cornerRadius = 8

		return textField
	}()
	
//	lazy var leftImageView: UIView = {
//		let imageView = UIImageView()
//		imageView.image = UIImage(systemName: "quote.opening")
//		imageView.tintColor = .black
//
//		return imageView
//	}()
	
	
//	lazy var button: UIButton = {
//		let button = UIButton()
//		button.setTitle("단어 입력하기", for: .normal)
//		button.setTitleColor(UIColor(named: "MainCollectionViewBehindColor"), for: .normal)
//		button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//		button.backgroundColor = .black
//		button.layer.cornerRadius = 8
//
//		return button
//	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureViews()
		textField.delegate = self
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
	private func configureViews() {
		contentView.addSubview(textField)
		
		textField.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
	}
	

	
}

extension PointWriteCollectionViewCell: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		textField.backgroundColor = UIColor(named: "BackgroundColor")
		textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
		textField.leftViewMode = .always
		textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
		textField.rightViewMode = .always
		
		let leftParagraphStyle = NSMutableParagraphStyle()
		leftParagraphStyle.alignment = .left
		textField.attributedPlaceholder = NSAttributedString(string: "단어 입력하기", attributes: [NSAttributedString.Key.foregroundColor : UIColor(named: "MainCollectionViewBehindColor") ?? .white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), .paragraphStyle: leftParagraphStyle])
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		if textField.text == "" {
			textField.backgroundColor = .black
//			textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
//			textField.leftViewMode = .always
				
			let centeredParagraphStyle = NSMutableParagraphStyle()
			centeredParagraphStyle.alignment = .center
			textField.attributedPlaceholder = NSAttributedString(string: "단어 입력하기", attributes: [NSAttributedString.Key.foregroundColor : UIColor(named: "MainCollectionViewBehindColor") ?? .white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), .paragraphStyle: centeredParagraphStyle])
		} else {
			textField.textAlignment = .center
		}
		
	}
}
