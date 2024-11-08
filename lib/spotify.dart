import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


const String clientId = '379adc5dea814876a9708499363955a6';
const String clientSecret = 'c354ac82a4784b42b1ecf23de9a1c79c';

class spotify extends StatefulWidget {
  const spotify({super.key});

  @override
  State<spotify> createState() => _spotifyState();
}

class _spotifyState extends State<spotify> {
  final TextEditingController controller=TextEditingController();
  String? artistInfo;
  List <String> topTracks=[];
  String? artistImage;
  bool isLoading=false;

  Future<String?> getSpotifyAcessToken() async{
    final String credentials=base64Encode(utf8.encode('$clientId:$clientSecret'));
    final response= await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Authorization': 'Basic $credentials',
        'Content-Type':'application/x-www-form-urlencoded',
      },
      body:{ 
        'grant_type':'client_credentials',
      },
    );
    if(response.statusCode==200){
      final Map<String, dynamic> data = json.decode(response.body);
      return data['access_token'];
  }
  else{
    print('failed to get access token:${response.statusCode}');
     return null;
  } 
}

Future<void> getArtistAndTopTracks(String artistName) async{
  setState(() {
    isLoading=true;
    topTracks=[];
  });

  final accessToken=await getSpotifyAcessToken();

  if(accessToken==null) return;

  final artistResponse=await http.get(Uri.parse('https://api.spotify.com/v1/search?q=$artistName&type=artist&limit=1'),
  headers: {
    'Authorization': 'Bearer $accessToken',
  },
  );
  
  if(artistResponse.statusCode==200){

    final Map<String, dynamic> artistData=json.decode(artistResponse.body);
    if(artistData['artists']['items'].isNotEmpty){
      final artist=artistData['artists']['items'][0];
      final artistID=artist['id'];
      artistImage=artist['images'].isNotEmpty ? artist['images'][0]['url']: null;

       setState(() {
          artistInfo = 'Artist: ${artist['name']}\n'
              'Followers: ${artist['followers']['total']}\n'
              'Genres: ${artist['genres'].join(', ')}\n'
              'Popularity: ${artist['popularity']}';
        });
         await _getTopTracks(artistID, accessToken);
      } else {
        setState(() {
          artistInfo = 'No artist found.';
        });
      }
    } else {
      print('Error fetching artist info: ${artistResponse.statusCode}');
    }

    setState(() {
      isLoading = false;
    });
  }
 Future<void> _getTopTracks(String artistId, String token) async {
    final topTracksResponse = await http.get(
      Uri.parse('https://api.spotify.com/v1/artists/$artistId/top-tracks?market=US'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (topTracksResponse.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(topTracksResponse.body);
      final List<dynamic> tracks = data['tracks'];
      setState(() {
        topTracks = tracks.map((track) => track['name'].toString()).toList();
      });
    } else {
      print('Error fetching top tracks: ${topTracksResponse.statusCode}');
    }
  }
    






 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Spotify Artist Search', style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.green,
          
      ),
       bottomNavigationBar: BottomAppBar(
        height: 70,
        color:  Colors.green,
      ),

      body: Padding(
      
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              style: TextStyle(color: Colors.black),
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Enter artist name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(child: Text('Search',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),style: ElevatedButton.styleFrom(backgroundColor:  Colors.green,), onPressed: () {
                if (controller.text.isNotEmpty) {
                  getArtistAndTopTracks(controller.text);
                }
              },),
            
            SizedBox(height: 20),
            if (isLoading) CircularProgressIndicator(),
             if (artistImage != null)
              Image.network(
                artistImage!,
                width: 100,  // Set desired width
                height: 100, // Set desired height
                fit: BoxFit.cover, // Optional, to adjust how the image fits within the bounds
              ),
               SizedBox(height: 20),
            if (artistInfo != null)
              Text(
                
                artistInfo!,
                // textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black),
              ),
            SizedBox(height: 20),
           

            if (topTracks.isNotEmpty) ...[
              Text('Top Tracks:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
              for (var track in topTracks) Text(track,  style: TextStyle(color: Colors.black),),
            ],
          ],
        ),
      ),
    );
  }
}
