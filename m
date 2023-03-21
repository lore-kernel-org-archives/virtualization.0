Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B40C6FD1D
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 20:45:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1602081E88;
	Tue, 21 Mar 2023 20:45:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1602081E88
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MdWG3z43
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QdkzV3MDUgLH; Tue, 21 Mar 2023 20:45:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6224481E62;
	Tue, 21 Mar 2023 20:45:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6224481E62
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 366D4C0035;
	Tue, 21 Mar 2023 20:45:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24906C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 20:45:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F376860EAB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 20:45:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F376860EAB
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MdWG3z43
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xHtOBphAMk7t
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 20:45:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E3A9A60A79
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E3A9A60A79
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 20:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679431527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8QEMYGCQ0QdBS1pkdsI4QfC2Y14/EBQbCi1DV5riPws=;
 b=MdWG3z432MuOvmzlLxOduUw3q1q3mR3+XB4ECzQxTR5SETm8lOwQZh1Mc+QklKdphhUIbs
 opUueO7/+qyTdfLAmGa48hk5yIOXwZjUg5sdP+l/+MyCFxpx/S18rZ3OOvQ1R68HnKM0U6
 T1GLaPlerTijXwJLMietsK0QZIa2VLQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-OFQdHz2NNl-uAgRxOmYS8Q-1; Tue, 21 Mar 2023 16:45:26 -0400
X-MC-Unique: OFQdHz2NNl-uAgRxOmYS8Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 m27-20020a05600c3b1b00b003ee502f1b16so446705wms.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 13:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679431525;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8QEMYGCQ0QdBS1pkdsI4QfC2Y14/EBQbCi1DV5riPws=;
 b=wJiiYC8SR8Q9L5DgfL73dkuH5dpmTlT31C1KtXoLuRZvDzhHAgUcLL4FH+El5mPmR/
 tPqXRzbtMK6oa76oNWqmYFlRYd8vM6ufb3dmaUxl2gs39V3z1814YuJ6MjT0va0Wq6du
 utvT3IQzaRu8sqRwiK9NdGwJUTgXclw4BTL7YUVzaPGbRZ0BFMvzu7JQEYEpytYKgIpP
 6NgVUMqkcr4P/S+vRtK25TL4rAprOvl0WHw/l85PiJunjjMOVKzW0C9eVRFVrMoF+Ans
 dFaF66I42yTFK2KJlo4LP8f4EmSwKCkiBctanhwwi1RbgUq4fv27jLoUZz/0k2mMnGnO
 gKcw==
X-Gm-Message-State: AO0yUKXdwPBlHYBGVmG1HaUcYT3/qeoLgLvC4dK2cLlYB/chrBRlk0qE
 nUz1kn2Nm/hhhYVtZq37LrtGcIvtYDI1TDQn5KogZ9PCzLG4kmmmaoHrP+tAx6a4wKQ2LfhBxde
 Y21F3hijjWWdBvm76mib21yuzklmqY/FcbChNKLIacQ==
X-Received: by 2002:adf:f80e:0:b0:2d8:36de:bb79 with SMTP id
 s14-20020adff80e000000b002d836debb79mr3509074wrp.9.1679431524940; 
 Tue, 21 Mar 2023 13:45:24 -0700 (PDT)
X-Google-Smtp-Source: AK7set9IOOKHx8MtBu5h482RNHwOPg5sb877OIsdviKnn12D/1sMht+88W7N2hnrRRWd/FRO+ELHXw==
X-Received: by 2002:adf:f80e:0:b0:2d8:36de:bb79 with SMTP id
 s14-20020adff80e000000b002d836debb79mr3509066wrp.9.1679431524612; 
 Tue, 21 Mar 2023 13:45:24 -0700 (PDT)
Received: from redhat.com ([2.52.1.105]) by smtp.gmail.com with ESMTPSA id
 e4-20020a5d4e84000000b002ceac2ccc4asm12166509wru.23.2023.03.21.13.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Mar 2023 13:45:24 -0700 (PDT)
Date: Tue, 21 Mar 2023 16:45:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v3 04/11] virtio_ring: split: support premapped
Message-ID: <20230321164343-mutt-send-email-mst@kernel.org>
References: <20230321093506.6546-1-xuanzhuo@linux.alibaba.com>
 <20230321093506.6546-5-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230321093506.6546-5-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

