Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90AEEB64DC
	for <virtualization@archiver.kernel.org>; Thu, 22 Jun 2023 19:36:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20282420E5;
	Thu, 22 Jun 2023 19:36:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 20282420E5
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gQhzlEbJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VkFkM80DOwbi; Thu, 22 Jun 2023 19:36:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D0B9C420A7;
	Thu, 22 Jun 2023 19:36:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D0B9C420A7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91A01C0037;
	Thu, 22 Jun 2023 19:36:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76556C0029
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 19:36:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4AC1683D0C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 19:36:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4AC1683D0C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gQhzlEbJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mJOghU8RIahh
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 19:36:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0733383CD8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0733383CD8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 19:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687462609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xomtdkpx+OSXN9zGfziQJLruZyJHAVV/laO4mRJwrJc=;
 b=gQhzlEbJUMiVx81DdQU7DjFR4hv7GCaRMkX77FqjtiH7HmBxVx6liYRVAJxTGM62zClEw3
 ElMPeGqIeb1h46h96z1As6+2NpkcYJCbhKy6MnbyaflVrestq0Tc1gc9FePpzfMlMnfBNB
 y3U25euiZNYXt2w/7YJrBHNXpftysc8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-bPKS1dbgPKagrfp4rs9Wxw-1; Thu, 22 Jun 2023 15:36:47 -0400
X-MC-Unique: bPKS1dbgPKagrfp4rs9Wxw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f7e7cfcae4so41314985e9.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 12:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687462606; x=1690054606;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xomtdkpx+OSXN9zGfziQJLruZyJHAVV/laO4mRJwrJc=;
 b=kyamzbUEASKCGTHV5v68Q22YpPkOqv5ulVBlEpDPtyZykaJiZnq9Y4TLvJGrKnWOrP
 OT2HmpBUPepMeW/MnJ33OLC6TvwGXkXmjYRkPoNpXm3x19Tlz7w2+paxEJoLVvf6V0Pg
 rtw532ggq4Estt7oPb3Gwvd/ayP+V12YqIy+HcZ1/inh+DFb9C+KsD/4UTkEOFyNPrYU
 9zJ3fTjZDBS0gaL1610U0/yIDEiNXLrU9K26+Pyrq7GauMUYKoIFF/JXTd7Tf8PUkSzW
 yr7FtBe+1yrcw5esr7L3fgyMM2GsRqqa9jbaWeCQk4hP3+f2LhVaP+h5cRW1qb8zMCyP
 I6wA==
X-Gm-Message-State: AC+VfDyjuJw4QCRHXCPC7kH2QfqKAtkTBzDxCkcFnocNC6OU9hj41ZgA
 HgfuYdxX7pgvH7jFTWX79N+JFjM4DnjCM1J0MscoOdZu12bK0Xa38u1qVDlDiXBMFi9WsUeTVTn
 SkgdC6880LFZ18sYIEHYGgKIoUixlxi2QmuK0pQ3faA==
X-Received: by 2002:a7b:cc8d:0:b0:3f7:3937:f5f2 with SMTP id
 p13-20020a7bcc8d000000b003f73937f5f2mr18244260wma.22.1687462606707; 
 Thu, 22 Jun 2023 12:36:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ffZmX/D2AmBX/0MjjySgMwN2Bt3XcGhIPrKbhVjFlueINY+ObTbza8dbbywFD++ptZXDnhw==
X-Received: by 2002:a7b:cc8d:0:b0:3f7:3937:f5f2 with SMTP id
 p13-20020a7bcc8d000000b003f73937f5f2mr18244241wma.22.1687462606355; 
 Thu, 22 Jun 2023 12:36:46 -0700 (PDT)
Received: from redhat.com ([2.52.149.110]) by smtp.gmail.com with ESMTPSA id
 v14-20020a1cf70e000000b003f9b2c602c0sm291066wmh.37.2023.06.22.12.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 12:36:45 -0700 (PDT)
Date: Thu, 22 Jun 2023 15:36:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v10 05/10] virtio_ring: split-detach: support
 return dma info to driver
Message-ID: <20230622153111-mutt-send-email-mst@kernel.org>
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-6-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230602092206.50108-6-xuanzhuo@linux.alibaba.com>
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

