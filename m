Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C485CDB482
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 12:57:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0655642E23;
	Thu, 19 Oct 2023 12:57:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0655642E23
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lpT13oYyjAQe; Thu, 19 Oct 2023 12:57:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9367E42E22;
	Thu, 19 Oct 2023 12:57:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9367E42E22
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65DD8C0071;
	Thu, 19 Oct 2023 12:57:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C58C0C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 12:57:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AEB2482379
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 12:57:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AEB2482379
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id buEWKhX-c7ws
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 12:57:14 +0000 (UTC)
Received: from out30-111.freemail.mail.aliyun.com
 (out30-111.freemail.mail.aliyun.com [115.124.30.111])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B4BB982372
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 12:57:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B4BB982372
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0VuU3cJJ_1697720225; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VuU3cJJ_1697720225) by smtp.aliyun-inc.com;
 Thu, 19 Oct 2023 20:57:06 +0800
Message-ID: <1697720122.49851-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/2] virtio_pci: Don't make an extra copy of cpu affinity
 mask
Date: Thu, 19 Oct 2023 20:55:22 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
References: <20231019101625.412936-1-jakub@cloudflare.com>
In-Reply-To: <20231019101625.412936-1-jakub@cloudflare.com>
Cc: Caleb Raitto <caraitto@google.com>, kernel-team@cloudflare.com,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
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

On Thu, 19 Oct 2023 12:16:24 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
> Since commit 19e226e8cc5d ("virtio: Make vp_set_vq_affinity() take a
> mask.") it is actually not needed to have a local copy of the cpu mask.


Could you give more info to prove this?

If you are right, I think you should delete all code about msix_affinity_masks?

Thanks.

>
> Pass the cpu mask we got as argument to set the irq affinity hint.
>
> Cc: Caleb Raitto <caraitto@google.com>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index c2524a7207cf..8927bc338f06 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -433,21 +433,14 @@ int vp_set_vq_affinity(struct virtqueue *vq, const struct cpumask *cpu_mask)
>  	struct virtio_device *vdev = vq->vdev;
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	struct virtio_pci_vq_info *info = vp_dev->vqs[vq->index];
> -	struct cpumask *mask;
>  	unsigned int irq;
>
>  	if (!vq->callback)
>  		return -EINVAL;
>
>  	if (vp_dev->msix_enabled) {
> -		mask = vp_dev->msix_affinity_masks[info->msix_vector];
>  		irq = pci_irq_vector(vp_dev->pci_dev, info->msix_vector);
> -		if (!cpu_mask)
> -			irq_set_affinity_hint(irq, NULL);
> -		else {
> -			cpumask_copy(mask, cpu_mask);
> -			irq_set_affinity_hint(irq, mask);
> -		}
> +		irq_set_affinity_hint(irq, cpu_mask);
>  	}
>  	return 0;
>  }
> --
> 2.41.0
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
