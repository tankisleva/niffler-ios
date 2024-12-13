//
//  RegPage.swift
//  NifflerUITests
//
//  Created by Олег Малышев on 13.12.2024.
//

import XCTest

final class RegPage: BasePage {

     func tapCreateNewAccount() {
        XCTContext.runActivity(named: "Тапаем на кнопку создания аккаунта") { _ in
            app.staticTexts["Create new account"].tap()
        }
    }
    
     func tapSignUp() {
        XCTContext.runActivity(named: "Тапаем на кнопку Регистрации") { _ in
            app.buttons["Sign Up"].tap()
        }
    }
    
     func fillRegForm(userName:String, password:String, confirmPassword: String){
        XCTContext.runActivity(named: "Заполняю форму регистрации \(userName), \(password), \(confirmPassword)") { _ in
            input(username: userName)
            input(password: password)
            input(confirmPassword: confirmPassword)
            closeKeyboards()
            swipeUp()
            tapSignUp()
        }
    }
    
     func input(username: String) {
        XCTContext.runActivity(named: "Заполняем поле userName \(username)") { _ in
            app.textFields["userNameTextField"].firstMatch.tap()
            app.textFields["userNameTextField"].firstMatch.typeText(username)
        }
    }
    
    
    private func input(password: String) {
        XCTContext.runActivity(named: "Заполняем поле пароль \(password)") { _ in
            app.secureTextFields["passwordTextField"].firstMatch.tap()
            app.secureTextFields["passwordTextField"].firstMatch.typeText(password)
        }
    }
    
    
    private func input(confirmPassword: String) {
        XCTContext.runActivity(named: "Заполняем поле подтвердить пароль пароль \(confirmPassword)") { _ in
            app.secureTextFields["confirmPasswordTextField"].tap()
               app.secureTextFields["confirmPasswordTextField"].typeText(confirmPassword)
        }
    }
    
    
    
}
