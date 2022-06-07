Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F37C433EF
	for <virtualization@archiver.kernel.org>; Tue,  7 Jun 2022 06:38:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 078F4802EE;
	Tue,  7 Jun 2022 06:38:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0H5rwa73T_d0; Tue,  7 Jun 2022 06:38:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3676484164;
	Tue,  7 Jun 2022 06:38:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2F49C0039;
	Tue,  7 Jun 2022 06:38:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21674C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 06:38:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1E09D410B1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 06:38:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YZO7sEdr2KLk
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 06:38:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CB243410AE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 06:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654583904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wbmh+cLiNUkJ2GMihMw3AGFn+jmS9SCo8bwKY106OII=;
 b=Fk4Z8L541KWUU4lvlpo5Yf6XAdSr/sLsL3A/J2QBG+LpVwTwTaWgpBK6ljk11hy+8CDfsQ
 G6ZUdVHqcNVf4voD0f3IHwr5NeUXq5LHmcX9G47sAoA6xnn6ysL+bMZOPTllgdQcS6w5du
 TEztM8SJ0DpQMcbUkb9QnIcpSvBgtc8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-Wh4e7ahRMlOvOAc640lcNg-1; Tue, 07 Jun 2022 02:38:22 -0400
X-MC-Unique: Wh4e7ahRMlOvOAc640lcNg-1
Received: by mail-ed1-f70.google.com with SMTP id
 x8-20020a056402414800b0042d8498f50aso12018375eda.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Jun 2022 23:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Wbmh+cLiNUkJ2GMihMw3AGFn+jmS9SCo8bwKY106OII=;
 b=LCs6Kjhxx0iwMivdOEiPDIxnJnuH8DvP38ctQKW0/zB8xg6GQxBO7Eya+bp7ttx9gG
 niWn64cnoTj9AgVXk5scBh5wXxZ9GtzzOQFdJUOedanMnNKZbQ3jxbKBAtRJSUBOnuEc
 /FxoWwOE9q/o6UHROh3JkvyOb3brsYJ0wCTSuEafWfY83zAX2kgtOd1eeCl/+xe3/vKH
 NRkuwgU5+lq5VpQN5lZYV/zW50EcnTLuLEOn1YtScy+MJuuzBfAmg7SeV3IfepV3z95k
 4p+SiQf8eE3z119Sia6otPStBrK3wpvVQp5X/oHzfjywhzrXNCOn5d+Swq3UktPZjqQz
 vzvg==
X-Gm-Message-State: AOAM531NJlTzIFbJQA3/ZC5rrcv0XDJP7R3DzNy3ESc0AC41CoSW54QF
 7nFeA9Yd4czQ3I0luqt7QFrt7R9Mso5D9HRuGRznn9rFMIme9slgfu6bBMnl3Hu8u1C2UVUci5p
 jx3illRoLWskjwdG0hXFE+JZd+BcLYwM/ny3484OJog==
X-Received: by 2002:a05:6402:51c7:b0:42d:f4ea:c09 with SMTP id
 r7-20020a05640251c700b0042df4ea0c09mr31162733edd.319.1654583900914; 
 Mon, 06 Jun 2022 23:38:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1Jps7kQ/xohH/8dtmq4OQwlyD81Z2cqYGOAsw9R6m19VYfQyyVmkIypwUyyL51/3gQ8oV5Q==
X-Received: by 2002:a05:6402:51c7:b0:42d:f4ea:c09 with SMTP id
 r7-20020a05640251c700b0042df4ea0c09mr31162718edd.319.1654583900647; 
 Mon, 06 Jun 2022 23:38:20 -0700 (PDT)
Received: from redhat.com ([2.55.169.1]) by smtp.gmail.com with ESMTPSA id
 en22-20020a056402529600b0043120d5f3dcsm4829582edb.14.2022.06.06.23.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jun 2022 23:38:20 -0700 (PDT)
Date: Tue, 7 Jun 2022 02:38:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bo Liu <liubo03@inspur.com>
Subject: Re: [PATCH] virtio_ring: remove unnecessary to_vvq call
Message-ID: <20220607023646-mutt-send-email-mst@kernel.org>
References: <20220607005951.2221-1-liubo03@inspur.com>
MIME-Version: 1.0
In-Reply-To: <20220607005951.2221-1-liubo03@inspur.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Mon, Jun 06, 2022 at 08:59:51PM -0400, Bo Liu wrote:
> In many functions, the parameter passed in is "_vq", which still call
> to_vvq() to get 'vq'. It can avoid unnecessary call of to_vvq() by directly
> passing in the parameter "vq".
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

What does the patch accomplish? Is the generated binary faster? smaller?

