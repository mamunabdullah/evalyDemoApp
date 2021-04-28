//
//  ViewController.swift
//  evalyDemoApp
//
//  Created by Abdullah Al Mamun on 27/4/21.
//

import UIKit
import Alamofire
import AlamofireImage
class ViewController: UIViewController,UICollectionViewDataSource {
   
    
    @IBOutlet weak var TopShopsCollectionView: UICollectionView!
    @IBOutlet weak var TopBrandsCollectionView: UICollectionView!
    @IBOutlet weak var TopProductsCollectionView: UICollectionView!
    
    var shopImage = ""
    var brandImage = ""
    var productImage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TopShopsCollectionView.dataSource = self
        TopShopsCollectionView.delegate = self
        TopBrandsCollectionView.dataSource = self
        TopBrandsCollectionView.delegate = self
        TopProductsCollectionView.dataSource = self
        TopProductsCollectionView.delegate = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 0
        TopBrandsCollectionView.collectionViewLayout = layout
     
    }
    override func loadView() {
        super.loadView()
        Alamofire.request("https://api.evaly.com.bd/go-catalog/api/v1/public/shops?page=1", method: .get).responseObject { (response: DataResponse<TopShopsModel>) in
            let request = response.request
            let httpResponse = response.response
            let statusCode = response.response?.statusCode
            print("""
                ***************************************
                FUNCTION: \(#function), LINE: \(#line), CLASS : \(type(of: self))
                ***************************************
                """)
            
            guard let statusCodeUnwrapped = statusCode else {
                return
            }
            
            if 200 ... 300 ~= statusCodeUnwrapped {
                print("Treshold")
                
                let shopDataResponseValue = response.result.value!
                let myData = shopDataResponseValue.data?[0]
                let image = myData?.logo_image!
                self.shopImage = image!
                print(self.shopImage)
                print(response)
                self.callTopBrands()
               
            } else {
                
            }
        }
    }
    
    func callTopBrands(){
        Alamofire.request("https://api.evaly.com.bd/go-catalog/api/v1/public/brands?page=1", method: .get).responseObject { (response: DataResponse<TopBrandsModel>) in
            let request = response.request
            let httpResponse = response.response
            let statusCode = response.response?.statusCode
            print("""
                ***************************************
                FUNCTION: \(#function), LINE: \(#line), CLASS : \(type(of: self))
                ***************************************
                """)
            
            guard let statusCodeUnwrapped = statusCode else {
                return
            }
            
            if 200 ... 300 ~= statusCodeUnwrapped {
               
                print("Treshold")
                
                 let brandsDataResponseValue = response.result.value!
                let myData = brandsDataResponseValue.data?[0]
                let image = myData?.image_url!
                self.brandImage = image!
                print(self.brandImage)
                print(myData)
                print(response)
                self.callTopProducts()
               
            } else {
            
            }
        }
    }
    
    
    func callTopProducts(){
        Alamofire.request("https://api.evaly.com.bd/go-catalog/api/v1/public/products", method: .get).responseObject { (response: DataResponse<TopProductsModel>) in
            let request = response.request
            let httpResponse = response.response
            let statusCode = response.response?.statusCode
            print("""
                ***************************************
                FUNCTION: \(#function), LINE: \(#line), CLASS : \(type(of: self))
                ***************************************
                """)
            
            guard let statusCodeUnwrapped = statusCode else {
                return
            }
            
            if 200 ... 300 ~= statusCodeUnwrapped {
                print("Treshold")
                let productsDataResponseValue = response.result.value!
                let myData = productsDataResponseValue.data?[0]
                let image = myData?.image_urls?[0]
                self.productImage = image!
                print(image)
                print(myData)
                print(response)
               
            } else {
                
            }
        }
    }

}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView==TopShopsCollectionView){
            return 10
        }else if(collectionView==TopBrandsCollectionView){
            return 12
        }
        else{
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView==TopShopsCollectionView){
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topShops", for: indexPath as IndexPath) as! TopShopsCollectionViewCell
            cell.topShopsImage.contentMode = .scaleAspectFit
            //cell.topShopsImage.image = UIImage(named:"home")!
            cell.topShopsImage.downloaded(from: shopImage)
            cell.topShopsName.text = "Apple"
            cell.subView.layer.cornerRadius = 14
            
            return cell
            
        }
        else if(collectionView==TopBrandsCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topBrands", for: indexPath as IndexPath) as! TopBrandsCollectionViewCell
            cell.topBrandsImage.contentMode = .scaleToFill
            //cell.topBrandsImage.image = UIImage(named:"notification")!
            cell.topBrandsImage.downloaded(from: brandImage)
            cell.topBrandsName.text = "AppleBrands"
            cell.subView.layer.cornerRadius = 12
            return cell
            
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topProducts", for: indexPath as IndexPath) as! TopProductsCollectionViewCell
            cell.topProductsImage.contentMode = .scaleToFill
            cell.topProductsImage.downloaded(from: productImage)
            cell.topProductsName.text = "AppleBrands"
            cell.topProductsMaxPrice.text = "৳ 1500"
            cell.topProductsSalePrice.text = "৳ 1000"
            cell.subView.layer.cornerRadius = 8
            return cell
        }
       

    }
   
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
       var cgSize = CGSize()
        if(collectionView==TopShopsCollectionView){
           
            cgSize = CGSize(width: collectionView.frame.width/4, height: 100)

        }
        else if(collectionView==TopBrandsCollectionView){
            cgSize = CGSize(width: collectionView.frame.width/4.2, height: 100)
        }
        else{
            cgSize = CGSize(width: collectionView.frame.width/2.2, height: 150)
        }
        return cgSize
       }
//    func collectionView(_ collectionView: UICollectionView,
//                                layout collectionViewLayout: UICollectionViewLayout,
//                                minimumInteritemSpacingForSectionAt section: Int) ->CGFloat{
//                return 5.0
//            }
//
    func collectionView(_ collectionView: UICollectionView, layout
                collectionViewLayout: UICollectionViewLayout,
                                minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                return 5.0
            }
    
}


    
    





