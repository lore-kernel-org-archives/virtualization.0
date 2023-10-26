Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1D8C25B47
	for <virtualization@archiver.kernel.org>; Thu, 26 Oct 2023 03:36:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0798160FCA;
	Thu, 26 Oct 2023 03:36:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0798160FCA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3lg7i4a8IJtx; Thu, 26 Oct 2023 03:36:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8E13360FC1;
	Thu, 26 Oct 2023 03:36:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8E13360FC1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D62FC0039;
	Thu, 26 Oct 2023 03:36:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D0C3C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 03:36:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 64BB640C08
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 03:36:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 64BB640C08
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YgQUsBdosYJJ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 03:36:26 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com
 (out30-101.freemail.mail.aliyun.com [115.124.30.101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1CB6340217
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 03:36:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1CB6340217
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R641e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0VuwQJX._1698291378; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VuwQJX._1698291378) by smtp.aliyun-inc.com;
 Thu, 26 Oct 2023 11:36:18 +0800
Message-ID: <1698291366.898542-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2] virtio_pci: Switch away from deprecated
 irq_set_affinity_hint
Date: Thu, 26 Oct 2023 11:36:06 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
References: <20231025145319.380775-1-jakub@cloudflare.com>
In-Reply-To: <20231025145319.380775-1-jakub@cloudflare.com>
Cc: kernel-team@cloudflare.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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

On Wed, 25 Oct 2023 16:53:19 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
> Since commit 65c7cdedeb30 ("genirq: Provide new interfaces for affinity
> hints") irq_set_affinity_hint is being phased out.
>
> Switch to new interfaces for setting and applying irq affinity hints.
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Thanks.

> ---
> v2:
>  - Leave cpumask_copy as is. We can't pass pointer to stack memory as hint.
>    Proposed a change to IRQ affinity interface to address this limitation:
>    https://lore.kernel.org/r/20231025141517.375378-1-jakub@cloudflare.com
>
> v1: https://lore.kernel.org/r/20231019101625.412936-2-jakub@cloudflare.com
> ---
>  drivers/virtio/virtio_pci_common.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index c2524a7207cf..7a5593997e0e 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -242,7 +242,7 @@ void vp_del_vqs(struct virtio_device *vdev)
>  			if (v != VIRTIO_MSI_NO_VECTOR) {
>  				int irq = pci_irq_vector(vp_dev->pci_dev, v);
>
> -				irq_set_affinity_hint(irq, NULL);
> +				irq_update_affinity_hint(irq, NULL);
>  				free_irq(irq, vq);
>  			}
>  		}
> @@ -443,10 +443,10 @@ int vp_set_vq_affinity(struct virtqueue *vq, const struct cpumask *cpu_mask)
>  		mask = vp_dev->msix_affinity_masks[info->msix_vector];
>  		irq = pci_irq_vector(vp_dev->pci_dev, info->msix_vector);
>  		if (!cpu_mask)
> -			irq_set_affinity_hint(irq, NULL);
> +			irq_update_affinity_hint(irq, NULL);
>  		else {
>  			cpumask_copy(mask, cpu_mask);
> -			irq_set_affinity_hint(irq, mask);
> +			irq_set_affinity_and_hint(irq, mask);
>  		}
>  	}
>  	return 0;
> --
> 2.41.0
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
