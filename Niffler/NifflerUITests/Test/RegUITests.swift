//
//  RegUITests.swift
//  NifflerUITests
//
//  Created by Олег Малышев on 03.12.2024.
//

import XCTest

final class RegUITests: XCTestCase {
    
    
    
    
    // Генерация уникального имени пользователя
    let uniqueUserName = "user\(Int(Date().timeIntervalSince1970))"
    let uniquePassword = "123456"




    func testPositiveRegistration() throws {
        XCTContext.runActivity(named: "Тест: регистрации нового пользователя") { _ in
            let app = XCUIApplication()
            let loginPage = LoginPage(app: app)
            let regPage = RegPage(app: app)
            let newSpendsPage = NewSpendPage(app: app)
            
            // Arrange
            loginPage.launchAppWithoutLogin()
            
            //act
            regPage.tapCreateNewAccount()
            regPage.fillRegForm(userName: uniqueUserName, password: uniquePassword, confirmPassword: uniquePassword)
            loginPage.logInInAlert()
            
            // Assert
            loginPage.assertFieldUserNameEqual(userName: uniqueUserName)
            loginPage.pressLoginButton()
            
            // Assert
            newSpendsPage.assertIsAddSpendButtonShown()
        }
    }
    
    
    //
    func testCreateCategoryAfterReg() throws {
        XCTContext.runActivity(named: "Тест: Создание категории после регистрации") { _ in
            
            let app = XCUIApplication()
            let loginPage = LoginPage(app: app)
            let regPage = RegPage(app: app)
            let newSpendsPage = NewSpendPage(app: app)
            
            
            // Arrange
            loginPage.launchAppWithoutLogin()
            
            //act
            regPage.tapCreateNewAccount()
            regPage.fillRegForm(userName: uniqueUserName, password: uniquePassword, confirmPassword: uniquePassword)
            loginPage.logInInAlert()
            loginPage.assertFieldUserNameEqual(userName: uniqueUserName)
            loginPage.pressLoginButton()
            newSpendsPage.assertIsAddSpendButtonShown()
            newSpendsPage.assertEmptySpendItem()
            newSpendsPage.addSpent()
            newSpendsPage.addNewCategory()
            newSpendsPage.inputNameCategory(nameCategory: "Еда")
            newSpendsPage.inputAmount(amount: "1000")
            newSpendsPage.inputDescription(description: "Бананы")
            newSpendsPage.pressAddSpend()
            
            // Assert
            newSpendsPage.assertNewSpendIsShown(title: "Бананы")
        }
    }
    
    func testChooseCategoryAfterReg() throws {
        XCTContext.runActivity(named: "Тест: Выбор категории после регистрации") { _ in
            
            
            let app = XCUIApplication()
            let loginPage = LoginPage(app: app)
            let regPage = RegPage(app: app)
            let newSpendsPage = NewSpendPage(app: app)
            
            // Arrange
            loginPage.launchAppWithoutLogin()
            
            //act
            regPage.tapCreateNewAccount()
            regPage.fillRegForm(userName: uniqueUserName, password: uniquePassword, confirmPassword: uniquePassword)
            loginPage.logInInAlert()
            loginPage.assertFieldUserNameEqual(userName: uniqueUserName)
            loginPage.pressLoginButton()
            newSpendsPage.assertIsAddSpendButtonShown()
            newSpendsPage.assertEmptySpendItem()
            newSpendsPage.addSpent()
            newSpendsPage.inputAmount(amount: "1000")
            newSpendsPage.inputDescription(description: "Бананы")
            newSpendsPage.pressAddSpend()
            
            // Assert
            newSpendsPage.assertNewSpendIsShown(title: "Бананы")
        }
    }
    

    
    
 
    
    
    
       }





