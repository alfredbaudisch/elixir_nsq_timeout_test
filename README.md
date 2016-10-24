elixir_nsq
===

Sample code to validate timeouts with NSQ Publishers and Consumers as per this issue: [https://github.com/wistia/elixir_nsq/issues/3](Timeouts on both Consumers and Producers).

How to run
==

Run NSQ and NSQLookup with Docker
---
```
docker pull nsqio/nsq

docker run -d --name lookupd -p 4160:4160 -p 4161:4161 nsqio/nsq /nsqlookupd

docker run -d --name nsqd -p 4150:4150 -p 4151:4151 \
    nsqio/nsq /nsqd \
    --broadcast-address=<YOUR MACHINE IP> \
    --lookupd-tcp-address=<YOUR MACHINE IP>:4160 \
    --data-path=/data

docker run -d --name nsqadmin -p 4171:4171 \
    nsqio/nsq /nsqadmin \
    --lookupd-http-address=<YOUR MACHINE IP>:4161
```

Run the Elixir applications
---

**Publisher**

```
cd nsq_publisher
mix deps.get
iex -S mix phoenix.server
```

To publish messages:
`iex(6)> NsqPublisher.Publisher.publish("hi")`

Or by HTTP endpoints:
```
post /messages => {"message" => "foo"}
get /publish
```

To mass publish via the API: `ab -n 10000 -c 10 "http://<YOUR HOST>:4000/api/publish"`

**Consumer**

```
cd nsq_consumer
mix deps.get
iex -S mix
```
