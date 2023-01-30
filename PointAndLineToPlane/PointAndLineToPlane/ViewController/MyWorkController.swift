//
//  WriteViewController.swift
//  PointAndLineToPlane
//
//  Created by jelly on 2023/01/24.
//

import UIKit

class MyWorkController: UIViewController {
  //MARK: - Properties
  var arrImageName: [String] = ["DotPictureImage","LinePictureImage","FlatPictureImage"]
  var titleNameArr: [String] = ["점", "선", "면"]
  var descriptionLabelArr:[String] = ["내 단어 기록이에요.","내 문장 기록이에요.","내 글 기록이에요."]
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
  lazy var wordCollectionView : UICollectionView = {
    var layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.scrollDirection = .vertical
    layout.sectionInset = .zero
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = .clear
    return cv
  }()
  lazy var lineCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 12
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    return collectionView
  }()
  lazy var planeCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 12
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    return collectionView
  }()
  lazy var addWordButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "plus"), for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.setTitle("단어 추가하기", for: .normal)
    button.backgroundColor = .black
    button.layer.cornerRadius = 20
    button.tintColor = .white
    button.addTarget(self, action: #selector(didTapWordButton), for: .allEvents)
    return button
  }()
  lazy var addLineButton: UIButton = {
    let button = UIButton()
    button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
    button.setImage(UIImage(systemName: "plus"), for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.setTitle("문장 추가하기", for: .normal)
    button.backgroundColor = .black
    button.tintColor = .white
    button.layer.cornerRadius = 20
    button.addTarget(self, action: #selector(didTapLineButton), for: .allEvents)
    return button
  }()
  lazy var addPlaneButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "plus"), for: .normal)
    button.setTitle("글 추가하기", for: .normal)
    button.backgroundColor = .black
    button.tintColor = .white
    button.layer.cornerRadius = 20
    button.addTarget(self, action: #selector(didTapPlaneButton), for: .allEvents)
    return button
  }()
  @objc private func didTapWordButton() {
    let vc = PointWriteViewController()
    self.navigationController?.pushViewController(vc, animated: true)
  }
  @objc private func didTapLineButton() {
    let vc = LineViewController()
    self.navigationController?.pushViewController(vc, animated: true)
  }
  @objc private func didTapPlaneButton() {
    let vc = PlaneWriteViewController()
    self.navigationController?.pushViewController(vc, animated: true)
  }
  //MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    wordCollectionView.delegate = self
    wordCollectionView.dataSource = self
    wordCollectionView.register(LineCell.self, forCellWithReuseIdentifier: LineCell.identifier)
    lineCollectionView.delegate = self
    lineCollectionView.dataSource = self
    lineCollectionView.register(PlaneWriteCollectionViewCell.self, forCellWithReuseIdentifier: PlaneWriteCollectionViewCell.identifier)
    planeCollectionView.delegate = self
    planeCollectionView.dataSource = self
    planeCollectionView.register(PlaneCollectionViewCell.self, forCellWithReuseIdentifier: PlaneCollectionViewCell.identifier)
    let cellWidth = floor(view.frame.width * cellRatio)
    //    let cellHeight = floor(view.frame.height * cellRatio)
    // 상하, 좌우 inset value 설정
    let insetX = (view.bounds.width - cellWidth) / 2.0
    //    let insetY = (view.bounds.height - cellHeight) / 2.0
    let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    layout.itemSize = CGSize(width: cellWidth, height: 140)
    layout.minimumLineSpacing = lineSpacing
    layout.scrollDirection = .horizontal
    collectionView.contentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
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
    [myLabel1, myLabel2, myLabel3, myImageView, myImageView1]
      .forEach { view.addSubview($0) }
    myLabel1.snp.makeConstraints {
      $0.top.equalToSuperview().inset(60)
      $0.leading.equalToSuperview().inset(30)
    }
    myLabel2.snp.makeConstraints {
      $0.top.equalToSuperview().inset(65)
      $0.leading.equalToSuperview().inset(85)
    }
    myImageView.snp.makeConstraints {
      $0.top.equalTo(collectionView.snp.bottom).offset(25)
      $0.centerX.equalToSuperview()
    }
    myLabel3.snp.makeConstraints {
      $0.top.equalTo(myImageView.snp.bottom).offset(20)
      $0.centerX.equalToSuperview()
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
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(25)
      $0.height.equalTo(140)
    }
  }
}

