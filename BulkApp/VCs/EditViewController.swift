//
//  EditViewController.swift
//  BulkApp
//
//  Created by user on 2022/11/13.
//

import UIKit
import Alamofire
import KeychainAccess
import Kingfisher

class EditViewController: UIViewController {
    var articleId: Int!
    
    private var token = ""
    let consts = Constants.shared
    //    let okAlert = OkAlert()
    
    @IBOutlet weak var eventTextField: UITextField! //①
    @IBOutlet weak var memoTextField: UITextField! //②
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //token読み込み
        token = LoadToken().loadAccessToken()
        
        //記事のIDがnilじゃなければ記事を読み込む
        guard let id = articleId else { return }
//        loadArticle(articleId: id)
    }
    
    //Update(更新)ボタン
    @IBAction func updateButton(_ sender: Any) {
        
    }
    
//    //Delete(削除)ボタン
//    @IBAction func deleteButton(_ sender: Any) {
//        
//    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
