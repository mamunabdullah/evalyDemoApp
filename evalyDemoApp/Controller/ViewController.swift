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
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var loadMoreButton: UIButton!
    
    
    var shopImage = ""
    var brandImage = ""
    var productImage = ""
    var shopModel = [Data]()
    var brandModel = [BrandData]()
    var productModel = [ProductsData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TopShopsCollectionView.dataSource = self
        TopShopsCollectionView.delegate = self
        TopBrandsCollectionView.dataSource = self
        TopBrandsCollectionView.delegate = self
        TopProductsCollectionView.dataSource = self
        TopProductsCollectionView.delegate = self
        createUI()
        
     
    }
    func createUI(){
        bottomView.layer.cornerRadius = 15
        bottomView.clipsToBounds = true
        loadMoreButton.layer.cornerRadius = 20
        loadMoreButton.clipsToBounds = true
        loadMoreButton.layer.borderWidth = 1
        loadMoreButton.layer.borderColor = UIColor.white.cgColor
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 0
        TopBrandsCollectionView.collectionViewLayout = layout
    }
    
    @IBAction func loadMoreClicked(_ sender: Any) {
        print("Can not do that Function!")
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
                //self.shopModel = shopDataResponseValue.data
//                let myData = shopDataResponseValue.data?[0]
//                let image = myData?.logo_image!
//                self.shopImage = image!
//                print(self.shopImage)
//                print(response)
                guard let topShopData = shopDataResponseValue.data else {
                    self.shopModel.removeAll()
                    self.TopShopsCollectionView.reloadData()
                    return
                }

                //success
                self.shopModel = topShopData
                self.TopShopsCollectionView.reloadData()
                
                
//                print(self.shopModel.count)
//                self.TopShopsCollectionView.reloadData()
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
                //self.brandModel = brandsDataResponseValue.data
//                let myData = brandsDataResponseValue.data?[0]
//                let image = myData?.image_url!
//                self.brandImage = image!
//                print(self.brandImage)
//                print(myData)
//                print(response)
                
                guard let topBrandData = brandsDataResponseValue.data else {
                    self.brandModel.removeAll()
                    self.TopBrandsCollectionView.reloadData()
                    return
                }

                //success
                self.brandModel = topBrandData
                self.TopBrandsCollectionView.reloadData()
                
                //self.TopBrandsCollectionView.reloadData()
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
                //self.productModel = productsDataResponseValue.data
//                let myData = productsDataResponseValue.data?[0]
//                let image = myData?.image_urls?[0]
//                self.productImage = image!
//                print(image)
//                print(myData)
//                print(response)
                guard let topProductData = productsDataResponseValue.data else {
                    self.productModel.removeAll()
                    self.TopProductsCollectionView.reloadData()
                    return
                }

                //success
                self.productModel = topProductData
                self.TopProductsCollectionView.reloadData()

               // self.TopProductsCollectionView.reloadData()
               
            } else {
                
            }
        }
    }

}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView==TopShopsCollectionView){
            return shopModel.count
        }else if(collectionView==TopBrandsCollectionView){
            return brandModel.count
        }
        else{
            return productModel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView==TopShopsCollectionView){
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topShops", for: indexPath as IndexPath) as! TopShopsCollectionViewCell
            let row = indexPath.row
            //var index : Int = indexPath[1]
            //print(self.shopModel![index].logo_image)
           // print(self.shopModel)
            cell.topShopsImage.contentMode = .scaleAspectFit
            //cell.topShopsImage.image = UIImage(named:"home")!
            //shopModel![indexPath.item].title
            let data = shopModel[row]
            cell.topShopsImage.downloaded(from:  data.logo_image!)
            cell.topShopsName.numberOfLines = 0
            cell.topShopsName.text = data.shop_name
            cell.subView.layer.cornerRadius = 14
            
            return cell
            
        }
        else if(collectionView==TopBrandsCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topBrands", for: indexPath as IndexPath) as! TopBrandsCollectionViewCell
            let row = indexPath.row
            cell.topBrandsImage.contentMode = .scaleToFill
            //cell.topBrandsImage.image = UIImage(named:"notification")!
            let data = brandModel[row]
            cell.topBrandsImage.downloaded(from: data.image_url!)
            cell.topBrandsName.text = data.name
            cell.subView.layer.cornerRadius = 12
            return cell
            
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topProducts", for: indexPath as IndexPath) as! TopProductsCollectionViewCell
            let row = indexPath.row
            cell.topProductsImage.contentMode = .scaleToFill
            let data = productModel[row]
            cell.topProductsImage.downloaded(from: (data.image_urls?[0])!)
            cell.topProductsName.text = data.name
            cell.topProductsMaxPrice.text = "৳ \(data.max_price!)"
            cell.topProductsSalePrice.text = "৳ \(data.min_discounted_price!)"
            cell.subView.layer.cornerRadius = 12
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
    func collectionView(_ collectionView: UICollectionView, layout
                collectionViewLayout: UICollectionViewLayout,
                                minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                return 5.0
            }
    
}


    
    





