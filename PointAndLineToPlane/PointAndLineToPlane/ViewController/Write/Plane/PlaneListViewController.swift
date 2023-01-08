//
//  PlaneListViewController.swift
//  PointAndLineToPlane
//
//  Created by 정현우 on 2023/01/08.
//

import UIKit
import SnapKit
import Alamofire

class PlaneListViewController: UIViewController {
	
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
		label.text = "첫번째, 문장을 골라주세요."
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
		tabBarController?.tabBar.isHidden = true
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.register(PlaneWriteCollectionViewCell.self, forCellWithReuseIdentifier: PlaneWriteCollectionViewCell.identifier)
		
		nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
		configureViews()
		planeRequest()
    }
	
	var vc: UIViewController?
	var cellData: [String] = []
	var lineID: [Int] = []
	var stringArr: [String] = []
	
	@objc func didTapNextButton() {
		let vc = PlaneWriteViewController()
		vc.stringArr = self.stringArr
		vc.lineID = self.lineID
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
	private func planeRequest() {
		let url = "http://3.39.221.35:8080/flat"
		let header: HTTPHeaders = [
			.authorization(bearerToken: APIToken.shared.tokenValue)
		]
		
		AF.request(url, method: .get, headers: header)
			.validate(statusCode: 200..<300)
			.responseData { response in
				switch response.result {
				case .success(let res):
					let decoder = JSONDecoder()
					
					do {
						let data = try decoder.decode(LineListModel.self, from: res)
						self.cellData.append(data.lines[0].line_content)
						self.cellData.append(data.lines[1].line_content)
						self.cellData.append(data.lines[2].line_content)
						self.lineID.append(data.lines[0].line_id)
						self.lineID.append(data.lines[1].line_id)
						self.lineID.append(data.lines[2].line_id)
						
						self.collectionView.reloadData()
//						self.stringArr.append(data.lines[0].line_content)
//						self.stringArr.append(data.lines[1].line_content)
//						self.stringArr.append(data.lines[2].line_content)
//						print(data.lines[0].line_content)
					} catch {
						print("errorr in decode")
					}
				case .failure(let err):
					print(err.localizedDescription)
				}
			}
	}
	
	func configureViews() {
		
		[titleLabel, backButtonImageView, planeImageView, descriptionLabel, collectionView, nextButton]
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
	}
    

}

extension PlaneListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return cellData.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaneWriteCollectionViewCell.identifier, for: indexPath) as? PlaneWriteCollectionViewCell else {return UICollectionViewCell()}
		cell.contentLabel.text = cellData[indexPath.row]
		// TODO: cell label text 설정
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.frame.size.width, height: 42)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaneWriteCollectionViewCell.identifier, for: indexPath) as? PlaneWriteCollectionViewCell else {return}
		self.stringArr.append(cellData[indexPath.row])
		cell.isSelected = true
	}

	
	
	
}
