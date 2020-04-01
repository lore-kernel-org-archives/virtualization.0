From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V9 1/9] vhost: refine vhost and vringh kconfig
Date: Wed, 1 Apr 2020 22:50:50 +0800
Message-ID: <5e409bb4-2b06-5193-20c3-a9ddaafacf5a@redhat.com>
References: <20200326140125.19794-1-jasowang@redhat.com>
 <20200326140125.19794-2-jasowang@redhat.com>
 <fde312a4-56bd-f11f-799f-8aa952008012@de.ibm.com>
 <41ee1f6a-3124-d44b-bf34-0f26604f9514@redhat.com>
 <4726da4c-11ec-3b6e-1218-6d6d365d5038@de.ibm.com>
 <39b96e3a-9f4e-6e1d-e988-8c4bcfb55879@de.ibm.com>
 <c423c5b1-7817-7417-d7af-e07bef6368e7@redhat.com>
 <20200401102631-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200401102631-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, jgg@mellanox.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, zhangweining@ruijie.com.cn
List-Id: virtualization@lists.linuxfoundation.org


On 2020/4/1 =E4=B8=8B=E5=8D=8810:27, Michael S. Tsirkin wrote:
> On Wed, Apr 01, 2020 at 10:13:29PM +0800, Jason Wang wrote:
>> On 2020/4/1 =E4=B8=8B=E5=8D=889:02, Christian Borntraeger wrote:
>>> On 01.04.20 14:56, Christian Borntraeger wrote:
>>>> On 01.04.20 14:50, Jason Wang wrote:
>>>>> On 2020/4/1 =E4=B8=8B=E5=8D=887:21, Christian Borntraeger wrote:
>>>>>> On 26.03.20 15:01, Jason Wang wrote:
>>>>>>> Currently, CONFIG_VHOST depends on CONFIG_VIRTUALIZATION. But vho=
st is
>>>>>>> not necessarily for VM since it's a generic userspace and kernel
>>>>>>> communication protocol. Such dependency may prevent archs without
>>>>>>> virtualization support from using vhost.
>>>>>>>
>>>>>>> To solve this, a dedicated vhost menu is created under drivers so
>>>>>>> CONIFG_VHOST can be decoupled out of CONFIG_VIRTUALIZATION.
>>>>>> FWIW, this now results in vhost not being build with defconfig ker=
nels (in todays
>>>>>> linux-next).
>>>>>>
>>>>> Hi Christian:
>>>>>
>>>>> Did you meet it even with this commit=C2=A0https://git.kernel.org/p=
ub/scm/linux/kernel/git/next/linux-next.git/commit/?id=3Da4be40cbcedba9b5=
b714f3c95182e8a45176e42d?
>>>> I simply used linux-next. The defconfig does NOT contain CONFIG_VHOS=
T and therefore CONFIG_VHOST_NET and friends
>>>> can not be selected.
>>>>
>>>> $ git checkout next-20200401
>>>> $ make defconfig
>>>>     HOSTCC  scripts/basic/fixdep
>>>>     HOSTCC  scripts/kconfig/conf.o
>>>>     HOSTCC  scripts/kconfig/confdata.o
>>>>     HOSTCC  scripts/kconfig/expr.o
>>>>     LEX     scripts/kconfig/lexer.lex.c
>>>>     YACC    scripts/kconfig/parser.tab.[ch]
>>>>     HOSTCC  scripts/kconfig/lexer.lex.o
>>>>     HOSTCC  scripts/kconfig/parser.tab.o
>>>>     HOSTCC  scripts/kconfig/preprocess.o
>>>>     HOSTCC  scripts/kconfig/symbol.o
>>>>     HOSTCC  scripts/kconfig/util.o
>>>>     HOSTLD  scripts/kconfig/conf
>>>> *** Default configuration is based on 'x86_64_defconfig'
>>>> #
>>>> # configuration written to .config
>>>> #
>>>>
>>>> $ grep VHOST .config
>>>> # CONFIG_VHOST is not set
>>>>
>>>>> If yes, what's your build config looks like?
>>>>>
>>>>> Thanks
>>> This was x86. Not sure if that did work before.
>>> On s390 this is definitely a regression as the defconfig files
>>> for s390 do select VHOST_NET
>>>
>>> grep VHOST arch/s390/configs/*
>>> arch/s390/configs/debug_defconfig:CONFIG_VHOST_NET=3Dm
>>> arch/s390/configs/debug_defconfig:CONFIG_VHOST_VSOCK=3Dm
>>> arch/s390/configs/defconfig:CONFIG_VHOST_NET=3Dm
>>> arch/s390/configs/defconfig:CONFIG_VHOST_VSOCK=3Dm
>>>
>>> and this worked with 5.6, but does not work with next. Just adding
>>> CONFIG_VHOST=3Dm to the defconfig solves the issue, something like
>>
>> Right, I think we probably need
>>
>> 1) add CONFIG_VHOST=3Dm to all defconfigs that enables
>> CONFIG_VHOST_NET/VSOCK/SCSI.
>>
>> or
>>
>> 2) don't use menuconfig for CONFIG_VHOST, let NET/SCSI/VDPA just selec=
t it.
>>
>> Thanks
> OK I tried this:
>
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index 2523a1d4290a..a314b900d479 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -19,11 +19,10 @@ menuconfig VHOST
>   	  This option is selected by any driver which needs to access
>   	  the core of vhost.
>  =20
> -if VHOST
> -
>   config VHOST_NET
>   	tristate "Host kernel accelerator for virtio net"
>   	depends on NET && EVENTFD && (TUN || !TUN) && (TAP || !TAP)
> +	select VHOST
>   	---help---
>   	  This kernel module can be loaded in host kernel to accelerate
>   	  guest networking with virtio_net. Not to be confused with virtio_n=
et
> @@ -35,6 +34,7 @@ config VHOST_NET
>   config VHOST_SCSI
>   	tristate "VHOST_SCSI TCM fabric driver"
>   	depends on TARGET_CORE && EVENTFD
> +	select VHOST
>   	default n
>   	---help---
>   	Say M here to enable the vhost_scsi TCM fabric module
> @@ -44,6 +44,7 @@ config VHOST_VSOCK
>   	tristate "vhost virtio-vsock driver"
>   	depends on VSOCKETS && EVENTFD
>   	select VIRTIO_VSOCKETS_COMMON
> +	select VHOST
>   	default n
>   	---help---
>   	This kernel module can be loaded in the host kernel to provide AF_VS=
OCK
> @@ -57,6 +58,7 @@ config VHOST_VDPA
>   	tristate "Vhost driver for vDPA-based backend"
>   	depends on EVENTFD
>   	select VDPA
> +	select VHOST
>   	help
>   	  This kernel module can be loaded in host kernel to accelerate
>   	  guest virtio devices with the vDPA-based backends.
> @@ -78,5 +80,3 @@ config VHOST_CROSS_ENDIAN_LEGACY
>   	  adds some overhead, it is disabled by default.
>  =20
>   	  If unsure, say "N".
> -
> -endif
>
>
> But now CONFIG_VHOST is always "y", never "m".
> Which I think will make it a built-in.
> Didn't figure out why yet.


Is it because the dependency of EVENTFD for CONFIG_VHOST?

Remove that one for this patch, I can get CONFIG_VHOST=3Dm.

But according to documentation/kbuild/kconfig.rst, select is used for=20
option without prompt.

Thanks


>
