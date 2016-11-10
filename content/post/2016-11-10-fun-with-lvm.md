+++
title = "Fun with LVM"
date = "2016-11-10"
tags = ["linux", "lvm"]
+++

The OOM killer just killed one my tabs in Chrome. As it turned out I
underestimated the size of the swap partition during Fedora installation on my
work laptop a few years ago. Or maybe I shouldn't just let virtual machines idle
in the background and open a gazillion of tabs in the browser at the same time.
Anyways, I needed more swap space and thankfully this installation sits on an
LVM volume group which allowed me to switch to a swap file, remove the swap
partition and add the free space to the root volume. Here is how I did that:

I created a new swapfile to use from now on. Six
[gibibytes](https://en.wikipedia.org/wiki/Gibibyte) should be enough, right?

```
fallocate -l 6G /swapfile
```

Creating the swap structure on it and making the system aware of the newly
available swap space is easy.

```
mkswap /swapfile
swapon /swapfile
```

At this point I had two swap locations with plenty of space available. I could
have just stopped here, mind you, but where is the fun in that?

I made the new swap file mounted automatically at boot with this line in
`/etc/fstab`

```
/swapfile  swap  swap  defaults,x-systemd.device-timeout=0 0 0
```

I also removed the line responsible for the swap partition, then disabled
swapping on it:

```
swapoff /dev/vg/swap
```

I removed the logical volume. You can use `vgdisplay` or `pvs` before and after
to see the available free space is indeed got bigger.

```
lvremove /dev/vg/swap
```


This is where the magic happens. I extended the root partition to use all the
available free space:

```
lvextend -l +100%FREE /dev/vg/root
```

And finally resized the ext4 root filesystem to claim the space.

```
resize2fs /dev/vg/root
```

The whole procedure took about 5 minutes, everything online and mounted, nice
and easy.

*Note to self*: don't forget to change the Linux kernel boot command line. In
the default Fedora install it contains a reference to the swap partition and the
system will not boot if the partition is missing. Edit `/etc/default/grub`
accordingly then update the right grub config:

```
grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
```