> ---
>  drivers/virtio/virtio_ring.c | 100 ++++++++++++++---------------------
>  1 file changed, 41 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 13a7348cedff..f82db59fdbdc 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -648,9 +648,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	return -ENOMEM;
>  }
>  
> -static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
> +static bool virtqueue_kick_prepare_split(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	u16 new, old;
>  	bool needs_kick;
>  
> @@ -667,12 +666,12 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
>  	LAST_ADD_TIME_INVALID(vq);
>  
>  	if (vq->event) {
> -		needs_kick = vring_need_event(virtio16_to_cpu(_vq->vdev,
> +		needs_kick = vring_need_event(virtio16_to_cpu(vq->vq.vdev,
>  					vring_avail_event(&vq->split.vring)),
>  					      new, old);
>  	} else {
>  		needs_kick = !(vq->split.vring.used->flags &
> -					cpu_to_virtio16(_vq->vdev,
> +					cpu_to_virtio16(vq->vq.vdev,
>  						VRING_USED_F_NO_NOTIFY));
>  	}
>  	END_USE(vq);
> @@ -735,11 +734,10 @@ static inline bool more_used_split(const struct vring_virtqueue *vq)
>  			vq->split.vring.used->idx);
>  }
>  
> -static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> +static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
>  					 unsigned int *len,
>  					 void **ctx)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	void *ret;
>  	unsigned int i;
>  	u16 last_used;
> @@ -761,9 +759,9 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  	virtio_rmb(vq->weak_barriers);
>  
>  	last_used = (vq->last_used_idx & (vq->split.vring.num - 1));
> -	i = virtio32_to_cpu(_vq->vdev,
> +	i = virtio32_to_cpu(vq->vq.vdev,
>  			vq->split.vring.used->ring[last_used].id);
> -	*len = virtio32_to_cpu(_vq->vdev,
> +	*len = virtio32_to_cpu(vq->vq.vdev,
>  			vq->split.vring.used->ring[last_used].len);
>  
>  	if (unlikely(i >= vq->split.vring.num)) {
> @@ -785,7 +783,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
>  		virtio_store_mb(vq->weak_barriers,
>  				&vring_used_event(&vq->split.vring),
> -				cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
> +				cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx));
>  
>  	LAST_ADD_TIME_INVALID(vq);
>  
> @@ -793,10 +791,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  	return ret;
>  }
>  
> -static void virtqueue_disable_cb_split(struct virtqueue *_vq)
> +static void virtqueue_disable_cb_split(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> -
>  	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
>  		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
>  		if (vq->event)
> @@ -804,14 +800,13 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
>  			vring_used_event(&vq->split.vring) = 0x0;
>  		else
>  			vq->split.vring.avail->flags =
> -				cpu_to_virtio16(_vq->vdev,
> +				cpu_to_virtio16(vq->vq.vdev,
>  						vq->split.avail_flags_shadow);
>  	}
>  }
>  
> -static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
> +static unsigned int virtqueue_enable_cb_prepare_split(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	u16 last_used_idx;
>  
>  	START_USE(vq);
> @@ -825,26 +820,23 @@ static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
>  		vq->split.avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
>  		if (!vq->event)
>  			vq->split.vring.avail->flags =
> -				cpu_to_virtio16(_vq->vdev,
> +				cpu_to_virtio16(vq->vq.vdev,
>  						vq->split.avail_flags_shadow);
>  	}
> -	vring_used_event(&vq->split.vring) = cpu_to_virtio16(_vq->vdev,
> +	vring_used_event(&vq->split.vring) = cpu_to_virtio16(vq->vq.vdev,
>  			last_used_idx = vq->last_used_idx);
>  	END_USE(vq);
>  	return last_used_idx;
>  }
>  
> -static bool virtqueue_poll_split(struct virtqueue *_vq, unsigned int last_used_idx)
> +static bool virtqueue_poll_split(struct vring_virtqueue *vq, unsigned int last_used_idx)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> -
> -	return (u16)last_used_idx != virtio16_to_cpu(_vq->vdev,
> +	return (u16)last_used_idx != virtio16_to_cpu(vq->vq.vdev,
>  			vq->split.vring.used->idx);
>  }
>  
> -static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
> +static bool virtqueue_enable_cb_delayed_split(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	u16 bufs;
>  
>  	START_USE(vq);
> @@ -858,7 +850,7 @@ static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
>  		vq->split.avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
>  		if (!vq->event)
>  			vq->split.vring.avail->flags =
> -				cpu_to_virtio16(_vq->vdev,
> +				cpu_to_virtio16(vq->vq.vdev,
>  						vq->split.avail_flags_shadow);
>  	}
>  	/* TODO: tune this threshold */
> @@ -866,9 +858,9 @@ static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
>  
>  	virtio_store_mb(vq->weak_barriers,
>  			&vring_used_event(&vq->split.vring),
> -			cpu_to_virtio16(_vq->vdev, vq->last_used_idx + bufs));
> +			cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx + bufs));
>  
> -	if (unlikely((u16)(virtio16_to_cpu(_vq->vdev, vq->split.vring.used->idx)
> +	if (unlikely((u16)(virtio16_to_cpu(vq->vq.vdev, vq->split.vring.used->idx)
>  					- vq->last_used_idx) > bufs)) {
>  		END_USE(vq);
>  		return false;
> @@ -878,9 +870,8 @@ static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
>  	return true;
>  }
>  
> -static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
> +static void *virtqueue_detach_unused_buf_split(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	unsigned int i;
>  	void *buf;
>  
> @@ -893,7 +884,7 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
>  		buf = vq->split.desc_state[i].data;
>  		detach_buf_split(vq, i, NULL);
>  		vq->split.avail_idx_shadow--;
> -		vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> +		vq->split.vring.avail->idx = cpu_to_virtio16(vq->vq.vdev,
>  				vq->split.avail_idx_shadow);
>  		END_USE(vq);
>  		return buf;
> @@ -1296,9 +1287,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	return -EIO;
>  }
>  
> -static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
> +static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	u16 new, old, off_wrap, flags, wrap_counter, event_idx;
>  	bool needs_kick;
>  	union {
> @@ -1410,11 +1400,10 @@ static inline bool more_used_packed(const struct vring_virtqueue *vq)
>  			vq->packed.used_wrap_counter);
>  }
>  
> -static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> +static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
>  					  unsigned int *len,
>  					  void **ctx)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	u16 last_used, id;
>  	void *ret;
>  
> @@ -1475,10 +1464,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  	return ret;
>  }
>  
> -static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
> +static void virtqueue_disable_cb_packed(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> -
>  	if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE) {
>  		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
>  		vq->packed.vring.driver->flags =
> @@ -1486,10 +1473,8 @@ static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
>  	}
>  }
>  
> -static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
> +static unsigned int virtqueue_enable_cb_prepare_packed(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> -
>  	START_USE(vq);
>  
>  	/*
> @@ -1522,9 +1507,8 @@ static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
>  			VRING_PACKED_EVENT_F_WRAP_CTR);
>  }
>  
> -static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
> +static bool virtqueue_poll_packed(struct vring_virtqueue *vq, u16 off_wrap)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	bool wrap_counter;
>  	u16 used_idx;
>  
> @@ -1534,9 +1518,8 @@ static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
>  	return is_used_desc_packed(vq, used_idx, wrap_counter);
>  }
>  
> -static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
> +static bool virtqueue_enable_cb_delayed_packed(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	u16 used_idx, wrap_counter;
>  	u16 bufs;
>  
> @@ -1593,9 +1576,8 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
>  	return true;
>  }
>  
> -static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
> +static void *virtqueue_detach_unused_buf_packed(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	unsigned int i;
>  	void *buf;
>  
> @@ -1906,8 +1888,8 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->packed_ring ? virtqueue_kick_prepare_packed(_vq) :
> -				 virtqueue_kick_prepare_split(_vq);
> +	return vq->packed_ring ? virtqueue_kick_prepare_packed(vq) :
> +				 virtqueue_kick_prepare_split(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
>  
> @@ -1977,8 +1959,8 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, ctx) :
> -				 virtqueue_get_buf_ctx_split(_vq, len, ctx);
> +	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(vq, len, ctx) :
> +				 virtqueue_get_buf_ctx_split(vq, len, ctx);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
>  
> @@ -2007,9 +1989,9 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
>  		return;
>  
>  	if (vq->packed_ring)
> -		virtqueue_disable_cb_packed(_vq);
> +		virtqueue_disable_cb_packed(vq);
>  	else
> -		virtqueue_disable_cb_split(_vq);
> +		virtqueue_disable_cb_split(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
>  
> @@ -2032,8 +2014,8 @@ unsigned int virtqueue_enable_cb_prepare(struct virtqueue *_vq)
>  	if (vq->event_triggered)
>  		vq->event_triggered = false;
>  
> -	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) :
> -				 virtqueue_enable_cb_prepare_split(_vq);
> +	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(vq) :
> +				 virtqueue_enable_cb_prepare_split(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
>  
> @@ -2054,8 +2036,8 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
>  		return false;
>  
>  	virtio_mb(vq->weak_barriers);
> -	return vq->packed_ring ? virtqueue_poll_packed(_vq, last_used_idx) :
> -				 virtqueue_poll_split(_vq, last_used_idx);
> +	return vq->packed_ring ? virtqueue_poll_packed(vq, last_used_idx) :
> +				 virtqueue_poll_split(vq, last_used_idx);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_poll);
>  
> @@ -2098,8 +2080,8 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
>  	if (vq->event_triggered)
>  		vq->event_triggered = false;
>  
> -	return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(_vq) :
> -				 virtqueue_enable_cb_delayed_split(_vq);
> +	return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(vq) :
> +				 virtqueue_enable_cb_delayed_split(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
>  
> @@ -2115,8 +2097,8 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(_vq) :
> -				 virtqueue_detach_unused_buf_split(_vq);
> +	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(vq) :
> +				 virtqueue_detach_unused_buf_split(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
>  
> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
