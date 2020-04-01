From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V9 1/9] vhost: refine vhost and vringh kconfig
Date: Wed, 1 Apr 2020 22:13:29 +0800
Message-ID: <c423c5b1-7817-7417-d7af-e07bef6368e7@redhat.com>
References: <20200326140125.19794-1-jasowang@redhat.com>
 <20200326140125.19794-2-jasowang@redhat.com>
 <fde312a4-56bd-f11f-799f-8aa952008012@de.ibm.com>
 <41ee1f6a-3124-d44b-bf34-0f26604f9514@redhat.com>
 <4726da4c-11ec-3b6e-1218-6d6d365d5038@de.ibm.com>
 <39b96e3a-9f4e-6e1d-e988-8c4bcfb55879@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <39b96e3a-9f4e-6e1d-e988-8c4bcfb55879@de.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Borntraeger <borntraeger@de.ibm.com>, mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: jgg@mellanox.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, zhangweining@ruijie.com.cn
List-Id: virtualization@lists.linuxfoundation.org


On 2020/4/1 =E4=B8=8B=E5=8D=889:02, Christian Borntraeger wrote:
>
> On 01.04.20 14:56, Christian Borntraeger wrote:
>> On 01.04.20 14:50, Jason Wang wrote:
>>> On 2020/4/1 =E4=B8=8B=E5=8D=887:21, Christian Borntraeger wrote:
>>>> On 26.03.20 15:01, Jason Wang wrote:
>>>>> Currently, CONFIG_VHOST depends on CONFIG_VIRTUALIZATION. But vhost=
 is
>>>>> not necessarily for VM since it's a generic userspace and kernel
>>>>> communication protocol. Such dependency may prevent archs without
>>>>> virtualization support from using vhost.
>>>>>
>>>>> To solve this, a dedicated vhost menu is created under drivers so
>>>>> CONIFG_VHOST can be decoupled out of CONFIG_VIRTUALIZATION.
>>>> FWIW, this now results in vhost not being build with defconfig kerne=
ls (in todays
>>>> linux-next).
>>>>
>>> Hi Christian:
>>>
>>> Did you meet it even with this commit=C2=A0https://git.kernel.org/pub=
/scm/linux/kernel/git/next/linux-next.git/commit/?id=3Da4be40cbcedba9b5b7=
14f3c95182e8a45176e42d?
>> I simply used linux-next. The defconfig does NOT contain CONFIG_VHOST =
and therefore CONFIG_VHOST_NET and friends
>> can not be selected.
>>
>> $ git checkout next-20200401
>> $ make defconfig
>>    HOSTCC  scripts/basic/fixdep
>>    HOSTCC  scripts/kconfig/conf.o
>>    HOSTCC  scripts/kconfig/confdata.o
>>    HOSTCC  scripts/kconfig/expr.o
>>    LEX     scripts/kconfig/lexer.lex.c
>>    YACC    scripts/kconfig/parser.tab.[ch]
>>    HOSTCC  scripts/kconfig/lexer.lex.o
>>    HOSTCC  scripts/kconfig/parser.tab.o
>>    HOSTCC  scripts/kconfig/preprocess.o
>>    HOSTCC  scripts/kconfig/symbol.o
>>    HOSTCC  scripts/kconfig/util.o
>>    HOSTLD  scripts/kconfig/conf
>> *** Default configuration is based on 'x86_64_defconfig'
>> #
>> # configuration written to .config
>> #
>>
>> $ grep VHOST .config
>> # CONFIG_VHOST is not set
>>
>>  =20
>>> If yes, what's your build config looks like?
>>>
>>> Thanks
> This was x86. Not sure if that did work before.
> On s390 this is definitely a regression as the defconfig files
> for s390 do select VHOST_NET
>
> grep VHOST arch/s390/configs/*
> arch/s390/configs/debug_defconfig:CONFIG_VHOST_NET=3Dm
> arch/s390/configs/debug_defconfig:CONFIG_VHOST_VSOCK=3Dm
> arch/s390/configs/defconfig:CONFIG_VHOST_NET=3Dm
> arch/s390/configs/defconfig:CONFIG_VHOST_VSOCK=3Dm
>
> and this worked with 5.6, but does not work with next. Just adding
> CONFIG_VHOST=3Dm to the defconfig solves the issue, something like


Right, I think we probably need

1) add CONFIG_VHOST=3Dm to all defconfigs that enables=20
CONFIG_VHOST_NET/VSOCK/SCSI.

or

2) don't use menuconfig for CONFIG_VHOST, let NET/SCSI/VDPA just select i=
t.

Thanks


>
> ---
>   arch/s390/configs/debug_defconfig | 5 +++--
>   arch/s390/configs/defconfig       | 5 +++--
>   2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debu=
g_defconfig
> index 46038bc58c9e..0b83274341ce 100644
> --- a/arch/s390/configs/debug_defconfig
> +++ b/arch/s390/configs/debug_defconfig
> @@ -57,8 +57,6 @@ CONFIG_PROTECTED_VIRTUALIZATION_GUEST=3Dy
>   CONFIG_CMM=3Dm
>   CONFIG_APPLDATA_BASE=3Dy
>   CONFIG_KVM=3Dm
> -CONFIG_VHOST_NET=3Dm
> -CONFIG_VHOST_VSOCK=3Dm
>   CONFIG_OPROFILE=3Dm
>   CONFIG_KPROBES=3Dy
>   CONFIG_JUMP_LABEL=3Dy
> @@ -561,6 +559,9 @@ CONFIG_VFIO_MDEV_DEVICE=3Dm
>   CONFIG_VIRTIO_PCI=3Dm
>   CONFIG_VIRTIO_BALLOON=3Dm
>   CONFIG_VIRTIO_INPUT=3Dy
> +CONFIG_VHOST=3Dm
> +CONFIG_VHOST_NET=3Dm
> +CONFIG_VHOST_VSOCK=3Dm
>   CONFIG_S390_CCW_IOMMU=3Dy
>   CONFIG_S390_AP_IOMMU=3Dy
>   CONFIG_EXT4_FS=3Dy
> diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
> index 7cd0648c1f4e..39e69c4e8cf7 100644
> --- a/arch/s390/configs/defconfig
> +++ b/arch/s390/configs/defconfig
> @@ -57,8 +57,6 @@ CONFIG_PROTECTED_VIRTUALIZATION_GUEST=3Dy
>   CONFIG_CMM=3Dm
>   CONFIG_APPLDATA_BASE=3Dy
>   CONFIG_KVM=3Dm
> -CONFIG_VHOST_NET=3Dm
> -CONFIG_VHOST_VSOCK=3Dm
>   CONFIG_OPROFILE=3Dm
>   CONFIG_KPROBES=3Dy
>   CONFIG_JUMP_LABEL=3Dy
> @@ -557,6 +555,9 @@ CONFIG_VFIO_MDEV_DEVICE=3Dm
>   CONFIG_VIRTIO_PCI=3Dm
>   CONFIG_VIRTIO_BALLOON=3Dm
>   CONFIG_VIRTIO_INPUT=3Dy
> +CONFIG_VHOST=3Dm
> +CONFIG_VHOST_NET=3Dm
> +CONFIG_VHOST_VSOCK=3Dm
>   CONFIG_S390_CCW_IOMMU=3Dy
>   CONFIG_S390_AP_IOMMU=3Dy
>   CONFIG_EXT4_FS=3Dy
