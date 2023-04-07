Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7DAC761A6
	for <virtualization@archiver.kernel.org>; Fri,  7 Apr 2023 03:20:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D2C8A60F51;
	Fri,  7 Apr 2023 03:20:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D2C8A60F51
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oYEtNh8_m0Al; Fri,  7 Apr 2023 03:20:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3A2A760F79;
	Fri,  7 Apr 2023 03:20:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A2A760F79
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFC23C0037;
	Fri,  7 Apr 2023 03:20:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03E31C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 03:20:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DDBF641ED5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 03:20:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DDBF641ED5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IEErWcANhRHK
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 03:20:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 79AF541ECB
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 79AF541ECB
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 03:20:31 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VfV9Dvw_1680837625; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VfV9Dvw_1680837625) by smtp.aliyun-inc.com;
 Fri, 07 Apr 2023 11:20:25 +0800
Message-ID: <1680837458.7467153-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v6 08/11] virtio_ring: introduce virtqueue_dma_dev()
Date: Fri, 7 Apr 2023 11:17:38 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Guenter Roeck <linux@roeck-us.net>
References: <20230327040536.48338-1-xuanzhuo@linux.alibaba.com>
 <20230327040536.48338-9-xuanzhuo@linux.alibaba.com>
 <73a24f95-b779-44ac-be28-45b35d1bf540@roeck-us.net>
