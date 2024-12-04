//
//  RegUITests.swift
//  NifflerUITests
//
//  Created by Олег Малышев on 03.12.2024.
//

import XCTest

final class RegUITests: TestCase {



    func testPositiveRegistration() throws {
        
        // Генерация уникального имени пользователя
        let uniqueUserName = "user\(Int(Date().timeIntervalSince1970))"
        let uniquePassword = "123456"
        
        print(uniqueUserName)
        print(uniquePassword)
        
        
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        //Нажимаем на кнопку создания аккаунта
        app.staticTexts["Create new account"].tap()
        
        //Заполняем поле username
        app.textFields["userNameTextField"].firstMatch.tap()
        app.textFields["userNameTextField"].firstMatch.typeText(uniqueUserName)
        
        //Заполняем поле password
        app.secureTextFields["passwordTextField"].firstMatch.tap()
        app.secureTextFields["passwordTextField"].firstMatch.typeText(uniquePassword)
        
        //Заполняем поле confirm password
        app.secureTextFields["confirmPasswordTextField"].tap()
        app.secureTextFields["confirmPasswordTextField"].typeText(uniquePassword)
        
        //свайпаем вверх, чтобы стала доступна кнопка Sign Up
        app.swipeUp()
        
        // Нажимаем на Sign Up
        app.buttons["Sign Up"].tap()
        
        // Нажимаем на log in в алерте
        app.alerts.buttons["Log in"].firstMatch.tap()
        
        //Проверям, что в заполненнм поле Username будет наш user name созданный при регисстрации
        XCTAssertEqual( app.textFields["userNameTextField"].firstMatch.value as! String, uniqueUserName)
        
        //нажимаем на кнопку логина
        app.buttons["loginButton"].tap()
        //проверчем что мы действительно авторизовались
        XCTAssertTrue(app.buttons["addSpendButton"].waitForExistence(timeout: 3))
    }


}
