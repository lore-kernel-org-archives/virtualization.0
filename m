From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V9 9/9] virtio: Intel IFC VF driver for VDPA
Date: Thu, 9 Apr 2020 20:43:49 +0800
Message-ID: <ffc4c788-2319-efda-508c-275b9f7efb95@redhat.com>
References: <20200326140125.19794-1-jasowang@redhat.com>
 <20200326140125.19794-10-jasowang@redhat.com>
 <CAK8P3a1RXUXs5oYjB=Jq5cpvG11eTnmJ+vc18_-0fzgTH6envA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a1RXUXs5oYjB=Jq5cpvG11eTnmJ+vc18_-0fzgTH6envA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, lingshan.zhu@intel.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org, Networking <netdev@vger.kernel.org>, Jason Gunthorpe <jgg@mellanox.com>, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, eperezma@redhat.com, lulu@redhat.com, Parav Pandit <parav@mellanox.com>, kevin.tian@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, Christoph Hellwig <hch@infradead.org>, aadam@redhat.com, Jiri Pirko <jiri@mellanox.com>, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, zhangw
List-Id: virtualization@lists.linuxfoundation.org


On 2020/4/9 =E4=B8=8B=E5=8D=886:41, Arnd Bergmann wrote:
> On Thu, Mar 26, 2020 at 3:08 PM Jason Wang <jasowang@redhat.com> wrote:
>> From: Zhu Lingshan <lingshan.zhu@intel.com>
>>
>> This commit introduced two layers to drive IFC VF:
>>
>> (1) ifcvf_base layer, which handles IFC VF NIC hardware operations and
>>      configurations.
>>
>> (2) ifcvf_main layer, which complies to VDPA bus framework,
>>      implemented device operations for VDPA bus, handles device probe,
>>      bus attaching, vring operations, etc.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>> Signed-off-by: Bie Tiwei <tiwei.bie@intel.com>
>> Signed-off-by: Wang Xiao <xiao.w.wang@intel.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> +
>> +#define IFCVF_QUEUE_ALIGNMENT  PAGE_SIZE
>> +#define IFCVF_QUEUE_MAX                32768
>> +static u16 ifcvf_vdpa_get_vq_align(struct vdpa_device *vdpa_dev)
>> +{
>> +       return IFCVF_QUEUE_ALIGNMENT;
>> +}
> This fails to build on arm64 with 64kb page size (found in linux-next):
>
> /drivers/vdpa/ifcvf/ifcvf_main.c: In function 'ifcvf_vdpa_get_vq_align'=
:
> arch/arm64/include/asm/page-def.h:17:20: error: conversion from 'long
> unsigned int' to 'u16' {aka 'short unsigned int'} changes value from
> '65536' to '0' [-Werror=3Doverflow]
>     17 | #define PAGE_SIZE  (_AC(1, UL) << PAGE_SHIFT)
>        |                    ^
> drivers/vdpa/ifcvf/ifcvf_base.h:37:31: note: in expansion of macro 'PAG=
E_SIZE'
>     37 | #define IFCVF_QUEUE_ALIGNMENT PAGE_SIZE
>        |                               ^~~~~~~~~
> drivers/vdpa/ifcvf/ifcvf_main.c:231:9: note: in expansion of macro
> 'IFCVF_QUEUE_ALIGNMENT'
>    231 |  return IFCVF_QUEUE_ALIGNMENT;
>        |         ^~~~~~~~~~~~~~~~~~~~~
>
> It's probably good enough to just not allow the driver to be built in t=
hat
> configuration as it's fairly rare but unfortunately there is no simple =
Kconfig
> symbol for it.


Or I think the 64KB alignment is probably more than enough.

Ling Shan, can we use smaller value here?

Thanks


>
> In a similar driver, we did
>
> config VMXNET3
>          tristate "VMware VMXNET3 ethernet driver"
>          depends on PCI && INET
>          depends on !(PAGE_SIZE_64KB || ARM64_64K_PAGES || \
>                       IA64_PAGE_SIZE_64KB || MICROBLAZE_64K_PAGES || \
>                       PARISC_PAGE_SIZE_64KB || PPC_64K_PAGES)
>
> I think we should probably make PAGE_SIZE_64KB a global symbol
> in arch/Kconfig and have it selected by the other symbols so drivers
> like yours can add a dependency for it.
>
>           Arnd
>
