//
//  post_self.swift
//  chain
//
//  Created by xuechuan mi on 2018-07-11.
//  Copyright © 2018 Dubal, Rohan. All rights reserved.
//

import UIKit
import Kingfisher
class MyTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // print("count:\(images.count)")
        return image_links.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell",
                                                       for: indexPath) as! MyCollectionViewCell
        
        let message = self.image_links[indexPath.row].deletingPrefix("https://s3.amazonaws.com/chance-userfiles-mobilehub-653619147/")
        if let cachedVersion = imageCache.object(forKey: message as NSString) {
            cell.photo.image = cachedVersion
            if !self.images.contains(cachedVersion){
                self.images.append(cachedVersion)}
        }
        else{
            downloadImage(key_: message, destination: cell.photo)
            //print("title: \(self.title.text) count: \(self.images.count)" )
        }
        
        
        cell.photo.tag = indexPath.row
        cell.photo.isUserInteractionEnabled = true
        let tapSingle=UITapGestureRecognizer(target:self,
                                             action:#selector(imageViewTap(_:)))
        tapSingle.numberOfTapsRequired = 1
        tapSingle.numberOfTouchesRequired = 1
        cell.photo.addGestureRecognizer(tapSingle)
        return cell
        
    }
    
    @objc func imageViewTap(_ recognizer:UITapGestureRecognizer){
        //图片索引
        let index = recognizer.view!.tag
        //进入图片全屏展示
        //print("count: \(images.count) index: \(index)" )
        images = []
        var image_dick:[Int:Int] = [:]
        var counter = 0
        for a in 0...self.image_links.count - 1
        {
            let indexPath = IndexPath(item: a, section: 0)
            if let x = (self.image_collection.cellForItem(at: indexPath) as! MyCollectionViewCell).photo.image
            {
                images.append(x)
                image_dick[a] = counter
                counter = counter + 1
            }
        }
        
        let previewVC = ImagePreviewVC(images: images, index: image_dick[index]!)
        //self.navigationController?.setToolbarHidden(true, animated: true)
        self.firstViewController()?.navigationController?.pushViewController(previewVC, animated: true)
    }
    
    var image_links:[String] = []
    @IBOutlet weak var profile_picture: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var time_label: UILabel!
    @IBOutlet weak var tagg: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    var unlocked = 0
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var image_collection: UICollectionView!
    
    @IBOutlet weak var tool_bar: UIView!
    @IBOutlet weak var bot_bar: UIView!
    @IBOutlet weak var zhanwaifenxiang: UIButton!
    @IBOutlet weak var zhanneifenxiang: UIButton!
    @IBOutlet weak var comments: UIButton!
    @IBOutlet weak var like: UIButton!
    
    @IBOutlet weak var share: UIButton!
    
    @IBOutlet weak var share_view: UIView!
    @IBOutlet weak var share_profile_picture: UIImageView!
    
    @IBOutlet weak var share_username: UILabel!
    @IBOutlet weak var share_title: UILabel!
    
    @IBOutlet weak var share_detail: UIButton!
    @IBOutlet weak var xiala: UIButton!
    
    
    
     var myViewController: UIViewController!
    var images:[UIImage] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置collectionView的代理
        self.image_collection.delegate = self//.superview
        self.image_collection.dataSource = self//.superview
        
        // 注册CollectionViewCell
        self.image_collection!.register(UINib(nibName:"MyCollectionViewCell", bundle:nil),forCellWithReuseIdentifier: "myCell")
    }
    
    

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
}
