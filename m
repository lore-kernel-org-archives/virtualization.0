Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9841AC7EE24
	for <virtualization@archiver.kernel.org>; Fri,  2 Jun 2023 11:40:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1417C84453;
	Fri,  2 Jun 2023 11:40:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1417C84453
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YLVcfy46
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TQPsgzfD1Wec; Fri,  2 Jun 2023 11:40:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 63F428444B;
	Fri,  2 Jun 2023 11:40:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 63F428444B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41018C0037;
	Fri,  2 Jun 2023 11:40:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE0D7C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 11:40:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7ACA38444E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 11:40:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7ACA38444E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aLPhr7D9iOC3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 11:40:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7FC488444B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7FC488444B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 11:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685706053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VxnskxVO8AXS1VjjPX0Qehr8afrCv+Lu5/PB3QTgDqI=;
 b=YLVcfy46i1j3Uf5FPOWDTklHTCzy5OSNxmH5XgBnS/UyyhIYNLbR8lEJVPKMPXvYmgFsND
 gUrlSLqZXOBG9YdI8S7kAK1/2PHyB/W9UP2xHhhvz+J8wFGt130j8id2y5BZbpoolzJ7Fk
 vALoiMJ9j2GGcmuMAUFIwi0+U9dqiNs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-E8PfLUIuMEmAGeYw4FCLMA-1; Fri, 02 Jun 2023 07:40:52 -0400
X-MC-Unique: E8PfLUIuMEmAGeYw4FCLMA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f6069f764bso33227655e9.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 02 Jun 2023 04:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685706051; x=1688298051;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VxnskxVO8AXS1VjjPX0Qehr8afrCv+Lu5/PB3QTgDqI=;
 b=QSQfA2fChNfQbGZcdOt6RTDE/CqyvnAqdxJHe1tsMtOm6Jt+fJBo/QswqqLOOjMnCt
 AnYbeaQ3nMYXUQA3re/7bfLoM1bcd+NMIM2LHTx4lgwVyrNwyVWkSUtN05dG5Wsio+HG
 OglOeOd/5mCzdoBEsPnb7hO2X6ht31KWuIZecVPehrJlhX9ZsT2nHg5o5YyaCUew7pOu
 5JXy7NKF0vvI+qWTbf2RimmBumnhtdq7A4gCGucHqzM7cvuAXNSzlFIjD+89W7ISx4Oe
 rv5WeNYMSJ2fMeTMEK6Djy1xgHP2EtWMyT1dCo0358sShgmFiFWJKTLhERtPI+cawRbS
 qQwg==
X-Gm-Message-State: AC+VfDx3yec6Jstb3ZyjsFTspZGaczAdTXF7nv46qHG4Wot/yXdkHONf
 02A/V/cHImk/yeIiU+BpwkYaYrGJpB7TfktfHPza2hlRXA8CDX8/2ltFzEEXmJRW/BkzCZkhJ3J
 GhQuN9wgxJXE86qQGPNmlTS0PZW3mXqXBo+qYMteO+g==
X-Received: by 2002:a7b:c40e:0:b0:3f6:692:5607 with SMTP id
 k14-20020a7bc40e000000b003f606925607mr1576906wmi.40.1685706051318; 
 Fri, 02 Jun 2023 04:40:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5kq+QX6iZImB+mIj7tvU+uwhorlCzeq6kS3V5YFUILtTH1qTcWoVOSLmlm1M3rGXDIz4wULg==
X-Received: by 2002:a7b:c40e:0:b0:3f6:692:5607 with SMTP id
 k14-20020a7bc40e000000b003f606925607mr1576894wmi.40.1685706050946; 
 Fri, 02 Jun 2023 04:40:50 -0700 (PDT)
Received: from redhat.com ([2.55.4.169]) by smtp.gmail.com with ESMTPSA id
 u8-20020a7bc048000000b003f4b6bcbd8bsm1688452wmc.31.2023.06.02.04.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 04:40:50 -0700 (PDT)
Date: Fri, 2 Jun 2023 07:40:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v10 06/10] virtio_ring: packed-detach: support
 return dma info to driver
Message-ID: <20230602073827-mutt-send-email-mst@kernel.org>
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-7-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230602092206.50108-7-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Fri, Jun 02, 2023 at 05:22:02PM +0800, Xuan Zhuo wrote:
> Under the premapped mode, the driver needs to unmap the DMA address
> after receiving the buffer. The virtio core records the DMA address,
> so the driver needs a way to get the dma info from the virtio core.
> 
> A straightforward approach is to pass an array to the virtio core when
> calling virtqueue_get_buf(). However, it is not feasible when there are
> multiple DMA addresses in the descriptor chain, and the array size is
> unknown.
> 
> To solve this problem, a helper be introduced. After calling
> virtqueue_get_buf(), the driver can call the helper to
> retrieve a dma info. If the helper function returns -EAGAIN, it means
> that there are more DMA addresses to be processed, and the driver should
> call the helper function again.


Please, keep error codes for when an actual error occurs.
A common pattern would be:
	<0 - error
	0 - success, done
	>0 - success, more to do


