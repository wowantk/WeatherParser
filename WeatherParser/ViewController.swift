//
//  ViewController.swift
//  WeatherParser
//
//  Created by macbook on 26.01.2021.
//

import UIKit

class ViewController: UIViewController {
    
    public var alert:UIAlertController?
    @IBOutlet weak var collection: UICollectionView!
    
    
    private var dataSourceObj:Welcome?
    private var refreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.register(UINib(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
        getAllData()
    }
    
    @objc  func getSearch(with text:String){
        ViewController.performRequest(with: .getSearchResult(searhText: text)) {  [weak self] (isSucces, response) in
            guard let self = self else {return}
            if isSucces {
                self.dataSourceObj = response
                DispatchQueue.main.async {
                    self.collection.reloadData()
                }
            }
            
        }
    }
    
    
    
    
    @objc private func getAllData() {
        ViewController.performRequest() { [weak self] (isSuccess, response) in
            guard let self = self else {return}
            if isSuccess {
                self.dataSourceObj = response
            }
            DispatchQueue.main.async {
                self.collection.reloadData()
                if isSuccess { self.collection.reloadData() }
            }
        }
    }
    
    static func performRequest(with requestType: RequestType = .getAll, completion: @escaping (_ isSuccess: Bool, _ response: Welcome?) -> ()) {
        var repStringURL = ""
        switch requestType {
        case .getAll: repStringURL = "https://api.openweathermap.org/data/2.5/weather?q=Moscow&units=metric&appid=32d3eaae37de69896ce7b715acb51275"
        case .getSearchResult(let searhText): repStringURL = "https://api.openweathermap.org/data/2.5/weather?q=\(searhText)&units=metric&appid=32d3eaae37de69896ce7b715acb51275"
        }
            guard let allRep = URL(string: repStringURL) else {return}
            URLSession.shared.dataTask(with: allRep) { (data, response, error) in
                var result: Welcome?
                guard data != nil else {
                    print("NO DATA")
                    completion(false, result)
                    return
                }
                
                guard error == nil else {
                    print(error!.localizedDescription)
                    completion(false, result)
                    return
                }
                do{
                    switch requestType {
                    case .getAll: result = try JSONDecoder().decode(Welcome.self, from: data!)
                    case .getSearchResult(_): result = try JSONDecoder().decode(Welcome.self, from: data!)
                    }
                    completion(true, result)
                }catch{
                    print(error.localizedDescription)
                    completion(false, result)
                    
                }
            }.resume()
        }
    
}


extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        while(self.dataSourceObj == nil){
            DispatchQueue.main.async {
                self.collection.reloadData()
            }
        }
        cell.setUp(model: dataSourceObj!)
        cell.ParentVC = self
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collection.frame.width ,height: collection.frame.height)
        
        
        
        
        
        
    }
    
}












