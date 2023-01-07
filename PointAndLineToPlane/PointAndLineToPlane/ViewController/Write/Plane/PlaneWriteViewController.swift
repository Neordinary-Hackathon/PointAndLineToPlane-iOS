//
//  PlaneWriteViewController.swift
//  PointAndLineToPlane
//
//  Created by 정현우 on 2023/01/08.
//

import UIKit

class PlaneWriteViewController: UIViewController {
	
	// 뒤로 가기 버튼
	lazy var backButtonImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(systemName: "chevron.left")
		imageView.tintColor = UIColor(named: "BackgroundColor")
		imageView.contentMode = .scaleAspectFit
		
		return imageView
	}()
	
	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.text = "면 작성하기"
		label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
		label.textColor = UIColor(named: "BackgroundColor")
		
		return label
	}()

	lazy var planeImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "Rectangle45")
		imageView.tintColor = UIColor(named: "BackgroundColor")
		
		return imageView
	}()
	
	lazy var descriptionLabel: UILabel = {
		let label = UILabel()
		label.text = "두번째, 글을 쓸 시간이에요."
		label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
		label.textColor = UIColor(named: "BackgroundColor")
		
		return label
	}()
	
	lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = 12
		
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = .clear
		collectionView.allowsMultipleSelection = true
		
		
		return collectionView
	}()
	
	lazy var textField: UITextField = {
		let textField = UITextField()
		textField.placeholder = "dsfdasdsada"
		textField.backgroundColor = .black
		textField.layer.cornerRadius = 8
		textField.textColor = .white
		textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
		textField.leftViewMode = .always
		let leftParagraphStyle = NSMutableParagraphStyle()
		leftParagraphStyle.alignment = .left
		textField.attributedPlaceholder = NSAttributedString(string: "글을 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor(named: "MainCollectionViewBehindColor") ?? .white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), .paragraphStyle: leftParagraphStyle])
		
		return textField
	}()
	
	lazy var nextButton: UIButton = {
		let button = UIButton()
		button.setTitle("다음으로 넘어가요", for: .normal)
		button.tintColor = .white
		button.layer.cornerRadius = 8
		button.layer.borderWidth = 2
		button.layer.borderColor = UIColor(named: "BackgroundColor")?.cgColor
		return button
	}()
	
	var stringArr: [String] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
		navigationController?.isNavigationBarHidden = true
		view.backgroundColor = UIColor(named: "MainCollectionViewBackgoundColor")
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.register(PlaneWriteSelectedCollectionViewCell.self, forCellWithReuseIdentifier: PlaneWriteSelectedCollectionViewCell.identifier)
		nextButton.addTarget(self, action: #selector(didTapCompletionButton), for: .touchUpInside)
		configureViews()
		print(self.stringArr)
		
    }
	
	@objc func didTapCompletionButton() {
		let popupVC = PlanePopUpViewController()
		popupVC.stringData = self.textField.text!
		// 투명도가 있으면 투명도에 맞춰서 나오게 함
		popupVC.modalPresentationStyle = .overCurrentContext
		self.present(popupVC, animated: false)
	}
	
	func configureViews() {
		
		[titleLabel, backButtonImageView, planeImageView, descriptionLabel, collectionView, textField, nextButton]
			.forEach {view.addSubview($0)}

		titleLabel.snp.makeConstraints {
			$0.centerX.equalToSuperview()
			$0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
		}
		
		backButtonImageView.snp.makeConstraints {
			$0.centerY.equalTo(titleLabel)
			$0.width.equalTo(24)
			$0.height.equalTo(24)
			$0.leading.equalToSuperview().inset(25)
		}
		
		planeImageView.snp.makeConstraints {
			$0.width.equalTo(35)
			$0.height.equalTo(35)
			$0.centerX.equalToSuperview()
			$0.top.equalTo(titleLabel.snp.bottom).offset(19)
		}
		
		descriptionLabel.snp.makeConstraints {
			$0.centerX.equalToSuperview()
			$0.top.equalTo(planeImageView.snp.bottom).offset(24)
		}
		
		collectionView.snp.makeConstraints {
			$0.top.equalTo(descriptionLabel.snp.bottom).offset(28)
			$0.leading.equalToSuperview().inset(25)
			$0.trailing.equalToSuperview().inset(25)
			$0.height.equalTo(42*3 + 12*2)
		}
		
		nextButton.snp.makeConstraints {
			$0.bottom.equalToSuperview().inset(30)
			$0.leading.equalToSuperview().inset(25)
			$0.trailing.equalToSuperview().inset(25)
			$0.height.equalTo(56)
		}
		textField.snp.makeConstraints {
			$0.top.equalTo(collectionView.snp.bottom).offset(27.5)
			$0.leading.equalToSuperview().inset(25)
			$0.trailing.equalToSuperview().inset(25)
//			$0.bottom.equalTo(nextButton.snp.top).offset(-30)
			$0.height.equalTo(300)
		}
		
		
	}
    

    

}

extension PlaneWriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return stringArr.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaneWriteSelectedCollectionViewCell.identifier, for: indexPath) as? PlaneWriteSelectedCollectionViewCell else {return UICollectionViewCell()}
		cell.contentLabel.text = self.stringArr[indexPath.row]
		
		// TODO: cell label text 설정
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.frame.size.width, height: 42)
	}
	
	
	
	
}
