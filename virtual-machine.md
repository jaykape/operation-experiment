## Getting started with virtual machine

I will start simple with Ubuntu server LTS 24.04.3 VMs on my laptop with type 2 Hypervisor VMware running on Windows host. 


*I've tried VirtualBox but the performance is unmatches with VMware workstation.  


### Set up
The fisrt step is download the iso file from the official site. The general setting that I usually use is 2 core CPU, 4GB RAM, 20GB disk.

### Networking  
I prefer to use bridge mode for networking, it will make my VM a part of LAN that my laptop is connected. My VM will able to get access to the internet while get IP from DHCP so I can ssh instead of using VMware interface.

**During boot up, when it ask for network interface, choose `edit IPv4` > `IPv4 Method` > `Automatic (DHCP)`

**We might use custom network that set to bridge rather than default bridge mode, so we can pick which adapter to sync.

Use `ip a` to see the current IP. After that add these host into the host ssh config file. Then gen a new key pair and send it to each VM.

*Since I'm on Windows, I use Git Bash for `sss-copy-id`.

<pre>
ssh-keygen -t ed25519 -C "any comment" <br>
ssh-copy-id -i &lt;key path&gt; &lt;vm address or alias&gt;
</pre>

Then add the argument `IdentityFile <private key path>` to the config file and we're done.

See [SSH best practice](ssh.md)

