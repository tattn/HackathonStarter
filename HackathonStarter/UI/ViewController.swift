//
//  ViewController.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/06/30.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        label.text = "Message"
        label.backgroundColor = .whiteColor()
        let image = label.image(CGSize(width: 300, height: 300))

        PhotoAlbumManager.runIfAuthorized {
            UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

