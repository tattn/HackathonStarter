//
//  PhotoManager.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/08/13.
//  Copyright © 2016年 tattn. All rights reserved.
//

#if false

import Foundation
import Photos

struct PhotoAlbumManager {

    fileprivate static var pickerListener: ImagePickerListener?

    static func runIfAuthorized(_ block: @escaping () -> Void) {
        requestAuthorization { status in
            if status == .authorized {
                block()
            }
        }
    }

    static func requestAuthorization(_ completion: @escaping (PHAuthorizationStatus) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()

        switch (status) {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(completion)

        case .restricted, .authorized:
            completion(status)

        case .denied:
            showAlertForDenied()
            completion(status)
        }
    }

    fileprivate static func showAlertForDenied() {
        UIAlertController(title: "Error".localized, message: "写真へのアクセスが許可されていません。設定より変更してください。".localized, preferredStyle:  .alert)
        .addAction(title: "設定画面へ".localized) { _ in
            goToSetting()
        }
        .addAction(title: "キャンセル".localized, style: .cancel)
        .show()
    }

    fileprivate static func goToSetting() {
        if let url = URL(string: UIApplicationOpenSettingsURLString) {
            UIApplication.shared.openURL(url)
        }
    }

    static func fetchAllPhotosAssets(fetchOptions: PHFetchOptions = .orderedByCreationDate(), block: @escaping (PHAsset) -> Bool) {
        let assets = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        assets.enumerateObjects({ asset, _, stop in
            if let asset = asset as? PHAsset {
                stop.pointee = ObjCBool(block(asset))
            }
        })
    }

    /**
     Fetch all photos.

     - parameter fetchOptions: fetch options
     - parameter block:        stop fetching if the block returns false.
     */
    static func fetchAllPhotos(fetchOptions: PHFetchOptions = .orderedByCreationDate(), block: @escaping (UIImage) -> Bool) {
        let assets = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        assets.enumerateObjects({ asset, _, stop in
            (asset as? PHAsset)?.requestImage { image in
                stop.pointee = ObjCBool(block(image))
            }
        })
    }

    static func pickPhotoFrom(_ sourceType: UIImagePickerControllerSourceType, completion: @escaping (UIImage?) -> Void) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            pickerListener = ImagePickerListener(completion: completion)

            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = sourceType
            imagePickerController.allowsEditing = true
            imagePickerController.delegate = pickerListener
            UIApplication.shared.topViewController?.present(imagePickerController, animated: true, completion: nil)
        } else {
            completion(nil)
        }
    }

}

extension PHAsset {
    func requestImage(_ size: CGSize? = nil, completion: @escaping (UIImage) -> Void) {
        let manager = PHImageManager()

        let size = size ?? CGSize(width: pixelWidth, height: pixelHeight)
        manager.requestImage(for: self, targetSize: size, contentMode: .aspectFill, options: nil) { image, info in
            // 解像度の低いサムネイルは無視
            guard let isDegraded = (info?[PHImageResultIsDegradedKey] as AnyObject).boolValue else { return }
            if isDegraded { return }

            if let image = image {
                completion(image)
            }
        }
    }

    func deleteAsset(_ completion: @escaping (NSError?) -> Void) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.deleteAssets([self])
        }) { _, error in
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
    static func orderedByCreationDate(_ ascending: Bool = false) -> PHFetchOptions {
        let options = PHFetchOptions()
        options.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: ascending)
        ]
        return options
    }
}

private final class ImagePickerListener: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let completion: (UIImage?) -> Void

    init(completion: @escaping (UIImage?) -> Void) {
        self.completion = completion
    }

    @objc fileprivate func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            completion(image)
        } else if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            completion(image)
        }
        picker.dismiss(animated: true, completion: nil)
    }

    @objc fileprivate func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        completion(nil)
    }
}

#endif
