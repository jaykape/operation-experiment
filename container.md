## Getting started with container

Some resources to learn about container.

From my experience, containers are almost tied to Linux rather than being a truly neutral tool across operating systems. This is because they rely heavily on Linux kernel features like namespaces and cgroups for isolation. Even when you see containers running on Windows, there’s a good chance they’re actually running through a Linux layer such as Windows Subsystem for Linux, meaning a Linux kernel is still doing the real work underneath.

So if u wanna learn containers, you just have to have an idea how Linux works in the first place, and then learn about how kernel namespaces, cnames isolate resources including networking, storage, etc.