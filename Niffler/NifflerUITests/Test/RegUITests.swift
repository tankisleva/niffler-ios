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
        XCTContext.runActivity(named: "Тест: регистрации нового пользователя") { _ in
    
            // Arrange
            loginPage.launchAppWithoutLogin()
            
            //act
            regPage.tapCreateNewAccount()
                     .fillRegForm(userName: uniqueUserName, password: uniquePassword, confirmPassword: uniquePassword)
            
            // Assert
            loginPage.logInInAlert()
                     .assertFieldUserNameEqual(userName:uniqueUserName)
                      .pressLoginButton()
            
            // Assert
            newSpendPage.assertIsAddSpendButtonShown()
        }
    }
    
    
    //
    func testCreateCategoryAfterReg() throws {
        XCTContext.runActivity(named: "Тест: Создание категории после регистрации") { _ in
            
            
            // Arrange
            loginPage.launchAppWithoutLogin()
            
            //act
            regPage.tapCreateNewAccount()
                    .fillRegForm(userName: uniqueUserName, password: uniquePassword, confirmPassword: uniquePassword)
            
            loginPage.logInInAlert()
                     .assertFieldUserNameEqual(userName: uniqueUserName)
                     .pressLoginButton()
            
            newSpendPage.assertIsAddSpendButtonShown()
                        .assertEmptySpendItem()
                        .addSpent()
                        .addNewCategory()
                        .inputNameCategory(nameCategory: "Еда")
                        .inputAmount(amount: "1000")
                        .inputDescription(description: "Бананы")
                        .pressAddSpend()
                        .assertNewSpendIsShown(title: "Бананы")
        }
    }
    
    func testChooseCategoryAfterReg() throws {
        XCTContext.runActivity(named: "Тест: Выбор категории после регистрации") { _ in
            
            // Arrange
            loginPage.launchAppWithoutLogin()
            
            //act
            regPage.tapCreateNewAccount()
                   .fillRegForm(userName: uniqueUserName, password: uniquePassword, confirmPassword: uniquePassword)
            
            loginPage.logInInAlert()
                     .assertFieldUserNameEqual(userName: uniqueUserName)
                     .pressLoginButton()
            
            newSpendPage.assertIsAddSpendButtonShown()
                         .assertEmptySpendItem()
                         .addSpent()
                         .inputAmount(amount: "1000")
                         .inputDescription(description: "Бананы")
                         .pressAddSpend()
            
            // Assert
                          .assertNewSpendIsShown(title: "Бананы")
        }
    }
    

    
    
 
    
    
    
       }





