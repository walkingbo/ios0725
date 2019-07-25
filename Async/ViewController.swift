//
//  ViewController.swift
//  Async
//
//  Created by 503_18 on 25/07/2019.
//  Copyright © 2019 503_18. All rights reserved.
//

import UIKit

class DownloadThread : Thread{
    
    //인스턴스 변수 선언
    var imageView : UIImageView!
    var url : URL!
    
    //스레드로 동작할 메소드
    override func main() {
        //데이터 가져오기
        //let data = try! Data(contentsOf: url)
        //이미지로 변환
        //let image = UIImage(data: data)
        //출력
        //메인스레드가 아닌 스레드에서 화면 출력하는 코드를 사용하면 예외가 발생해서 앱이 중지
        //imageView.image = image
        
        //이미지 뷰에 출력하는 코드를 메인 스레드에서 수행하도록 작성
        //클로저(람다)에서는 인스턴스 변수를 사용할 때 반드시 self.을 붙여야 합니다.
       /*
        OperationQueue.main.addOperation{
            self.imageView.image = image
        }
        */
        
        //performSelector 메소드를 이용해메인 스레드에게 메소드르 수행해달라고 요청
        self.performSelector(onMainThread: #selector(download), with: nil, waitUntilDone: false)
        }
    
        @objc func download(){
            //데이터 가져오기
            let data = try! Data(contentsOf: url)
            //이미지로 변환
            let image = UIImage(data: data)
            self.imageView.image = image
        
    }
}



class ViewController: UIViewController {

    var imageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ImageView를 생성해서 정 중앙에 300,300 크기로 배치
        
        //화면 전체 크기와 좌표를 가져오기
        let frame = UIScreen.main.bounds
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        imageView.center = CGPoint(x: frame.width/2, y: frame.height/2)
        self.view.addSubview(imageView)
        //스레드 인스턴스를 생성해서 다운로드 받기
        /*
        let downloadThread = DownloadThread()
        downloadThread.imageView = imageView
        downloadThread.url = URL(string:"http://img.hani.co.kr/imgdb/resize/2018/0518/00502318_20180518.JPG")
        downloadThread.start()
        */
        
        //URLSession  객체를 생성
        let session = URLSession.shared
        //실제 수행할 작업을 생성
        let task = session.dataTask(with: URL(string:"http://img.hani.co.kr/imgdb/resize/2018/0518/00502318_20180518.JPG")!,
                                    completionHandler: { (data : Data?, response : URLResponse?, error : Error?)
                                        in
                                        if error != nil{
                                            NSLog("다운로드 에러:\(error!.localizedDescription)")
                                            return
                                        }
                                        // 메인 쓰레드에서 이미지를 이미지 뷰에 반영
                                        OperationQueue.main.addOperation { self.imageView.image = UIImage(data:
                                            data!)
                                        }
        })
        task.resume()
}
}
