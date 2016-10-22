+++
date = "2016-08-08T15:15:50+02:00"
draft = false
title = "Faster AUR builds"
tags = ["archlinux", "aur"]
+++

The process of building a package from AUR, the Arch Linux User Repository, is
the following:

 1. download the PKGBUILD
 2. makepkg will download, decompress and compile the source based on the
    PKGBUILD
 3. compress the software into a `.tar.xz` package
 4. pacman will install the package via decompressing its contents into the filesystem

As you can see the last two steps are quite redundant. Compressing the files to
then decompress them a few seconds later. If you are installing a large package
like Google Chrome from the AUR you will notice these two steps take some time
to finish, especially on weak hardware.

The building of the packages are done by the makepkg tool. The compressor is
chosen based on the settings in the `/etc/makepkg.conf` configuration file. This
is its default state:


```
# WARNING: Do NOT modify these variables unless you know what you are
#          doing.
#
PKGEXT='.pkg.tar.xz'
```

Makepkg chooses the compressor based on the specified package extension. If you
omit the extension no compression will take place.

```
PKGEXT='.pkg.tar'
```

From here on, locally built packages will not be compressed. They will be stored
in an uncompressed `tar` archive instead. Installing them will become almost
instantaneous.

If you are not distributing your locally created packages then there no downside
to this change.
