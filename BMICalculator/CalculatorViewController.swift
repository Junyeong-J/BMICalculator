//
//  CalculatorViewController.swift
//  BMICalculator
//
//  Created by 전준영 on 5/21/24.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet var bmiTitle: UILabel!
    @IBOutlet var bmiSubTitle: UILabel!
    @IBOutlet var bmiImageView: UIImageView!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!

    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    
    @IBOutlet var weightUIVIew: UIView!
    
    @IBOutlet var eyeButton: UIButton!
    @IBOutlet var randomBMIButton: UIButton!
    @IBOutlet var resultButton: UIButton!
    

    var secureBool: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelUI(bmiTitle, text: "BMI Calculator", font: .boldSystemFont(ofSize: 25))
        labelUI(bmiSubTitle, text: "당신의 BMI 지수를\n알려드릴게요.", font: .boldSystemFont(ofSize: 13))
        labelUI(heightLabel, text: "키가 어떻게 되시나요?", font: .boldSystemFont(ofSize: 13))
        labelUI(weightLabel, text: "몸무게는 어떻게 되시나요?", font: .boldSystemFont(ofSize: 13))
        
        bmiImageView.image = UIImage(named: "image")
        bmiImageView.contentMode = .scaleAspectFill
        
        textFieldUI(heightTextField, boardColor: UIColor.black.cgColor, secure: false)
        textFieldUI(weightTextField, boardColor: UIColor.clear.cgColor, secure: true)
        
        weightUIVIew.layer.cornerRadius = 15
        weightUIVIew.layer.borderColor = UIColor.black.cgColor
        weightUIVIew.layer.borderWidth = 1
        
        buttonUI(eyeButton, imageName: "eye.slash.fill", size: 13, buttonTintColor: .lightGray, buttonTitle: "", titleColor: nil, backgroundColor: .clear, cornerRadiusSize: 0)
        
        buttonUI(randomBMIButton, imageName: "", size: 12, buttonTintColor: nil, buttonTitle: "랜덤으로 BMI 계산하기", titleColor: .red, backgroundColor: .clear, cornerRadiusSize: 0)
        
        buttonUI(resultButton, imageName: "", size: 15, buttonTintColor: nil, buttonTitle: "결과 확인", titleColor: .white, backgroundColor: .purple, cornerRadiusSize: 10)
        
        
    }
    
    func labelUI(_ label: UILabel, text: String, font: UIFont) {
        
        label.text = text
        label.numberOfLines = 0
        label.font = font
        
    }
    
    func textFieldUI(_ textField: UITextField, boardColor: CGColor, secure: Bool) {
        
        textField.layer.borderColor = boardColor
        textField.layer.cornerRadius = 15
        textField.layer.borderWidth = 1
        textField.borderStyle = .none
        textField.textAlignment = .left
        textField.tintColor = .black
        textField.keyboardType = .decimalPad
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        textField.leftViewMode = .always
        textField.isSecureTextEntry = secure
        
    }
    
    func buttonUI(_ button: UIButton, imageName: String, size: Double, buttonTintColor: UIColor?, buttonTitle: String, titleColor: UIColor? ,backgroundColor: UIColor, cornerRadiusSize: Double){
        
        let image = UIImage(systemName: imageName)
        button.setImage(image, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: size)
        button.tintColor = buttonTintColor
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = cornerRadiusSize
        
    }
    
    
    @IBAction func eyeButtonTapped(_ sender: UIButton) {
        
        weightTextField.isSecureTextEntry = secureBool
        
        
        if secureBool {
            let image = UIImage(systemName: "eye.slash.fill")
            eyeButton.setImage(image, for: .normal)
        } else {
            let image = UIImage(systemName: "eye.fill")
            eyeButton.setImage(image, for: .normal)
        }
        
        secureBool.toggle()
    }
    
    func alertSetting(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let open = UIAlertAction(title: "확인", style: .default)
        let cancel = UIAlertAction(title: "취소", style: .cancel)

        alert.addAction(open)
        alert.addAction(cancel)
        
        present(alert, animated: true)
        
    }

    
    func bmiCalculator(height: Double, weight: Double) -> String {
        var bmi: Double
        let result: String
        
        bmi = weight / ((height/100) * (height/100))
        bmi = Double(round(100 * bmi) / 100)// 반올림했음
        
        switch bmi{
        case ..<18.5:
            result = "\(bmi)이므로 저체중입니다."
        case ...22.9:
            result = "\(bmi)이므로 정상입니다."
        case ...24.9:
            result = "\(bmi)이므로 비만전단계입니다."
        case ...29.9:
            result = "\(bmi)이므로 1단계 비만입니다."
        case ...34.9:
            result = "\(bmi)이므로 2단계 비만입니다."
        case 34.9...:
            result = "\(bmi)이므로 3단계 비만입니다."
        default:
            result = "다시 측정해 주세요."
        }
        
        return result
    }

    @IBAction func keyboardDismiss(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
        
    }
    
    @IBAction func resultButtonTapped(_ sender: UIButton) {
        
        let heightString = heightTextField.text ?? ""
        let weightString = weightTextField.text ?? ""
        
        if heightString.count == 0 || weightString.count == 0 {
            alertSetting(title: "오류", message: "빈칸을 입력해주세요")
        } else {
            
            if let height = Double(heightString), let weight = Double(weightString) {
                
                alertSetting(title: "BMI 수치", message: bmiCalculator(height: height, weight: weight))
                
            }
        }
    }
    
        
    @IBAction func randomBMIButtonTapped(_ sender: UIButton) {
        
        var height = Double.random(in: 150...200)
        var weight = Double.random(in: 40...150)
        
        height = Double(round(100 * height) / 100)
        weight = Double(round(100 * weight) / 100)
        
        heightTextField.text = String(height)
        weightTextField.text = String(weight)
        
        alertSetting(title: "BMI 수치", message: bmiCalculator(height: height, weight: weight))
        
    }
    
}
