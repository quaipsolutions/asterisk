# quaipsolutions/asterisk13-pjsip

quaipsolutions/asterisk13-pjsip is a docker base image that bundles the latest version of asterisk certified version with pjsip.
What is Asterisk?

Asterisk is a free and open source framework for building communications applications and is sponsored by Digium.
Asterisk turns an ordinary computer into a communications server. Asterisk powers IP PBX systems, VoIP gateways, conference servers and is used by small businesses, large businesses, call centers, carriers and governments worldwide.
Usage

# Run the following command:

docker run -d --restart=always --name my-asterisk quaipsolutions/asterisk

# Enter the asterisk console:

docker exec -it my-asterisk rasterisk -vvvv

Asterisk 13.1-cert2, Copyright (C) 1999 - 2014, Digium, Inc. and others. 
Created by Mark Spencer <markster@digium.com>
Asterisk comes with ABSOLUTELY NO WARRANTY; type 'core show warranty' for details.
This is free software, with components licensed under the GNU General Public  
License version 2 and other licenses; you are welcome to redistribute it under
certain conditions. Type 'core show license' for details.

Connected to Asterisk 13.1-cert2 currently running on c28b7896d2d6 (pid = 1)
c28b7896d2d6*CLI>

Using a custom configuration folder

The asterisk configuration is on /etc/asterisk and de image create official sample files, If you want to use a customized asterisk configuration, you can create your alternative configuration directory on the host machine and then mount that directory location as /etc/asterisk inside the asterisk container:

$ docker run --expose-all --name some-asterisk -v /my/custom/folder/asterisk:/etc/asterisk
