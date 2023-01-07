//
//  LineViewController.swift
//  PointAndLineToPlane
//
//  Created by 고명주 on 2023/01/07.
//

import UIKit
import Alamofire

class LineViewController: UIViewController {
  
  var selectedIdx = Array<Int>()
  var selectedTx = Array<String>()
  var model: [WordListModel.Dots]?
  
  lazy var loginImage: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "slash"))
    return imageView
  }()
  lazy var lineLabel: UILabel = {
    let label = UILabel()
    label.text = "문장 속 들어갈 단어를 골라주세요."
    label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    label.textColor = UIColor(named: "BackgroundColor")
    return label
  }()
  lazy var backButtonImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "chevron.left")
    imageView.tintColor = UIColor(named: "BackgroundColor")
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.text = "선 작성하기"
    label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    label.textColor = UIColor(named: "BackgroundColor")
    
    return label
  }()
  lazy var collectionView : UICollectionView = {
    var layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.scrollDirection = .vertical
    layout.sectionInset = .zero
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return cv
  }()
  lazy var lineImage: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "longLine"))
    return imageView
  }()
  var textView: UITextView = {
    let textView = UITextView()
    textView.backgroundColor = .black
    textView.textContainerInset = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    textView.text = "문장을 입력해주세요."
    textView.textColor = .lightGray
    textView.font = UIFont(name: "Kefa-Regular", size: 14)
    textView.layer.cornerRadius = 20
    //    textView.isUserInteractionEnabled = false
    return textView
  }()
  lazy var button: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 10
    button.layer.borderColor = UIColor.white.cgColor
    button.layer.borderWidth = 1
    button.setTitle("작성 끝", for: .normal)
    button.addTarget(self, action: #selector(didClicked), for: .touchDown)
    return button
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    get()
    configureUI()
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
    textView.addGestureRecognizer(tapGestureRecognizer)
    collectionView.delegate = self
    collectionView.dataSource = self
    autoLayout()
    collectionView.register(LineCell.self, forCellWithReuseIdentifier: LineCell.identifier)
  }
  @objc private func didClicked() {
    let vc = LineDetailViewController()
    vc.selectedIds = selectedIdx  
    self.navigationController?.pushViewController(vc, animated: true)
    print("dfsdf")
  }
  @objc func didTapView(_ sender: UITapGestureRecognizer) {
    let vc = LineDetailViewController()
    vc.selectedIds = selectedIdx
    vc.selectedWord = selectedTx
//    self.navigationController?.pushViewController(vc, animated: true)
    print("dfsdf")
  }
  
  func get() {
    let url = "http://3.39.221.35:8080/line"
    AF.request(url, method: .get, headers: [
      .authorization(bearerToken: "Z3QVm_9UOLc1MaTk2dMIe43Pbx0Es2OfQ15YYMNWCinI2QAAAYWNnWD2")
    ])
      .validate()
      .responseDecodable(of: WordListModel.self, completionHandler: { response in
        self.model = response.value?.dots
        self.collectionView.reloadData()
      })
  }
  
  func configureUI() {
    view.addSubview(collectionView)
    view.backgroundColor = UIColor(named: "MainCollectionViewBackgoundColor")
    collectionView.backgroundColor = UIColor(named: "MainCollectionViewBackgoundColor")
    [titleLabel, backButtonImageView, loginImage, lineLabel, lineImage, textView, button]
      .forEach {view.addSubview($0)
      }
    loginImage.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(titleLabel.snp.bottom).offset(22)
      $0.width.equalTo(36)
      $0.height.equalTo(36)
    }
    lineLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(loginImage.snp.bottom).offset(28)
    }
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
    lineImage.snp.makeConstraints {
      $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
      $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
      $0.top.equalTo(collectionView.snp.bottom).offset(35)
      $0.height.equalTo(10)
    }
    textView.snp.makeConstraints {
      $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(25)
      $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-25)
      $0.top.equalTo(lineImage.snp.bottom).offset(34)
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-100)
    }
    button.snp.makeConstraints {
      $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(25)
      $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-25)
      $0.top.equalTo(textView.snp.bottom).offset(25)
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
  }
}

extension LineViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LineCell.identifier, for: indexPath) as? LineCell else {
      return
    }
    print("인덱스 : \(indexPath)")
    if selectedIdx.contains(indexPath.row){
      if let idx = selectedIdx.firstIndex(of: indexPath.row){
        selectedIdx.remove(at: idx)
        selectedTx.remove(at: idx)
      }
    }else{
      selectedTx.append(model?[indexPath.row].dotContent ?? "")
      selectedIdx.append(indexPath.row)
    }
    
    collectionView.reloadData()
   
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return model?.count ?? 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LineCell.identifier, for: indexPath) as? LineCell else {
      return UICollectionViewCell()
    }
    if selectedIdx.contains(indexPath.row){
      cell.contentView.backgroundColor = UIColor(named: "BackgroundColor")
      cell.label.textColor = .black
    } else{

      cell.contentView.backgroundColor = UIColor.clear
      cell.label.textColor = .black
    }
//    cell.backgroundColor = selectedIdx.contains(indexPath.row) ? UIColor.blue : UIColor.clear {
    cell.isMultipleTouchEnabled = true
    cell.layer.cornerRadius = 15
    cell.label.text = model?[indexPath.row].dotContent
    cell.layer.borderWidth = 1
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let itemSpacing : CGFloat = 3
    
    return CGSize(width: 80, height: 32)
  }
}

extension LineViewController {
  private func autoLayout() {
    collectionView.snp.makeConstraints {
      $0.top.equalTo(lineLabel.snp.bottom).offset(20)
      $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
      $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
      $0.height.equalTo(120)
    }
  }
}
