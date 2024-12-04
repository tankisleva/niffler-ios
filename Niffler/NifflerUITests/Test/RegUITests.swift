//
//  RegUITests.swift
//  NifflerUITests
//
//  Created by Олег Малышев on 03.12.2024.
//

import XCTest

final class RegUITests: TestCase {
    
    // Генерация уникального имени пользователя
    let uniqueUserName = "user\(Int(Date().timeIntervalSince1970))"
    let uniquePassword = "123456"



    func testPositiveRegistration() throws {
        launchAppWithoutLogin()
        tapCreateNewAccount()
        fillRegForm(userName: uniqueUserName, password: uniquePassword, confirmPassword: uniquePassword)
        logInInAlert()
        assertFieldUserNameEqual(userName: uniqueUserName)
        pressLoginButton()
        assertIsAddSpendButtonShown()
    }
    
    
    private func input(username: String) {
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
    
    private func tapCreateNewAccount() {
        XCTContext.runActivity(named: "Тапаем на кнопку создания аккаунта") { _ in
            app.staticTexts["Create new account"].tap()
        }
    }
    
    private func tapSignUp() {
        XCTContext.runActivity(named: "Тапаем на кнопку Регистрации") { _ in
            app.buttons["Sign Up"].tap()
        }
    }
    
    private func closeKeyboards() {
        XCTContext.runActivity(named: "Закрываем клавиатуру") { _ in
            app.keyboards.buttons["Return"].tap()
        }
    }
    
    private func swipeUp() {
        XCTContext.runActivity(named: "Сваейпаем вверх") { _ in
            app.swipeUp()
        }
    }
    
    private func fillRegForm(userName:String, password:String, confirmPassword: String){
        XCTContext.runActivity(named: "Заполняю форму регистрации \(userName), \(password), \(confirmPassword)") { _ in
            input(username: userName)
            input(password: password)
            input(confirmPassword: confirmPassword)
            closeKeyboards()
            swipeUp()
            tapSignUp()
        }
    }
    
    
    
    private func logInInAlert() {
        XCTContext.runActivity(named: "Тапаем на Log in в алерте") { _ in
            app.alerts.buttons["Log in"].firstMatch.tap()
        }
    }
    
    
    private func assertFieldUserNameEqual(userName: String) {
        XCTContext.runActivity(named: "Сравниваем что введенный нами \(userName) равен значению из заполненного поля с юзер неймом") { _ in
            let userNameFromField = app.textFields["userNameTextField"].firstMatch.value
            XCTAssertEqual( userNameFromField as! String, userName)
        }
    }
    
    private func pressLoginButton() {
            XCTContext.runActivity(named: "Тапаем на LogIn button на экране ") { _ in
                app.buttons["loginButton"].tap()
            }
        }
    
    func assertIsAddSpendButtonShown(file: StaticString = #filePath, line: UInt = #line) {
        XCTContext.runActivity(named: "Жду кноку добавления траты") { _ in
            let isAddSpendButton = app.buttons["addSpendButton"].waitForExistence(timeout: 3)
            
            XCTAssertTrue(isAddSpendButton,
                          "Не нашли кнопку добавления траты",
                          file: file, line: line)
        }
    }
        
        
    }




