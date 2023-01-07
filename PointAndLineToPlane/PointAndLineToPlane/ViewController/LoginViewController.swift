//
//  ViewController.swift
//  PointAndLineToPlane
//
//  Created by HA on 2023/01/07.
//

import UIKit
import SnapKit
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon
import Alamofire

class LoginViewController: UIViewController {
  
  lazy var loginLabel: UILabel = {
    let label = UILabel()
    label.text = "점선면"
    label.font = UIFont(name: "Kefa-Regular", size: 20)
    return label
  }()
  lazy var loginLabel2: UILabel = {
    let label = UILabel()
    label.text = "에"
    label.font = UIFont(name: "Kefa-Regular", size: 20)
    return label
  }()
  lazy var loginLabel3: UILabel = {
    let label = UILabel()
    label.text = "오신 것을 환영합니다."
    label.font = UIFont(name: "Kefa-Regular", size: 20)
    return label
  }()
  lazy var loginLabel4: UILabel = {
    let label = UILabel()
    label.text = "점  선  면"
    label.font = UIFont(name: "Nanum Myeongjo", size: 24)
    return label
  }()
  lazy var loginLabel5: UILabel = {
    let label = UILabel()
    label.text = "DLF"
    label.font = UIFont(name: "STIXTwoMath-Regular", size: 24)
    return label
  }()
  lazy var loginLabel6: UILabel = {
    let label = UILabel()
    label.text = "SNS로 간편가입"
    label.tintColor = UIColor(named: "MainCollectionViewBehindColor")
    label.font = UIFont(name: "STIXTwoMath-Regular", size: 12)
    return label
  }()
  lazy var loginImage: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "dot"))
    return imageView
  }()
  lazy var kakaoLogo: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "kakaoLogo"), for: .normal)
    button.addTarget(self, action: #selector(buttonClicked), for: .touchDown)
    return button
  }()
  lazy var naverLogo: UIImageView = {
    let button = UIImageView(image: UIImage(named: "naverLogo"))
    return button
  }()
  lazy var flowerImage: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "loginFlower"))
    imageView.frame.width.isEqual(to: 200)
    return imageView
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(named: "BackgroundColor")
    configureViews()
    //    getFontName()
    //    kakaoLogo.isUserInteractionEnable(true)
  }
  //  func getFontName() {
  //    for family in UIFont.familyNames {
  //      let sName: String = family as String
  //      print("family: (sName)")
  //      for name in UIFont.fontNames(forFamilyName: sName) {
  //        print("name: (\(name) as String)")
  //      }
  //    }
  //  }
  
  @objc func buttonClicked() {
    print("login ~")
    // 카카오톡 설치 여부 확인
    UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
      if let error = error {
        print(error)
      }
      else {
        print("loginWithKakaoAccount() success.")
        //        UserDefaults.standard.set(oauthToken, forKey: "accessToken") 얜 넘겨주는거
        print("token >>>>>>> \(oauthToken?.accessToken)")
        self.get(accessToken: oauthToken?.accessToken ?? "")
        self.dismiss(animated: true)
      }
    }
  }
  func get(accessToken: String) {
    AF.request("http://3.39.221.35:8080/auth",
               method: .post,
               parameters: nil,
               encoding: URLEncoding.default,
               headers: ["ACCESS_TOKEN":"\(accessToken)"])
    .validate()
    .responseDecodable(of: KakaoLogin.self,  completionHandler: { response in
      switch response.result {
      case .success(let response):
        AF.request("http://3.39.221.35:8080/register",
                   method: .post,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["ACCESS_TOKEN":"\(response.accessToken)"])
        .responseJSON { (json) in
          print("jsonddata \(json)")
          UserDefaults.standard.set(response.accessToken, forKey: "jwtToken")
          let vc = LineViewController()
          (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc, animated: false)
        }
      default:
        break
      }
    })
  }
  
  func configureViews() {
    [loginLabel, loginLabel2, loginLabel3, loginLabel4, loginLabel5, loginLabel6, loginImage, kakaoLogo, naverLogo, flowerImage]
      .forEach {view.addSubview($0)
      }
    loginLabel.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(160)
      $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(160)
    }
    loginLabel2.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(160)
      $0.left.equalTo(loginLabel.snp.right)
    }
    loginLabel3.snp.makeConstraints {
      $0.top.equalTo(loginLabel.snp.bottom).offset(10)
      $0.centerX.equalToSuperview()
    }
    loginLabel4.snp.makeConstraints {
      $0.top.equalTo(loginLabel3.snp.bottom).offset(42)
      $0.centerX.equalToSuperview()
    }
    loginLabel5.snp.makeConstraints {
      $0.top.equalTo(loginLabel4.snp.bottom).offset(42)
      $0.centerX.equalToSuperview()
    }
    loginImage.snp.makeConstraints {
      $0.top.equalTo(loginLabel5.snp.bottom).offset(38)
      $0.height.equalTo(10)
      $0.width.equalTo(10)
      $0.centerX.equalToSuperview()
    }
    kakaoLogo.snp.makeConstraints {
      $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(120)
      $0.top.equalTo(loginImage.snp.bottom).offset(38)
      $0.height.equalTo(63)
      $0.width.equalTo(63)
    }
    naverLogo.snp.makeConstraints {
      $0.left.equalTo(kakaoLogo.snp.right).offset(22)
      $0.top.equalTo(kakaoLogo.snp.top)
      $0.height.equalTo(63)
      $0.width.equalTo(63)
    }
    loginLabel6.snp.makeConstraints {
      $0.top.equalTo(kakaoLogo.snp.bottom).offset(21)
      $0.centerX.equalToSuperview()
    }
    flowerImage.snp.makeConstraints {
      $0.bottom.equalTo(view.snp.bottom)
      $0.height.equalTo(250)
      $0.width.equalTo(250)
      $0.centerX.equalToSuperview()
    }
  }
}
