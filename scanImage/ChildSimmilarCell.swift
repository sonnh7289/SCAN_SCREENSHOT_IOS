//
//  ChildSimmilarCell.swift
//  SwiftStitch
//
//  Created by nguyenhuyson on 11/25/20.
//  Copyright © 2020 ellipsis.com. All rights reserved.
//

import UIKit
import Photos

class ChildSimmilarCell: UICollectionViewCell {

    @IBOutlet weak var imgTick: UIImageView!
    let option = PHImageRequestOptions()
    @IBOutlet weak var imgChild: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgChild.layer.cornerRadius = 10
        imgChild.layer.masksToBounds = true
        
        option.isNetworkAccessAllowed = true
    }
    
    
    func reloadCell(asset: PHAsset){
        if self.tag != 0 {
            PhotoLibraryManager.shared.cachingImageManager.cancelImageRequest(PHImageRequestID(self.tag))
        }
        let scale = UIScreen.main.scale
        let imageSize = CGSize.init(width: self.bounds.size.width * scale, height: self.bounds.size.width * scale)
        self.tag = Int(PhotoLibraryManager.shared.cachingImageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFit, options: option) { (result, _) in
            self.imgChild.image = result
        })
       // self.sizeLabel.text = PhotoLibraryManager.shared.getSizeText(asset: asset)
    }

}
