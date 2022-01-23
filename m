Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5429BC433EF
	for <virtualization@archiver.kernel.org>; Sun, 23 Jan 2022 22:40:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C66C781274;
	Sun, 23 Jan 2022 22:40:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vboAGNi45hDX; Sun, 23 Jan 2022 22:40:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 490D58126A;
	Sun, 23 Jan 2022 22:40:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A527C0031;
	Sun, 23 Jan 2022 22:40:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22E10C002F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 22:40:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0A8A560DFF
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 22:40:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LWn0IugjtMcB
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 22:40:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6E38560DDF
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 22:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642977619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0pIY2RGPU7KzoGfuQNFBNefJk1n5vPd00tDnIcgg4Dg=;
 b=YwxVEsV57fMrfv1SN5dH9IO4/3wPe25g1qxFG+X+pHW69XLqVrp5w3tSTkxcrtPKXbhrKk
 SmtKvNDoEy8BCsl7lOa7Ufp81Zpzge0kGtz+9O71TfwK4WmN5S8jq6KvnvdXGz6Dev4sBy
 /j4VepHmvxfDhbRo57Xd2gnXBdb4FWM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-4ztJ2dZnOEeFg-PEIUAtvw-1; Sun, 23 Jan 2022 17:40:17 -0500
X-MC-Unique: 4ztJ2dZnOEeFg-PEIUAtvw-1
Received: by mail-wm1-f72.google.com with SMTP id
 bg16-20020a05600c3c9000b0034bea12c043so13806912wmb.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 14:40:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0pIY2RGPU7KzoGfuQNFBNefJk1n5vPd00tDnIcgg4Dg=;
 b=ECqQ5dHhtLd3wKnvZ7bis+AMIqFd/Sw8YijZhk9EzGRxLXKOkPD6b8o4CpVGIsW2wR
 sYlcsAOes5c4Vj0+IEYcvSONOCe541/rtMh17GH2gczuPJcqYHv+GJWp7dXOqRxJ9EKJ
 dzcwKPB+NXA+W1/2lJD+Eg5N9dv6NJ4TP2jJQyTh2LSQ8QgGEl1MFfAJHVf9ll6iQZ5L
 3eXamWObrgWKpZi/xGUa/OU3VGeZPJYq+zMAc1q/rA+YrjmwneQn9CKm7zlxhkzYIrfW
 0S2tlcG+2aZ9MIziOWrL5y5nsYHXGwe2OIyUZP98YiXBmgu+8pHX71BV6MO06vY8vW+9
 o9mg==
X-Gm-Message-State: AOAM533EZLtvC1tR3Rhkaqhz+LzEbwet4bluX0uq98TpfZHfVWMbYWMy
 pbCAUr4xpJzKs9Y2AVj2cdcXb6xDrKBw1bICWrbyxRT00QBdQPNRb8rxdHnfITOY/sndBI7nj7G
 cqZd9CYcu06j3MFMq+/Qp2EMxlgyqsdcj91SXqbefzQ==
X-Received: by 2002:a5d:4604:: with SMTP id t4mr3028639wrq.285.1642977616274; 
 Sun, 23 Jan 2022 14:40:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjwwX6XBQA8gamPuGltOrFWIbtbUNwx90Lv8LABa1RXJtgWg+iT3fUgdTQUtIQR89XV0agPQ==
X-Received: by 2002:a5d:4604:: with SMTP id t4mr3028621wrq.285.1642977616041; 
 Sun, 23 Jan 2022 14:40:16 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:107d:3855:f057:7883:a28a:5e3c])
 by smtp.gmail.com with ESMTPSA id i8sm19203233wry.45.2022.01.23.14.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jan 2022 14:40:15 -0800 (PST)
Date: Sun, 23 Jan 2022 17:40:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH v9 09/11] firmware: arm_scmi: Add atomic mode support to
 virtio transport
Message-ID: <20220123172950-mutt-send-email-mst@kernel.org>
References: <20211220195646.44498-10-cristian.marussi@arm.com>
 <20211221140027.41524-1-cristian.marussi@arm.com>
 <f231094a-6f34-3dc1-237d-97218e8fde91@opensynergy.com>
 <20220119122338.GE6113@e120937-lin>
 <2f1ea794-a0b9-2099-edc0-b2aeb3ca6b92@opensynergy.com>
 <20220120150418-mutt-send-email-mst@kernel.org>
 <20220123200254.GF6113@e120937-lin>
MIME-Version: 1.0
In-Reply-To: <20220123200254.GF6113@e120937-lin>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: f.fainelli@gmail.com, vincent.guittot@linaro.org,
 igor.skalkin@opensynergy.com, sudeep.holla@arm.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Peter Hilber <peter.hilber@opensynergy.com>, james.quinlan@broadcom.com,
 Jonathan.Cameron@huawei.com, souvik.chakravarty@arm.com,
 etienne.carriere@linaro.org, linux-arm-kernel@lists.infradead.org
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

