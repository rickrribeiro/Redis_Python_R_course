import redis

r = redis.Redis()
r.set("1", "eng dados")
print(r.get("1"))
