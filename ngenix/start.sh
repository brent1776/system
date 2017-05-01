# this script starts the ngenix web server
docker run -d --net=bridge  -p 80:80 -v /Users/bajones/dfps_repository/dfps_repository:/var/www/html ngenix 

