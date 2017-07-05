import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextField!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var textView2: UITextField!
    
    let thread1 = DispatchQueue(label: "Thread1")
    let thread2 = DispatchQueue(label: "Thread2")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadImage(_url: String, _imageView: Int)
    {
        let url = URL(string: _url)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async(execute: {
                if let downloadedImage = UIImage(data: data!) {
                    if _imageView == 1 {
                        self.imageView.image = downloadedImage
                    }
                    else {
                        self.imageView2.image = downloadedImage
                    }
                }
            })
            
        }).resume()
    }
    
    @IBAction func oK(_ sender: UIButton) {
        thread1.async {
            if self.textView.text != "" {
                self.loadImage(_url: self.textView.text!, _imageView: 1)
            }
            else {
                self.loadImage(_url: "https://i.ytimg.com/vi/cGFP4h1dD90/maxresdefault.jpg", _imageView: 1)
            }
        }
        thread2.async {
            if self.textView2.text != "" {
                self.loadImage(_url: self.textView2.text!, _imageView: 2)
            }
            else {
                self.loadImage(_url: "https://i.ytimg.com/vi/mCFPfr6Er1Y/maxresdefault.jpg", _imageView: 2)
            }
        }
    }
}
