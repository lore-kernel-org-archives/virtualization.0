From: Jason Wang <jasowang@redhat.com>
Subject: Re: vhost: refine vhost and vringh kconfig
Date: Fri, 10 Apr 2020 16:33:01 +0800
Message-ID: <f7fc96d4-de8e-cdce-bd98-242cdade2843@redhat.com>
References: <git-mailbomb-linux-master-20c384f1ea1a0bc7320bc445c72dd02d2970d594@kernel.org>
 <CAMuHMdUkff8XUrbHa90nGxa8Kj3HO9b2CRO57s3YZrSFPM51pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUkff8XUrbHa90nGxa8Kj3HO9b2CRO57s3YZrSFPM51pg@mail.gmail.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, KVM list <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/4/10 =E4=B8=8B=E5=8D=883:53, Geert Uytterhoeven wrote:
> Hi Jason,
>
> On Thu, Apr 9, 2020 at 6:04 AM Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org> wrote:
>> Commit:     20c384f1ea1a0bc7320bc445c72dd02d2970d594
>> Parent:     5a6b4cc5b7a1892a8d7f63d6cbac6e0ae2a9d031
>> Refname:    refs/heads/master
>> Web:        https://git.kernel.org/torvalds/c/20c384f1ea1a0bc7320bc445=
c72dd02d2970d594
>> Author:     Jason Wang <jasowang@redhat.com>
>> AuthorDate: Thu Mar 26 22:01:17 2020 +0800
>> Committer:  Michael S. Tsirkin <mst@redhat.com>
>> CommitDate: Wed Apr 1 12:06:26 2020 -0400
>>
>>      vhost: refine vhost and vringh kconfig
>>
>>      Currently, CONFIG_VHOST depends on CONFIG_VIRTUALIZATION. But vho=
st is
>>      not necessarily for VM since it's a generic userspace and kernel
>>      communication protocol. Such dependency may prevent archs without
>>      virtualization support from using vhost.
>>
>>      To solve this, a dedicated vhost menu is created under drivers so
>>      CONIFG_VHOST can be decoupled out of CONFIG_VIRTUALIZATION.
>>
>>      While at it, also squash Kconfig.vringh into vhost Kconfig file. =
This
>>      avoids the trick of conditional inclusion from VOP or CAIF. Then =
it
>>      will be easier to introduce new vringh users and common dependenc=
y for
>>      both vringh and vhost.
>>
>>      Signed-off-by: Jason Wang <jasowang@redhat.com>
>>      Link: https://lore.kernel.org/r/20200326140125.19794-2-jasowang@r=
edhat.com
>>      Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>   arch/arm/kvm/Kconfig         |  2 --
>>   arch/arm64/kvm/Kconfig       |  2 --
>>   arch/mips/kvm/Kconfig        |  2 --
>>   arch/powerpc/kvm/Kconfig     |  2 --
>>   arch/s390/kvm/Kconfig        |  4 ----
>>   arch/x86/kvm/Kconfig         |  4 ----
>>   drivers/Kconfig              |  2 ++
>>   drivers/misc/mic/Kconfig     |  4 ----
>>   drivers/net/caif/Kconfig     |  4 ----
>>   drivers/vhost/Kconfig        | 28 +++++++++++++++++++++-------
>>   drivers/vhost/Kconfig.vringh |  6 ------
>>   11 files changed, 23 insertions(+), 37 deletions(-)
>> --- a/drivers/vhost/Kconfig
>> +++ b/drivers/vhost/Kconfig
>> @@ -1,4 +1,23 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>> +config VHOST_RING
>> +       tristate
>> +       help
>> +         This option is selected by any driver which needs to access
>> +         the host side of a virtio ring.
>> +
>> +config VHOST
>> +       tristate
>> +       select VHOST_IOTLB
>> +       help
>> +         This option is selected by any driver which needs to access
>> +         the core of vhost.
>> +
>> +menuconfig VHOST_MENU
>> +       bool "VHOST drivers"
>> +       default y
> Please do not use default y. Your subsystem is not special.


This is because before this patch VHOST depends on VIRTUALIZATION. So=20
the archs whose defconfig that has VIRTUALIZATION can just enable e.g=20
VHOST_NET without caring about VHOST_MENU.

If this is not preferable, we can:

1) modify the defconfig and enable VHOST_MENU there
2) switch to use default y if $(all_archs_that_has_VIRTUALIZATION)


>
>> +
> I think this deserves a help text, so users know if they want to enable=
 this
> option or not.


Will add one.

Thanks


>
> Thanks!
>
>> +if VHOST_MENU
>> +
>>   config VHOST_NET
>>          tristate "Host kernel accelerator for virtio net"
>>          depends on NET && EVENTFD && (TUN || !TUN) && (TAP || !TAP)
> Gr{oetje,eeting}s,
>
>                          Geert
>
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org
>
> In personal conversations with technical people, I call myself a hacker=
. But
> when I'm talking to journalists I just say "programmer" or something li=
ke that.
>                                  -- Linus Torvalds
>
