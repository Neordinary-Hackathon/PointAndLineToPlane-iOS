//
//  PointPopUpViewController.swift
//  PointAndLineToPlane
//
//  Created by 정현우 on 2023/01/07.
//

import UIKit
import Alamofire

class PointPopUpViewController: UIViewController {
	
	lazy var popUpView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor(named: "BackgroundColor")
		view.layer.cornerRadius = 12
		
		return view
	}()
	
	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.text = "점 작성을 완료할까요?"
		label.textColor = .black
		label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
		
		return label
	}()
	
	lazy var descriptionLabel: UILabel = {
		let label = UILabel()
		label.text = "내 작업에서 확인할 수 있어요."
		label.textColor = .black
		label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
		
		return label
	}()
	
	lazy var cancelButton: UIButton = {
		let button = UIButton()
		button.setTitle("취소", for: .normal)
		button.backgroundColor = .black
		button.layer.cornerRadius = 8
		
		return button
	}()
	
	lazy var confirmButton: UIButton = {
		let button = UIButton()
		button.setTitle("확인", for: .normal)
		button.backgroundColor = .black
		button.layer.cornerRadius = 8
		
		return button
	}()
	
	lazy var stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.spacing = 14
		
		return stackView
	}()
	
	var wordList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .black.withAlphaComponent(0.6)
		configureViews()
		
		cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
		confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
    }
	
	@objc func didTapCancelButton() {
		wordList.removeAll()
		self.navigationController?.popViewController(animated: false)
	}
	
	@objc func didTapConfirmButton() {
		// TODO: 점 작성 완료 -> 선 VC로 이동 or 메인 VC로 이동
//		print(wordList)
		DotRequest()
//		self.dismiss(animated: false)
		
		self.navigationController?.popToRootViewController(animated: false)
		
	}
	
	
	private func DotRequest() {
		let url = "http://3.39.221.35:8080/dot"
		let header: HTTPHeaders = [
			.authorization(bearerToken: APIToken.shared.tokenValue)
		]
		
		let bodyData: Parameters = ["dot_content": self.wordList.joined(separator: " ")]
		
		AF.request(url, method: .post, parameters: bodyData,encoding: JSONEncoding.default ,headers: header)
			.validate(statusCode: 200..<300)
			.responseData { response in
				switch response.result {
				case .success(let res):
					let decoder = JSONDecoder()
					
					do {
						let data = try decoder.decode(DotRequestModel.self, from: res)
						print(data)
					} catch {
						print("errorr in decode")
					}
				case .failure(let err):
					print(err.localizedDescription)
				}
			}
	}
    

	private func configureViews() {
		view.addSubview(popUpView)
		
		popUpView.snp.makeConstraints {
			$0.leading.equalToSuperview().inset(32)
			$0.trailing.equalToSuperview().inset(32)
			$0.height.equalTo(185)
			$0.centerY.equalToSuperview()
		}
		
		[cancelButton, confirmButton]
			.forEach {stackView.addArrangedSubview($0)}
		
		
		cancelButton.snp.makeConstraints {
			$0.width.equalTo(98)
			$0.height.equalTo(48)
		}
		confirmButton.snp.makeConstraints {
			$0.width.equalTo(100)
			$0.height.equalTo(48)
		}
		
		[titleLabel, descriptionLabel, stackView]
			.forEach {popUpView.addSubview($0)}
		titleLabel.snp.makeConstraints {
			$0.centerX.equalToSuperview()
			$0.top.equalToSuperview().inset(32)
		}
		descriptionLabel.snp.makeConstraints {
			$0.centerX.equalToSuperview()
			$0.top.equalTo(titleLabel.snp.bottom).offset(8)
		}
		
		stackView.snp.makeConstraints {
			$0.bottom.equalToSuperview().inset(22)
			$0.leading.equalToSuperview().inset(24)
			$0.trailing.equalToSuperview().inset(24)
		}
		
	}

}
