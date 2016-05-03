Przykładowe Zapytania do servera

curl -H "Content-Type: application/json" \
-X POST -d '{"client_id":"3be31b188f33137ddaaa55f32a5e5ba63eb9254b6a7de720d5b0d85d68062231",
 "client_secret":"17f49902fe8f17cc43274745494be1b5cc663a464b2d93ba0bf3a3ed16a1158c",
 "grant_type":"password",
 "password":"12345678",
 "username":"sierra@a.com"}' \
 http://localhost:3000/oauth/token



curl -H 'Content-Type: application/json' -H 'Authorization: Bearer 4295a3dbf306b7943b674e02f78a5e795bf43b2f976f76ef5bc6a5b697d1565c' \
-d '{"location":"Wisla", "describe":"2 za 1","discount":50, "store":"empik"}' -X POST http://localhost:3000/api/events/do_event

curl -H 'Authorization: Bearer 4295a3dbf306b7943b674e02f78a5e795bf43b2f976f76ef5bc6a5b697d1565c' \
-X DELETE http://localhost:3000/api/events/delete_event/1

curl -H 'Content-Type: application/json' -H 'Authorization: Bearer 4295a3dbf306b7943b674e02f78a5e795bf43b2f976f76ef5bc6a5b697d1565c' \
-X GET http://localhost:3000/api/find_event/Wisla



