module Support
  class Fixtures
    def self.tweet_json_string
      <<-eos
    {
        "id": "tag:search.twitter.com,2005:123456789",
        "objectType": "activity",
        "actor": {
            "objectType": "person",
            "id": "id:twitter.com:261468970",
            "link": "http://www.twitter.com/someone",
            "displayName": "Someone",
            "postedTime": "2011-03-06T01:13:33.000Z",
            "image": "https://pbs.twimg.com/profile_images/378800000421932974/1ebdd175a8c608810377a3fd1e49b4e4_normal.jpeg",
            "summary": "Cali Grown -818 to the 612! My son, family, then my career. Go follow my bro, @holdsworth135, while he lives his UFC Dream!",
            "links": [{
                "href": null,
                "rel": "me"
            }],
            "friendsCount": 104,
            "followersCount": 62,
            "listedCount": 0,
            "statusesCount": 911,
            "twitterTimeZone": "Mountain Time (US & Canada)",
            "verified": false,
            "utcOffset": "-25200",
            "preferredUsername": "CaliMspink",
            "languages": ["en"],
            "location": {
                "objectType": "place",
                "displayName": "Minneapolis MN"
            },
            "favoritesCount": 364
        },
        "verb": "post",
        "postedTime": "2014-03-02T01:47:02.000Z",
        "generator": {
            "displayName": "Instagram",
            "link": "http://instagram.com"
        },
        "provider": {
            "objectType": "service",
            "displayName": "Twitter",
            "link": "http://www.twitter.com"
        },
        "link": "http://twitter.com/someone/statuses/123456789",
        "body": "Saaayyy whaaaa? #New #Breyers #Gelato #Tiramisu #MamasTreat #StayAway #GoodThingIAlreadyPumped ;-) http://t.co/i5nN1ZS2VZ",
        "object": {
            "objectType": "note",
            "id": "object:search.twitter.com,2005:439939908128759808",
            "summary": "Saaayyy whaaaa? #New #Breyers #Gelato #Tiramisu #MamasTreat #StayAway #GoodThingIAlreadyPumped ;-) http://t.co/i5nN1ZS2VZ",
            "link": "http://twitter.com/CaliMspink/statuses/439939908128759808",
            "postedTime": "2014-03-02T01:47:02.000Z"
        },
        "favoritesCount": 0,
        "twitter_entities": {
            "hashtags": [{
                "text": "New",
                "indices": [16, 20]
            }, {
                "text": "Breyers",
                "indices": [21, 29]
            }, {
                "text": "Gelato",
                "indices": [30, 37]
            }, {
                "text": "Tiramisu",
                "indices": [38, 47]
            }, {
                "text": "MamasTreat",
                "indices": [48, 59]
            }, {
                "text": "StayAway",
                "indices": [60, 69]
            }, {
                "text": "GoodThingIAlreadyPumped",
                "indices": [70, 94]
            }],
            "symbols": [],
            "urls": [{
                "url": "http://t.co/i5nN1ZS2VZ",
                "expanded_url": "http://instagram.com/p/lBbX0Oxvya/",
                "display_url": "instagram.com/p/lBbX0Oxvya/",
                "indices": [99, 121]
            }],
            "user_mentions": []
        },
        "twitter_filter_level": "medium",
        "twitter_lang": "en",
        "retweetCount": 0,
        "gnip": {
            "matching_rules": [{
                "tag": null
            }],
            "urls": [{
                "url": "http://t.co/i5nN1ZS2VZ",
                "expanded_url": "http://instagram.com/p/lBbX0Oxvya/",
                "expanded_status": 200
            }],
            "language": {
                "value": "en"
            },
            "profileLocations": [{
                "objectType": "place",
                "geo": {
                    "type": "point",
                    "coordinates": [-93.26384, 44.97997]
                },
                "address": {
                    "country": "United States",
                    "countryCode": "US",
                    "locality": "Minneapolis",
                    "region": "Minnesota",
                    "subRegion": "Hennepin County"
                },
                "displayName": "Minneapolis, Minnesota, United States"
            }]
        }
    }
      eos
    end
  end
end
