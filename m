Return-Path: <SRS0=oZaN=JI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79638C433B4
	for <virtualization@archiver.kernel.org>; Sun, 11 Apr 2021 13:43:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E562E61284
	for <virtualization@archiver.kernel.org>; Sun, 11 Apr 2021 13:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E562E61284
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A2C324039A;
	Sun, 11 Apr 2021 13:43:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2WFuZ-yE3ksw; Sun, 11 Apr 2021 13:43:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id F0A5F40384;
	Sun, 11 Apr 2021 13:43:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA683C000C;
	Sun, 11 Apr 2021 13:43:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5D6EC000A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Apr 2021 13:43:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B93F840314
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Apr 2021 13:43:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 48utmOoJEe31
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Apr 2021 13:43:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0FC4F40278
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Apr 2021 13:43:31 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 101-20020a9d0d6e0000b02902816815ff62so4393849oti.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Apr 2021 06:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=lm+1nTaYK0Xy0VBQZoYewHuPGWgicxcLAhpQXk24OCg=;
 b=CVIJXiiDUr8PL/5Ixh8UAbh6yKZZax74ZJrBVS7JnXLyy6uD7kTDqxShdpVPRAaOsn
 bXcFYKSfu6KYE0ed+tX/eC5xm2EPaf63fNu4di7cWdIb5Um0du+v8yy5V/umzr5nb8CB
 zmYU+jd3gmZeyICeOweOsA5IWp/z3e2kcLxxXbWSYCTJcOd79yASV0+OsP/E/7zFCAmt
 F925zRZ6kUqtmY431xp4UICFaKPNmaflmEn+I97k9XQN0uqOqWcCYTBYVhiz0d3D7pPb
 S5QE3s8b8TJgBWynbUcDPbT7J/edVYlQNYvnx28avt29VU5P5t0HYFiZycJEllCOKncV
 zQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=lm+1nTaYK0Xy0VBQZoYewHuPGWgicxcLAhpQXk24OCg=;
 b=BYy7Ke06CqGc//J+r3L0zyHO+5Hjr8MYbphAHYSkBAj/CaQegBjFleKCNFO7GJBH23
 OO+NwANu4/yL5CROZYeu0rugNlgmTxY49sMA9rUEXNYDnFqaKpJyz/ZTw7FKMni6Eo8i
 S/g6eUf7pjMOMkj5BD1LRKLzVIdhA+f7Hi48sebZQdPI6IAAOaMBW1vjD0dpiwXyKQJ0
 H4fWXz4gkSsIvSA/C/xhbCoKdezNSelp9zCOG35LYnAchUg3qxdRQOaxPf7Cydq3PxSN
 mKWYtr4xHMEfQAMMvt5ydYiy80n536HxlBIGwiTN0atBuHz9tdX6Q8U5JB3INjJgGcWe
 cM7Q==
X-Gm-Message-State: AOAM5325G73/yS1bm4aALdbooL9i9iXQ/O1K39tqs9UOkYSvGzIB58M/
 bGkS1cV2fZc7ymZuS/OgUNE=
X-Google-Smtp-Source: ABdhPJwAozvf1G1HqH3L43wb65DJ03RA8xcRrwE8l+RLh042wnhBVDu3NxsCz+Zn+jLBg4JsbARVjg==
X-Received: by 2002:a9d:e87:: with SMTP id 7mr13463102otj.324.1618148611034;
 Sun, 11 Apr 2021 06:43:31 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id 103sm1574969otj.41.2021.04.11.06.43.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 11 Apr 2021 06:43:30 -0700 (PDT)
Date: Sun, 11 Apr 2021 06:43:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH net] virtio_net: Do not pull payload in skb->head
Message-ID: <20210411134329.GA132317@roeck-us.net>
References: <20210402132602.3659282-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210402132602.3659282-1-eric.dumazet@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi,

