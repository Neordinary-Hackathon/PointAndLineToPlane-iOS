//
//  KakaoLogin.swift
//  PointAndLineToPlane
//
//  Created by 고명주 on 2023/01/08.
//

import Foundation

struct KakaoLogin: Decodable {
  let accessToken: String
  let tokenType: String
  let refreshToken: String
  let idToken: String
  let expiresIn: Int
  let scope: String
  let refreshTk: Int
  
  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case tokenType = "token_type"
    case refreshToken = "refresh_token"
    case idToken = "id_token"
    case expiresIn = "expires_in"
    case scope
    case refreshTk = "refresh_token_expires_in"
  }
}

