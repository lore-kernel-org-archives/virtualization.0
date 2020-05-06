From: David Hildenbrand <david@redhat.com>
Subject: Re: [vhost:vhost 8/22] drivers/virtio/virtio_mem.c:1375:20: error: implicit declaration of function 'kzalloc'; did you mean 'vzalloc'?
Date: Wed, 6 May 2020 22:32:31 +0200
Message-ID: <37C99432-6290-4130-B0AF-953DDE09D5DC@redhat.com>
References: <20200506162751-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200506162751-mutt-send-email-mst@kernel.org>
Sender: netdev-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org



> Am 06.05.2020 um 22:28 schrieb Michael S. Tsirkin <mst@redhat.com>:
>=20
> =EF=BB=BFOn Tue, May 05, 2020 at 06:22:51PM +0200, David Hildenbrand wrote=
:
>>> On 05.05.20 18:20, Michael S. Tsirkin wrote:
>>> On Tue, May 05, 2020 at 05:46:44PM +0200, David Hildenbrand wrote:
>>>> On 05.05.20 17:44, Michael S. Tsirkin wrote:
>>>>> On Tue, May 05, 2020 at 04:50:13PM +0200, David Hildenbrand wrote:
>>>>>> On 05.05.20 16:15, kbuild test robot wrote:
>>>>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.gi=
t vhost
>>>>>>> head:   da1742791d8c0c0a8e5471f181549c4726a5c5f9
>>>>>>> commit: 7527631e900d464ed2d533f799cb0da2b29cc6f0 [8/22] virtio-mem: P=
aravirtualized memory hotplug
>>>>>>> config: x86_64-randconfig-b002-20200505 (attached as .config)
>>>>>>> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
>>>>>>> reproduce:
>>>>>>>        git checkout 7527631e900d464ed2d533f799cb0da2b29cc6f0
>>>>>>>        # save the attached .config to linux build tree
>>>>>>>        make ARCH=3Dx86_64=20
>>>>>>>=20
>>>>>>> If you fix the issue, kindly add following tag as appropriate
>>>>>>> Reported-by: kbuild test robot <lkp@intel.com>
>>>>>>>=20
>>>>>>> All error/warnings (new ones prefixed by >>):
>>>>>>>=20
>>>>>>>   drivers/virtio/virtio_mem.c: In function 'virtio_mem_probe':
>>>>>>>>> drivers/virtio/virtio_mem.c:1375:20: error: implicit declaration o=
f function 'kzalloc'; did you mean 'vzalloc'? [-Werror=3Dimplicit-function-d=
eclaration]
>>>>>>>     vdev->priv =3D vm =3D kzalloc(sizeof(*vm), GFP_KERNEL);
>>>>>>>                       ^~~~~~~
>>>>>>>                       vzalloc
>>>>>>>>> drivers/virtio/virtio_mem.c:1375:18: warning: assignment makes poi=
nter from integer without a cast [-Wint-conversion]
>>>>>>>     vdev->priv =3D vm =3D kzalloc(sizeof(*vm), GFP_KERNEL);
>>>>>>>                     ^
>>>>>>>>> drivers/virtio/virtio_mem.c:1419:2: error: implicit declaration of=
 function 'kfree'; did you mean 'vfree'? [-Werror=3Dimplicit-function-declar=
ation]
>>>>>>>     kfree(vm);
>>>>>>>     ^~~~~
>>>>>>>     vfree
>>>>>>>   cc1: some warnings being treated as errors
>>>>>>>=20
>>>>>>> vim +1375 drivers/virtio/virtio_mem.c
>>>>>>=20
>>>>>> Guess we simply need
>>>>>>=20
>>>>>> #include <linux/slab.h>
>>>>>>=20
>>>>>> to make it work for that config.
>>>>>=20
>>>>>=20
>>>>> OK I added that in the 1st commit that introduced virtio-mem.
>>>>=20
>>>> Thanks. I have some addon-patches ready, what's the best way to continu=
e
>>>> with these?
>>>=20
>>> If these are bugfixes, just respin the series (including this fix).
>>=20
>> There are two really minor bugfixes for corner-case error handling and
>> one simplification. I can squash them and resend, makes things easier.
>=20
> OK try to do it ASAP, we don't want to repeat the drama we had with vdpa.
>=20

Yeah, did some more testing today. Will send v3 out tomorrow.

Cheers!=
