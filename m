Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56FBC61DA4
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 09:17:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 442F041C98;
	Fri,  3 Feb 2023 09:17:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 442F041C98
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fUXb7DUD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DpXrH-RGwVOf; Fri,  3 Feb 2023 09:17:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1ADF941BAA;
	Fri,  3 Feb 2023 09:17:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1ADF941BAA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6D01C0033;
	Fri,  3 Feb 2023 09:17:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF8A7C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:17:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8DC4A401D5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:17:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8DC4A401D5
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fUXb7DUD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fb5F_D9TIu5J
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:17:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 917AD40105
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 917AD40105
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675415823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PJGQZStfxsVKGxUqV2WM+lmLEOi/QZRXzJ/C23me5nI=;
 b=fUXb7DUDvMF5V5I9xtHMvZyFVnvHmh4PmTPkVjfEXbcToKVn2j2i4+jr8+XzioH9VjygdC
 o+7AhbcU3QLnMuwX0uTQegjzUaYJS0PPHSI6KATVG/sTQSK5fkS2Os5xNkuit1PRpHi/b0
 NY24SdzQS4kiSn99G7M1WRIXfS0Ox38=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-303-2MgVrZLpOcG0FXhreOvO9Q-1; Fri, 03 Feb 2023 04:16:52 -0500
X-MC-Unique: 2MgVrZLpOcG0FXhreOvO9Q-1
Received: by mail-ed1-f71.google.com with SMTP id
 j10-20020a05640211ca00b0049e385d5830so3196686edw.22
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Feb 2023 01:16:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PJGQZStfxsVKGxUqV2WM+lmLEOi/QZRXzJ/C23me5nI=;
 b=fIaAHNSXOTif7LgYNCoYGUHn4/qE+9/Zpqyq3X7bU834luT3xwWwxTAdjX20I7lX5L
 cBB4zcwEWkyAwH734TEDl7lGhYTsONO1iqOW5EuqFpsSnTZNJWKk+byIp5O7FTpJIVG+
 3RV1eNQoHrD0Sfa5hOyfjMLJoCZDbcTzoruZv9NgOuxifODqL8/pDvS8cqFK5bx9p9vH
 JoIXXj55LMZJtAVm9otwmGD+C6Al7HAsRxVvbRPg5fGWgHmlWRE0thAQojzqzQ4PmkGS
 TqW3pZEkw+yRcWCF7KColhjjGMZOyfFQjN0xyeYqWWgA2mJuENafA8RXLke7pVYMihvW
 TIEg==
X-Gm-Message-State: AO0yUKXCfRo2aKR33aXSYU/2XcGoNjkvTzOibenTGposwibDqrsOBdbs
 /0ZsEFEUdW4MtSHzmnZf+PH0UqJbrAqY0tBWjXD3kQJbmq26zTAlxVuzGRwdpX78t+tb8bpyDuD
 ukhSwiY53O2521nstaJ/mXME27O27e+9qJsc+0Eif+w==
X-Received: by 2002:aa7:cd7b:0:b0:49e:28b6:4cf5 with SMTP id
 ca27-20020aa7cd7b000000b0049e28b64cf5mr8389091edb.12.1675415811689; 
 Fri, 03 Feb 2023 01:16:51 -0800 (PST)
X-Google-Smtp-Source: AK7set/EmHAFK9dC9goDmVVuChPcdLV6U8CHAWYLmcDLw7reR7t0oHvcqvjJrxlemwCIBS6vUDpGlw==
X-Received: by 2002:aa7:cd7b:0:b0:49e:28b6:4cf5 with SMTP id
 ca27-20020aa7cd7b000000b0049e28b64cf5mr8389078edb.12.1675415811477; 
 Fri, 03 Feb 2023 01:16:51 -0800 (PST)
Received: from redhat.com ([2.52.156.122]) by smtp.gmail.com with ESMTPSA id
 z21-20020aa7c655000000b00483dd234ac6sm800134edr.96.2023.02.03.01.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Feb 2023 01:16:50 -0800 (PST)
Date: Fri, 3 Feb 2023 04:16:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 03/33] virtio_ring: packed: virtqueue_add_packed()
 support premapped
