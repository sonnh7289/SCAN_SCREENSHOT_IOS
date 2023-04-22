//
//  ScreenShotsVC.swift
//  SwiftStitch
//
//  Created by nguyenhuyson on 11/26/20.
//  Copyright © 2020 ellipsis.com. All rights reserved.
//

import UIKit
import Photos
import CoreLocation

class ScreenShotsVC: UIViewController {
    var assets: [PHAsset] = []
    var filterAsset: [PHAsset] = []
    @IBOutlet weak var viewSelect: UIView!
    @IBOutlet weak var lblNumFile: UILabel!
    var selectDate = Date()
    @IBOutlet weak var screenShotCollection: UICollectionView!
    @IBOutlet weak var viewHeader: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSelect.backgroundColor = .clear
        viewHeader.backgroundColor = .clear
        screenShotCollection.backgroundColor = .clear
        screenShotCollection.dataSource = self
        screenShotCollection.delegate = self
        screenShotCollection.register(UINib(nibName: "ChildSimmilarCell", bundle: nil), forCellWithReuseIdentifier: "ChildSimmilarCell")
        getDataImage()
      //  convertPHAssetToUIImage(assets: assets)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func ac_SelectAll(_ sender: Any) {
//        listImageToDelle = []
//        listImageToDelle.append(contentsOf: filterAsset)
        screenShotCollection.reloadData()
    }
    func getDataImage(){
        PhotoLibraryManager.shared.authorize(fromViewController: self) {[weak self] (authorized) -> Void in
            guard authorized == true else { return }
            self?.assets.removeAll()
            self?.filterAsset.removeAll()
     
            // Lấy ra toàn bộ ảnh trong thư viện ở đây
           self?.assets.append(contentsOf: PhotoLibraryManager.shared.getScreenShotsImageAsset())
            self?.getDateImage()
            // Thực hiện chuyển nó sang dạng UIImage
           // self?.convertPHAssetToUIImage(assets: self!.assets)
            //self?.getDateImage()
        
            
          self?.screenShotCollection.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        listImageToDelle = []
    }

    func getDateImage()
       {
           for i in assets{
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "yyyy-MM-dd"
           
           let localDate = dateFormatter.string(from: i.creationDate ?? Date())
           let dateSelect = dateFormatter.string(from: selectDate)
           let dateNow = dateFormatter.string(from: Date())
               
               if dateNow == dateSelect{
                   filterAsset.append(i)
               }
               else if localDate >= dateSelect{
                   filterAsset.append(i)
               }
           
           }
           
           lblNumFile.text = String((filterAsset.count ?? 0))
        screenShotCollection.reloadData()
       }
   
   
    
    

    @IBAction func ac_back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ac_Delete(_ sender: Any) {
   
        
        // lấy vị trí của nó trong library
//        let assetIdentifiers = listImageToDelle.map({ $0.localIdentifier})
//
//        // chuyển nó về kiểu NSFastEnumeration để thực hiện xoá dữ liệu
//        let listDelete = PHAsset.fetchAssets(withLocalIdentifiers: assetIdentifiers, options: nil)
//
//        // Thực hiện việc xoá. kiểm tra xem có thành công hay không
//        PHPhotoLibrary.shared().performChanges({PHAssetChangeRequest.deleteAssets(listDelete)}, completionHandler: {
//        [self] success, error in
//            if success{
//                print("Deleted!")
//                DispatchQueue.main.async {
//                    navigationController?.popViewController(animated: true)
//                }
//
//            }
//            else
//            {
//                print("Cannot delete data")
//            }
//        })
    }
    
}
extension ScreenShotsVC: UICollectionViewDataSource, UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterAsset.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChildSimmilarCell", for: indexPath) as! ChildSimmilarCell
//        if listImageToDelle.contains(filterAsset[indexPath.row])
//        {
//            cell.imgTick.image = UIImage(named: "ic_tick")
//        }else
//        {
//            cell.imgTick.image = UIImage(named: "ic_unTick")
//        }
        
       cell.accessibilityIdentifier = "photo_cell_\(indexPath.item)"
       cell.isAccessibilityElement = true
        var asset: PHAsset!
        asset = filterAsset[indexPath.row]
        cell.reloadCell(asset: asset)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let index = listImageToDelle.index(of: filterAsset[indexPath.row]){
//            listImageToDelle.remove(at: index)
//        }
//        else
//        {
//            listImageToDelle.append(filterAsset[indexPath.row])
//        }
        
        
        screenShotCollection.reloadData()
    }
}

extension ScreenShotsVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad{
            return CGSize(width: collectionView.frame.width / 6, height: collectionView.frame.width / 6)
            
        }
        return CGSize(width: collectionView.frame.width / 4, height: collectionView.frame.width / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }
}
