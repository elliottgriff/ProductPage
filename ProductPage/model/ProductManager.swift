//
//  ProductManager.swift
//  ProductPage
//
//  Created by elliott on 4/11/22.
//

import UIKit

protocol ProductManagerDelegate {
    func didUpdateData(data: [String:Product])
}

struct ProductManager {
    
    let urlString = "https://run.mocky.io/v3/4e23865c-b464-4259-83a3-061aaee400ba"
    var delegate: ProductManagerDelegate?
    
    func fetchData() {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("error fetching data")
                    return
                }
                if let safeData = data {
                    self.parseJSON(safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ safeData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([String:Product].self, from: safeData)
            self.delegate?.didUpdateData(data: decodedData)
            print("sending did update json")
        } catch {
            print("error parsing")
        }
    }
}
