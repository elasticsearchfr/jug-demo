# delete all data
curl -XDELETE localhost:9200/

# create an index so we can play with it
curl -XPUT localhost:9200/test

# whitespace analysis of sample text
# whitespace analyzer
#    tokenizer -> whitespace
curl -XPOST 'localhost:9200/test/_analyze?analyzer=whitespace&pretty=1' -d 'The quick brown fox jumped over the lazy dog'
# simple analyzer
#    tokenizer -> lowercase (divides text at non-letters and lowercase them)
curl -XPOST 'localhost:9200/test/_analyze?analyzer=simple&pretty=1' -d 'The quick brown fox jumped over the lazy dog'
# standard analyzer: (the default)
#    tokenizer -> standard
#    filter -> [standard, lowercase, stop]
curl -XPOST 'localhost:9200/test/_analyze?analyzer=standard&pretty=1' -d 'The quick brown fox jumped over the lazy dog'
# keyword analyzer:
#	 tokenizer -> keyword
curl -XPOST 'localhost:9200/test/_analyze?analyzer=keyword&pretty=1' -d 'The quick brown fox jumped over the lazy dog'


curl -XDELETE localhost:9200/
# custom analysis
curl -XPUT localhost:9200/test -d '{
    "settings" : {
        "index" : {
            "analysis" : {
                "analyzer" : {
                    "key_lowercase" : {
                        "tokenizer" : "keyword",
                        "filter" : "lowercase"
                    },
                    "ngram" : {
                        "tokenizer" : "standard",
                        "filter" : ["standard", "lowercase", "stop", "ngram"]
                    },
                    "stemmer" : {
                        "tokenizer" : "standard",
                        "filter" : ["french_stemmer"]
                    },
            		"francais":{
            			"type":"custom",
            			"tokenizer":"standard",
            			"filter":["lowercase", "stop_francais", "french_stemmer", "asciifolding", "elision"]
            		},
            		"francais_ok":{
            			"type":"custom",
            			"tokenizer":"standard",
            			"filter":["lowercase", "french_stemmer", "stop_francais", "asciifolding", "elision"]
            		},
                    "soundex" : {
                        "tokenizer" : "whitespace",
                        "filter" : ["soundex"]
                    }
                },
                "filter" : {
                    "ngram" : {
                        "type" : "ngram",
                        "min_gram" : 2,
                        "max_gram" : 4
                    },
                    "french_stemmer" : {
                        "type" : "stemmer",
                        "name" : "french"
                    },
                    "stop_francais":{
            			"type":"stop",
            			"stopwords":["_french_"]
            		},
            		"elision" : {
            			"type" : "elision",
            			"articles" : ["l", "m", "t", "qu", "n", "s", "j", "d"]
            		},
                    "soundex" : {
                        "type" : "phonetic",
                        "encoder" : "soundex"
                    }
                }
            }
        }
    }
}'

# use the key_lowercase analyzer
curl -XPOST 'localhost:9200/test/_analyze?analyzer=key_lowercase&pretty=1' -d 'The quick brown fox jumped over the lazy dog'
# use the ngram analyzer
curl -XPOST 'localhost:9200/test/_analyze?analyzer=ngram&pretty=1' -d 'The quick brown fox jumped over the lazy dog'
# use the soundex analyzer
curl -XPOST 'localhost:9200/test/_analyze?analyzer=soundex&pretty=1' -d 'The quick brown fox jumped over the lazy dog'
# use the french stemmer
curl -XPOST 'localhost:9200/test/_analyze?analyzer=stemmer&pretty=1' -d 'elephant cheval chevaux'
# use the francais analyzer
curl -XPOST 'localhost:9200/test/_analyze?analyzer=francais&pretty=1' -d 'J"imagine que ce garon est protŽgŽ par la Force !'
# Beware of analysis
curl -XPOST 'localhost:9200/test/_analyze?analyzer=francais&pretty=1' -d 'un avion'
curl -XPOST 'localhost:9200/test/_analyze?analyzer=francais&pretty=1' -d 'des avions'



# Use analyzers in mappings
# -> Note the text3 multi_field option
curl -XPUT localhost:9200/test/type1/_mapping -d '{
    "type1" : {
        "properties" : {
            "text1" : {
                "type" : "string",
                "analyzer" : "simple"
            },
            "text2" : {
                "type" : "string",
                "index_analyzer" : "simple",
                "search_analyzer" : "standard"
            },
            "text3" : {
                "type" : "multi_field",
                "fields" : {
                    "text3" : {
                        "type" : "string",
                        "analyzer" : "standard"
                    },
                    "ngram" : {
                        "type" : "string",
                        "analyzer" : "ngram"
                    },
                    "soundex" : {
                        "type" : "string",
                        "analyzer" : "soundex"
                    }
                }
            }
        }
    }
}'

# Index sample data (just with text3)
curl -XPUT localhost:9200/test/type1/1 -d '{
    "text3" : "The quick brown fox jumped over the lazy dog"
}'

# search for quik (note that its not quick) using differen text3 fields
curl 'localhost:9200/test/_search?q=text3:quik&pretty=1'
curl 'localhost:9200/test/_search?q=text3.ngram:quik&pretty=1'
curl 'localhost:9200/test/_search?q=text3.soundex:quik&pretty=1'

