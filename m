Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643F0EB64DD
	for <virtualization@archiver.kernel.org>; Mon,  3 Jul 2023 02:13:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0D9581DF7;
	Mon,  3 Jul 2023 02:13:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C0D9581DF7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HrjjRhjydoQ8; Mon,  3 Jul 2023 02:13:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4200981BD4;
	Mon,  3 Jul 2023 02:13:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4200981BD4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D84BC0071;
	Mon,  3 Jul 2023 02:13:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16562C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 02:13:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC1574056E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 02:13:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC1574056E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2k2GTjacrVs0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 02:13:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 44A0440025
Received: from out30-101.freemail.mail.aliyun.com
 (out30-101.freemail.mail.aliyun.com [115.124.30.101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 44A0440025
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 02:13:09 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R711e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0VmQ0CKk_1688350382; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VmQ0CKk_1688350382) by smtp.aliyun-inc.com;
 Mon, 03 Jul 2023 10:13:03 +0800
Message-ID: <1688350297.9197447-5-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio-mmio: don't break lifecycle of vm_dev
Date: Mon, 3 Jul 2023 10:11:37 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20230629120526.7184-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230629120526.7184-1-wsa+renesas@sang-engineering.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 weiping zhang <zhangweiping@didichuxing.com>
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

On Thu, 29 Jun 2023 14:05:26 +0200, Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:
> vm_dev has a separate lifecycle because it has a 'struct device'
> embedded. Thus, having a release callback for it is correct.
>
> Allocating the vm_dev struct with devres totally breaks this protection,

device? or driver?

And why?


> though. Instead of waiting for the vm_dev release callback, the memory
> is freed when the platform_device is removed. Resulting in a
> use-after-free when finally the callback is to be called.

Can we have the break stack?

Thanks.


>
> To easily see the problem, compile the kernel with
> CONFIG_DEBUG_KOBJECT_RELEASE and unbind with sysfs.
>
> The fix is easy, don't use devres in this case.
>
> Found during my research about object lifetime problems.
>
> Fixes: 7eb781b1bbb7 ("virtio_mmio: add cleanup for virtio_mmio_probe")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/virtio/virtio_mmio.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index a46a4a29e929..97760f611295 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -607,9 +607,8 @@ static void virtio_mmio_release_dev(struct device *_d)
>  	struct virtio_device *vdev =
>  			container_of(_d, struct virtio_device, dev);
>  	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> -	struct platform_device *pdev = vm_dev->pdev;
>
> -	devm_kfree(&pdev->dev, vm_dev);
> +	kfree(vm_dev);
>  }
>
>  /* Platform device */
> @@ -620,7 +619,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  	unsigned long magic;
>  	int rc;
>
> -	vm_dev = devm_kzalloc(&pdev->dev, sizeof(*vm_dev), GFP_KERNEL);
> +	vm_dev = kzalloc(sizeof(*vm_dev), GFP_KERNEL);
>  	if (!vm_dev)
>  		return -ENOMEM;
>
> --
> 2.35.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
