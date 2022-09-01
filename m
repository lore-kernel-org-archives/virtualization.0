Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A48ECAAD2
	for <virtualization@archiver.kernel.org>; Thu,  1 Sep 2022 06:08:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E651B4176D;
	Thu,  1 Sep 2022 06:08:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E651B4176D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gt0f6GifXDOe; Thu,  1 Sep 2022 06:08:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 24D6D41682;
	Thu,  1 Sep 2022 06:08:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24D6D41682
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E487EC0032;
	Thu,  1 Sep 2022 06:08:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E19D5C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 06:08:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B5FFF607C7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 06:08:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B5FFF607C7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MpDVrPoy1ihf
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 06:08:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2CF32607F2
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2CF32607F2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 06:08:17 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R711e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0VNxI5.W_1662012491; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VNxI5.W_1662012491) by smtp.aliyun-inc.com;
 Thu, 01 Sep 2022 14:08:12 +0800
Message-ID: <1662012423.9200838-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC v3 5/7] virtio: unmask F_NEXT flag in desc_extra
Date: Thu, 1 Sep 2022 14:07:03 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Guo Zhi <qtxuning1999@sjtu.edu.cn>
References: <20220901055434.824-1-qtxuning1999@sjtu.edu.cn>
 <20220901055434.824-6-qtxuning1999@sjtu.edu.cn>
In-Reply-To: <20220901055434.824-6-qtxuning1999@sjtu.edu.cn>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, Guo Zhi <qtxuning1999@sjtu.edu.cn>
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

On Thu,  1 Sep 2022 13:54:32 +0800, Guo Zhi <qtxuning1999@sjtu.edu.cn> wrote:
> We didn't unmask F_NEXT flag in desc_extra in the end of a chain,
> unmask it so that we can access desc_extra to get next information.
>
> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> ---
>  drivers/virtio/virtio_ring.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a5ec724c01d8..00aa4b7a49c2 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -567,7 +567,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	}
>  	/* Last one doesn't continue. */
>  	desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> -	if (!indirect && vq->use_dma_api)
> +	if (!indirect)
>  		vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
>  			~VRING_DESC_F_NEXT;
>
> @@ -584,6 +584,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  					 total_sg * sizeof(struct vring_desc),
>  					 VRING_DESC_F_INDIRECT,
>  					 false);
> +		vq->split.desc_extra[head & (vq->split.vring.num - 1)].flags &=
> +			~VRING_DESC_F_NEXT;

Wondering if this is necessary? When setting flags, NEXT is not included.

>  	}
>
>  	/* We're using some buffers from the free list. */
> @@ -685,7 +687,6 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  			     void **ctx)
>  {
>  	unsigned int i, j;
> -	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
>
>  	/* Clear data ptr. */
>  	vq->split.desc_state[head].data = NULL;
> @@ -693,7 +694,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  	/* Put back on free list: unmap first-level descriptors and find end */
>  	i = head;
>
> -	while (vq->split.vring.desc[i].flags & nextflag) {
> +	while (vq->split.desc_extra[i].flags & VRING_DESC_F_NEXT) {
>  		vring_unmap_one_split(vq, i);
>  		i = vq->split.desc_extra[i].next;
>  		vq->vq.num_free++;
> --
> 2.17.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
