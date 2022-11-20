//
//  DetailViewController.swift
//  BulkApp
//
//  Created by user on 2022/11/13.
//

import UIKit
import Alamofire
import KeychainAccess

class DetailViewController: UIViewController {
    var articleId: Int! //Indexの画面から受け取る
    var myUser: User!   //Indexの画面から受け取る
    
    @IBOutlet weak var dateTextView: UITextView!
    
    @IBOutlet weak var eventTextView: UITextView!
    
    @IBOutlet weak var memoTextView: UITextView!
    //    @IBOutlet weak var editAndDeleteButtonState: UIBarButtonItem! //⑦
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        //token読み込み
//                token = LoadToken().loadAccessToken()
//
//                //TextViewとImageViewに枠線をつける
//                let viewCustomize = ViewCustomize()
//                memoTextView = viewCustomize.addBoundsTextView(memoView: memoTextView)
//
//                //記事のIDがnilじゃなければ記事を読み込む
//                guard let id = articleId else { return }
//                loadArticle(articleId: id)
//        //編集したい記事の情報をapiでリクエストして読み込む
//            func loadArticle(articleId: Int) {
//                guard let url = URL(string: consts.baseUrl + "/api/posts/\(articleId)") else { return }
//                let headers: HTTPHeaders = [
//                    "Authorization": "Bearer \(token)"
//                ]
//                AF.request(
//                    url,
//                    headers: headers
//                ).responseDecodable(of: Article.self) { response in
//                    switch response.result {
//                    case .success(let article):
//                        self.eventTextField.text = article.event
//                        self.memoTextView.text = article.memo
//                    case .failure(let error):
//                        print(error)
//                    }
//                }
//            }
    }
    
    //Edit(編集)ボタン
    @IBAction func editButton(_ sender: Any) {
        guard let articleId = articleId else { return }
        let editVC = self.storyboard?.instantiateViewController(withIdentifier: "Edit") as! EditViewController
        editVC.articleId = articleId
        navigationController?.pushViewController(editVC, animated: true)
    }
    
    //Delete(削除)ボタン
    @IBAction func deleteButton(_ sender: Any) {
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