On Fri, Jun 02, 2023 at 05:22:01PM +0800, Xuan Zhuo wrote:
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
> call the helper function again. To keep track of the current position in
> the chain, a cursor must be passed to the helper function, which is
> initialized by virtqueue_get_buf().
> 
> Some processes are done inside this helper, so this helper MUST be
> called under the premapped mode.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 118 ++++++++++++++++++++++++++++++++---
>  include/linux/virtio.h       |  11 ++++
>  2 files changed, 119 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index dc109fbc05a5..cdc4349f6066 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -754,8 +754,95 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
>  	return needs_kick;
>  }
>  
> -static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> -			     void **ctx)
> +static void detach_cursor_init_split(struct vring_virtqueue *vq,
> +				     struct virtqueue_detach_cursor *cursor, u16 head)
> +{
> +	struct vring_desc_extra *extra;
> +
> +	extra = &vq->split.desc_extra[head];
> +
> +	/* Clear data ptr. */
> +	vq->split.desc_state[head].data = NULL;
> +
> +	cursor->head = head;
> +	cursor->done = 0;
> +
> +	if (extra->flags & VRING_DESC_F_INDIRECT) {
> +		cursor->num = extra->len / sizeof(struct vring_desc);
> +		cursor->indirect = true;
> +		cursor->pos = 0;
> +
> +		vring_unmap_one_split(vq, head);
> +
> +		extra->next = vq->free_head;
> +
> +		vq->free_head = head;
> +
> +		/* Plus final descriptor */
> +		vq->vq.num_free++;
> +
> +	} else {
> +		cursor->indirect = false;
> +		cursor->pos = head;
> +	}
> +}
> +
> +static int virtqueue_detach_split(struct virtqueue *_vq, struct virtqueue_detach_cursor *cursor,
> +				  dma_addr_t *addr, u32 *len, enum dma_data_direction *dir)
> +{

I don't get it. This is generic split vq code? Why is it unconditionally
wasting time with cursors etc? Poking at split.desc_extra when not
necessary is also not really nice, will cause lots of cache misses.

And it looks like we duplicated a bunch of logic?


> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
> +	int rc = -EAGAIN;
> +
> +	if (unlikely(cursor->done))
> +		return -EINVAL;
> +
> +	if (!cursor->indirect) {
> +		struct vring_desc_extra *extra;
> +		unsigned int i;
> +
> +		i = cursor->pos;
> +
> +		extra = &vq->split.desc_extra[i];
> +
> +		if (vq->split.vring.desc[i].flags & nextflag) {
> +			cursor->pos = extra->next;
> +		} else {
> +			extra->next = vq->free_head;
> +			vq->free_head = cursor->head;
> +			cursor->done = true;
> +			rc = 0;
> +		}
> +
> +		*addr = extra->addr;
> +		*len = extra->len;
> +		*dir = (extra->flags & VRING_DESC_F_WRITE) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
> +
> +		vq->vq.num_free++;
> +
> +	} else {
> +		struct vring_desc *indir_desc, *desc;
> +		u16 flags;
> +
> +		indir_desc = vq->split.desc_state[cursor->head].indir_desc;
> +		desc = &indir_desc[cursor->pos];
> +
> +		flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
> +		*addr = virtio64_to_cpu(vq->vq.vdev, desc->addr);
> +		*len = virtio32_to_cpu(vq->vq.vdev, desc->len);
> +		*dir = (flags & VRING_DESC_F_WRITE) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
> +
> +		if (++cursor->pos == cursor->num) {
> +			kfree(indir_desc);
> +			cursor->done = true;
> +			return 0;
> +		}
> +	}
> +
> +	return rc;
> +}
> +
> +static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head)
>  {
>  	unsigned int i, j;
>  	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
> @@ -799,8 +886,6 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  
>  		kfree(indir_desc);
>  		vq->split.desc_state[head].indir_desc = NULL;
> -	} else if (ctx) {
> -		*ctx = vq->split.desc_state[head].indir_desc;
>  	}
>  }
>  
> @@ -812,7 +897,8 @@ static bool more_used_split(const struct vring_virtqueue *vq)
>  
>  static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  					 unsigned int *len,
> -					 void **ctx)
> +					 void **ctx,
> +					 struct virtqueue_detach_cursor *cursor)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  	void *ret;
> @@ -852,7 +938,15 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  
>  	/* detach_buf_split clears data, so grab it now. */
>  	ret = vq->split.desc_state[i].data;
> -	detach_buf_split(vq, i, ctx);
> +
> +	if (!vq->indirect && ctx)
> +		*ctx = vq->split.desc_state[i].indir_desc;
> +
> +	if (vq->premapped)
> +		detach_cursor_init_split(vq, cursor, i);
> +	else
> +		detach_buf_split(vq, i);
> +
>  	vq->last_used_idx++;
>  	/* If we expect an interrupt for the next entry, tell host
>  	 * by writing event index and flush out the write before
> @@ -961,7 +1055,8 @@ static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
>  	return true;
>  }
>  
> -static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
> +static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq,
> +					       struct virtqueue_detach_cursor *cursor)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  	unsigned int i;
> @@ -974,7 +1069,10 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
>  			continue;
>  		/* detach_buf_split clears data, so grab it now. */
>  		buf = vq->split.desc_state[i].data;
> -		detach_buf_split(vq, i, NULL);
> +		if (vq->premapped)
> +			detach_cursor_init_split(vq, cursor, i);
> +		else
> +			detach_buf_split(vq, i);
>  		vq->split.avail_idx_shadow--;
>  		vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>  				vq->split.avail_idx_shadow);
> @@ -2361,7 +2459,7 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, ctx) :
> -				 virtqueue_get_buf_ctx_split(_vq, len, ctx);
> +				 virtqueue_get_buf_ctx_split(_vq, len, ctx, NULL);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
>  
> @@ -2493,7 +2591,7 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(_vq) :
> -				 virtqueue_detach_unused_buf_split(_vq);
> +				 virtqueue_detach_unused_buf_split(_vq, NULL);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
>  
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 1fc0e1023bd4..eb4a4e4329aa 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -38,6 +38,17 @@ struct virtqueue {
>  	void *priv;
>  };
>  
> +struct virtqueue_detach_cursor {
> +	unsigned indirect:1;
> +	unsigned done:1;
> +	unsigned hole:14;
> +
> +	/* for split head */
> +	unsigned head:16;
> +	unsigned num:16;
> +	unsigned pos:16;
> +};
> +

is cursor ever stored somewhere? If not don't use bitfields,
they cause many gcc versions to generate atrocious code.


>  int virtqueue_add_outbuf(struct virtqueue *vq,
>  			 struct scatterlist sg[], unsigned int num,
>  			 void *data,
> -- 
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
