//
//  ViewController.swift
//  PhotoMaster
//
//  Created by 田嶋智洋 on 2018/04/12.
//  Copyright © 2018年 田嶋智洋. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //「テキスト合成」ボタンを押した時に呼ばれるメソッド
    @IBAction func onTappedCamerButton(_ sender: Any) {
        presentPickerController(sourrceType: .camera)
    }
    // 「イラスト合成」ボタンを押した時に呼ばれるメソッド
    @IBAction func onTappedPhotoButton(_ sender: Any) {
        presentPickerController(sourrceType: .photoLibrary)
    }
    func presentPickerController(sourrceType: UIImagePickerControllerSourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourrceType){
            let picker = UIImagePickerController()
            picker.sourceType = sourrceType
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        photoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
    }
    func drawText(image :UIImage) -> UIImage {
        let text =  "LifeisTech!"
        
        let textFontAttributes = [
            NSAttributedStringKey.font: UIFont(name: "Arial",size: 120)!,
            NSAttributedStringKey.foregroundColor: UIColor.red
        ]
        
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(x: 0,y: 0,width: image.size.width, height: image.size.height))
        let margin:CGFloat = 5.0
        let textRect = CGRect(x: margin, y: margin, width: image.size.width - margin, height: image.size.height - margin)
        text.draw(in: textRect,withAttributes: textFontAttributes)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
        
    }
    //表示される画像がちっさすぎてよくわかりませんが一応表示されています！
    //元の画像にイラストを合成するメソッド
    func drawMaskImage(image: UIImage) -> UIImage {
        print("pushImageButton")
        //マスク画像(保存場所：PhotoMaster > Asssers.xcassets)の設定
        let maskImage = UIImage(named: "monster.png")!
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(x:0 , y:0,width:image.size.width,height:image.size.height ))
        
        let margin: CGFloat = 50.0
        let maskRect  = CGRect(x: image.size.width - maskImage.size.width - margin, y: image.size.height - maskImage.size.height - margin, width: maskImage.size.width,height: maskImage.size.height)
        maskImage.draw(in: maskRect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    @IBAction func onTappedTextButton(_ sender: Any) {
        if photoImageView.image != nil {
            photoImageView.image = drawText(image: photoImageView.image!)
        }else{
            print("画像がありません")
        }
    }
    
    @IBAction func onTappedIllustButton(_ sender: Any) {
        if photoImageView.image != nil {
            photoImageView.image = drawMaskImage(image: photoImageView.image!)
        }else{
            print("画像がありません")
        }
    }
    
    
    @IBAction func onTappedUploadButton(_ sender: Any) {
        if photoImageView.image != nil {
            let activityVC = UIActivityViewController(activityItems:[photoImageView.image!,"#PhotoMaster"], applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }else{
            print("画像がありません")
        }
    }
    
    
}

