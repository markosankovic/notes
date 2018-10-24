# OBLAC Drives Bundle Update Service.md

## Enabling Docker Remote API

    $ sudo mkdir -p /etc/systemd/system/docker.service.d
    $ sudo vi /etc/systemd/system/docker.service.d/override.conf
    [Service]
    ExecStart=
    ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2376
    $ sudo systemctl daemon-reload
    $ sudo systemctl restart docker.service
    $ curl http://localhost:2376/version

## Links

- https://success.docker.com/article/how-do-i-enable-the-remote-api-for-dockerd
