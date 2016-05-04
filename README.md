Przykładowe Zapytania do servera
<--Logowanie-->

curl -H "Content-Type: application/json" \
-X POST -d '{"client_id":"app_id",
 "client_secret":"secret_id",
 "grant_type":"password",
 "password":"12345678",
 "username":"sierra@a.com"}' \
 http://localhost:3000/oauth/token
 
 <--Rejestracja-->
 
 curl -H "Content-Type: application/json" \
-X POST \
-d '{"first_name":"Kathy",
"last_name":"Sierra",
"profile_name":"sierra_official",
"email":"sierra@a.com",
"password":"12345678",
"password_confirmation":"12345678"}' \
http://localhost:3000/api/v1/users/sign_up

<--Eventy-->
 <-Add->

 curl -H 'Content-Type: application/json' -H 'Authorization: Bearer <token>' \
-d '{"location":"Wisla", "describe":"2 za 1","discount":50, "store":"empik"}' -X POST http://localhost:3000/api/events/do_event

 <-Delete->
curl -H 'Authorization: Bearer <token>' \
-X DELETE http://localhost:3000/api/events/delete_event/1

 <-find->
curl -H 'Content-Type: application/json' -H 'Authorization: Bearer <token>' \
-X GET http://localhost:3000/api/find_event/Wisla

<--Komentarze-->
 <-Add->
curl -H 'Content-Type: application/json' -H 'Authorization: Bearer <token>' \
-d '{"content":"To jest chujowe", "event_id":2}' -X POST http://localhost:3000/api/comments/do_comment

<-find->
curl -H 'Content-Type: application/json' -H 'Authorization: Bearer <token>' \
-X GET http://localhost:3000/api/comments/find_comments_for/1

<-Delete->
curl -H 'Authorization: Bearer <token>' \
-X DELETE http://localhost:3000/api/comments/delete_comment/1