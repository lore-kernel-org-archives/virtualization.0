From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V9 1/9] vhost: refine vhost and vringh kconfig
Date: Wed, 1 Apr 2020 22:43:56 +0800
Message-ID: <12f0ff8f-cdf2-9aac-883c-48c39138b7ea@redhat.com>
References: <20200326140125.19794-1-jasowang@redhat.com>
 <20200326140125.19794-2-jasowang@redhat.com>
 <20200401092004-mutt-send-email-mst@kernel.org>
 <6b4d169a-9962-6014-5423-1507059343e9@redhat.com>
 <20200401100954-mutt-send-email-mst@kernel.org>
 <3dd3b7e7-e3d9-dba4-00fc-868081f95ab7@redhat.com>
 <20200401103659-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200401103659-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, jgg@mellanox.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, zhangweining@ruijie.com.cn
List-Id: virtualization@lists.linuxfoundation.org


On 2020/4/1 =E4=B8=8B=E5=8D=8810:39, Michael S. Tsirkin wrote:
>> >From 9b3a5d23b8bf6b0a11e65e688335d782f8e6aa5c Mon Sep 17 00:00:00 200=
1
>> From: Jason Wang<jasowang@redhat.com>
>> Date: Wed, 1 Apr 2020 22:17:27 +0800
>> Subject: [PATCH] vhost: let CONFIG_VHOST to be selected by drivers
>>
>> The defconfig on some archs enable vhost_net or vhost_vsock by
>> default. So instead of adding CONFIG_VHOST=3Dm to all of those files,
>> simply letting CONFIG_VHOST to be selected by all of the vhost
>> drivers. This fixes the build on the archs with CONFIG_VHOST_NET=3Dm i=
n
>> their defconfig.
>>
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>> ---
>>   drivers/vhost/Kconfig | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
>> index 2523a1d4290a..362b832f5338 100644
>> --- a/drivers/vhost/Kconfig
>> +++ b/drivers/vhost/Kconfig
>> @@ -11,19 +11,23 @@ config VHOST_RING
>>   	  This option is selected by any driver which needs to access
>>   	  the host side of a virtio ring.
>>  =20
>> -menuconfig VHOST
>> -	tristate "Host kernel accelerator for virtio (VHOST)"
>> -	depends on EVENTFD
>> +config VHOST
>> +	tristate
>>   	select VHOST_IOTLB
>>   	help
>>   	  This option is selected by any driver which needs to access
>>   	  the core of vhost.
>>  =20
>> -if VHOST
>> +menuconfig VHOST_MENU
>> +	bool "VHOST drivers"
>> +	default y
>> +
>> +if VHOST_MENU
> In fact this is similar to VIRTIO, and I wonder whether VIRTIO has also
> been broken by
> 	commit 7b95fec6d2ffa53f4a8d637b0f223644d458ea4e
> 	Author: Vincent Legoll<vincent.legoll@gmail.com>
> 	Date:   Sun Jan 7 12:33:56 2018 +0100
>
> 	    virtio: make VIRTIO a menuconfig to ease disabling it all
>
> I see lots of defconfigs set VIRTIO_PCI but not VIRTIO_MENU ...


Probably not since VIRTIO_MENU has "default y"

E.g for powerpc, I got:

# make ARCH=3Dpowerpc defconfig
*** Default configuration is based on 'ppc64_defconfig'
#
# No change to .config
#
# grep CONFIG_VIRTIO .config
CONFIG_VIRTIO_BLK=3Dm
CONFIG_VIRTIO_NET=3Dm
CONFIG_VIRTIO_CONSOLE=3Dm
CONFIG_VIRTIO=3Dm
CONFIG_VIRTIO_MENU=3Dy
CONFIG_VIRTIO_PCI=3Dm
CONFIG_VIRTIO_PCI_LEGACY=3Dy
# CONFIG_VIRTIO_VDPA is not set
CONFIG_VIRTIO_BALLOON=3Dm
# CONFIG_VIRTIO_INPUT is not set
# CONFIG_VIRTIO_MMIO is not set
# CONFIG_VIRTIO_FS is not set

Thanks
