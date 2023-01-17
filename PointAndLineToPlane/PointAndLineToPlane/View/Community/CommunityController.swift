//
//  CommuityViewController.swift
//  PointAndLineToPlane
//
//  Created by HA on 2023/01/07.
//

import UIKit
import SnapKit

class CommunityController: UIViewController {
	
	lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.isScrollEnabled = true
		scrollView.clipsToBounds = true
		scrollView.showsVerticalScrollIndicator = false
		return scrollView
	}()
	
	lazy var containerView: UIView = {
		let view = UIView()
		view.backgroundColor = .clear
		
		return view
	}()
    
	// MARK: Top Bar
	lazy var titleEngLabel: UILabel = {
	   let label = UILabel()
		label.text = "DLF"
		label.font = UIFont(name: "Kefa-Regular", size: 24)
		return label
	}()
	
	lazy var titleKorLabel: UILabel = {
	   let label = UILabel()
		label.text = "점 선 면"
		return label
	}()
	
   
	
	lazy var topDotImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "round1")
		
		return imageView
	}()
	
	lazy var topLineImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "line1")
		
		return imageView
	}()
	
	// MARK: Contents
	lazy var dotListEngLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "Kefa-Regular", size: 24)
		label.text = "Hot Dot"
		return label
	}()
	
	lazy var dotListKorLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 12)
		label.text = "인기 많은 단어"
		return label
	}()
	
	lazy var dotCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = 8
		layout.minimumInteritemSpacing = 8
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.isScrollEnabled = false
		collectionView.backgroundColor = .clear
		
		return collectionView
	}()
	
	lazy var lineListEngLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "Kefa-Regular", size: 24)
		label.text = "Hot Line"
		return label
	}()
	
	lazy var lineListKorLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 12)
		label.text = "인기 많은 문장"
		return label
	}()
	
	lazy var lineCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = 12
		
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.isScrollEnabled = false
		collectionView.backgroundColor = .clear
		
		return collectionView
	}()
	
	lazy var planeListEngLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "Kefa-Regular", size: 24)
		label.text = "Hot Face"
		return label
	}()
	
	lazy var planeListKorLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 12)
		label.text = "인기 많은 글"
		return label
	}()
	
	lazy var planeCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 5
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.isScrollEnabled = true
		collectionView.backgroundColor = .clear
		collectionView.showsHorizontalScrollIndicator = false
		
		return collectionView
	}()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
		navigationController?.navigationBar.isHidden = true
//		tabBarController?.tabBar.backgroundColor = UIColor(named: "TabBarBackgroundColor")
//		tabBarController?.tabBar.isTranslucent = false
		
		
		
//		UITabBar.appearance().isTranslucent = false
		configureScrollView()
		configureTopBar()
		configureViews()
		configureCollectionvView()
    }
}

extension CommunityController {
	private func configureScrollView() {
		view.addSubview(scrollView)
		scrollView.snp.makeConstraints {
			$0.top.equalTo(view.safeAreaLayoutGuide)
			$0.bottom.equalToSuperview().inset(120)
			$0.leading.trailing.equalToSuperview()
		}
		
		scrollView.addSubview(containerView)
		containerView.snp.makeConstraints {
			$0.edges.equalToSuperview()
			$0.width.equalToSuperview()
		}
	}
	
