# Motion Master

## somanet_motion_master.cpp

* Initializes ØMQ context. When destroying a context all socekts are cleanly shut-down and destroyed. A ØMQ context is thread safe and may be shared among as many application threads as necessary, without any additional locking required on the part of the caller.
* Create and run Forwarder thread. When run this object creates two sockets from the provided ØMQ context: backend as XSUB and frontent as XPUB and then it proxies from frontend (set of publishers) to backend (set of subscribers). FORWARDER is like the pub-sub proxy server. It allows both publishers and subscribers to be moving parts and it self becomes the stable hub for interconnecting them. FORWARDER collects messages from a set of publishers and forwards these to a set of subscribers. The frontend speaks to publishers and the backend speaks to subscribers. You should use ZMQ_FORWARDER with a ZMQ_SUB socket for the frontend and a ZMQ_PUB socket for the backend.
* Create and run Heartbeat thread. This object uses Notifier to send Motion Master heartbeat to clients. Notifier eventually uses the instance of forwarder_socket to send message.
* 
