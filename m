Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28DA548F8
	for <virtualization@lists.linux.dev>; Thu, 22 Feb 2024 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708632373; cv=none; b=GzyIfrxfsguQYPrysRPF92lM6xhgZ7BgIPir852Fg8amQPtAT0KBvAv2WKbZpieSu1NNUVGaTFDqcR6GtqdnLWIsrQPWgAJkUxItB97lbIHEsb5m4YCVGoNRD32p8y+nkmvt4bzqPwoTNjPubqrNQEyNqfAC1JNwgqqh/Ru7q/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708632373; c=relaxed/simple;
	bh=FqL1rITe2ZjNtqUQ4KV/ItyrO8GoVdqKz/BblIhKCE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qlw9wLqZdMkuM8M9FjM0hHNKe6uKY8pNErM3EPL5WryJCLB9dgrGg7syWKKIIVi6wwVIYGYaxzScF5wrFKM/1d2rB1GJoZ+qUbsOPpr4Ym7V08/UN2V4RlrCjJVeWBAfQDnvv4NHAlzf1Qv/C6bo428GtN/0SpUMCq0sx1wwJUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rnq3A3yt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rnq3A3yt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708632370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AxuhoPQ/948+5NQNK9OuDcMwiyXE1lolJGAMQupFnLc=;
	b=Rnq3A3ytlIewzpGM2TbpXMwJ3WLxUntSRCf2Q0X9nItHsPoKn4ECc7jbYcD+/C4cTL2Koz
	Z/Gzhja8A4iMtcgQADOjsNVclQkx9T2I5RxwxqScMFXNQgCrXsaBbBKzdA1jRovsHsTzQ6
	RNlevpuLSlHFbBMmGwbcz7mURo64QSY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-1OkM741xOLOG7DwRisaH6g-1; Thu, 22 Feb 2024 15:06:08 -0500
X-MC-Unique: 1OkM741xOLOG7DwRisaH6g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33d7e755f52so43424f8f.1
        for <virtualization@lists.linux.dev>; Thu, 22 Feb 2024 12:06:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708632367; x=1709237167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxuhoPQ/948+5NQNK9OuDcMwiyXE1lolJGAMQupFnLc=;
        b=Z3Ab1XaTEPHAmbFLwdR0EfxqnYvhTRWiRfzAGkHltFSAzMlk1R6Az5S4VliSOS2Bvz
         BUBdGwB24DulbnwysSWCyP/PjJDtSsbjoOZOeBbK7wbnwxsZ8Vih5umeN7p+H6JU3q0t
         UENNCkxsGKxiKuIWC+3em7UUGq+fTTs6PZ1BepKE6CWGIQO5D58XFSGxcuWEOlwXWG6u
         +64JqmaSRj82BW4nDNSS7EVCSjd+FyP8TMy8sXF6vj0ffXIV2iTobMEeqFlW7e3n0JTv
         lor/NRM4QfidkYb0tRY+UNtUuzJBhfDdnTlMENQ8T0bnba8Hruer5Bx/ROcM2UtqZxju
         3sng==
X-Gm-Message-State: AOJu0YxCWZOYxg3EdXtDUEyqea4a03TGUy8c/1yWqy9rudSm0A1G7fbv
	NjnxLqXP57y2XFvzfbUscRNnj/ZxyAcaWULlKBzuWrFPibv0XwDE26L1Mj9Uk7maJ3Gl461ac41
	ZMgxHBemWgwdYn7nE9YnPEaYG58VTvEgWka0mEKwjp8p1kH2v83KIEXexL4e2draDs3q2Yr99rI
	c=
X-Received: by 2002:a5d:69ce:0:b0:33d:9c51:1776 with SMTP id s14-20020a5d69ce000000b0033d9c511776mr145706wrw.10.1708632367455;
        Thu, 22 Feb 2024 12:06:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+NcN4VE0R7N3nlNoIQzlh4g4mjw8WUnS+BCYxBUqCzcrK0TCMMocf/EYhJUmZ9sz0lbCpXA==
