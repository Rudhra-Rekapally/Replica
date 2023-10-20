import SwiftUI

struct ContentView: View {
    @State private var selectedTab = "Stay Local"
    @State private var likes = [false, false, false]
    @State private var cardExpanded = [false, false, false]
    
    let posts: [PostData] = randomPosts
    
    var body: some View {
        VStack {
            CustomTabBar(selectedTab: $selectedTab)
            
            ScrollView(.vertical, showsIndicators: true) {
                ForEach(0..<posts.count) { index in
                    PostCard(
                        isLiked: $likes[index],
                        cardExpanded: $cardExpanded[index],
                        postData: posts[index]
                    )
                }
            }
            .background(Color(red: 0.98, green: 0.97, blue: 0.96))

            FooterMenu()
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: String
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                
                Spacer()
                
                HStack {
                    Spacer().frame(width: 10)
                    
                    ForEach(["Stay Local", "Go Global"], id: \.self) {
                        tab in
                        Text(tab)
                            .padding()
                            .font(.caption)
                            .bold()
                            .cornerRadius(5)
                            
                            .onTapGesture {
                                withAnimation {
                                    self.selectedTab = tab
                                }
                            }
                    }
                    .padding(.vertical)
                    
                    Spacer().frame(width: 10)
                }
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(red: 0.79, green: 0.64, blue: 0.58))
                        .frame(height: 60)
                        .overlay(
                            Capsule()
                                .fill(Color(red: 0.87, green: 0.78, blue: 0.75))
                                .frame(width: selectedTab == "Stay Local" ? 90 : 90, height: 40)
                                .offset(x: selectedTab == "Stay Local" ? -49 : 50)
                        )
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Spacer()
                
                Image("ProfilePicture")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
            .shadow(radius: 5)
            .background(Color.white)
        }

    }
}

struct PostCard: View {
    @Binding var isLiked: Bool
    @Binding var cardExpanded: Bool
    let postData: PostData
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(postData.type)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .bold()
                    .background(Color(red: 0.98, green: 0.63, blue: 0.61))
                    .cornerRadius(15)
                
                Text(postData.experience)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .bold()
                    .background(Color(red: 0.87, green: 0.78, blue: 0.75))
                    .cornerRadius(15)
                
                Text(postData.classType)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .bold()
                    .background(Color(red: 0.87, green: 0.78, blue: 0.75))
                    .cornerRadius(15)
            }
            .lineLimit(1)
            
            Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    Text(postData.userName)
                        .bold()
                        
                    Spacer()
                    
                    Button(action: {
                        self.isLiked.toggle()
                    }) {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 30, height: 25)
                            .foregroundColor(isLiked ? .red : .primary)
                    }
                    .padding(.trailing, 5)
                    
                    Image(systemName: "bookmark")
                        .resizable()
                        .frame(width: 17, height: 25)
                        .padding(.trailing, 5)
                    
                    Image(systemName: "message.badge")
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                    Text("2")
                        .font(.callout)
                        .padding(.leading, -5)
                        .padding(.bottom, -25)
                }
                .padding()
                
                Text(postData.date)
                    .font(.footnote)
                    .padding(.horizontal)
                Text(postData.title)
                    .bold()
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                Text(postData.description)
                    .font(.caption)
                    .lineLimit(cardExpanded ? nil : 2)
                    .padding()
                    .padding(.top, -15)
            }
            .background(Color(red: 0.98, green: 0.97, blue: 0.96).opacity(0.8))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .onTapGesture {
                withAnimation {
                    cardExpanded.toggle()
                }
            }
        }
        .padding(.horizontal, 5)
        .padding(.vertical, 10)
        .frame(height: 550)
        .shadow(radius: 10)
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
}

struct PostData {
    let type: String
    let experience: String
    let classType: String
    let userName: String
    let date: String
    let title: String
    let description: String
}

let randomPosts: [PostData] = [
    PostData(type: "Rec", experience: "Adventure", classType: "Outdoor", userName: "Alice_Wonder", date: "12 October 2023", title: "Mountain Climbing in Colorado", description: "Get a thrill out of climbing the highest peaks..."),
    PostData(type: "Food", experience: "Dining", classType: "Restaurant", userName: "FoodieMark", date: "13 October 2023", title: "Fine Dining in NYC", description: "Discover the best five-star restaurants in NYC..."),
    PostData(type: "Travel", experience: "Leisure", classType: "Beach", userName: "Traveller_Joe", date: "14 October 2023", title: "Relaxing in Bali", description: "Find the most peaceful beaches in Bali...")
]


struct FooterMenu: View {
    var body: some View {
        HStack {
            Image(systemName: "house.fill")
            Spacer()
            Image(systemName: "plus.circle.fill")
            Spacer()
            Image(systemName: "ticket")
        }
        .font(.title2)
        .padding(.horizontal, 80)
        .padding(.top, 20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

