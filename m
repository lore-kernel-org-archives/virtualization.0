From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V9 1/9] vhost: refine vhost and vringh kconfig
Date: Wed, 1 Apr 2020 10:27:24 -0400
Message-ID: <20200401102631-mutt-send-email-mst@kernel.org>
References: <20200326140125.19794-1-jasowang@redhat.com>
 <20200326140125.19794-2-jasowang@redhat.com>
 <fde312a4-56bd-f11f-799f-8aa952008012@de.ibm.com>
 <41ee1f6a-3124-d44b-bf34-0f26604f9514@redhat.com>
 <4726da4c-11ec-3b6e-1218-6d6d365d5038@de.ibm.com>
 <39b96e3a-9f4e-6e1d-e988-8c4bcfb55879@de.ibm.com>
 <c423c5b1-7817-7417-d7af-e07bef6368e7@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c423c5b1-7817-7417-d7af-e07bef6368e7@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, jgg@mellanox.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, zhangweining@ruijie.com.cn
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 01, 2020 at 10:13:29PM +0800, Jason Wang wrote:
> 
> On 2020/4/1 下午9:02, Christian Borntraeger wrote:
> > 
> > On 01.04.20 14:56, Christian Borntraeger wrote:
> > > On 01.04.20 14:50, Jason Wang wrote:
> > > > On 2020/4/1 下午7:21, Christian Borntraeger wrote:
> > > > > On 26.03.20 15:01, Jason Wang wrote:
> > > > > > Currently, CONFIG_VHOST depends on CONFIG_VIRTUALIZATION. But vhost is
> > > > > > not necessarily for VM since it's a generic userspace and kernel
> > > > > > communication protocol. Such dependency may prevent archs without
> > > > > > virtualization support from using vhost.
> > > > > > 
> > > > > > To solve this, a dedicated vhost menu is created under drivers so
> > > > > > CONIFG_VHOST can be decoupled out of CONFIG_VIRTUALIZATION.
> > > > > FWIW, this now results in vhost not being build with defconfig kernels (in todays
> > > > > linux-next).
> > > > > 
> > > > Hi Christian:
> > > > 
> > > > Did you meet it even with this commit https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=a4be40cbcedba9b5b714f3c95182e8a45176e42d?
> > > I simply used linux-next. The defconfig does NOT contain CONFIG_VHOST and therefore CONFIG_VHOST_NET and friends
> > > can not be selected.
> > > 
> > > $ git checkout next-20200401
> > > $ make defconfig
> > >    HOSTCC  scripts/basic/fixdep
> > >    HOSTCC  scripts/kconfig/conf.o
> > >    HOSTCC  scripts/kconfig/confdata.o
> > >    HOSTCC  scripts/kconfig/expr.o
> > >    LEX     scripts/kconfig/lexer.lex.c
> > >    YACC    scripts/kconfig/parser.tab.[ch]
> > >    HOSTCC  scripts/kconfig/lexer.lex.o
> > >    HOSTCC  scripts/kconfig/parser.tab.o
> > >    HOSTCC  scripts/kconfig/preprocess.o
> > >    HOSTCC  scripts/kconfig/symbol.o
> > >    HOSTCC  scripts/kconfig/util.o
> > >    HOSTLD  scripts/kconfig/conf
> > > *** Default configuration is based on 'x86_64_defconfig'
> > > #
> > > # configuration written to .config
> > > #
> > > 
> > > $ grep VHOST .config
> > > # CONFIG_VHOST is not set
> > > 
> > > > If yes, what's your build config looks like?
> > > > 
> > > > Thanks
> > This was x86. Not sure if that did work before.
> > On s390 this is definitely a regression as the defconfig files
> > for s390 do select VHOST_NET
> > 
> > grep VHOST arch/s390/configs/*
> > arch/s390/configs/debug_defconfig:CONFIG_VHOST_NET=m
> > arch/s390/configs/debug_defconfig:CONFIG_VHOST_VSOCK=m
> > arch/s390/configs/defconfig:CONFIG_VHOST_NET=m
> > arch/s390/configs/defconfig:CONFIG_VHOST_VSOCK=m
> > 
> > and this worked with 5.6, but does not work with next. Just adding
> > CONFIG_VHOST=m to the defconfig solves the issue, something like
> 
> 
> Right, I think we probably need
> 
> 1) add CONFIG_VHOST=m to all defconfigs that enables
> CONFIG_VHOST_NET/VSOCK/SCSI.
> 
> or
> 
> 2) don't use menuconfig for CONFIG_VHOST, let NET/SCSI/VDPA just select it.
> 
> Thanks

OK I tried this:

diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index 2523a1d4290a..a314b900d479 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -19,11 +19,10 @@ menuconfig VHOST
 	  This option is selected by any driver which needs to access
 	  the core of vhost.
 
-if VHOST
-
 config VHOST_NET
 	tristate "Host kernel accelerator for virtio net"
 	depends on NET && EVENTFD && (TUN || !TUN) && (TAP || !TAP)
+	select VHOST
 	---help---
 	  This kernel module can be loaded in host kernel to accelerate
 	  guest networking with virtio_net. Not to be confused with virtio_net
@@ -35,6 +34,7 @@ config VHOST_NET
 config VHOST_SCSI
 	tristate "VHOST_SCSI TCM fabric driver"
 	depends on TARGET_CORE && EVENTFD
+	select VHOST
 	default n
 	---help---
 	Say M here to enable the vhost_scsi TCM fabric module
@@ -44,6 +44,7 @@ config VHOST_VSOCK
 	tristate "vhost virtio-vsock driver"
 	depends on VSOCKETS && EVENTFD
 	select VIRTIO_VSOCKETS_COMMON
+	select VHOST
 	default n
 	---help---
 	This kernel module can be loaded in the host kernel to provide AF_VSOCK
@@ -57,6 +58,7 @@ config VHOST_VDPA
 	tristate "Vhost driver for vDPA-based backend"
 	depends on EVENTFD
 	select VDPA
+	select VHOST
 	help
 	  This kernel module can be loaded in host kernel to accelerate
 	  guest virtio devices with the vDPA-based backends.
@@ -78,5 +80,3 @@ config VHOST_CROSS_ENDIAN_LEGACY
 	  adds some overhead, it is disabled by default.
 
 	  If unsure, say "N".
-
-endif


But now CONFIG_VHOST is always "y", never "m".
Which I think will make it a built-in.
Didn't figure out why yet.

-- 
MST
