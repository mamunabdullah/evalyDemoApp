//
//  ViewController.swift
//  evalyDemoApp
//
//  Created by Abdullah Al Mamun on 27/4/21.
//

import UIKit
class ViewController: UIViewController,UICollectionViewDataSource {
   
    
    @IBOutlet weak var TopShopsCollectionView: UICollectionView!
    @IBOutlet weak var TopBrandsCollectionView: UICollectionView!
    @IBOutlet weak var TopProductsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        TopShopsCollectionView.dataSource = self
        TopShopsCollectionView.delegate = self
        TopBrandsCollectionView.dataSource = self
        TopBrandsCollectionView.delegate = self
        TopProductsCollectionView.dataSource = self
        TopProductsCollectionView.delegate = self
     
    }

}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView==TopShopsCollectionView){
            return 10
        }else if(collectionView==TopBrandsCollectionView){
            return 8
        }
        else{
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView==TopShopsCollectionView){
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topShops", for: indexPath as IndexPath) as! TopShopsCollectionViewCell
            cell.topShopsImage.contentMode = .scaleAspectFit
            cell.topShopsImage.image = UIImage(named:"home")!
            cell.topShopsName.text = "Apple"
            cell.subView.layer.cornerRadius = 8
            
            return cell
            
        }
        else if(collectionView==TopBrandsCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topBrands", for: indexPath as IndexPath) as! TopBrandsCollectionViewCell
            cell.topBrandsImage.contentMode = .scaleToFill
            cell.topBrandsImage.image = UIImage(named:"profile")!
            cell.topBrandsName.text = "AppleBrands"
            cell.subView.layer.cornerRadius = 8
            return cell
            
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topProducts", for: indexPath as IndexPath) as! TopProductsCollectionViewCell
            cell.topProductsImage.contentMode = .scaleToFill
            cell.topProductsImage.image = UIImage(named:"profile")!
            cell.topProductsName.text = "AppleBrands"
            cell.topProductsMaxPrice.text = "1500"
            cell.topProductsSalePrice.text = "1000"
            cell.subView.layer.cornerRadius = 8
            return cell
        }
       

    }
   
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
        if(collectionView==TopShopsCollectionView){
            
            return CGSize(width: collectionView.frame.width/4, height: 100)

        }
        else if(collectionView==TopBrandsCollectionView){
            return CGSize(width: collectionView.frame.width/5.2, height: 100)
        }
        else{
            return CGSize(width: collectionView.frame.width/2.2, height: 150)
        }
        
       }
    func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                minimumInteritemSpacingForSectionAt section: Int) ->CGFloat{
                return 5.0
            }

    func collectionView(_ collectionView: UICollectionView, layout
                collectionViewLayout: UICollectionViewLayout,
                                minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                return 5.0
            }
    
}
    
    





