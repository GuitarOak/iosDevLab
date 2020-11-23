//
//  QuestionsResult.swift
//  iosDevLab
//
//  Created by Emil Karlsson on 2020-11-23.
//

import Foundation

struct QuestionsResult: Decodable {
    let results: [Question]
}
