//
//  ViewController.swift
//  CreatingForm
//
//  Created by Rupika Sompalli on 04/11/18.
//  Copyright © 2018 Rupika. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var userTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var confirmPassTextField : UITextField!
    @IBOutlet weak var phonenoTextField : UITextField!
    @IBOutlet weak var countryTextField : UITextField!
    @IBOutlet weak var timeTextField : UITextField!
    @IBOutlet weak var siginButton : UIButton!
    
    var  myPickerCountry = ["India","japan","cannada","china","thailand" ]
    override func viewDidLoad() {
        customizedButton()
        phonenoTextField.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.phonenoTextField.keyboardType = UIKeyboardType.decimalPad
        
    }
    // for customising button
    
    func customizedButton(){
       siginButton.layer.cornerRadius = siginButton.frame.height / 2.0
        
        siginButton.clipsToBounds = true
        siginButton.tintColor = UIColor.white
        siginButton.setTitle("Sign In", for: .normal)
        
        
    }
    
    // After clicking signIN button we need to validate two things 1)one is whether the user name,password and conform password is empty
    // 2) checking both password and conform password matched or not if not matched displaying alert
    @IBAction func signInButtonClicked(){
    
        // the endediting method is use to end the date picker after clicking any text field
        self.view.endEditing(true)
        
        performEmptyValidation()
        passwordValidation()
        
    }
    // here we are checking whther user name,password and conform password is having a text(here we also comparing individual text filed like only user name or password or confirm password) if it is empty displaying alert
    func performEmptyValidation(){
        //check if fields are empty or not
        if checkIfFieldIsEmpty(textField: userTextField) == true || checkIfFieldIsEmpty(textField: passwordTextField) == true || checkIfFieldIsEmpty(textField: confirmPassTextField) == true{
            //show alert
            let alert = UIAlertController(title: "enter some text", message: alertEmptyMessage(), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //this method alertEmptymessage is used to display messgae in alert message in performEmptyValidation method where for each username,password,confirm password to display alert which one is empty it is used
    // for example if username is empty to get that in alert message alertEmptymessage method is used
    func alertEmptyMessage() -> String{
        
        var message = ""
        if checkIfFieldIsEmpty(textField: userTextField) == true{
            message.append("User field is empty")
            message.append(",")
        }
        
        if checkIfFieldIsEmpty(textField: passwordTextField) == true{
            message.append("Password field is empty")
            message.append(",")
        }
        
        if checkIfFieldIsEmpty(textField: confirmPassTextField) == true{
            message.append("Confirm field is empty")
            message.append(".")
        }
        
        
        return message
    }
    
   
    //if it is true then the textfield is empty
    //if it is flase then the textfield has text in it
    
     //checking text field is empty or not
    //This method takes a parameter 'textField', this could be anything
    // checkIfFieldIsEmpty(textField: userTextField) == true , here we are passing userTextField as a parameter, so this method check if text in userTextField is empty or not
    // we are giving only for user den how abt password and confrom password- No, we are not doing that. We are calling this methiod 3 tiomes, for 3 textfields, each time with a different parameter
    
    
    func checkIfFieldIsEmpty(textField: UITextField) -> Bool{
      
        var textFieldIsEmpty: Bool = true
        
        if let textinPAssedTextField = textField.text{
            if textinPAssedTextField.count > 0{
                textFieldIsEmpty = false
            }
        }
        return textFieldIsEmpty
        
    }
    
   
    //MARK: text field delegate mthods
    //This method will get called everytime you press a character(either of type integer or alphabet) on keyboard
    //In this method we are giving validation for either password or conform password should not exceed 8 charcter( could be either numbers or alphabets)
    //In this method we are also giving validation for phoneno should contain only 10 numbers
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
     if textField == passwordTextField || textField == confirmPassTextField {
        
        //    print("entered character is ",string)
        //   print("text field text is ",textField.text ?? "no text")
        //  for validating only 8 chaacter  password and confirm password
        return textField.text!.count < 8 || string == ""
        
        }//allowing only 10 numbers
        if textField == phonenoTextField{
            
            let allowedCharacters = "1234567890"
            let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
            let typedCharacterSet = CharacterSet(charactersIn: string)
            let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
            //this return type is used to get only interger values like 0,1,2 up to 9 and also the textField.text!.count < 10 means it will allow only 10 numbers in the text field
            return alphabet && textField.text!.count < 10
            
            
        }
        
        //by default this hsould return true
        return true
    }
    
    //for validating password and conform password both matches if not displaying alert
    
    func passwordValidation(){
        
        if (passwordTextField.text == confirmPassTextField.text){
            
            // if both apssword  matched dispaying both password and confirm passwrod textfield background color as green and text color as black
            // to change the back ground color in text field use backgroundColor property
            passwordTextField.backgroundColor = UIColor.green
            confirmPassTextField.backgroundColor = UIColor.green
            // to change the text color in text filed use textcolor property
            passwordTextField.textColor = UIColor.black
            confirmPassTextField.textColor = UIColor.black
            print("both password matched")
        }// if both apssword not matched dispaying both password and confirm passwrod textfield background color as red and text color as black and also for displaying alert if both password not matched
        else{
            passwordTextField.backgroundColor = UIColor.red
            confirmPassTextField.backgroundColor = UIColor.red
            passwordTextField.textColor = UIColor.black
            confirmPassTextField.textColor = UIColor.black
            let alert = UIAlertController(title: "password not matched", message: "password and conform password is not matched ", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
   
    
    //for displaying picker view in text field to know how many rows and colums display and also how to give title and how to slect particular row this 4 methods are used
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerCountry.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return myPickerCountry[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
            countryTextField.text = myPickerCountry[row]
        
    }
    
    
    
    //for displaying  date picker in text field and also pickerview in country we are using tetxtFiledDidBeginEditing
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == timeTextField{
            // Create a date picker for the date field.
            let picker = UIDatePicker()
            picker.datePickerMode = .date
            picker.addTarget(self, action: #selector(updateDateField(sender:)), for: .valueChanged)
            
            // If the date field has focus, display a date picker instead of keyboard.
            // Set the text to the date currently displayed by the picker.
            timeTextField.inputView = picker
            timeTextField.text = formatDateForDisplay(date: picker.date)
        }
        
        if textField == countryTextField{
            // Create a date picker for the date field.
            let picker = UIPickerView()
            picker.dataSource = self
            picker.delegate = self
            countryTextField.inputView = picker
            
        }
    }
    
    // for upating date picker every time when we change date
    @objc func updateDateField(sender: UIDatePicker) {
        timeTextField?.text = formatDateForDisplay(date: sender.date)
    }
    func formatDateForDisplay(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
    
    //MARK: picker data source and delegate mthods

   
}