Message-ID: <20230203041006-mutt-send-email-mst@kernel.org>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-4-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230202110058.130695-4-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

On Thu, Feb 02, 2023 at 07:00:28PM +0800, Xuan Zhuo wrote:
> virtqueue_add_packed() only supports virtual addresses, dma is completed
> in virtqueue_add_packed().
> 
> In some scenarios (such as the AF_XDP scenario), the memory is allocated
> and DMA is completed in advance, so it is necessary for us to support
> passing the DMA address to virtqueue_add_packed().
> 
> Record this information in desc_state, we can skip unmap based on this
> when executing dma unmap.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 71 +++++++++++++++++++++++++-----------
>  1 file changed, 50 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index ec622403cbd5..25027a35fcf8 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -78,6 +78,7 @@ struct vring_desc_state_packed {
>  	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
>  	u16 num;			/* Descriptor list length. */
>  	u16 last;			/* The last desc state in a list. */
> +	bool premapped;
>  };
>  
>  struct vring_desc_extra {


That's an extra cache line. 
> @@ -1200,7 +1201,8 @@ static inline u16 packed_last_used(u16 last_used_idx)
>  }
>  
>  static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
> -				     struct vring_desc_extra *extra)
> +				     struct vring_desc_extra *extra,
> +				     bool premapped)
>  {
>  	u16 flags;
>  
> @@ -1215,6 +1217,9 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
>  				 (flags & VRING_DESC_F_WRITE) ?
>  				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
>  	} else {
> +		if (premapped)
> +			return;
> +
>  		dma_unmap_page(vring_dma_dev(vq),
>  			       extra->addr, extra->len,
>  			       (flags & VRING_DESC_F_WRITE) ?
> @@ -1262,7 +1267,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  					 unsigned int out_sgs,
>  					 unsigned int in_sgs,
>  					 void *data,
> -					 gfp_t gfp)
> +					 gfp_t gfp,
> +					 bool premapped)
>  {
>  	struct vring_packed_desc *desc;
>  	struct scatterlist *sg;
> @@ -1288,10 +1294,15 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  
>  	for (n = 0; n < out_sgs + in_sgs; n++) {
>  		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
> -			addr = vring_map_one_sg(vq, sg, n < out_sgs ?
> -					DMA_TO_DEVICE : DMA_FROM_DEVICE);
> -			if (vring_mapping_error(vq, addr))
> -				goto unmap_release;
> +			if (premapped) {
> +				addr = sg_dma_address(sg);
> +
> +			} else {
> +				addr = vring_map_one_sg(vq, sg, n < out_sgs ?
> +							DMA_TO_DEVICE : DMA_FROM_DEVICE);
> +				if (vring_mapping_error(vq, addr))
> +					goto unmap_release;
> +			}
>  
>  			desc[i].flags = cpu_to_le16(n < out_sgs ?
>  						0 : VRING_DESC_F_WRITE);
> @@ -1350,6 +1361,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	vq->packed.desc_state[id].data = data;
>  	vq->packed.desc_state[id].indir_desc = desc;
>  	vq->packed.desc_state[id].last = id;
> +	vq->packed.desc_state[id].premapped = premapped;
>  
>  	vq->num_added += 1;
>  
> @@ -1359,10 +1371,11 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	return 0;
>  
>  unmap_release:
> -	err_idx = i;
> -
> -	for (i = 0; i < err_idx; i++)
> -		vring_unmap_desc_packed(vq, &desc[i]);
> +	if (!premapped) {
> +		err_idx = i;
> +		for (i = 0; i < err_idx; i++)
> +			vring_unmap_desc_packed(vq, &desc[i]);
> +	}
>  
>  	kfree(desc);
>  
> @@ -1377,6 +1390,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  				       unsigned int in_sgs,
>  				       void *data,
>  				       void *ctx,
> +				       bool premapped,
>  				       gfp_t gfp)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
> @@ -1403,7 +1417,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  
>  	if (virtqueue_use_indirect(vq, total_sg)) {
>  		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
> -						    in_sgs, data, gfp);
> +						    in_sgs, data, gfp, premapped);
>  		if (err != -ENOMEM) {
>  			END_USE(vq);
>  			return err;
> @@ -1435,10 +1449,17 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	c = 0;
>  	for (n = 0; n < out_sgs + in_sgs; n++) {
>  		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
> -			dma_addr_t addr = vring_map_one_sg(vq, sg, n < out_sgs ?
> -					DMA_TO_DEVICE : DMA_FROM_DEVICE);
> -			if (vring_mapping_error(vq, addr))
> -				goto unmap_release;
> +			dma_addr_t addr;
> +
> +			if (premapped) {
> +				addr = sg_dma_address(sg);
> +

drop this empty line pls.

> +			} else {
> +				addr = vring_map_one_sg(vq, sg, n < out_sgs ?
> +							DMA_TO_DEVICE : DMA_FROM_DEVICE);
> +				if (vring_mapping_error(vq, addr))
> +					goto unmap_release;
> +			}
>  
>  			flags = cpu_to_le16(vq->packed.avail_used_flags |
>  				    (++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
> @@ -1485,6 +1506,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	vq->packed.desc_state[id].data = data;
>  	vq->packed.desc_state[id].indir_desc = ctx;
>  	vq->packed.desc_state[id].last = prev;
> +	vq->packed.desc_state[id].premapped = premapped;
>  
>  	/*
>  	 * A driver MUST NOT make the first descriptor in the list
> @@ -1501,22 +1523,26 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	return 0;
>  
>  unmap_release:
> +	vq->packed.avail_used_flags = avail_used_flags;
> +
> +	if (premapped)
> +		goto unmap_free;
> +

This goto branching inside error handling is too much like spaghetti code.
See Documentation/process/coding-style.rst for when goto is ok -
basically exit/error handling. This is not error handling.
Pls find a way to avoid.

>  	err_idx = i;
>  	i = head;
>  	curr = vq->free_head;
>  
> -	vq->packed.avail_used_flags = avail_used_flags;
> -
>  	for (n = 0; n < total_sg; n++) {
>  		if (i == err_idx)
>  			break;
> -		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr]);
> +		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr], false);
>  		curr = vq->packed.desc_extra[curr].next;
>  		i++;
>  		if (i >= vq->packed.vring.num)
>  			i = 0;
>  	}
>  
> +unmap_free:
>  	END_USE(vq);
>  	return -EIO;
>  }
> @@ -1576,8 +1602,10 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
>  	struct vring_desc_state_packed *state = NULL;
>  	struct vring_packed_desc *desc;
>  	unsigned int i, curr;
> +	bool premapped;
>  
>  	state = &vq->packed.desc_state[id];
> +	premapped = state->premapped;
>  
>  	/* Clear data ptr. */
>  	state->data = NULL;
> @@ -1590,7 +1618,8 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
>  		curr = id;
>  		for (i = 0; i < state->num; i++) {
>  			vring_unmap_extra_packed(vq,
> -						 &vq->packed.desc_extra[curr]);
> +						 &vq->packed.desc_extra[curr],
> +						 premapped);
>  			curr = vq->packed.desc_extra[curr].next;
>  		}
>  	}
> @@ -1603,7 +1632,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
>  		if (!desc)
>  			return;
>  
> -		if (vq->use_dma_api) {
> +		if (vq->use_dma_api && !premapped) {
>  			len = vq->packed.desc_extra[id].len;
>  			for (i = 0; i < len / sizeof(struct vring_packed_desc);
>  					i++)
> @@ -2122,7 +2151,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  	return vq->packed_ring ? virtqueue_add_packed(_vq, sgs, total_sg,
> -					out_sgs, in_sgs, data, ctx, gfp) :
> +					out_sgs, in_sgs, data, ctx, premapped, gfp) :
>  				 virtqueue_add_split(_vq, sgs, total_sg,
>  					out_sgs, in_sgs, data, ctx, premapped, gfp);
>  }


Too much if !premapped all over the place. Pls refactor so we
get common code and then have premapped and non premapped
versions call that.
> -- 
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
