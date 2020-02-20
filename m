From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 4/5] virtio: introduce a vDPA based transport
Date: Thu, 20 Feb 2020 13:40:52 +0800
Message-ID: <0f796bc9-3e27-38ae-9d7a-bf2be2a9f8ab@redhat.com>
References: <20200220035650.7986-1-jasowang@redhat.com>
 <20200220035650.7986-5-jasowang@redhat.com>
 <2c5a3a84-be56-3003-8d71-d46645664bab@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2c5a3a84-be56-3003-8d71-d46645664bab@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: tiwei.bie@intel.com, jgg@mellanox.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/2/20 =E4=B8=8B=E5=8D=8812:07, Randy Dunlap wrote:
> On 2/19/20 7:56 PM, Jason Wang wrote:
>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>> index 9c4fdb64d9ac..0df3676b0f4f 100644
>> --- a/drivers/virtio/Kconfig
>> +++ b/drivers/virtio/Kconfig
>> @@ -43,6 +43,19 @@ config VIRTIO_PCI_LEGACY
>>  =20
>>   	  If unsure, say Y.
>>  =20
>> +config VIRTIO_VDPA
>> +	tristate "vDPA driver for virtio devices"
>> +        select VDPA
>> +        select VIRTIO
>> +	help
>> +	  This driver provides support for virtio based paravirtual
>> +	  device driver over vDPA bus. For this to be useful, you need
>> +	  an appropriate vDPA device implementation that operates on a
>> +          physical device to allow the datapath of virtio to be
>> +	  offloaded to hardware.
>> +
>> +	  If unsure, say M.
>> +
> Please use tabs consistently for indentation, not spaces,
> except in the Kconfig help text, which should be 1 tab + 2 spaces.


Fixed.

Thanks


>
>>   config VIRTIO_PMEM
>>   	tristate "Support for virtio pmem driver"
>>   	depends on VIRTIO
>
