FROM nodered/node-red:3.1.9

USER root

RUN apk update && apk add nginx

RUN cd /usr/src/node-red && npm install node-red-node-serialport
RUN cd /usr/src/node-red/node_modules/@serialport/bindings-cpp && npm run rebuild

RUN mkdir -p /service
COPY nginx.conf /etc/nginx/nginx.conf
COPY register_service /service/register_service

COPY start.sh /start.sh
COPY entrypoint.sh /entrypoint.sh

LABEL version="1.0.3"
LABEL permissions='{\
  "ExposedPorts": {\
    "80/tcp": {}\
  },\
  "HostConfig": {\
    "Privileged": true,\
    "Binds": [\
      "/usr/blueos/extensions/node-red:/data:rw",\
      "/etc/hostname:/etc/hostname:ro",\
      "/dev:/dev:rw",\
      "/:/home/workspace/host:rw"\
    ],\
    "PortBindings": {\
      "80/tcp": [\
        {\
          "HostPort": ""\
        }\
      ]\
    }\
  }\
}'
LABEL authors='[\
    {\
        "name": "Patrick José Pereira",\
        "email": "patrickelectric@gmail.com"\
    }\
]'
LABEL company='{\
    "about": "",\
    "name": "Blue Robotics",\
    "email": "support@bluerobotics.com"\
}'
LABEL type="device-integration"
LABEL readme="https://raw.githubusercontent.com/BlueOS-Community/blueos-node-red/master/README.md"
LABEL type="other"
LABEL tags='[\
  "code",\
  "development",\
  "ide",\
  "node-red"\
]'

ENTRYPOINT ["/start.sh"]