On Fri, Apr 02, 2021 at 06:26:02AM -0700, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> Xuan Zhuo reported that commit 3226b158e67c ("net: avoid 32 x truesize
> under-estimation for tiny skbs") brought  a ~10% performance drop.
> 
> The reason for the performance drop was that GRO was forced
> to chain sk_buff (using skb_shinfo(skb)->frag_list), which
> uses more memory but also cause packet consumers to go over
> a lot of overhead handling all the tiny skbs.
> 
> It turns out that virtio_net page_to_skb() has a wrong strategy :
> It allocates skbs with GOOD_COPY_LEN (128) bytes in skb->head, then
> copies 128 bytes from the page, before feeding the packet to GRO stack.
> 
> This was suboptimal before commit 3226b158e67c ("net: avoid 32 x truesize
> under-estimation for tiny skbs") because GRO was using 2 frags per MSS,
> meaning we were not packing MSS with 100% efficiency.
> 
> Fix is to pull only the ethernet header in page_to_skb()
> 
> Then, we change virtio_net_hdr_to_skb() to pull the missing
> headers, instead of assuming they were already pulled by callers.
> 
> This fixes the performance regression, but could also allow virtio_net
> to accept packets with more than 128bytes of headers.
> 
> Many thanks to Xuan Zhuo for his report, and his tests/help.
> 
> Fixes: 3226b158e67c ("net: avoid 32 x truesize under-estimation for tiny skbs")
> Reported-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Link: https://www.spinics.net/lists/netdev/msg731397.html
> Co-Developed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: virtualization@lists.linux-foundation.org

This patch causes a virtio-net interface failure when booting sh4 images
in qemu. The test case is nothing special: Just try to get an IP address
using udhcpc. If it fails, udhcpc reports:

udhcpc: started, v1.33.0
udhcpc: sending discover
FAIL

After the failure, ifconfig shows no error:

eth0      Link encap:Ethernet  HWaddr 52:54:00:12:34:56
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:1 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:590 (590.0 B)  TX bytes:342 (342.0 B)

This happens with almost every boot. The problem disappears after reverting
this patch.

Guenter

---
bisect log:
# bad: [52e44129fba5cfc4e351fdb5e45849afc74d9a53] Merge branch 'for-5.12-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu
# good: [f40ddce88593482919761f74910f42f4b84c004b] Linux 5.11
git bisect start 'HEAD' 'v5.11'
# good: [d99676af540c2dc829999928fb81c58c80a1dce4] Merge tag 'drm-next-2021-02-19' of git://anongit.freedesktop.org/drm/drm
git bisect good d99676af540c2dc829999928fb81c58c80a1dce4
# good: [c4fbde84fedeaf513ec96f0c6ed3f352bdcd61d6] Merge tag 'sfi-removal-5.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect good c4fbde84fedeaf513ec96f0c6ed3f352bdcd61d6
# good: [b1dd9bf688b0dcc5a34dca660de46c7570bd9243] net: phy: broadcom: Fix RGMII delays for BCM50160 and BCM50610M
git bisect good b1dd9bf688b0dcc5a34dca660de46c7570bd9243
# good: [e138138003eb3b3d06cc91cf2e8c5dec77e2a31e] Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect good e138138003eb3b3d06cc91cf2e8c5dec77e2a31e
# good: [dbaa5d1c254e1b565caee9ac7b526a9b7267d4c4] Merge branch 'parisc-5.12-3' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
git bisect good dbaa5d1c254e1b565caee9ac7b526a9b7267d4c4
# bad: [1ffbc7ea91606e4abd10eb60de5367f1c86daf5e] net: sched: sch_teql: fix null-pointer dereference
git bisect bad 1ffbc7ea91606e4abd10eb60de5367f1c86daf5e
# good: [9256ce33110174decc04caf6ef733409012e5b1c] Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
git bisect good 9256ce33110174decc04caf6ef733409012e5b1c
# bad: [3cf1482852825bdf8cc4e4f09346262c80ad5cbe] Merge branch 'ethtool-link_mode'
git bisect bad 3cf1482852825bdf8cc4e4f09346262c80ad5cbe
# bad: [0f6925b3e8da0dbbb52447ca8a8b42b371aac7db] virtio_net: Do not pull payload in skb->head
git bisect bad 0f6925b3e8da0dbbb52447ca8a8b42b371aac7db
# good: [6dcc4e38386950abf9060784631622dfc4df9577] Merge branch 'AF_XDP Socket Creation Fixes'
git bisect good 6dcc4e38386950abf9060784631622dfc4df9577
# good: [630e4576f83accf90366686f39808d665d8dbecc] net-ipv6: bugfix - raw & sctp - switch to ipv6_can_nonlocal_bind()
git bisect good 630e4576f83accf90366686f39808d665d8dbecc
# good: [22f69de18ee86e81dc41253869e5dd963ccea429] Merge branch 'hns3-fixes'
git bisect good 22f69de18ee86e81dc41253869e5dd963ccea429
# good: [b25b343db0526669947a427e9a31bac91d29bb06] net: broadcom: bcm4908enet: Fix a double free in bcm4908_enet_dma_alloc
git bisect good b25b343db0526669947a427e9a31bac91d29bb06
# first bad commit: [0f6925b3e8da0dbbb52447ca8a8b42b371aac7db] virtio_net: Do not pull payload in skb->head

---
qemu command line:

qemu-system-sh4 -M r2d -kernel ./arch/sh/boot/zImage -no-reboot \
	-snapshot \
	-drive file=rootfs.ext2,format=raw,if=ide \
	-device virtio-net,netdev=net0 -netdev user,id=net0 \
	-append "root=/dev/sda console=ttySC1,115200 earlycon=scif,mmio16,0xffe80000 noiotrap" \
	-serial null -serial stdio -nographic -monitor null

The root file system is
	https://github.com/groeck/linux-build-test/blob/master/rootfs/sh/rootfs.ext2.gz
It was generated with buildroot version 2021.02.

To reproduce the problem, just run the qemu command and look for "Network
interface test [passed|failed]".

AFAICS any qemu version can be used to reproduce the problem.

---
defconfig:

CONFIG_SYSVIPC=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_BLK_DEV_INITRD=y
CONFIG_SLAB=y
CONFIG_PROFILING=y
CONFIG_CPU_SUBTYPE_SH7751R=y
CONFIG_MEMORY_START=0x0c000000
CONFIG_SH_RTS7751R2D=y
CONFIG_RTS7751R2D_PLUS=y
CONFIG_HEARTBEAT=y
CONFIG_MODULES=y
CONFIG_FLATMEM_MANUAL=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IPV6 is not set
CONFIG_PCI=y
CONFIG_HOTPLUG_PCI=y
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_MTD=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_BLOCK=y
CONFIG_MTD_CFI=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_PHYSMAP=y
CONFIG_BLK_DEV_RAM=y
CONFIG_VIRTIO_BLK=y
CONFIG_BLK_DEV_NVME=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=y
CONFIG_MEGARAID_SAS=y
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_DC395x=y
CONFIG_SCSI_AM53C974=y
CONFIG_SCSI_VIRTIO=y
CONFIG_ATA=y
CONFIG_PATA_PLATFORM=y
CONFIG_FUSION=y
CONFIG_FUSION_SAS=y
CONFIG_NETDEVICES=y
CONFIG_VIRTIO_NET=y
CONFIG_PCNET32=y
CONFIG_NET_TULIP=y
CONFIG_TULIP=y
CONFIG_E100=y
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_NE2K_PCI=y
CONFIG_8139CP=y
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
CONFIG_USB_USBNET=y
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_SERIO is not set
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_SH_SCI=y
CONFIG_HW_RANDOM=y
CONFIG_SPI=y
CONFIG_SPI_SH_SCI=y
# CONFIG_PTP_1588_CLOCK is not set
CONFIG_MFD_SM501=y
CONFIG_FB=y
CONFIG_FB_SH_MOBILE_LCDC=m
CONFIG_FB_SM501=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
# CONFIG_LOGO_LINUX_CLUT224 is not set
# CONFIG_LOGO_SUPERH_MONO is not set
# CONFIG_LOGO_SUPERH_VGA16 is not set
CONFIG_SOUND=y
CONFIG_SND=m
CONFIG_SND_YMFPCI=m
CONFIG_HID_GYRATION=y
CONFIG_HID_PANTHERLORD=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_SAMSUNG=y
CONFIG_HID_SUNPLUS=y
CONFIG_USB=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_STORAGE=y
CONFIG_USB_UAS=y
CONFIG_MMC=y
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_PCI=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_DRV_R9701=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_MMIO=y
CONFIG_EXT2_FS=y
CONFIG_ISO9660_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_PROC_KCORE=y
CONFIG_TMPFS=y
CONFIG_MINIX_FS=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_CRC_T10DIF=y
CONFIG_DEBUG_FS=y
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
