Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0ECEC25B08
	for <virtualization@archiver.kernel.org>; Thu, 18 Aug 2022 03:10:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2884C40FEC;
	Thu, 18 Aug 2022 03:10:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2884C40FEC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cgt6De9H8BNe; Thu, 18 Aug 2022 03:10:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1BA7240272;
	Thu, 18 Aug 2022 03:10:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1BA7240272
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E710EC0033;
	Thu, 18 Aug 2022 03:09:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DD33C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 03:09:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6828161119
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 03:09:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6828161119
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mfJlAUA1Ax4k
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 03:09:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD74F61112
Received: from out199-4.us.a.mail.aliyun.com (out199-4.us.a.mail.aliyun.com
 [47.90.199.4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AD74F61112
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 03:09:56 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0VMYsNDR_1660792190; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VMYsNDR_1660792190) by smtp.aliyun-inc.com;
 Thu, 18 Aug 2022 11:09:51 +0800
Message-ID: <1660791937.681257-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC v2 5/7] virtio: unmask F_NEXT flag in desc_extra
Date: Thu, 18 Aug 2022 11:05:37 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Guo Zhi <qtxuning1999@sjtu.edu.cn>
References: <20220817135718.2553-1-qtxuning1999@sjtu.edu.cn>
 <20220817135718.2553-6-qtxuning1999@sjtu.edu.cn>
In-Reply-To: <20220817135718.2553-6-qtxuning1999@sjtu.edu.cn>
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

On Wed, 17 Aug 2022 21:57:16 +0800, Guo Zhi <qtxuning1999@sjtu.edu.cn> wrote:
> We didn't unmask F_NEXT flag in desc_extra in the end of a chain,
> unmask it so that we can access desc_extra to get next information.

I think we should state the purpose of this.

>
> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> ---
>  drivers/virtio/virtio_ring.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a5ec724c01d8..1c1b3fa376a2 100644
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

This seems unnecessary.

>  	}
>
>  	/* We're using some buffers from the free list. */
> @@ -693,7 +695,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  	/* Put back on free list: unmap first-level descriptors and find end */
>  	i = head;
>
> -	while (vq->split.vring.desc[i].flags & nextflag) {
> +	while (vq->split.desc_extra[i].flags & nextflag) {

nextflag is __virtio16

You can use VRING_DESC_F_NEXT directly.

Thanks.

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
