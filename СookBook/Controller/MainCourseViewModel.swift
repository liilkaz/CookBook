//
//  MainCourseViewModel.swift
//  СookBook
//
//  Created by Meddor on 01.03.2023.
//

import Foundation

protocol MainCourseProtocol: AnyObject {
    func updateMainCourse()
}
class MainCourseViewModel {
    
    weak var delegat: MainCourseProtocol?
    var model: MainCourseModel?
    
    func fetchURL() {
        let url = "http://135.181.99.110:8080/recipes/complexSearch?sort=popularity&apiKey=c020b400a8244106a0b807006800605b"
        performRequest(currentURL: url)
    }
    func performRequest(currentURL: String) {
        if let url = URL(string: currentURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, responce, error in
                if error != nil {
                    print("🤬\(error!)")
                    return
                }
                if let dataFromJson = data {
                    self.jsonDecoder(data: dataFromJson)
                }
            }
            task.resume()
        }
    }
    func jsonDecoder(data: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MainCourseModel.self, from: data)
            self.model = decodedData
            delegat?.updateMainCourse()
        } catch {
            print("🤬\(error)")
        }
    }
}
