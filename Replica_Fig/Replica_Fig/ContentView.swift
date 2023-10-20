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
    PostData(type: "Rec", experience: "Adventure", classType: "Outdoor", userName: "Alice_Wonder", date: "12 October 2023", title: "Mountain Climbing.  ", description: "a mountain in Colorado for the first time was an experience that transcended mere physical exertion; it was a journey of self-discovery and awe-inspiring moments. The initial ascent was a blend of excitement and trepidation, as I navigated through rugged terrains and steep inclines. The air grew thinner with elevation, but each breath felt like a gulp of purity, untainted by urban life. Surrounded by the grandeur of towering peaks and expansive forests, I felt both humbled and invigorated. The challenges of the climb—be it the slippery rocks, the unpredictable weather, or the bouts of altitude sickness—were mitigated by the camaraderie among fellow climbers and the sheer beauty of the natural landscape."),
    PostData(type: "Food", experience: "Dining", classType: "Restaurant", userName: "FoodieMark", date: "13 October 2023", title: "Fine dining in New York City ", description: "Discover the best five-star restaurants in NYC offers an unparalleled gastronomic experience, blending world-class culinary artistry with exceptional service. Restaurants like The Consulate in Midtown specialize in French and New American cuisines, boasting a 4.5-star rating. Boucherie Union Square, another 4.5-star establishment, serves exquisite steak and French dishes. Cathédrale Restaurant offers a blend of French and Mediterranean flavors and holds a 4-star rating. These restaurants not only provide a feast for the palate but also create an atmosphere that elevates the entire dining experience. Whether it's the meticulously crafted cocktails or the elegant interiors, fine dining in NYC is a luxurious affair worth experiencing."),
    PostData(type: "Travel", experience: "Leisure", classType: "Beach", userName: "Traveller_Joe", date: "14 October 2023", title: "Relaxing in Bali", description: "Find the most peaceful beaches in Bali, Bali, often referred to as the Island of the Gods, offers a rich tapestry of experiences for travelers. From its lush rice terraces in Ubud to the bustling nightlife in Kuta, Bali is a destination that caters to various tastes. The island is renowned for its intricate temples, vibrant arts scene, and traditional ceremonies. For those seeking tranquility, the northern and western coasts offer secluded beaches and diving spots. Transportation can be a challenge, with congested roads, but renting a scooter or hiring a private driver can make navigation easier. Food hygiene has improved significantly, so enjoying local cuisine is generally safe")
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

