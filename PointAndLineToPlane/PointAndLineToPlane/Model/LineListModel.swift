//
//  LineListModel.swift
//  PointAndLineToPlane
//
//  Created by 정현우 on 2023/01/08.
//

import Foundation

struct LineListModel: Decodable {
	let lines: [Line]
}

struct Line: Decodable {
	let line_id: Int
	let line_content: String
}
