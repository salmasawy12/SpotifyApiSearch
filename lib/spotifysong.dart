import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


const String clientId = '379adc5dea814876a9708499363955a6';
const String clientSecret = 'c354ac82a4784b42b1ecf23de9a1c79c';

class spotifysong extends StatefulWidget {
  const spotifysong({super.key});

  @override
  State<spotifysong> createState() => _spotifysongState();
}

class _spotifysongState extends State<spotifysong> {
  final TextEditingController controller=TextEditingController();
  String? songInfo;
  String? songImage;
  bool isLoading = false;
 

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

Future<void> getArtistAndTopTracks(String Songname) async{
  setState(() {
    isLoading=true;
    songInfo = null;
  });

  final accessToken=await getSpotifyAcessToken();

  if(accessToken==null) return;

  final songResponse=await http.get (Uri.parse('https://api.spotify.com/v1/search?q=$Songname&type=track&limit=1'),
  headers: {
    'Authorization': 'Bearer $accessToken',
  },
  );
  
  if(songResponse.statusCode==200){

    final Map<String, dynamic> songData=json.decode(songResponse.body);
    if(songData['tracks']['items'].isNotEmpty){
     final track = songData['tracks']['items'][0];
        final artist = track['artists'][0]['name'];
        final trackName = track['name'];
        final trackPopularity = track['popularity'];
        songImage = track['album']['images'].isNotEmpty ? track['album']['images'][0]['url'] : null;

       setState(() {
          songInfo = 'Song: $trackName\nArtist: $artist\nPopularity: $trackPopularity';
        });
        
      } else {
        setState(() {
           songInfo = 'No song found.';
           songImage=null;
        });
      }
    } else {
      print('Error fetching song info: ${songResponse.statusCode}');
    }

    setState(() {
      isLoading = false;
    });
  }


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Spotify Song Search', style: TextStyle(color: Colors.white),),
          backgroundColor: const Color.fromARGB(255, 219, 154, 231),
          
      ),
       bottomNavigationBar: BottomAppBar(
        height: 70,
        color: const Color.fromARGB(255, 219, 154, 231),
      ),

      body: Padding(
      
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              style: TextStyle(color: Colors.black),
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Enter song name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
           ElevatedButton(child: Text('Search',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
           style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 219, 154, 231),),  onPressed: () {
                if (controller.text.isNotEmpty) {
                  getArtistAndTopTracks(controller.text);
                }
              },),
            
            SizedBox(height: 20),
            if (isLoading) CircularProgressIndicator(),
             if (songImage != null)
              Image.network(
                songImage!,
                width: 100,  // Set desired width
                height: 100, // Set desired height
                fit: BoxFit.cover, // Optional, to adjust how the image fits within the bounds
              ),
               SizedBox(height: 20),
            if (songInfo != null)
              Text(
                
                songInfo!,
                // textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black),
              ),
            SizedBox(height: 20),
           

            // if (topTracks.isNotEmpty) ...[
            //   Text('Top Tracks:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
            //   for (var track in topTracks) Text(track,  style: TextStyle(color: Colors.black),),
            // ],
          ],
        ),
      ),
    );
  }
}