On Sun, Jan 23, 2022 at 08:02:54PM +0000, Cristian Marussi wrote:
> I was thinking...keeping the current virtqueue_poll interface, since our
> possible issue arises from the used_index wrapping around exactly on top
> of the same polled index and given that currently the API returns an
> unsigned "opaque" value really carrying just the 16-bit index (and possibly
> the wrap bit as bit15 for packed vq) that is supposed to be fed back as
> it is to the virtqueue_poll() function....
> 
> ...why don't we just keep an internal full fledged per-virtqueue wrap-counter
> and return that as the MSB 16-bit of the opaque value returned by
> virtqueue_prepare_enable_cb and then check it back in virtqueue_poll when the
> opaque is fed back ? (filtering it out from the internal helpers machinery)
> 
> As in the example below the scissors.
> 
> I mean if the internal wrap count is at that point different from the
> one provided to virtqueue_poll() via the opaque poll_idx value previously
> provided, certainly there is something new to fetch without even looking
> at the indexes: at the same time, exposing an opaque index built as
> (wraps << 16 | idx) implicitly 'binds' each index to a specific
> wrap-iteration, so they can be distiguished (..ok until the wrap-count
> upper 16bit wraps too....but...)
> 
> I am not really extremely familiar with the internals of virtio so I
> could be missing something obvious...feel free to insult me :P
> 
> (..and I have not made any perf measurements or consideration at this
> point....nor considered the redundancy of the existent packed
> used_wrap_counter bit...)
> 
> Thanks,
> Cristian
> 
> ----
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 00f64f2f8b72..bda6af121cd7 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -117,6 +117,8 @@ struct vring_virtqueue {
>         /* Last used index we've seen. */
>         u16 last_used_idx;
>  
> +       u16 wraps;
> +
>         /* Hint for event idx: already triggered no need to disable. */
>         bool event_triggered;
>  
> @@ -806,6 +808,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>         ret = vq->split.desc_state[i].data;
>         detach_buf_split(vq, i, ctx);
>         vq->last_used_idx++;
> +       if (unlikely(!vq->last_used_idx))
> +               vq->wraps++;

I wonder whether
               vq->wraps += !vq->last_used_idx;
is faster or slower. No branch but OTOH a dependency.


>         /* If we expect an interrupt for the next entry, tell host
>          * by writing event index and flush out the write before
>          * the read in the next get_buf call. */
> @@ -1508,6 +1512,7 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>         if (unlikely(vq->last_used_idx >= vq->packed.vring.num)) {
>                 vq->last_used_idx -= vq->packed.vring.num;
>                 vq->packed.used_wrap_counter ^= 1;
> +               vq->wraps++;
>         }
>  
>         /*
> @@ -1744,6 +1749,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
>         vq->weak_barriers = weak_barriers;
>         vq->broken = false;
>         vq->last_used_idx = 0;
> +       vq->wraps = 0;
>         vq->event_triggered = false;
>         vq->num_added = 0;
>         vq->packed_ring = true;
> @@ -2092,13 +2098,17 @@ EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
>   */
>  unsigned virtqueue_enable_cb_prepare(struct virtqueue *_vq)
>  {
> +       unsigned last_used_idx;
>         struct vring_virtqueue *vq = to_vvq(_vq);
>  
>         if (vq->event_triggered)
>                 vq->event_triggered = false;
>  
> -       return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) :
> -                                virtqueue_enable_cb_prepare_split(_vq);
> +       last_used_idx = vq->packed_ring ?
> +                       virtqueue_enable_cb_prepare_packed(_vq) :
> +                       virtqueue_enable_cb_prepare_split(_vq);
> +
> +       return VRING_BUILD_OPAQUE(last_used_idx, vq->wraps);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
>  
> @@ -2118,9 +2128,13 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned last_used_idx)
>         if (unlikely(vq->broken))
>                 return false;
>  
> +       if (unlikely(vq->wraps != VRING_GET_WRAPS(last_used_idx)))
> +               return true;
> +
>         virtio_mb(vq->weak_barriers);
> -       return vq->packed_ring ? virtqueue_poll_packed(_vq, last_used_idx) :
> -                                virtqueue_poll_split(_vq, last_used_idx);
> +       return vq->packed_ring ?
> +               virtqueue_poll_packed(_vq, VRING_GET_IDX(last_used_idx)) :
> +                       virtqueue_poll_split(_vq, VRING_GET_IDX(last_used_idx));
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_poll);
>  
> @@ -2245,6 +2259,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>         vq->weak_barriers = weak_barriers;
>         vq->broken = false;
>         vq->last_used_idx = 0;
> +       vq->wraps = 0;
>         vq->event_triggered = false;
>         vq->num_added = 0;
>         vq->use_dma_api = vring_use_dma_api(vdev);
> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> index 476d3e5c0fe7..e6b03017ebd7 100644
> --- a/include/uapi/linux/virtio_ring.h
> +++ b/include/uapi/linux/virtio_ring.h
> @@ -77,6 +77,17 @@
>   */
>  #define VRING_PACKED_EVENT_F_WRAP_CTR  15
>  
> +#define VRING_IDX_MASK                                 GENMASK(15, 0)
> +#define VRING_GET_IDX(opaque)                          \
> +       ((u16)FIELD_GET(VRING_IDX_MASK, (opaque)))
> +
> +#define VRING_WRAPS_MASK                               GENMASK(31, 16)
> +#define VRING_GET_WRAPS(opaque)                                \
> +       ((u16)FIELD_GET(VRING_WRAPS_MASK, (opaque)))
> +
> +#define VRING_BUILD_OPAQUE(idx, wraps)                 \
> +       (FIELD_PREP(VRING_WRAPS_MASK, (wraps)) | ((idx) & VRING_IDX_MASK))
> +
>  /* We support indirect buffer descriptors */
>  #define VIRTIO_RING_F_INDIRECT_DESC    28

Yea I think this patch increases the time it takes to wrap around from
2^16 to 2^32 which seems good enough.
Need some comments to explain the logic.
Would be interesting to see perf data.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
