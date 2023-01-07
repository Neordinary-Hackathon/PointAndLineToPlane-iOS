//
//  WriteViewController.swift
//  PointAndLineToPlane
//
//  Created by HA on 2023/01/07.
//

import UIKit


class WriteController: UIViewController {
    //MARK: - Properties
    
    var arrImageName: [String] = ["DotPictureImage","LinePictureImage","FlatPictureImage"]
    var titleNameArr: [String] = ["점", "선", "면"]
    var descriptionLabelArr:[String] = ["글감이 되는 단어를 적을 수 있어요.","기존 단어로 문장을 써볼 수 있어요.","문장을 통해 작품을 완성할 수 있어요."]
    var titleEngNameArr: [String] = ["Dot", "Line", "Plane"]
    
    var currentIndex: CGFloat = 0
    let lineSpacing: CGFloat = 20
    let cellRatio: CGFloat = 0.7
    var isOneStepPaging = true
	
	lazy var myLabel1: UILabel = {
	   let label = UILabel()
		label.text = "DLF"
		label.font = UIFont(name: "Kefa-Regular", size: 24)
		return label
	}()
	
	lazy var myLabel2: UILabel = {
	   let label = UILabel()
		label.text = "점 선 면"
		return label
	}()
	
   
	
	lazy var myImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "round1")
		
		return imageView
	}()
	
	lazy var myImageView1: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "line1")
		
		return imageView
	}()
    
    lazy var myLabel3: UILabel = {
       let label = UILabel()
        label.text = "Dot"
        return label
    }()
 
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
//        layout.itemSize = CGSize(width: 250, height: 388)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.isPagingEnabled = false
        return collectionView
        
    }()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellWidth = floor(view.frame.width * cellRatio)
              let cellHeight = floor(view.frame.height * cellRatio)
              
              // 상하, 좌우 inset value 설정
              let insetX = (view.bounds.width - cellWidth) / 2.0
              let insetY = (view.bounds.height - cellHeight) / 2.0
              
              let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
              layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
              layout.minimumLineSpacing = lineSpacing
              layout.scrollDirection = .horizontal
              collectionView.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
              
              collectionView.delegate = self
              collectionView.dataSource = self
              
              // 스크롤 시 빠르게 감속 되도록 설정
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        configureUI()
        configLabel()
    }
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tabBarController?.tabBar.isHidden = false
	}
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
    
    
    func configLabel(){
        [myLabel3]
            .forEach {view.addSubview($0)}
        
        myLabel3.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(200)
            $0.leading.equalToSuperview().inset(177)
        }
		
		[myLabel1, myLabel2, myImageView, myImageView1]
			.forEach {view.addSubview($0)}
		
		myLabel1.snp.makeConstraints {
			$0.top.equalToSuperview().inset(60)
			$0.leading.equalToSuperview().inset(30)
		}
		
		myLabel2.snp.makeConstraints {
			$0.top.equalToSuperview().inset(65)
			$0.leading.equalToSuperview().inset(85)
		}
		
		
		myImageView.snp.makeConstraints {
			$0.bottom.equalToSuperview().inset(250)
			$0.leading.equalToSuperview().inset(187)
		}
		
		myImageView1.snp.makeConstraints {
			$0.top.equalToSuperview().inset(100)
		}
    }
    
    private func configureUI() {
        view.addSubview(collectionView)
        collectionView.register(SelecteImageCell.self, forCellWithReuseIdentifier: SelecteImageCell.reuseIdentifier)
        collectionView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(60)
            $0.height.equalTo(388)
        }
        
    }
}
    //MARK: - Extensions

extension WriteController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelecteImageCell.reuseIdentifier, for: indexPath) as! SelecteImageCell
        cell.backgroundColor = UIColor(named: "BackgroundColor")
        cell.titleLabel.text = titleNameArr[indexPath.row]
        cell.pictureImageView.image = UIImage(named: arrImageName[indexPath.row])
        cell.descriptionLabel.text = descriptionLabelArr[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 1
        }
        //좌우간격
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 1
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.size.width - (20*2) - (20*2)
        return CGSize(width: cellWidth, height: 388)
    }
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		switch indexPath.row {
		case 0:
			let vc = PointWriteViewController()
			self.navigationController?.pushViewController(vc, animated: true)
		case 1:
			let vc = LineViewController()
			self.navigationController?.pushViewController(vc, animated: true)
		case 2:
			let vc = PlaneListViewController()
			self.navigationController?.pushViewController(vc, animated: true)
		default:
			return 
		}
	}
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
       {
           // item의 사이즈와 item 간의 간격 사이즈를 구해서 하나의 item 크기로 설정.
           let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
           let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
           
           // targetContentOff을 이용하여 x좌표가 얼마나 이동했는지 확인
           // 이동한 x좌표 값과 item의 크기를 비교하여 몇 페이징이 될 것인지 값 설정
           var offset = targetContentOffset.pointee
           let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
           var roundedIndex = round(index)
           
           // scrollView, targetContentOffset의 좌표 값으로 스크롤 방향을 알 수 있다.
           // index를 반올림하여 사용하면 item의 절반 사이즈만큼 스크롤을 해야 페이징이 된다.
           // 스크로로 방향을 체크하여 올림,내림을 사용하면 좀 더 자연스러운 페이징 효과를 낼 수 있다.
           if scrollView.contentOffset.x > targetContentOffset.pointee.x {
               roundedIndex = floor(index)
           } else if scrollView.contentOffset.x < targetContentOffset.pointee.x {
               roundedIndex = ceil(index)
           } else {
               roundedIndex = round(index)
           }
           
           if isOneStepPaging {
               if currentIndex > roundedIndex {
                   currentIndex -= 1.3
                   roundedIndex = currentIndex
               } else if currentIndex < roundedIndex {
                   currentIndex += 1.3
                   roundedIndex = currentIndex
               }
           }
           
           if currentIndex == 0 {
               myLabel3.text = "Dot"
           }else if currentIndex == 1.3 {
               myLabel3.text = "Line"
           }else {
               myLabel3.text = "Plane"
           }

           //self.myLabel3.text = self.titleEngNameArr[floor(currentIndex)]
           // 위 코드를 통해 페이징 될 좌표값을 targetContentOffset에 대입하면 된다.
           offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
           targetContentOffset.pointee = offset
       }
}


