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

    override func viewDidLoad() {
        super.viewDidLoad()
		navigationController?.isNavigationBarHidden = true
		view.backgroundColor = UIColor(named: "MainCollectionViewBackgoundColor")
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.register(PlaneWriteCollectionViewCell.self, forCellWithReuseIdentifier: PlaneWriteCollectionViewCell.identifier)
		
		configureViews()
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
		return 3
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaneWriteCollectionViewCell.identifier, for: indexPath) as? PlaneWriteCollectionViewCell else {return UICollectionViewCell()}
		
		// TODO: cell label text 설정
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.frame.size.width, height: 42)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaneWriteCollectionViewCell.identifier, for: indexPath) as? PlaneWriteCollectionViewCell else {return}

		cell.isSelected = true
	}
}
