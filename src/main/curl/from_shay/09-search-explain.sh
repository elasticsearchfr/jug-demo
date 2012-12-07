# delete all data
curl -XDELETE localhost:9200/

# index some data
curl -XPUT localhost:9200/test/type1/1 -d '{
	"tags" : ["scala", "functional"],
	"count" : 10,
	"price" : 12.5,
	"date" : "2011-05-25"
}'

curl -XPUT localhost:9200/test/type1/2 -d '{
	"tags" : ["clojure", "lisp", "functional"],
	"count" : 5,
	"price" : 15.7,
	"date" : "2011-05-26"
}'

curl -XPUT localhost:9200/test/type1/3 -d '{
	"tags" : ["java", "scala"],
	"count" : 5,
	"price" : 10.7,
	"date" : "2011-05-27"
}'

curl 'localhost:9200/test/type1/1/_explain?q=scala&pretty=1'
curl 'localhost:9200/test/type1/2/_explain?q=scala&pretty=1'