	private func configureTopBar() {
		[titleEngLabel, titleKorLabel, topDotImageView, topLineImageView]
			.forEach {containerView.addSubview($0)}
		
		titleEngLabel.snp.makeConstraints {
			$0.top.equalToSuperview().offset(16)
			$0.leading.equalToSuperview().inset(25)
		}
		
		titleKorLabel.snp.makeConstraints {
			$0.centerY.equalTo(titleEngLabel)
			$0.leading.equalTo(titleEngLabel.snp.trailing).offset(10)
		}
		
		
		topDotImageView.snp.makeConstraints {
			$0.top.equalTo(titleEngLabel.snp.bottom).offset(10)
			$0.leading.equalToSuperview().inset(20)
			$0.width.height.equalTo(10)
		}
		
		topLineImageView.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview()
			$0.centerY.equalTo(topDotImageView)
			$0.height.equalTo(2)
		}
	}
	
	private func configureViews() {
		[dotListEngLabel, dotListKorLabel, dotCollectionView, lineListEngLabel, lineListKorLabel, lineCollectionView, planeListEngLabel, planeListKorLabel, planeCollectionView]
			.forEach {containerView.addSubview($0)}
		
		dotListEngLabel.snp.makeConstraints {
			$0.leading.equalToSuperview().inset(25)
			$0.top.equalTo(topDotImageView.snp.bottom).offset(24)
		}
		
		dotListKorLabel.snp.makeConstraints {
			$0.centerY.equalTo(dotListEngLabel)
			$0.leading.equalTo(dotListEngLabel.snp.trailing).offset(10)
		}
		
		dotCollectionView.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview().inset(25)
			$0.top.equalTo(dotListEngLabel.snp.bottom).offset(20)
			$0.height.equalTo(32*3 + 8*2)
		}
		
		lineListEngLabel.snp.makeConstraints {
			$0.leading.equalToSuperview().inset(25)
			$0.top.equalTo(dotCollectionView.snp.bottom).offset(24)
		}
		
		lineListKorLabel.snp.makeConstraints {
			$0.centerY.equalTo(lineListEngLabel)
			$0.leading.equalTo(lineListEngLabel.snp.trailing).offset(10)
		}
		
		lineCollectionView.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview().inset(25)
			$0.top.equalTo(lineListEngLabel.snp.bottom).offset(20)
			$0.height.equalTo(43*3 + 12*2)
		}
		
		planeListEngLabel.snp.makeConstraints {
			$0.leading.equalToSuperview().inset(25)
			$0.top.equalTo(lineCollectionView.snp.bottom).offset(24)
		}
		
		planeListKorLabel.snp.makeConstraints {
			$0.centerY.equalTo(planeListEngLabel)
			$0.leading.equalTo(planeListEngLabel.snp.trailing).offset(10)
		}
		
		planeCollectionView.snp.makeConstraints {
			$0.leading.equalToSuperview().inset(25)
			$0.trailing.equalToSuperview()
			$0.top.equalTo(planeListEngLabel.snp.bottom).offset(20)
			$0.height.equalTo(140)
			$0.bottom.equalToSuperview().inset(10)
		}
		
	}
	
	private func configureCollectionvView() {
		dotCollectionView.delegate = self
		dotCollectionView.dataSource = self
		lineCollectionView.delegate = self
		lineCollectionView.dataSource = self
		planeCollectionView.delegate = self
		planeCollectionView.dataSource = self
		
		dotCollectionView.register(CommunityDotCollectionViewCell.self, forCellWithReuseIdentifier: CommunityDotCollectionViewCell.identifier)
		lineCollectionView.register(CommunityLineCollectionViewCell.self, forCellWithReuseIdentifier: CommunityLineCollectionViewCell.identifier)
		planeCollectionView.register(CommunityPlaneCollectionViewCell.self, forCellWithReuseIdentifier: CommunityPlaneCollectionViewCell.identifier)
	}
}

extension CommunityController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		switch collectionView {
		case dotCollectionView:
			return 12
		case lineCollectionView:
			return 3
		case planeCollectionView:
			return 3
		default:
			return 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		switch collectionView {
		case dotCollectionView:
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommunityDotCollectionViewCell.identifier, for: indexPath) as? CommunityDotCollectionViewCell else {return UICollectionViewCell()}
			cell.titleLabel.text = "\(indexPath.row)번째 cell"
			
			return cell
		case lineCollectionView:
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommunityLineCollectionViewCell.identifier, for: indexPath) as? CommunityLineCollectionViewCell else {return UICollectionViewCell()}
			cell.titleLabel.text = "\(indexPath.row)번째 cell"
			
			return cell
		case planeCollectionView:
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommunityPlaneCollectionViewCell.identifier, for: indexPath) as? CommunityPlaneCollectionViewCell else {return UICollectionViewCell()}
			cell.textView.text = "점선면\n이것은\n\(indexPath.row)번째\ncell입니다."
			cell.rankLabel.text = "Top 0\(indexPath.row + 1)"
			
			return cell
		default:
			return UICollectionViewCell()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		switch collectionView {
		case dotCollectionView:
			let width = ((view.frame.width) - 25.0*2 - 8.0*3) / 4
			return CGSize(width: width, height: 32)
		case lineCollectionView:
			let width = (view.frame.width) - 25*2
			return CGSize(width: width, height: 43)
		case planeCollectionView:
			return CGSize(width: 210, height: 140)
		default:
			return CGSize(width: 0, height: 0)
		}
	}
	
	
}
