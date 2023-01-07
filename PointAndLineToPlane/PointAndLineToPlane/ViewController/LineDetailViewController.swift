//
//  LineDetailViewController.swift
//  PointAndLineToPlane
//
//  Created by 고명주 on 2023/01/07.
//

import UIKit
import Alamofire

class LineDetailViewController: UIViewController {
  
  var selectedIds = Array<Int>()
  var selectedWord: [String] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    view.addSubview(collectionView)
    collectionView.delegate = self
    collectionView.dataSource = self
    autoLayout()
    collectionView.register(LineDetailCell.self, forCellWithReuseIdentifier: LineDetailCell.identifier)
  }
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
  lazy var lineLabel: UILabel = {
    let label = UILabel()
    label.text = "문장을 입력해주세요."
    label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    label.textColor = UIColor(named: "BackgroundColor")
    return label
  }()
  
  lazy var loginImage: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "slash"))
    return imageView
  }()
  lazy var collectionView : UICollectionView = {
    var layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.scrollDirection = .horizontal
    layout.sectionInset = .zero
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return cv
  }()
  var textView: UITextView = {
    let textView = UITextView()
    textView.backgroundColor = UIColor(named: "BackgroundColor")
    textView.textContainerInset = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    textView.text = "문장 입력하기"
    textView.textColor = .lightGray
    textView.layer.cornerRadius = 20
    //    textView.add
    return textView
  }()
  lazy var button: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 10
    button.layer.borderColor = UIColor.white.cgColor
    button.layer.borderWidth = 1
    button.setTitle("입력 완료했어요", for: .normal)
    button.addTarget(self, action: #selector(didTapCompletionButton), for: .touchDown)
    return button
  }()
  
  @objc func didTapCompletionButton() {
    didTapConfirmButton()
    let popupVC = PopupViewController()
    //    tempList.forEach {popupVC.wordList.append($0)}
    // 투명도가 있으면 투명도에 맞춰서 나오게 함
    popupVC.modalPresentationStyle = .overCurrentContext
    self.present(popupVC, animated: false)
  }
  
  func postWord() {
    let url = "http://3.39.221.35:8080/line"
    // [http 요청 파라미터 지정 실시]
    let queryString : Parameters = [
      "dot_id" : self.selectedIds.map { String($0) }.joined(separator: " "),
      "line_content" : self.textView.text ?? "n/a"
    ]
    AF.request(url,
               method: .post,
               parameters: queryString,
               encoding: JSONEncoding.default,
               headers: [.authorization(bearerToken: "Z3QVm_9UOLc1MaTk2dMIe43Pbx0Es2OfQ15YYMNWCinI2QAAAYWNnWD2")]
    )
    .validate(statusCode: 200...299)
    .response(completionHandler: { response in
      print(" mmmmodel >> \(response)")
    })
  }
  
  private func didTapConfirmButton() {
    postWord()
    //    for cell in collectionView.visibleCells {
    //      guard let cell = cell as? PointWriteCollectionViewCell else {return}
    //      guard cell.textField.text != "" else {return}
    //      tempList.append(cell.textField.text ?? "")
    //    }
    // Alamofire tempList 보내야 함
    //    print(tempList)
    //    PointPopUpViewController().wordList.append(tempList)
    
  }
  
  func configureUI() {
    view.backgroundColor = UIColor(named: "MainCollectionViewBackgoundColor")
    collectionView.backgroundColor = UIColor(named: "MainCollectionViewBackgoundColor")
    [titleLabel, backButtonImageView, collectionView, lineLabel, textView, loginImage, button]
      .forEach {view.addSubview($0)
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
    textView.snp.makeConstraints {
      $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(25)
      $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-25)
      $0.top.equalTo(collectionView.snp.bottom).offset(34)
      $0.height.equalTo(250)
    }
    button.snp.makeConstraints {
      $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(25)
      $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-25)
      $0.top.equalTo(textView.snp.bottom).offset(25)
      $0.height.equalTo(70)
    }
  }
}

extension LineDetailViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return selectedIds.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LineDetailCell.identifier, for: indexPath) as? LineDetailCell else {
      return UICollectionViewCell()
    }
    cell.label.text = selectedWord[indexPath.row]
    //    cell.label.tintColor = .white
    //    cell.backgroundColor = .black
    //    cell.img.image = UIImage(named: "testImage")
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

extension LineDetailViewController {
  private func autoLayout() {
    collectionView.snp.makeConstraints {
      $0.top.equalTo(lineLabel.snp.bottom).offset(20)
      $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
      $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
      $0.height.equalTo(50)
    }
  }
}
