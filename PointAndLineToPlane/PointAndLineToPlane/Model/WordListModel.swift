//
//  WordListModel.swift
//  PointAndLineToPlane
//
//  Created by 고명주 on 2023/01/08.
//

import Foundation

struct WordListModel: Decodable {
  let dots: [Dots]
  struct Dots: Decodable {
    let dotId: Int
    let dotContent: String
    let userId: Int
    
    enum CodingKeys: String, CodingKey {
      case dotId = "dot_id"
      case dotContent = "dot_content"
      case userId = "user_id"
    }
  }
}
