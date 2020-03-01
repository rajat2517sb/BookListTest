//
//  ViewController.swift
//  BookList
//
//  Created by Rajat Babhulgaonkar on 01/03/20.
//  Copyright © 2020 Rajat Babhulgaonkar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    struct BookList:Decodable {
        let id:Int
        let author:String
    }
    lazy var collectionView : UICollectionView = {
        let collection = UICollectionView.init(frame: .zero, collectionViewLayout: self.collectionFlowLayout)
        collection.register(BookListCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifer)
        collection.backgroundColor = .white
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    lazy var collectionFlowLayout:UICollectionViewFlowLayout = {
       let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 3
        return flowLayout
    }()
    var bookListArray:[BookList] = []
    
    let reuseIdentifer = "collectionCell"
    let bookListUrl = URL(string: "https://picsum.photos/list")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        serviceCall()
        
        self.view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    func serviceCall()
    {
        guard let url = bookListUrl else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                return
            }
            
            do{
                let decode = try JSONDecoder().decode([BookList].self, from: data)
                self.bookListArray = decode
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                print(decode.count)
            }
            catch let error
            {
                print("Failed to serialize...")
            }
           
        }.resume()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }
}

extension ViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bookListArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let offset = collectionFlowLayout.minimumInteritemSpacing * 2
                
        let width = (collectionView.frame.width - CGFloat(offset)) / 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath) as! BookListCollectionViewCell
        (cell as! BookListCollectionViewCell).authorName.text = bookListArray[indexPath.row].author
    
        (cell as! BookListCollectionViewCell).bookImage.image = UIImage()
        let bookImageUrl = "https://picsum.photos/300/300?image=\(bookListArray[indexPath.row].id)"
        let url = URL(string: bookImageUrl)

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                 (cell as! BookListCollectionViewCell).bookImage.image = UIImage(data: data!)
            }
        }
        return cell
    }
    
    
}
