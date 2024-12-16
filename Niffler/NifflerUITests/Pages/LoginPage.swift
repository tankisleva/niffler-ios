import XCTest

class LoginPage: BasePage {
    
    @discardableResult
    func input(login: String, password: String) -> Self {
        XCTContext.runActivity(named: "Авторизуюсь \(login), \(password)") { _ in
            input(login: login)
            input(password: password)
            pressLoginButton()
        }
        return self
    }
    
     func input(login: String) -> Self {
        XCTContext.runActivity(named: "Ввожу логин \(login)") { _ in
            app.textFields["userNameTextField"].tap()
            app.textFields["userNameTextField"].tap() // TODO: Remove the cause of double tap
            app.textFields["userNameTextField"].typeText(login)
            return self
        }
    }
    
     func input(password: String) -> Self {
        XCTContext.runActivity(named: "Ввожу пароль \(password)") { _ in
            app.secureTextFields["passwordTextField"].tap()
            app.secureTextFields["passwordTextField"].typeText(password)
            return self
        }
    }
    
     @discardableResult
     func pressLoginButton() -> Self {
        XCTContext.runActivity(named: "Жму кнопку логина") { _ in
            app.buttons["loginButton"].tap()
            return self
        }
    }
    
    @discardableResult
    func assertIsLoginErrorShown(file: StaticString = #filePath, line: UInt = #line) -> Self{
        XCTContext.runActivity(named: "Жду сообщение с ошибкой") { _ in
            let isFound = app.staticTexts["LoginError"]
                .waitForExistence(timeout: 5)
            
            XCTAssertTrue(isFound,
                          "Не нашли сообщение о неправильном логине",
                          file: file, line: line)
            return self
        }
    }
    
    @discardableResult
    func assertNoErrorShown(file: StaticString = #filePath, line: UInt = #line) -> Self {
        XCTContext.runActivity(named: "Жду сообщение с ошибкой") { _ in
            let errorLabel =
             app.staticTexts[
                "LoginError"
                //"Нет такого пользователя. Попробуйте другие данные"
            ]
                
            let isFound = errorLabel.waitForExistence(timeout: 5)
            
            XCTAssertFalse(isFound,
                           "Появилась ошибка: \(errorLabel.label)",
                          file: file, line: line)
            return self
        }
    }
    
     func assertFieldUserNameEqual(userName: String) -> Self {
        XCTContext.runActivity(named: "Сравниваем что введенный нами \(userName) равен значению из заполненного поля с юзер неймом") { _ in
            let userNameFromField = app.textFields["userNameTextField"].firstMatch.value
            XCTAssertEqual( userNameFromField as! String, userName)
            return self
        }
    }
    
     func logInInAlert() -> Self {
        XCTContext.runActivity(named: "Тапаем на Log in в алерте") { _ in
            app.alerts.buttons["Log in"].firstMatch.tap()
            return self
        }
    }
    
    
}
