## SSH Best Practice

When we want to set up a connection between two devices/instances via SSH. First we have to considered the role, i.e. one that you use to initiate a connection (SSH client) and the one you wanted to take controle (SSH server).

Generally steps are 
1. generate a *key pair* or use an existing one on the client side. 
(key pair = two files of keys private one and public one)
2. send the public key to the server side and put it in certain locations.

These steps may sounds very vague and generic, this because SSH is just a protocol, not an implementation. 

For example, OpenSSH is a program that most of the time came by default to Linux and Windows. OpenSSH provide a tool for 
- generate key pairs using the command `ssh-keygen` 
- sending key over the network using command `ssh-copy-id` 

When OpenSSH daemon is listening to the port 22 and it received a request, it look at each key in the directory `~/.ssh/authorized_keys` and send a *challenge* (data encrypted with the public key) for client to prove that it has a the private key corresponding to some of public keys.

### Note

- In fact, generating the key pair at the server side and send the private key to the client is still technically worked. But it is a very bad practice and a security risk. The reason is that it is very easy to derive the public key from the private one, but it is almost impossible to do the converse. So the private key should not ever leave the machine/instance.