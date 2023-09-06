Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF678EE14A5
	for <virtualization@archiver.kernel.org>; Wed,  6 Sep 2023 16:35:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 380CB4056F;
	Wed,  6 Sep 2023 16:35:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 380CB4056F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lbk_EbdkigMm; Wed,  6 Sep 2023 16:35:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B5967400D9;
	Wed,  6 Sep 2023 16:35:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B5967400D9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89F8FC0071;
	Wed,  6 Sep 2023 16:35:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E773AC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Sep 2023 16:35:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C23B64034B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Sep 2023 16:35:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C23B64034B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vLgW0Aa1NSfh
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Sep 2023 16:35:03 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7713A400D9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Sep 2023 16:35:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7713A400D9
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 69FD8CE16E7;
 Wed,  6 Sep 2023 16:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29018C433C8;
 Wed,  6 Sep 2023 16:26:37 +0000 (UTC)
Date: Wed, 6 Sep 2023 17:26:34 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Maximilian Heyne <mheyne@amazon.de>
Subject: Re: [PATCH] virtio-mmio: fix memory leak of vm_dev
Message-ID: <ZPioOicQ5nPtDmwJ@arm.com>
References: <20230905094228.97125-1-mheyne@amazon.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230905094228.97125-1-mheyne@amazon.de>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
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

On Tue, Sep 05, 2023 at 09:42:28AM +0000, Maximilian Heyne wrote:
> With the recent removal of vm_dev from devres its memory is only freed
> via the callback virtio_mmio_release_dev. However, this only takes
> effect after device_add is called by register_virtio_device. Until then
> it's an unmanaged resource and must be explicitly freed on error exit.
>
> This bug was discovered and resolved using Coverity Static Analysis
> Security Testing (SAST) by Synopsys, Inc.
>
> Cc: stable@vger.kernel.org
> Fixes: 55c91fedd03d ("virtio-mmio: don't break lifecycle of vm_dev")
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>

Kmemleak was reporting around 31 of these leaks (under qemu). I have not
tried your patch yet as you mentioned a v2.

unreferenced object 0xffff000040bb6c00 (size 1024):
  comm "swapper/0", pid 1, jiffies 4294892472 (age 106.728s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000669bb200>] __kmem_cache_alloc_node+0x1c4/0x288
    [<00000000ac0129e3>] kmalloc_trace+0x20/0x2c
    [<0000000055d7a492>] virtio_mmio_probe+0x28/0x260
    [<000000002661dcec>] platform_probe+0x68/0xdc
    [<00000000e9abc76a>] really_probe+0x148/0x2ac
    [<00000000d9fbd8d5>] __driver_probe_device+0x78/0x12c
    [<0000000060d7804a>] driver_probe_device+0x3c/0x15c
    [<00000000705fa0e9>] __driver_attach+0x94/0x19c
    [<000000005079c97f>] bus_for_each_dev+0x74/0xd4
    [<0000000026582009>] driver_attach+0x24/0x30
    [<000000003e6b0968>] bus_add_driver+0xe4/0x1e8
    [<000000009e7b5554>] driver_register+0x60/0x128
    [<00000000d1f180b4>] __platform_driver_register+0x28/0x34
    [<0000000097a0072e>] virtio_mmio_init+0x1c/0x28
    [<00000000b3340a88>] do_one_initcall+0x6c/0x1b0
    [<0000000048f4ff06>] kernel_init_freeable+0x1bc/0x284

> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 97760f611295..b2a48d07e973 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -631,13 +631,16 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  	spin_lock_init(&vm_dev->lock);
>
>  	vm_dev->base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(vm_dev->base))
> +	if (IS_ERR(vm_dev->base)) {
> +		kfree(vm_dev);
>  		return PTR_ERR(vm_dev->base);
> +	}
>
>  	/* Check magic value */
>  	magic = readl(vm_dev->base + VIRTIO_MMIO_MAGIC_VALUE);
>  	if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
>  		dev_warn(&pdev->dev, "Wrong magic value 0x%08lx!\n", magic);
> +		kfree(vm_dev);
>  		return -ENODEV;
>  	}
>
> @@ -646,6 +649,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  	if (vm_dev->version < 1 || vm_dev->version > 2) {
>  		dev_err(&pdev->dev, "Version %ld not supported!\n",
>  				vm_dev->version);
> +		kfree(vm_dev);
>  		return -ENXIO;
>  	}
>
> @@ -655,6 +659,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  		 * virtio-mmio device with an ID 0 is a (dummy) placeholder
>  		 * with no function. End probing now with no error reported.
>  		 */
> +		kfree(vm_dev);
>  		return -ENODEV;
>  	}
>  	vm_dev->vdev.id.vendor = readl(vm_dev->base + VIRTIO_MMIO_VENDOR_ID);

I'd rather have a goto with a single point of freeing.

--
Catalin
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
