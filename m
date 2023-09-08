Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA385EC875F
	for <virtualization@archiver.kernel.org>; Fri,  8 Sep 2023 01:50:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5860E8220C;
	Fri,  8 Sep 2023 01:50:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5860E8220C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lipY8vFEo1BR; Fri,  8 Sep 2023 01:49:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D0A1D81FB3;
	Fri,  8 Sep 2023 01:49:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D0A1D81FB3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2051C0071;
	Fri,  8 Sep 2023 01:49:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0E7EC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Sep 2023 01:49:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B736882012
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Sep 2023 01:49:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B736882012
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wxdWaKCEkGI0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Sep 2023 01:49:55 +0000 (UTC)
Received: from out30-112.freemail.mail.aliyun.com
 (out30-112.freemail.mail.aliyun.com [115.124.30.112])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D224B81FB3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Sep 2023 01:49:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D224B81FB3
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R461e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0VradabB_1694137785; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VradabB_1694137785) by smtp.aliyun-inc.com;
 Fri, 08 Sep 2023 09:49:46 +0800
Message-ID: <1694137778.7008362-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2] virtio-mmio: fix memory leak of vm_dev
Date: Fri, 8 Sep 2023 09:49:38 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Maximilian Heyne <mheyne@amazon.de>
References: <20230907141716.88863-1-mheyne@amazon.de>
In-Reply-To: <20230907141716.88863-1-mheyne@amazon.de>
Cc: "Michael S.  Tsirkin" <mst@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Maximilian Heyne <mheyne@amazon.de>
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

On Thu, 7 Sep 2023 14:17:16 +0000, Maximilian Heyne <mheyne@amazon.de> wrote:
> With the recent removal of vm_dev from devres its memory is only freed
> via the callback virtio_mmio_release_dev. However, this only takes
> effect after device_add is called by register_virtio_device. Until then
> it's an unmanaged resource and must be explicitly freed on error exit.
>
> This bug was discovered and resolved using Coverity Static Analysis
> Security Testing (SAST) by Synopsys, Inc.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 55c91fedd03d ("virtio-mmio: don't break lifecycle of vm_dev")
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/virtio/virtio_mmio.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 97760f611295..59892a31cf76 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -631,14 +631,17 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  	spin_lock_init(&vm_dev->lock);
>
>  	vm_dev->base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(vm_dev->base))
> -		return PTR_ERR(vm_dev->base);
> +	if (IS_ERR(vm_dev->base)) {
> +		rc = PTR_ERR(vm_dev->base);
> +		goto free_vm_dev;
> +	}
>
>  	/* Check magic value */
>  	magic = readl(vm_dev->base + VIRTIO_MMIO_MAGIC_VALUE);
>  	if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
>  		dev_warn(&pdev->dev, "Wrong magic value 0x%08lx!\n", magic);
> -		return -ENODEV;
> +		rc = -ENODEV;
> +		goto free_vm_dev;
>  	}
>
>  	/* Check device version */
> @@ -646,7 +649,8 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  	if (vm_dev->version < 1 || vm_dev->version > 2) {
>  		dev_err(&pdev->dev, "Version %ld not supported!\n",
>  				vm_dev->version);
> -		return -ENXIO;
> +		rc = -ENXIO;
> +		goto free_vm_dev;
>  	}
>
>  	vm_dev->vdev.id.device = readl(vm_dev->base + VIRTIO_MMIO_DEVICE_ID);
> @@ -655,7 +659,8 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  		 * virtio-mmio device with an ID 0 is a (dummy) placeholder
>  		 * with no function. End probing now with no error reported.
>  		 */
> -		return -ENODEV;
> +		rc = -ENODEV;
> +		goto free_vm_dev;
>  	}
>  	vm_dev->vdev.id.vendor = readl(vm_dev->base + VIRTIO_MMIO_VENDOR_ID);
>
> @@ -685,6 +690,10 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  		put_device(&vm_dev->vdev.dev);
>
>  	return rc;
> +
> +free_vm_dev:
> +	kfree(vm_dev);
> +	return rc;
>  }
>
>  static int virtio_mmio_remove(struct platform_device *pdev)
> --
> 2.40.1
>
>
>
>
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
>
>
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
