//
//  PhotoManager.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/08/13.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation
import Photos

struct PhotoAlbumManager {

    private static var pickerListener: ImagePickerListener?

    static func requestAuthorization(completion: PHAuthorizationStatus -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()

        switch (status) {
        case .NotDetermined:
            PHPhotoLibrary.requestAuthorization(completion)

        case .Restricted, .Authorized:
            completion(status)

        case .Denied:
            showAlertForDenied()
        }
    }

    private static func showAlertForDenied() {
        UIAlertController(title: "Error".localized, message: "写真へのアクセスが許可されていません。設定より変更してください。".localized, preferredStyle:  .Alert)
        .addAction(title: "設定画面へ".localized) { _ in
            goToSetting()
        }
        .addAction(title: "キャンセル".localized, style: .Cancel)
        .show()
    }

    private static func goToSetting() {
        if let url = NSURL(string: UIApplicationOpenSettingsURLString) {
            UIApplication.sharedApplication().openURL(url)
        }
    }

    static func fetchAllPhotosAssets(fetchOptions fetchOptions: PHFetchOptions = .orderedByCreationDate(), block: PHAsset -> Bool) {
        let assets = PHAsset.fetchAssetsWithMediaType(.Image, options: fetchOptions)
        assets.enumerateObjectsUsingBlock { asset, index, stop in
            if let asset = asset as? PHAsset {
                stop.memory = ObjCBool(block(asset))
            }
        }
    }

    /**
     Fetch all photos.

     - parameter fetchOptions: fetch options
     - parameter block:        stop fetching if the block returns false.
     */
    static func fetchAllPhotos(fetchOptions fetchOptions: PHFetchOptions = .orderedByCreationDate(), block: UIImage -> Bool) {
        let assets = PHAsset.fetchAssetsWithMediaType(.Image, options: fetchOptions)
        assets.enumerateObjectsUsingBlock { asset, index, stop in
            (asset as? PHAsset)?.requestImage { image in
                stop.memory = ObjCBool(block(image))
            }
        }
    }

    static func pickPhotoFrom(sourceType: UIImagePickerControllerSourceType, completion: UIImage? -> Void) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            pickerListener = ImagePickerListener(completion: completion)

            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = sourceType
            imagePickerController.allowsEditing = true
            imagePickerController.delegate = pickerListener
            UIApplication.sharedApplication().topViewController?.presentViewController(imagePickerController, animated: true, completion: nil)
        } else {
            completion(nil)
        }
    }

}

extension PHAsset {
    func requestImage(size: CGSize? = nil, completion: UIImage -> Void) {
        let manager = PHImageManager()

        let size = size ?? CGSize(width: pixelWidth, height: pixelHeight)
        manager.requestImageForAsset(self, targetSize: size, contentMode: .AspectFill, options: nil) { image, info in
            // 解像度の低いサムネイルは無視
            guard let isDegraded = info?[PHImageResultIsDegradedKey]?.boolValue else { return }
            if isDegraded { return }

            if let image = image {
                completion(image)
            }
        }
    }

    func deleteAsset(completion: NSError? -> Void) {
        PHPhotoLibrary.sharedPhotoLibrary().performChanges({
            PHAssetChangeRequest.deleteAssets([self])
        }) { success, error in
            completion(error)
        }
    }
}

extension PHFetchOptions {
    /**
     作成日順

     - parameter ascending: trueなら新しい順

     - returns: PHFetchOptions
     */
    static func orderedByCreationDate(ascending: Bool = false) -> PHFetchOptions {
        let options = PHFetchOptions()
        options.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: ascending)
        ]
        return options
    }
}

private final class ImagePickerListener: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let completion: UIImage? -> Void

    init(completion: UIImage? -> Void) {
        self.completion = completion
    }

    @objc private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            completion(image)
        } else if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            completion(image)
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    @objc private func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        completion(nil)
    }
}
