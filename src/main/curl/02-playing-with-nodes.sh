# start with one server (node 1) and open http://localhost:9200/_plugin/head/

# delete all data
curl -XDELETE localhost:9200/

# create an index with two shards and 1 replica
curl -XPUT localhost:9200/index1 -d '{
    "index" : {
        "number_of_shards" : 2,
        "number_of_replicas" : 1
    }
}'

# see how it's allocated: http://localhost:9200/_plugin/head/

# index some data if you want...
curl -XPOST localhost:9200/jug/talk?pretty=1 -d '{
	"speaker" : "Shay Banon",
	"title" : "Elasticsearch: the final frontier"
}'

curl -XPOST localhost:9200/jug/talk -d '{
	"speaker" : "David Pilato",
	"title" : "Elasticsearch : la recherche Žlastique pour tous !"
}'

curl -XPOST localhost:9200/jug/talk -d '{
	"speaker" : "Tugdual Grall",
	"title" : "NoSQL : le changement, c'est maintenant !"
}'

curl -XPOST localhost:9200/jug/talk -d '{
	"speaker" : "Emmanuel Bernard",
	"title" : "Des OGM dans votre hibernate"
}'

# play with head interface (show index, query _all : elasticsearch): http://localhost:9200/_plugin/head/

# start node 2, and see the rest of the shards allocated
# see how it's allocated: http://localhost:9200/_plugin/head/

# start node 3, and see the rest of the shards allocated
# see how it's allocated: http://localhost:9200/_plugin/head/

# start node 4, and see the rest of the shards allocated
# see how it's allocated: http://localhost:9200/_plugin/head/

#kill node 1 and see in logs that a new master being elected
# see how it's allocated: http://localhost:9200/_plugin/head/ (it should fail ;-))

# start node 1
# see how it's allocated: http://localhost:9200/_plugin/head/
# node 1 is not master anymore

#increase the number of replicas
curl -XPUT localhost:9200/index1/_settings -d '{
	"index" : {
	    "number_of_replicas" : 2
	}
}'

# see how it's allocated: http://localhost:9200/_plugin/head/ (it should fail ;-))
