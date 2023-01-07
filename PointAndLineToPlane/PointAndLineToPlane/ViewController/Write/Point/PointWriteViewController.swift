//
//  PointWriteViewController.swift
//  PointAndLineToPlane
//
//  Created by 정현우 on 2023/01/07.
//

import UIKit
import SnapKit

class PointWriteViewController: UIViewController {
	
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
		label.text = "점 작성하기"
		label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
		label.textColor = UIColor(named: "BackgroundColor")
		
		return label
	}()
	
	lazy var dotImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(systemName: "circle.fill")
		imageView.tintColor = UIColor(named: "BackgroundColor")
		return imageView
	}()
	
	lazy var descriptionLabel: UILabel = {
		let label = UILabel()
		label.text = "생각나는 단어를 적어주세요."
		label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
		label.textColor = UIColor(named: "BackgroundColor")
		
		return label
	}()
	
	lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = 12
		
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = UIColor(named: "MainCollectionViewBackgoundColor")
		
		return collectionView
	}()
	
	lazy var completionButton: UIButton = {
		let button = UIButton()
		button.setTitle("완료했어요", for: .normal)
		button.tintColor = .white
		button.layer.cornerRadius = 8
		button.layer.borderWidth = 2
		button.layer.borderColor = UIColor(named: "BackgroundColor")?.cgColor

		
		return button
	}()
	
	var cellCount: Int = 5
	var tempList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
		tabBarController?.tabBar.isHidden = true
		navigationController?.isNavigationBarHidden = true
		view.backgroundColor = UIColor(named: "MainCollectionViewBackgoundColor")
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.register(PointWriteCollectionViewCell.self, forCellWithReuseIdentifier: PointWriteCollectionViewCell.identifier)
		
		configureViews()
		
		completionButton.addTarget(self, action: #selector(didTapCompletionButton), for: .touchUpInside)
    }
	
	
	
	@objc func didTapCompletionButton() {
		didTapConfirmButton()
		let popupVC = PointPopUpViewController()
		tempList.forEach {popupVC.wordList.append($0)}
		// 투명도가 있으면 투명도에 맞춰서 나오게 함
		
		popupVC.modalPresentationStyle = .overCurrentContext
		self.navigationController?.pushViewController(popupVC, animated: false)
	}
	
	private func didTapConfirmButton() {
		
		for cell in collectionView.visibleCells {
			guard let cell = cell as? PointWriteCollectionViewCell else {return}
			guard cell.textField.text != "" else {return}
			tempList.append(cell.textField.text ?? "")
		}
		// Alamofire tempList 보내야 함
//		print(tempList)
//		PointPopUpViewController().wordList.append(tempList)
		
	}
	
	
	private func configureViews() {
		[titleLabel, backButtonImageView, dotImageView, descriptionLabel, collectionView, completionButton]
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
		
		dotImageView.snp.makeConstraints {
			$0.width.equalTo(10)
			$0.height.equalTo(10)
			$0.centerX.equalToSuperview()
			$0.top.equalTo(titleLabel.snp.bottom).offset(36)
		}
		
		descriptionLabel.snp.makeConstraints {
			$0.centerX.equalToSuperview()
			$0.top.equalTo(dotImageView.snp.bottom).offset(37)
		}
		
		collectionView.snp.makeConstraints {
			$0.leading.equalToSuperview().inset(25)
			$0.trailing.equalToSuperview().inset(25)
			$0.height.equalTo(64 * cellCount + 12 * cellCount)
			$0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
		}
		
		completionButton.snp.makeConstraints {
			$0.bottom.equalToSuperview().inset(30)
			$0.leading.equalToSuperview().inset(25)
			$0.trailing.equalToSuperview().inset(25)
			$0.height.equalTo(56)
		}
	}
    

    
}

extension PointWriteViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return cellCount
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PointWriteCollectionViewCell.identifier, for: indexPath) as? PointWriteCollectionViewCell else {return UICollectionViewCell()}
		
		return cell
	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.frame.size.width, height: 64)
	}
	
	
	
}


