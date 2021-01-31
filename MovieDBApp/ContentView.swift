

import SwiftUI
import LocalAuthentication

struct ContentView: View {  ///login - email@gmail.com PSW - FaceID
    
    @AppStorage("status") var logged = false
    var body: some View {
        
        NavigationView{
            
            if logged{
                
//                Text("User Logged in ....")
//                    .navigationTitle("Home")
//                    .navigationBarHidden(false)
//                    .preferredColorScheme(.light)
                TabView {
                    MovieLIst()
                        .tabItem {
                            VStack {
                                Image(systemName: "tv")
                                Text("Movies")
                            }
                        }
                    tag(0)
                    
                    MovieSearchView()
                        .tabItem {
                            VStack {
                                Image(systemName:  "magnifyingglass")
                                Text("Search")
                            }
                        }
                    tag(1)
                    
                }
                
                
                
                
                
                
                
            }
            else {
               
                HomeCsreen()
                    .preferredColorScheme(.dark)
                    .navigationBarHidden(true)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HomeCsreen: View {
    
    @State var userName  = ""
    @State var password  = ""
    @AppStorage("stored_User") var user = "email@gmail.com"
    @AppStorage("status") var logged = false
    
    var body: some View {
        
        VStack{
            
            Spacer(minLength: 0)
            
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 35)
                .padding(.vertical)
            
            HStack{
                
                VStack(alignment: .leading, spacing: 12, content: {
                    
                    Text("Login")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Please sign in to continiue")
                        .foregroundColor(Color.white.opacity(0.5))
                    
                })
                
                Spacer(minLength: 0)
                
            }
            .padding()
            .padding(.leading, 15)
            
            HStack{
                
                Image(systemName: "envelope")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 35)
                
                
                TextField("Email", text: $userName)
                    .autocapitalization(.none)
            }
            .padding()
            .background(Color.white.opacity(userName == "" ? 0 : 0.12))
            .cornerRadius(15)
            .padding(.horizontal)
            
            HStack{
                
                Image(systemName: "lock")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 35)
                
                
                SecureField("Password", text: $password)
                    .autocapitalization(.none)
            }
            .padding()
            .background(Color.white.opacity(password == "" ? 0 : 0.12))
            .cornerRadius(15)
            .padding(.horizontal)
            .padding(.top)
            
            HStack(spacing: 15) {
                Button(action: {}, label: {
                    Text("LogIn")
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 150)
                        .background(Color(#colorLiteral(red: 0.09757234901, green: 0.7179021835, blue: 0.8671984673, alpha: 1)))
                        .clipShape(Capsule())
                })
                .opacity(userName != "" && password != "" ? 1 : 0.5 )
                .disabled(userName != "" && password != "" ? false : true)
                
                if getBiometricStatus() {
                    Button(action: autheficateUser, label: {
                        
                        Image(systemName: LAContext().biometryType == .faceID ? "faceid" : "touchid")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color(#colorLiteral(red: 0.09757234901, green: 0.7179021835, blue: 0.8671984673, alpha: 1)))
                            .clipShape(Circle())
                    })
                }
            }
            .padding(.top)
            
            Button(action: {}, label: {
                Text("Forgot password")
                    .foregroundColor(Color(#colorLiteral(red: 0.09757234901, green: 0.7179021835, blue: 0.8671984673, alpha: 1)))
            })
            .padding(.top, 10)
            
            Spacer(minLength: 0)
            
            HStack(spacing: 6){
                
                Text("Don't have an account?")
                    .foregroundColor(Color.white.opacity(0.6))
                
                Button(action: {}, label: {
                    Text("Sign Up")
                        .foregroundColor(Color(#colorLiteral(red: 0.09757234901, green: 0.7179021835, blue: 0.8671984673, alpha: 1)))
                        .fontWeight(.heavy)
                    
                })
            }
            .padding(.vertical)
            
        }
        .background(Color(#colorLiteral(red: 0.009844466113, green: 0.145662576, blue: 0.2554561198, alpha: 1)).ignoresSafeArea(.all, edges: .all))
        .animation(.easeOut)
        
    }
    
    func getBiometricStatus()->Bool {
        
        let scanner = LAContext()
        if userName == user && scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none){
            
            return true
        }
        return false
    }
    
    func autheficateUser() {
        
        let scanner = LAContext()
        scanner.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To unlock\(userName)") { (status, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            withAnimation(.easeOut){logged = true}
        }
    }
}


