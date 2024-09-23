import Api
import SwiftUI

struct MainView: View {
    let spendsRepository = SpendsRepository()
    
    @State var isPresentLoginOnStart: Bool = false
    @State var isPresentLoginInModalScreen = false
    @State var showMenu: Bool = false

    @EnvironmentObject var api: Api {
        didSet {
            isPresentLoginOnStart = !api.auth.isAuthorized()
            
        }
    }
    
    init() {
        setupForUITests()
    }

    let userData = UserData()


    func setupForUITests() {
        if CommandLine.arguments.contains("RemoveAuthOnStart") {
            Auth.removeAuth()
        }
    }

    func fetchData() {
        Task {
            let (userDataModel, _) = try await api.currentUser()

            await MainActor.run {
                self.userData.setValues(from: userDataModel)
            }
        }
    }
}

extension MainView {
    var body: some View {
        VStack {
            if isPresentLoginOnStart {
                LoginView(
                    onLogin: {
                        // Just hide, login
                        self.isPresentLoginOnStart = false
                    }
                )
            } else {
                NavigationStack {
                    VStack {
                        HeaderView(
                            spendsRepository: spendsRepository,
                            switchMenuIcon: false,
                            onPressMenu: { showMenu.toggle() }
                        )
                        Divider()
                        if showMenu {
                            MenuView(
                                onPressLogout: {
                                    showMenu = false
                                    isPresentLoginInModalScreen = true
                                }
                            )
                        } else {
                            Section {
                                SpendsView(spendsRepository: spendsRepository)
                                    .onAppear {
                                        // TODO: Check that is called on main queue
                                        api.auth.requestCredentialsFromUser = {
                                            isPresentLoginInModalScreen = true
                                        }
                                    }
                                    .sheet(isPresented: $isPresentLoginInModalScreen) {
                                        LoginView(onLogin: {
                                            self.isPresentLoginInModalScreen = false
                                        })
                                    }
                            }
                        }
                        Spacer()
                    }
                }
                .onAppear {
                    fetchData()
                }
            }
        }
    }
}

//#Preview {
//    MainView()
//}