X-Received: by 2002:a5d:69ce:0:b0:33d:9c51:1776 with SMTP id s14-20020a5d69ce000000b0033d9c511776mr145694wrw.10.1708632367116;
        Thu, 22 Feb 2024 12:06:07 -0800 (PST)
Received: from redhat.com ([172.93.237.99])
        by smtp.gmail.com with ESMTPSA id i4-20020adff304000000b0033d87f61613sm89276wro.58.2024.02.22.12.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 12:06:06 -0800 (PST)
Date: Thu, 22 Feb 2024 15:06:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio: packed: fix unmap leak for indirect desc table
Message-ID: <20240222150550-mutt-send-email-mst@kernel.org>
References: <20240201095618.2288-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240201095618.2288-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 01, 2024 at 05:56:18PM +0800, Xuan Zhuo wrote:
> When use_dma_api and premapped are true, then the do_unmap is false.
> 
> Because the do_unmap is false, vring_unmap_extra_packed is not called by
> detach_buf_packed.
> 
>  if (unlikely(vq->do_unmap)) {
>                curr = id;
>                for (i = 0; i < state->num; i++) {
>                        vring_unmap_extra_packed(vq,
>                                                 &vq->packed.desc_extra[curr]);
>                        curr = vq->packed.desc_extra[curr].next;
>                }
>   }
> 
> So the indirect desc table is not unmapped. This causes the unmap leak.
> 
> On the other side, the dma addr and the flags is not updated. That
> will be used by vring_unmap_extra_packed.
> 
> For safety in this patch, the flags of desc without indirect flag is
> also updated.
> 
> This bug does not occur, because no driver use the premapped with
> indirect.
> 
> Fixes: b319940f83c2 ("virtio_ring: skip unmap for premapped")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

were you going to post v2?

> ---
>  drivers/virtio/virtio_ring.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 49299b1f9ec7..097258a10819 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1340,14 +1340,15 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  				sizeof(struct vring_packed_desc));
>  	vq->packed.vring.desc[head].id = cpu_to_le16(id);
>  
> -	if (vq->do_unmap) {
> +	if (vq->use_dma_api) {
>  		vq->packed.desc_extra[id].addr = addr;
>  		vq->packed.desc_extra[id].len = total_sg *
>  				sizeof(struct vring_packed_desc);
> -		vq->packed.desc_extra[id].flags = VRING_DESC_F_INDIRECT |
> -						  vq->packed.avail_used_flags;
>  	}
>  
> +	vq->packed.desc_extra[id].flags = VRING_DESC_F_INDIRECT |
> +		vq->packed.avail_used_flags;
> +
>  	/*
>  	 * A driver MUST NOT make the first descriptor in the list
>  	 * available before all subsequent descriptors comprising
> @@ -1484,9 +1485,10 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  			if (unlikely(vq->do_unmap)) {
>  				vq->packed.desc_extra[curr].addr = addr;
>  				vq->packed.desc_extra[curr].len = sg->length;
> -				vq->packed.desc_extra[curr].flags =
> -					le16_to_cpu(flags);
>  			}
> +
> +			vq->packed.desc_extra[curr].flags = le16_to_cpu(flags);
> +
>  			prev = curr;
>  			curr = vq->packed.desc_extra[curr].next;
>  
> @@ -1615,13 +1617,11 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
>  	vq->free_head = id;
>  	vq->vq.num_free += state->num;
>  
> -	if (unlikely(vq->do_unmap)) {
> -		curr = id;
> -		for (i = 0; i < state->num; i++) {
> -			vring_unmap_extra_packed(vq,
> -						 &vq->packed.desc_extra[curr]);
> -			curr = vq->packed.desc_extra[curr].next;
> -		}
> +	curr = id;
> +	for (i = 0; i < state->num; i++) {
> +		vring_unmap_extra_packed(vq,
> +					 &vq->packed.desc_extra[curr]);
> +		curr = vq->packed.desc_extra[curr].next;
>  	}
>  
>  	if (vq->indirect) {
> -- 
> 2.32.0.3.g01195cf9f

