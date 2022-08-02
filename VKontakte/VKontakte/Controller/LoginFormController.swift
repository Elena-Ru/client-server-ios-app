//
//  LoginFormController.swift
//  VKontakte
//
//  Created by Елена Русских on 16.06.2022.
//

import UIKit

class LoginFormController: UIViewController {

    @IBOutlet weak var loadIndicator: UIView!
    
    @IBOutlet weak var loginInput: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        guard let login = loginInput.text,
              let password = passwordInput.text,
              login == "",
              password == "" else {
            alert(message: "Error login/password")
            return
        }
        
        _ = Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { timer in
            self.performSegue(withIdentifier: "Login", sender: nil)
        }
        var loadCircles = [UIView]()
        
        creatLoadCircle()
        setLoadIndicator()
        setLoadCircle(circle: loadCircles)
        animateLoadIndicator(indicators: loadCircles)
        
      func creatLoadCircle(){
            for _ in 0...2{
            let loadCircle = UIView()
                loadCircles.append(loadCircle)
            }
        }

        func setLoadIndicator(){
            for i in 0..<loadCircles.count{
            loadIndicator.addSubview(loadCircles[i])
            }
            loadIndicator.backgroundColor = .clear
            loadIndicator.layer.opacity = 1
        }
        
        func setLoadCircle(circle: [UIView]){
            for i in 0..<circle.count{
                circle[i].frame = CGRect(x: 54 + (i * 30),
                                         y: 10,
                                         width: 20,
                                         height: 20)
                circle[i].backgroundColor = .systemCyan
                circle[i].backgroundColor?.withAlphaComponent(1)
                circle[i].layer.cornerRadius = circle[i].frame.width / 2
                circle[i].layer.masksToBounds = true
                circle[i].layer.opacity = 0
            }
        }
        
        func animateLoadIndicator( indicators: [UIView]){
            for i in 0..<indicators.count{
                UIView.animate(withDuration: 1,
                               delay: (Double(i) * 0.5),
                               options: [.repeat, .autoreverse],
                animations: {
                    indicators[i].layer.opacity = 1
                })
            }
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loadIndicator?.setLoadCircle()
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action:
        #selector(hideKeyboard))
        // Присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
    }
    
    // Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
    // Получаем размер клавиатуры
    let info = notification.userInfo! as NSDictionary
    let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
    let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
    // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
    self.scrollView?.contentInset = contentInsets
    scrollView?.scrollIndicatorInsets = contentInsets
    }
    //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
    // Устанавливаем отступ внизу UIScrollView, равный 0
    let contentInsets = UIEdgeInsets.zero
    scrollView?.contentInset = contentInsets
    }
    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
       //делаем прозрачным view индикатора загрузки
        loadIndicator.layer.opacity = 0
    // Подписываемся на два уведомления: одно приходит при появлении
    //клавиатуры
    NotificationCenter.default.addObserver(self, selector:
    #selector(self.keyboardWasShown), name:
    UIResponder.keyboardWillShowNotification, object: nil)
    // Второе — когда она пропадает
    NotificationCenter.default.addObserver(self, selector:
    #selector(self.keyboardWillBeHidden(notification:)), name:
    UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func hideKeyboard() {
    self.scrollView?.endEditing(true)
    }
    
    
    
    
    
    
    
    
  

}