//MARK: - Extensions
extension MyWorkController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == self.collectionView {
      return 3
    } else if collectionView == self.wordCollectionView {
      return 12
    } else if collectionView == self.lineCollectionView {
      return 3
    } else if collectionView == self.planeCollectionView {
      return 3
    }
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == self.collectionView {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelecteImageCell.reuseIdentifier, for: indexPath) as! SelecteImageCell
      cell.backgroundColor = UIColor(named: "BackgroundColor")
      cell.titleLabel.text = titleNameArr[indexPath.row]
      cell.pictureImageView.image = UIImage(named: arrImageName[indexPath.row])
      cell.descriptionLabel.text = descriptionLabelArr[indexPath.row]
      return cell
    } else if collectionView == self.wordCollectionView {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LineCell.identifier, for: indexPath) as? LineCell else {
        return UICollectionViewCell()
      }
      cell.backgroundColor = UIColor(named: "BackgroundColor")
      cell.layer.cornerRadius = 15
      cell.label.text = "수영장"
      cell.layer.borderWidth = 1
      return cell
    } else if collectionView == self.lineCollectionView {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaneWriteCollectionViewCell.identifier, for: indexPath) as? PlaneWriteCollectionViewCell else {return UICollectionViewCell()}
      cell.contentLabel.text = "흙에서 자란 내 마음 파아란 하늘빛"
      return cell
    } else if collectionView == self.planeCollectionView {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaneCollectionViewCell.identifier, for: indexPath) as? PlaneCollectionViewCell else {return UICollectionViewCell()}
      cell.contentLabel.text = "흙에서 자란 내 마음 파아란 하늘빛 흙에서 자란 내 마음 파아란 하늘빛 흙에서 자란 내 마음 파아란 하늘빛 흙에서 자란 내 마음 파아란 하늘빛"
      return cell
    }
    return UICollectionViewCell()
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if collectionView == self.collectionView {
      let cellWidth = collectionView.frame.size.width - (20*2) - (20*2)
      return CGSize(width: cellWidth, height: 140)
    } else if collectionView == self.wordCollectionView {
      let itemSpacing : CGFloat = 3
      return CGSize(width: 80, height: 32)
    } else if collectionView == self.lineCollectionView {
      return CGSize(width: collectionView.frame.size.width, height: 42)
    } else if collectionView == self.planeCollectionView {
      return CGSize(width: collectionView.frame.size.width, height: 130)
    }
    return CGSize(width: 10, height: 10)
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10
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
      view.addSubview(wordCollectionView)
      view.addSubview(addWordButton)
      wordCollectionView.snp.makeConstraints {
        $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(260)
        $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
        $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
        $0.height.equalTo(120)
      }
      wordCollectionView.isHidden = false
      lineCollectionView.isHidden = true
      planeCollectionView.isHidden = true
      addWordButton.snp.makeConstraints {
        $0.top.equalTo(wordCollectionView.snp.bottom).offset(30)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(40)
        $0.width.equalTo(150)
      }
      addWordButton.isHidden = false
      addLineButton.isHidden = true
      addPlaneButton.isHidden = true
    } else if currentIndex == 1.3 {
      myLabel3.text = "Line"
      view.addSubview(lineCollectionView)
      view.addSubview(addLineButton)
      lineCollectionView.snp.makeConstraints {
        $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(260)
        $0.leading.equalToSuperview().inset(25)
        $0.trailing.equalToSuperview().inset(25)
        $0.height.equalTo(42*3 + 12*2)
      }
      wordCollectionView.isHidden = true
      lineCollectionView.isHidden = false
      planeCollectionView.isHidden = true
      addLineButton.snp.makeConstraints {
        $0.top.equalTo(lineCollectionView.snp.bottom).offset(30)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(40)
        $0.width.equalTo(150)
      }
      addWordButton.isHidden = true
      addLineButton.isHidden = false
      addPlaneButton.isHidden = true
    } else {
      myLabel3.text = "Plane"
      view.addSubview(planeCollectionView)
      view.addSubview(addPlaneButton)
      planeCollectionView.snp.makeConstraints {
        $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(260)
        $0.leading.equalToSuperview().inset(25)
        $0.trailing.equalToSuperview().inset(25)
        $0.height.equalTo(270)
      }
      wordCollectionView.isHidden = true
      lineCollectionView.isHidden = true
      planeCollectionView.isHidden = false
      addPlaneButton.snp.makeConstraints {
        $0.top.equalTo(planeCollectionView.snp.bottom).offset(30)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(40)
        $0.width.equalTo(150)
      }
      addWordButton.isHidden = true
      addLineButton.isHidden = true
      addPlaneButton.isHidden = false
    }
    //self.myLabel3.text = self.titleEngNameArr[floor(currentIndex)]
    // 위 코드를 통해 페이징 될 좌표값을 targetContentOffset에 대입하면 된다.
    offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
    targetContentOffset.pointee = offset
  }
}
