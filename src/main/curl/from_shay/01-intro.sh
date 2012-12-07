# Delete all the data
curl -XDELETE localhost:9200/

# Index Some Data
curl -XPOST localhost:9200/jug/talk?pretty=1 -d '{
	"speaker" : "Adrian Colyer",
	"title" : "Enterprise Applications in 2011 Challenges in Development and Deployment, and Springs response"
}'

curl -XPOST localhost:9200/jug/talk -d '{
	"speaker" : "Boris Bokowski",
	"title" : "Introducing Orion: Embracing the Web for Software Development Tooling"
}'

curl -XPOST localhost:9200/jug/talk -d '{
	"speaker" : "Howard Lewis Ship",
	"title" : "Towards the Essence of Programming"
}'

curl -XPOST localhost:9200/jug/talk -d '{
	"speaker" : "Jevgeni Kabanov",
	"title" : "Do you really get memory?"
}'

curl -XPOST localhost:9200/jug/talk -d '{
	"speaker" : "Jags Ramnarayan",
	"title" : "SQLFabric - Scalable SQL instead of NoSQL"
}'

curl -XPOST localhost:9200/jug/talk -d '{
	"speaker" : "Brad Drysdale",
	"title" : "HTML5 WebSockets : the Web Communication revolution, making the impossible possible"
}'

curl -XPOST localhost:9200/jug/talk -d '{
	"speaker" : "Neal Gafter",
	"title" : ""
}'

curl -XPOST localhost:9200/jug/talk -d '{
	"speaker" : "Rob Harrop",
	"title" : "Multi-Platform Messaging with RabbitMQ"
}'

curl -XPOST localhost:9200/jug/talk -d '{
	"speaker" : "Theo Schlossnagle",
	"title" : "Service Decoupling in Carrier-Class Architectures"
}'

curl -XPOST localhost:9200/jug/talk -d '{
	"speaker" : "Michael Chaize",
	"title" : "Architecting user-experiences"
}'

curl -XPOST localhost:9200/jug/talk -d '{
	"speaker" : "Jonas Boner",
	"title" : "Akka: Simpler Scalability, Fault-Tolerance, Concurrency Remoting through Actors"
}'

curl -XPOST localhost:9200/jug/talk -d '{
	"speaker" : "Shay Banon",
	"title" : "ElasticSearch - A Distributed Search Engine"
}'

curl -XPOST localhost:9200/jug/talk -d '{
	"speaker" : "Kohsuke Kawaguchi",
	"title" : "Taking Continuous Integration to the next level with Jenkins"
}'

# Simple Search
curl 'localhost:9200/_count?q=*&pretty=1'

curl 'localhost:9200/_search?q=scalability&pretty=1'

curl 'localhost:9200/_search?q=speaker:Adrian&pretty=1'

curl 'localhost:9200/_search?q=_missing_:title&pretty=1'
