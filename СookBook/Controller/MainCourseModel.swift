//
//  MainCourseModel.swift
//  СookBook
//
//  Created by Meddor on 01.03.2023.
//

import Foundation

struct MainCourseModel: Codable{
    let results: [Ingridients]

}
struct Ingridients: Codable {
    let id: Int
    let title: String
    let image: String
}
