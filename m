From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V9 1/9] vhost: refine vhost and vringh kconfig
Date: Wed, 1 Apr 2020 22:39:34 +0800
Message-ID: <51e43cc8-63fe-94c1-54f6-1200e5ef772d@redhat.com>
References: <20200326140125.19794-1-jasowang@redhat.com>
 <20200326140125.19794-2-jasowang@redhat.com>
 <20200401092004-mutt-send-email-mst@kernel.org>
 <6b4d169a-9962-6014-5423-1507059343e9@redhat.com>
 <20200401100954-mutt-send-email-mst@kernel.org>
 <3dd3b7e7-e3d9-dba4-00fc-868081f95ab7@redhat.com>
 <20200401103311-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200401103311-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, jgg@mellanox.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, zhangweining@ruijie.com.cn
List-Id: virtualization@lists.linuxfoundation.org


On 2020/4/1 =E4=B8=8B=E5=8D=8810:35, Michael S. Tsirkin wrote:
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
> Will this not still have the problem with defconfigs? They don't set
> VHOST_MENU ...


Looks not, since it was enabled by default.

I tested this on s390/ppc defconfigs:

# make ARCH=3Ds390 defconfig
*** Default configuration is based on 'defconfig'
#
# No change to .config
#
# grep CONFIG_VHOST .config
CONFIG_VHOST_IOTLB=3Dm
CONFIG_VHOST=3Dm
CONFIG_VHOST_MENU=3Dy
CONFIG_VHOST_NET=3Dm
CONFIG_VHOST_VSOCK=3Dm
# CONFIG_VHOST_VDPA is not set
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

Thanks
