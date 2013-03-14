# Delete all the data
curl -XDELETE localhost:9200/

# Index Some Data
curl -XPOST localhost:9200/jug/talk?pretty=1 -d '{
	"speaker" : "Shay Banon",
	"title" : "Elasticsearch: the final frontier"
}'

curl -XPOST localhost:9200/jug/talk -d '{
	"speaker" : "David Pilato",
	"title" : "Elasticsearch : la recherche élastique pour tous !"
}'

curl -XPOST localhost:9200/jug/talk -d '{
	"speaker" : "Tugdual Grall",
	"title" : "NoSQL : le changement, c est maintenant !"
}'

curl -XPOST localhost:9200/jug/talk -d '{
	"speaker" : "Emmanuel Bernard",
	"title" : "Des OGM dans votre hibernate"
}'

# Simple Search
curl 'localhost:9200/_count?q=*&pretty=1'

curl 'localhost:9200/_search?q=elasticsearch&pretty=1'

curl 'localhost:9200/_search?q=speaker:David&pretty=1'
