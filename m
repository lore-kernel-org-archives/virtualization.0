From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH V9 1/9] vhost: refine vhost and vringh kconfig
Date: Wed, 1 Apr 2020 15:02:00 +0200
Message-ID: <39b96e3a-9f4e-6e1d-e988-8c4bcfb55879@de.ibm.com>
References: <20200326140125.19794-1-jasowang@redhat.com>
 <20200326140125.19794-2-jasowang@redhat.com>
 <fde312a4-56bd-f11f-799f-8aa952008012@de.ibm.com>
 <41ee1f6a-3124-d44b-bf34-0f26604f9514@redhat.com>
 <4726da4c-11ec-3b6e-1218-6d6d365d5038@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4726da4c-11ec-3b6e-1218-6d6d365d5038@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: jgg@mellanox.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, zhangweining@ruijie.com.cn
List-Id: virtualization@lists.linuxfoundation.org



On 01.04.20 14:56, Christian Borntraeger wrote:
> 
> On 01.04.20 14:50, Jason Wang wrote:
>>
>> On 2020/4/1 下午7:21, Christian Borntraeger wrote:
>>> On 26.03.20 15:01, Jason Wang wrote:
>>>> Currently, CONFIG_VHOST depends on CONFIG_VIRTUALIZATION. But vhost is
>>>> not necessarily for VM since it's a generic userspace and kernel
>>>> communication protocol. Such dependency may prevent archs without
>>>> virtualization support from using vhost.
>>>>
>>>> To solve this, a dedicated vhost menu is created under drivers so
>>>> CONIFG_VHOST can be decoupled out of CONFIG_VIRTUALIZATION.
>>> FWIW, this now results in vhost not being build with defconfig kernels (in todays
>>> linux-next).
>>>
>>
>> Hi Christian:
>>
>> Did you meet it even with this commit https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=a4be40cbcedba9b5b714f3c95182e8a45176e42d?
> 
> I simply used linux-next. The defconfig does NOT contain CONFIG_VHOST and therefore CONFIG_VHOST_NET and friends
> can not be selected.
> 
> $ git checkout next-20200401
> $ make defconfig
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTCC  scripts/kconfig/confdata.o
>   HOSTCC  scripts/kconfig/expr.o
>   LEX     scripts/kconfig/lexer.lex.c
>   YACC    scripts/kconfig/parser.tab.[ch]
>   HOSTCC  scripts/kconfig/lexer.lex.o
>   HOSTCC  scripts/kconfig/parser.tab.o
>   HOSTCC  scripts/kconfig/preprocess.o
>   HOSTCC  scripts/kconfig/symbol.o
>   HOSTCC  scripts/kconfig/util.o
>   HOSTLD  scripts/kconfig/conf
> *** Default configuration is based on 'x86_64_defconfig'
> #
> # configuration written to .config
> #
> 
> $ grep VHOST .config
> # CONFIG_VHOST is not set
> 
>  
>> If yes, what's your build config looks like?
>>
>> Thanks

This was x86. Not sure if that did work before.
On s390 this is definitely a regression as the defconfig files 
for s390 do select VHOST_NET

grep VHOST arch/s390/configs/*
arch/s390/configs/debug_defconfig:CONFIG_VHOST_NET=m
arch/s390/configs/debug_defconfig:CONFIG_VHOST_VSOCK=m
arch/s390/configs/defconfig:CONFIG_VHOST_NET=m
arch/s390/configs/defconfig:CONFIG_VHOST_VSOCK=m

and this worked with 5.6, but does not work with next. Just adding
CONFIG_VHOST=m to the defconfig solves the issue, something like

---
 arch/s390/configs/debug_defconfig | 5 +++--
 arch/s390/configs/defconfig       | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 46038bc58c9e..0b83274341ce 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -57,8 +57,6 @@ CONFIG_PROTECTED_VIRTUALIZATION_GUEST=y
 CONFIG_CMM=m
 CONFIG_APPLDATA_BASE=y
 CONFIG_KVM=m
-CONFIG_VHOST_NET=m
-CONFIG_VHOST_VSOCK=m
 CONFIG_OPROFILE=m
 CONFIG_KPROBES=y
 CONFIG_JUMP_LABEL=y
@@ -561,6 +559,9 @@ CONFIG_VFIO_MDEV_DEVICE=m
 CONFIG_VIRTIO_PCI=m
 CONFIG_VIRTIO_BALLOON=m
 CONFIG_VIRTIO_INPUT=y
+CONFIG_VHOST=m
+CONFIG_VHOST_NET=m
+CONFIG_VHOST_VSOCK=m
 CONFIG_S390_CCW_IOMMU=y
 CONFIG_S390_AP_IOMMU=y
 CONFIG_EXT4_FS=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 7cd0648c1f4e..39e69c4e8cf7 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -57,8 +57,6 @@ CONFIG_PROTECTED_VIRTUALIZATION_GUEST=y
 CONFIG_CMM=m
 CONFIG_APPLDATA_BASE=y
 CONFIG_KVM=m
-CONFIG_VHOST_NET=m
-CONFIG_VHOST_VSOCK=m
 CONFIG_OPROFILE=m
 CONFIG_KPROBES=y
 CONFIG_JUMP_LABEL=y
@@ -557,6 +555,9 @@ CONFIG_VFIO_MDEV_DEVICE=m
 CONFIG_VIRTIO_PCI=m
 CONFIG_VIRTIO_BALLOON=m
 CONFIG_VIRTIO_INPUT=y
+CONFIG_VHOST=m
+CONFIG_VHOST_NET=m
+CONFIG_VHOST_VSOCK=m
 CONFIG_S390_CCW_IOMMU=y
 CONFIG_S390_AP_IOMMU=y
 CONFIG_EXT4_FS=y
-- 
2.25.1