On Tue, Mar 21, 2023 at 05:34:59PM +0800, Xuan Zhuo wrote:
> virtio core only supports virtual addresses, dma is completed in virtio
> core.
> 
> In some scenarios (such as the AF_XDP), the memory is allocated
> and DMA mapping is completed in advance, so it is necessary for us to
> support passing the DMA address to virtio core.
> 
> Drives can use sg->dma_address to pass the mapped dma address to virtio
> core. If one sg->dma_address is used then all sgs must use
> sg->dma_address, otherwise all must be null when passing it to the APIs
> of virtio.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index c8ed4aef9462..be2ff96964c3 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -70,6 +70,7 @@
>  struct vring_desc_state_split {
>  	void *data;			/* Data for callback. */
>  	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
> +	bool map_inter;			/* Do dma map internally. */

I prefer a full name. E.g. "dma_map_internal". Eschew abbreviation.


>  };
>  
>  struct vring_desc_state_packed {
> @@ -448,7 +449,7 @@ static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
>  }
>  
>  static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
> -					  unsigned int i)
> +					  unsigned int i, bool map_inter)
>  {
>  	struct vring_desc_extra *extra = vq->split.desc_extra;
>  	u16 flags;
> @@ -465,6 +466,9 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
>  				 (flags & VRING_DESC_F_WRITE) ?
>  				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
>  	} else {
> +		if (!map_inter)
> +			goto out;
> +
>  		dma_unmap_page(vring_dma_dev(vq),
>  			       extra[i].addr,
>  			       extra[i].len,
> @@ -615,7 +619,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	struct scatterlist *sg;
>  	struct vring_desc *desc;
>  	unsigned int i, n, avail, descs_used, prev;
> -	bool indirect;
> +	bool indirect, map_inter;
>  	int head;
>  
>  	START_USE(vq);
> @@ -668,7 +672,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  		return -ENOSPC;
>  	}
>  
> -	if (virtqueue_map_sgs(vq, sgs, total_sg, out_sgs, in_sgs))
> +	map_inter = !sgs[0]->dma_address;
> +	if (map_inter && virtqueue_map_sgs(vq, sgs, total_sg, out_sgs, in_sgs))
>  		return -ENOMEM;
>  
>  	for (n = 0; n < out_sgs; n++) {
> @@ -734,6 +739,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  		vq->split.desc_state[head].indir_desc = desc;
>  	else
>  		vq->split.desc_state[head].indir_desc = ctx;
> +	vq->split.desc_state[head].map_inter = map_inter;
>  
>  	/* Put entry in available array (but don't update avail->idx until they
>  	 * do sync). */
> @@ -759,7 +765,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	return 0;
>  
>  unmap_release:
> -	virtqueue_unmap_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
> +	if (map_inter)
> +		virtqueue_unmap_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
>  
>  	if (indirect)
>  		kfree(desc);
> @@ -804,20 +811,22 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  {
>  	unsigned int i, j;
>  	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
> +	bool map_inter;
>  
>  	/* Clear data ptr. */
>  	vq->split.desc_state[head].data = NULL;
> +	map_inter = vq->split.desc_state[head].map_inter;
>  
>  	/* Put back on free list: unmap first-level descriptors and find end */
>  	i = head;
>  
>  	while (vq->split.vring.desc[i].flags & nextflag) {
> -		vring_unmap_one_split(vq, i);
> +		vring_unmap_one_split(vq, i, map_inter);
>  		i = vq->split.desc_extra[i].next;
>  		vq->vq.num_free++;
>  	}
>  
> -	vring_unmap_one_split(vq, i);
> +	vring_unmap_one_split(vq, i, map_inter);
>  	vq->split.desc_extra[i].next = vq->free_head;
>  	vq->free_head = head;
>  
> @@ -839,8 +848,10 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  				VRING_DESC_F_INDIRECT));
>  		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
>  
> -		for (j = 0; j < len / sizeof(struct vring_desc); j++)
> -			vring_unmap_one_split_indirect(vq, &indir_desc[j]);
> +		if (map_inter) {
> +			for (j = 0; j < len / sizeof(struct vring_desc); j++)
> +				vring_unmap_one_split_indirect(vq, &indir_desc[j]);
> +		}
>  
>  		kfree(indir_desc);
>  		vq->split.desc_state[head].indir_desc = NULL;
> -- 
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