In-Reply-To: <73a24f95-b779-44ac-be28-45b35d1bf540@roeck-us.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, 6 Apr 2023 10:20:09 -0700, Guenter Roeck <linux@roeck-us.net> wrote:
> Hi,
>
> On Mon, Mar 27, 2023 at 12:05:33PM +0800, Xuan Zhuo wrote:
> > Added virtqueue_dma_dev() to get DMA device for virtio. Then the
> > caller can do dma operation in advance. The purpose is to keep memory
> > mapped across multiple add/get buf operations.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
>
> On sparc64, this patch results in
>
> [    4.364643] Unable to handle kernel NULL pointer dereference
> [    4.365157] tsk->{mm,active_mm}->context = 0000000000000000
> [    4.365394] tsk->{mm,active_mm}->pgd = fffff80000402000
> [    4.365611]               \|/ ____ \|/
> [    4.365611]               "@'/ .. \`@"
> [    4.365611]               /_| \__/ |_\
> [    4.365611]                  \__U_/
> [    4.366165] swapper/0(1): Oops [#1]
> [    4.366630] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                 N 6.3.0-rc5-next-20230405 #1
> [    4.367121] TSTATE: 0000004411001606 TPC: 00000000004375c0 TNPC: 00000000004375c4 Y: 00000002    Tainted: G                 N
> [    4.367548] TPC: <dma_4u_supported+0x20/0x40>
> [    4.368111] g0: 0000000000000000 g1: 0000000001a93a50 g2: 0000000000000000 g3: 0000000001a96170
> [    4.368439] g4: fffff8000416e9a0 g5: fffff8001dc98000 g6: fffff80004170000 g7: 0000000000000005
> [    4.368769] o0: 0000000000000000 o1: ffffffffffffffff o2: 0000000000000001 o3: fffff800040b78d8
> [    4.369095] o4: 0000000000000000 o5: 0000000000000000 sp: fffff80004172d51 ret_pc: 00000000004375ac
> [    4.369934] RPC: <dma_4u_supported+0xc/0x40>
> [    4.370160] l0: 0000000000000002 l1: 0000000000000002 l2: 0000000000000000 l3: 00000000ffffffff
> [    4.370493] l4: 0000000000000001 l5: 000000000119d2b0 l6: fffff8000416e9a0 l7: 00000000018df000
> [    4.370820] i0: 0000000000000001 i1: ffffffffffffffff i2: fffff80004657758 i3: 000000000125ac00
> [    4.371145] i4: 0000000002362400 i5: 0000000000000000 i6: fffff80004172e01 i7: 000000000050e288
> [    4.371473] I7: <dma_set_mask+0x28/0x80>
> [    4.371683] Call Trace:
> [    4.371864] [<000000000050e288>] dma_set_mask+0x28/0x80
> [    4.372123] [<0000000000a83234>] virtio_dev_probe+0x14/0x400
> [    4.372348] [<0000000000ac7a18>] really_probe+0xb8/0x340
> [    4.372555] [<0000000000ac7d64>] driver_probe_device+0x24/0x120
> [    4.372794] [<0000000000ac8010>] __driver_attach+0x90/0x1a0
> [    4.373012] [<0000000000ac5b4c>] bus_for_each_dev+0x4c/0xa0
> [    4.373226] [<0000000000ac6d80>] bus_add_driver+0x140/0x1e0
> [    4.373440] [<0000000000ac8d94>] driver_register+0x74/0x120
> [    4.373653] [<0000000001b2a690>] virtio_net_driver_init+0x74/0xa8
> [    4.373886] [<0000000000427ee0>] do_one_initcall+0x60/0x340
> [    4.374099] [<0000000001b02f50>] kernel_init_freeable+0x1bc/0x228
> [    4.374330] [<0000000000f37264>] kernel_init+0x18/0x134
> [    4.374534] [<00000000004060e8>] ret_from_fork+0x1c/0x2c
> [    4.374738] [<0000000000000000>] 0x0
> [    4.374981] Disabling lock debugging due to kernel taint
> [    4.375237] Caller[000000000050e288]: dma_set_mask+0x28/0x80
> [    4.375477] Caller[0000000000a83234]: virtio_dev_probe+0x14/0x400
> [    4.375704] Caller[0000000000ac7a18]: really_probe+0xb8/0x340
> [    4.375916] Caller[0000000000ac7d64]: driver_probe_device+0x24/0x120
> [    4.376146] Caller[0000000000ac8010]: __driver_attach+0x90/0x1a0
> [    4.376365] Caller[0000000000ac5b4c]: bus_for_each_dev+0x4c/0xa0
> [    4.376583] Caller[0000000000ac6d80]: bus_add_driver+0x140/0x1e0
> [    4.376805] Caller[0000000000ac8d94]: driver_register+0x74/0x120
> [    4.377025] Caller[0000000001b2a690]: virtio_net_driver_init+0x74/0xa8
> [    4.377262] Caller[0000000000427ee0]: do_one_initcall+0x60/0x340
> [    4.377480] Caller[0000000001b02f50]: kernel_init_freeable+0x1bc/0x228
> [    4.377721] Caller[0000000000f37264]: kernel_init+0x18/0x134
> [    4.377930] Caller[00000000004060e8]: ret_from_fork+0x1c/0x2c
> [    4.378140] Caller[0000000000000000]: 0x0
> [    4.378309] Instruction DUMP:
> [    4.378339]  80a22000
> [    4.378556]  12400006
> [    4.378654]  b0102001
> [    4.378746] <c2076658>
> [    4.378838]  b0102000
> [    4.378930]  80a04019
> [    4.379022]  b1653001
> [    4.379115]  81cfe008
> [    4.379507]  913a2000
> [    4.379617]
> [    4.380504] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
>
> Reverting it fixes the problem. Bisect log attached.
>
> The reason is that dma_supported() calls dma_4u_supported(), which
> expects that dev->archdata.iommu has been initialized. However,
> this is not the case for the virtio device. Result is a null pointer
> dereference in dma_4u_supported().
>
> static int dma_4u_supported(struct device *dev, u64 device_mask)
> {
>         struct iommu *iommu = dev->archdata.iommu;
>
>         if (ali_sound_dma_hack(dev, device_mask))
>                 return 1;
>
>         if (device_mask < iommu->dma_addr_mask)
> 	                  ^^^^^^^^^^^^^^^^^^^^ Crash location
>                 return 0;
>         return 1;
> }

sparc64 does not support direct dma?

The virtio is a virtul device based on pci.

Do you know how we should adapt to sparc64?

Thanks.


>
> Guenter
>
> ---
> # bad: [8417c8f5007bf4567ccffda850a3157c7d905f67] Add linux-next specific files for 20230405
> # good: [7e364e56293bb98cae1b55fd835f5991c4e96e7d] Linux 6.3-rc5
> git bisect start 'HEAD' 'v6.3-rc5'
> # good: [699c146eb5a03458f29e94cfde4d7dd7a36deeb4] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
> git bisect good 699c146eb5a03458f29e94cfde4d7dd7a36deeb4
> # good: [efe74e6476a9f04263288009910f07a26597386f] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git
> git bisect good efe74e6476a9f04263288009910f07a26597386f
> # good: [24be607eedb226c1627973190a0b65cab39440b9] Merge branch 'char-misc-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> git bisect good 24be607eedb226c1627973190a0b65cab39440b9
> # good: [5213285e3f212cf266c085c1c11041adda2bc63f] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git
> git bisect good 5213285e3f212cf266c085c1c11041adda2bc63f
> # bad: [e8f5d7e1787104da5977773ba5b3e1d502fdb9e3] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
> git bisect bad e8f5d7e1787104da5977773ba5b3e1d502fdb9e3
> # bad: [c08b5ad3300122790cef1bf7c1f51c554c778e4d] Merge branch 'gpio/for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
> git bisect bad c08b5ad3300122790cef1bf7c1f51c554c778e4d
> # good: [4ea0c97776bf8c63805eb0f8182d9c20072219d9] gpiolib: Check array_info for NULL only once in gpiod_get_array()
> git bisect good 4ea0c97776bf8c63805eb0f8182d9c20072219d9
> # good: [b8e4bb0f05bef8334e689618c75cfed122f3a292] vdpa_sim: use kthread worker
> git bisect good b8e4bb0f05bef8334e689618c75cfed122f3a292
> # bad: [ac1fa106f52a3ea2d2718a0de7d532d3d6c03e4e] Merge branch 'linux-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
> git bisect bad ac1fa106f52a3ea2d2718a0de7d532d3d6c03e4e
> # good: [56c8cf37fb0800ad66c926eb3d044e50691afa6e] virtio_ring: packed: separate dma codes
> git bisect good 56c8cf37fb0800ad66c926eb3d044e50691afa6e
> # good: [f19986b93ab7aa23f76dedf9fd8657f865324f78] virtio_ring: update document for virtqueue_add_*
> git bisect good f19986b93ab7aa23f76dedf9fd8657f865324f78
> # bad: [60602b367dc928e2b3d6c1f21df5d05f90e37fa3] virtio_ring: correct the expression of the description of virtqueue_resize()
> git bisect bad 60602b367dc928e2b3d6c1f21df5d05f90e37fa3
> # bad: [3a06353479111e1c9e072825bb0d0730e3a0f4e7] virtio_ring: introduce virtqueue_dma_dev()
> git bisect bad 3a06353479111e1c9e072825bb0d0730e3a0f4e7
> # first bad commit: [3a06353479111e1c9e072825bb0d0730e3a0f4e7] virtio_ring: introduce virtqueue_dma_dev()
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
