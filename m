From: David Hildenbrand <david@redhat.com>
Subject: Re: [vhost:vhost 8/22] drivers/virtio/virtio_mem.c:1375:20: error:
 implicit declaration of function 'kzalloc'; did you mean 'vzalloc'?
Date: Tue, 5 May 2020 16:50:13 +0200
Message-ID: <7dea2810-85cf-0892-20a8-bba3e3a2c133@redhat.com>
References: <202005052221.83QerHmG%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <202005052221.83QerHmG%lkp@intel.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@lists.01.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On 05.05.20 16:15, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git v=
host
> head:   da1742791d8c0c0a8e5471f181549c4726a5c5f9
> commit: 7527631e900d464ed2d533f799cb0da2b29cc6f0 [8/22] virtio-mem: Par=
avirtualized memory hotplug
> config: x86_64-randconfig-b002-20200505 (attached as .config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce:
>         git checkout 7527631e900d464ed2d533f799cb0da2b29cc6f0
>         # save the attached .config to linux build tree
>         make ARCH=3Dx86_64=20
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>=20
> All error/warnings (new ones prefixed by >>):
>=20
>    drivers/virtio/virtio_mem.c: In function 'virtio_mem_probe':
>>> drivers/virtio/virtio_mem.c:1375:20: error: implicit declaration of f=
unction 'kzalloc'; did you mean 'vzalloc'? [-Werror=3Dimplicit-function-d=
eclaration]
>      vdev->priv =3D vm =3D kzalloc(sizeof(*vm), GFP_KERNEL);
>                        ^~~~~~~
>                        vzalloc
>>> drivers/virtio/virtio_mem.c:1375:18: warning: assignment makes pointe=
r from integer without a cast [-Wint-conversion]
>      vdev->priv =3D vm =3D kzalloc(sizeof(*vm), GFP_KERNEL);
>                      ^
>>> drivers/virtio/virtio_mem.c:1419:2: error: implicit declaration of fu=
nction 'kfree'; did you mean 'vfree'? [-Werror=3Dimplicit-function-declar=
ation]
>      kfree(vm);
>      ^~~~~
>      vfree
>    cc1: some warnings being treated as errors
>=20
> vim +1375 drivers/virtio/virtio_mem.c

Guess we simply need

 #include <linux/slab.h>

to make it work for that config.

--=20
Thanks,

David / dhildenb
