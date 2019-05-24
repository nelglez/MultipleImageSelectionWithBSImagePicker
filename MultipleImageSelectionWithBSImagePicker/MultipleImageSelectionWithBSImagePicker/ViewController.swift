//
//  ViewController.swift
//  MultipleImageSelectionWithBSImagePicker
//
//  Created by Nelson Gonzalez on 5/24/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//https://stackoverflow.com/questions/35476906/bsimagepicker-into-imageview
//https://github.com/mikaoj/BSImagePicker

import UIKit
import BSImagePicker
import Photos

class ViewController: UIViewController {

    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var middleImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    
    var selectedAssets = [PHAsset]()
    
    var photoArray = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func pickImagesButtonPressed(_ sender: UIButton) {
        
        let vc = BSImagePickerViewController()
        vc.maxNumberOfSelections = 3
     
        bs_presentImagePickerController(vc, animated: true,
                                        select: { (asset: PHAsset) -> Void in
                                            print("Selected: \(asset)")
        }, deselect: { (asset: PHAsset) -> Void in
            print("Deselected: \(asset)")
        }, cancel: { (assets: [PHAsset]) -> Void in
            print("Cancel: \(assets)")
        }, finish: { (assets: [PHAsset]) -> Void in
            print("Finish: \(assets)")
            for i in 0..<assets.count
            {
                self.selectedAssets.append(assets[i])
                print(self.selectedAssets)
            }
            self.getAllImages()
        }, completion: nil)
    }
    
    func getAllImages() -> Void {
        
        print("get all images method called here")
        if selectedAssets.count != 0{
            for i in 0..<selectedAssets.count{
                let manager = PHImageManager.default()
                let option = PHImageRequestOptions()
                var thumbnail = UIImage()
                
                option.isSynchronous = true
                manager.requestImage(for: selectedAssets[i], targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                    thumbnail = result!
                
                })
                self.photoArray.append(thumbnail)
            }
            DispatchQueue.main.async {
                self.leftImageView.image = self.photoArray.first
                self.middleImageView.image = self.photoArray[1]
                
                self.rightImageView.image = self.photoArray.last
            }
        }
    }
    
}

