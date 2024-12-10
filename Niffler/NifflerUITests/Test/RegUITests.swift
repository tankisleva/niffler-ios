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
    
    
    //
    func testCreateCategoryAfterReg() throws {
        // Arrange
        launchAppWithoutLogin()
        
        //act
        tapCreateNewAccount()
        fillRegForm(userName: uniqueUserName, password: uniquePassword, confirmPassword: uniquePassword)
        logInInAlert()
        assertFieldUserNameEqual(userName: uniqueUserName)
        pressLoginButton()
        assertIsAddSpendButtonShown()
        assertEmptySpendItem()
        addSpent()
        addNewCategory()
        inputNameCategory(nameCategory: "Еда")
        inputAmount(amount: "1000")
        inputDescription(description: "Бананы")
        pressAddSpend()

        // Assert
        assertNewSpendIsShown(title: "Бананы")
    }
    
    func testChooseCategoryAfterReg() throws {
        // Arrange
        launchAppWithoutLogin()
        
        //act
        tapCreateNewAccount()
        fillRegForm(userName: uniqueUserName, password: uniquePassword, confirmPassword: uniquePassword)
        logInInAlert()
        assertFieldUserNameEqual(userName: uniqueUserName)
        pressLoginButton()
        assertIsAddSpendButtonShown()
        assertEmptySpendItem()
        addSpent()
        inputAmount(amount: "1000")
        inputDescription(description: "Бананы")
        pressAddSpend()

        // Assert
        assertNewSpendIsShown(title: "Бананы")
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
            
            if (app.keyboards.buttons["Return"].isHittable){
                app.keyboards.buttons["Return"].tap()
            }
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
            let isAddSpendButton = app.buttons["addSpendButton"].waitForExistence(timeout: 5)
            
            XCTAssertTrue(isAddSpendButton,
                          "Не нашли кнопку добавления траты",
                          file: file, line: line)
        }
    }
    
    func assertEmptySpendItem(file: StaticString = #filePath, line: UInt = #line) {
        XCTContext.runActivity(named: "Жду кноку добавления траты") { _ in
            XCTAssertEqual(app.scrollViews.switches.count, 0,
                                        "Список трат не пустой!",
                                        file: file, line: line)
        }
    }
    
    
    func inputSpent(description: String, amount: String) {
        inputAmount(amount: amount)
        selectCategory()
        inputDescription(description: description)
        pressAddSpend()
    }
    
    func inputAmount(amount: String) {
        XCTContext.runActivity(named: "Вводим сумму равную \(amount)") { _ in
         app.textFields["amountField"].typeText(amount)
        }
    }
    
    
    func addNewCategory(){
        XCTContext.runActivity(named: "Жму кноку добавления новой категории") { _ in
            app.buttons["+ New category"].tap()
        }
    }
    
    func inputNameCategory(nameCategory: String) {
        XCTContext.runActivity(named: "Вводим название категории, равное  \(nameCategory)") { _ in
            app.textFields["Name"].typeText(nameCategory)
            app.buttons["Add"].firstMatch.tap()}
        }
    
    

    
    func selectCategory() {
        XCTContext.runActivity(named: "Выбираю категорию") { _ in
         app.buttons["Select category"].tap()
         app.buttons["Рыбалка"].tap()
        }
    }
    
    func inputDescription(description: String) {
        XCTContext.runActivity(named: "Заполняю поле description, равное \(description)") { _ in
            app.textFields["descriptionField"].tap()
            app.textFields["descriptionField"].typeText(description)
        }
    }
    
    func inputDescription(amount: String) {
        XCTContext.runActivity(named: "Заполняю поле amount, равное \(amount)") { _ in
            app.textFields["descriptionField"].tap()
            app.textFields["descriptionField"].typeText(description)
        }
    }
    
    func addSpent() {
        XCTContext.runActivity(named: "Жму кноку добавления траты") { _ in
            app.buttons["addSpendButton"].tap()
        }
    }
    
//    func swipeToAddSpendsButton() -> Self {
//        let screenCenter = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
//        let screenTop = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.15))
//        screenCenter.press(forDuration: 0.01, thenDragTo: screenTop)
//        return self
//    }
    
    func pressAddSpend() {
        XCTContext.runActivity(named: "Нажимаю кнопку 'Add' для сохранения траты") { _ in
            let addButton = app.buttons["Add"]
            waitForElement(addButton, message: "'Add' button did not appear.")
            addButton.tap()
        }
    }
    
    
    private func waitForElement(_ element: XCUIElement, timeout: TimeInterval = 1, message: String, file: StaticString = #file, line: UInt = #line) {
           XCTContext.runActivity(named: "Ожидание элемента") { _ in
               XCTAssertTrue(element.waitForExistence(timeout: timeout), message, file: file, line: line)
           }
       }
    
    func assertNewSpendIsShown(title: String, file: StaticString = #filePath, line: UInt = #line) {
        XCTContext.runActivity(named: "Проверяю, что новая трата с заголовком '\(title)' отображается в списке") { _ in
            let spendTitle = app.firstMatch
                .scrollViews.firstMatch
                .staticTexts[title].firstMatch

            waitForElement(spendTitle, timeout: 2, message: "Spend with title '\(title)' was not found in the list.")

            XCTAssertTrue(spendTitle.exists, "Spend with title '\(title)' is not displayed in the list.", file: file, line: line)
        }
    }
    
    
    
       }