> To keep track of the current position in
> the chain, a cursor must be passed to the helper function, which is
> initialized by virtqueue_get_buf().
> 
> Some processes are done inside this helper, so this helper MUST be
> called under the premapped mode.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 105 ++++++++++++++++++++++++++++++++---
>  include/linux/virtio.h       |   9 ++-
>  2 files changed, 103 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cdc4349f6066..cbc22daae7e1 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1695,8 +1695,85 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
>  	return needs_kick;
>  }
>  
> +static void detach_cursor_init_packed(struct vring_virtqueue *vq,
> +				      struct virtqueue_detach_cursor *cursor, u16 id)
> +{
> +	struct vring_desc_state_packed *state = NULL;
> +	u32 len;
> +
> +	state = &vq->packed.desc_state[id];
> +
> +	/* Clear data ptr. */
> +	state->data = NULL;
> +
> +	vq->packed.desc_extra[state->last].next = vq->free_head;
> +	vq->free_head = id;
> +	vq->vq.num_free += state->num;
> +
> +	/* init cursor */
> +	cursor->curr = id;
> +	cursor->done = 0;
> +	cursor->pos = 0;
> +
> +	if (vq->packed.desc_extra[id].flags & VRING_DESC_F_INDIRECT) {
> +		len = vq->split.desc_extra[id].len;
> +
> +		cursor->num = len / sizeof(struct vring_packed_desc);
> +		cursor->indirect = true;
> +
> +		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[id]);
> +	} else {
> +		cursor->num = state->num;
> +		cursor->indirect = false;
> +	}
> +}
> +
> +static int virtqueue_detach_packed(struct virtqueue *_vq, struct virtqueue_detach_cursor *cursor,
> +				   dma_addr_t *addr, u32 *len, enum dma_data_direction *dir)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	if (unlikely(cursor->done))
> +		return -EINVAL;
> +
> +	if (!cursor->indirect) {
> +		struct vring_desc_extra *extra;
> +
> +		extra = &vq->packed.desc_extra[cursor->curr];
> +		cursor->curr = extra->next;
> +
> +		*addr = extra->addr;
> +		*len = extra->len;
> +		*dir = (extra->flags & VRING_DESC_F_WRITE) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
> +
> +		if (++cursor->pos == cursor->num) {
> +			cursor->done = true;
> +			return 0;
> +		}
> +	} else {
> +		struct vring_packed_desc *indir_desc, *desc;
> +		u16 flags;
> +
> +		indir_desc = vq->packed.desc_state[cursor->curr].indir_desc;
> +		desc = &indir_desc[cursor->pos];
> +
> +		flags = le16_to_cpu(desc->flags);
> +		*addr = le64_to_cpu(desc->addr);
> +		*len = le32_to_cpu(desc->len);
> +		*dir = (flags & VRING_DESC_F_WRITE) ?  DMA_FROM_DEVICE : DMA_TO_DEVICE;
> +
> +		if (++cursor->pos == cursor->num) {
> +			kfree(indir_desc);
> +			cursor->done = true;
> +			return 0;
> +		}
> +	}
> +
> +	return -EAGAIN;
> +}
> +
>  static void detach_buf_packed(struct vring_virtqueue *vq,
> -			      unsigned int id, void **ctx)
> +			      unsigned int id)
>  {
>  	struct vring_desc_state_packed *state = NULL;
>  	struct vring_packed_desc *desc;
> @@ -1736,8 +1813,6 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
>  		}
>  		kfree(desc);
>  		state->indir_desc = NULL;
> -	} else if (ctx) {
> -		*ctx = state->indir_desc;
>  	}
>  }
>  
> @@ -1768,7 +1843,8 @@ static bool more_used_packed(const struct vring_virtqueue *vq)
>  
>  static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  					  unsigned int *len,
> -					  void **ctx)
> +					  void **ctx,
> +					  struct virtqueue_detach_cursor *cursor)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  	u16 last_used, id, last_used_idx;
> @@ -1808,7 +1884,14 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  
>  	/* detach_buf_packed clears data, so grab it now. */
>  	ret = vq->packed.desc_state[id].data;
> -	detach_buf_packed(vq, id, ctx);
> +
> +	if (!vq->indirect && ctx)
> +		*ctx = vq->packed.desc_state[id].indir_desc;
> +
> +	if (vq->premapped)
> +		detach_cursor_init_packed(vq, cursor, id);
> +	else
> +		detach_buf_packed(vq, id);
>  
>  	last_used += vq->packed.desc_state[id].num;
>  	if (unlikely(last_used >= vq->packed.vring.num)) {
> @@ -1960,7 +2043,8 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
>  	return true;
>  }
>  
> -static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
> +static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq,
> +						struct virtqueue_detach_cursor *cursor)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  	unsigned int i;
> @@ -1973,7 +2057,10 @@ static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
>  			continue;
>  		/* detach_buf clears data, so grab it now. */
>  		buf = vq->packed.desc_state[i].data;
> -		detach_buf_packed(vq, i, NULL);
> +		if (vq->premapped)
> +			detach_cursor_init_packed(vq, cursor, i);
> +		else
> +			detach_buf_packed(vq, i);
>  		END_USE(vq);
>  		return buf;
>  	}
> @@ -2458,7 +2545,7 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, ctx) :
> +	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, ctx, NULL) :
>  				 virtqueue_get_buf_ctx_split(_vq, len, ctx, NULL);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
> @@ -2590,7 +2677,7 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(_vq) :
> +	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(_vq, NULL) :
>  				 virtqueue_detach_unused_buf_split(_vq, NULL);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index eb4a4e4329aa..7f137c7a9034 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -43,8 +43,13 @@ struct virtqueue_detach_cursor {
>  	unsigned done:1;
>  	unsigned hole:14;
>  
> -	/* for split head */
> -	unsigned head:16;
> +	union {
> +		/* for split head */
> +		unsigned head:16;
> +
> +		/* for packed id */
> +		unsigned curr:16;
> +	};
>  	unsigned num:16;
>  	unsigned pos:16;
>  };
> -- 
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
