Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0191FC77B73
	for <virtualization@archiver.kernel.org>; Sun,  4 Jun 2023 13:45:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D1FD41B92;
	Sun,  4 Jun 2023 13:45:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4D1FD41B92
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Lk3WSOcn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NdKy2a8TAIuV; Sun,  4 Jun 2023 13:45:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5203D418EA;
	Sun,  4 Jun 2023 13:45:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5203D418EA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 279A1C0037;
	Sun,  4 Jun 2023 13:45:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24C08C0029
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Jun 2023 13:45:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DF37E60E31
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Jun 2023 13:45:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DF37E60E31
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Lk3WSOcn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P2p6yW_nDGYw
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Jun 2023 13:45:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 74D9760E29
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 74D9760E29
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Jun 2023 13:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685886324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FtWXr+699Hb3Bt46ASXuF1J0GM1OW7yEJvH6TifZCko=;
 b=Lk3WSOcnYRRsbahuh3ZCP90218j4YiRdan5Lw+LIIIIK7+8/jde5/J1ucRzqxxRa6bG09q
 tJFD78TGK1I2cKX/hS2OzBqS3u43r2ckGKFM+vQY6g89BZPfAGP6qJ6xvOvPvIPRhLFHTb
 /rC2VWuYPnI7a29dATKTILcNrTU6WCo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-HYW8Y7iZM8eIeWLFJ9JMHA-1; Sun, 04 Jun 2023 09:45:20 -0400
X-MC-Unique: HYW8Y7iZM8eIeWLFJ9JMHA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4edbdd8268bso18769e87.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 04 Jun 2023 06:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685886319; x=1688478319;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FtWXr+699Hb3Bt46ASXuF1J0GM1OW7yEJvH6TifZCko=;
 b=GgFaGmS84mptZJauEoXkZ+AFTvbSHhobgJug8E2Ldq1RxLmfhYDjxPxXIqXwpxXnWz
 rH72SUn9zXzBr2QanH3WyJ42hVIU/zhKbZnVGjywOaLkhAbC9O3O17WmfxAe6RVQlnCf
 kWrTOcUI3mvImxQ9P3G+UmgJTul9nMyv5wjFvS7CoZHRDHrQwKFIAdg5HwVgusKth5HZ
 fYqaRSGz+Y5c0LuX4Hd/rT25khU1j3kfLx/3XqgLyATnHg/JOFKz5QFI5c8fFgmD2/y4
 aTQNAe/R9z9pspj6xJlRrUqRbYSkwxHIhYKnqMmrUhcjOpUrAAgYImycFyKuTk04Akdx
 24lA==
X-Gm-Message-State: AC+VfDxhqAtK4z5EC2T1EJFXSS+okqH0ZgXZPkbuNWubS5TE7epbaylp
 kNglp/bBMSLFCxLnG8TyEawwPh1aL3LjS788+FZ56yiM9J39GnmY68PbpNcSPq9CEvL3OWLndM2
 lJyaJSP81b3BXhOGlMc00jyjcazTyS/5Vo6hHKSK1/g==
X-Received: by 2002:ac2:42c6:0:b0:4f3:9930:5b8c with SMTP id
 n6-20020ac242c6000000b004f399305b8cmr3679159lfl.25.1685886319425; 
 Sun, 04 Jun 2023 06:45:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ50ipioWzajptAHNCN3t7vMpbwHQFVFHQocI8w0p9FDECMVbrkC4nACxASbyPY4XZ1V+SC8gg==
X-Received: by 2002:ac2:42c6:0:b0:4f3:9930:5b8c with SMTP id
 n6-20020ac242c6000000b004f399305b8cmr3679148lfl.25.1685886319052; 
 Sun, 04 Jun 2023 06:45:19 -0700 (PDT)
Received: from redhat.com ([2.55.4.169]) by smtp.gmail.com with ESMTPSA id
 y7-20020a1c4b07000000b003f60455de07sm7837888wma.15.2023.06.04.06.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jun 2023 06:45:18 -0700 (PDT)
Date: Sun, 4 Jun 2023 09:45:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v10 07/10] virtio_ring: introduce helpers for
 premapped
Message-ID: <20230604094122-mutt-send-email-mst@kernel.org>
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-8-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230602092206.50108-8-xuanzhuo@linux.alibaba.com>
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

On Fri, Jun 02, 2023 at 05:22:03PM +0800, Xuan Zhuo wrote:
> This patch introduces three helpers for premapped mode.
> 
> * virtqueue_get_buf_premapped
> * virtqueue_detach_unused_buf_premapped
> 
> The above helpers work like the non-premapped funcs. But a cursor is
> passed.
> 
> virtqueue_detach is used to get the dma info of the last buf by
>   cursor.

This isn't very clear from the description but virtqueue_detach is
also introduced by this patch as opposed to being used.


> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 83 ++++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h       | 10 +++++
>  2 files changed, 93 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cbc22daae7e1..6771b9661798 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2555,6 +2555,66 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
>  	return virtqueue_get_buf_ctx(_vq, len, NULL);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_buf);
> +
> +/**
> + * virtqueue_get_buf_premapped - get the next used buffer
> + * @_vq: the struct virtqueue we're talking about.
> + * @len: the length written into the buffer
> + * @ctx: extra context for the token
> + * @cursor: detach cursor
> + *
> + * If the device wrote data into the buffer, @len will be set to the
> + * amount written.  This means you don't need to clear the buffer
> + * beforehand to ensure there's no data leakage in the case of short
> + * writes.
> + *
> + * Caller must ensure we don't call this with other virtqueue
> + * operations at the same time (except where noted).
> + *
> + * This is used for the premapped vq. The cursor is passed by the dirver, that
> + * is used for virtqueue_detach. That will be initialized by virtio core
> + * internally.
> + *
> + * Returns NULL if there are no used buffers, or the "data" token
> + * handed to virtqueue_add_*().
> + */
> +void *virtqueue_get_buf_premapped(struct virtqueue *_vq, unsigned int *len,
> +				  void **ctx,
> +				  struct virtqueue_detach_cursor *cursor)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, ctx, cursor) :
> +				 virtqueue_get_buf_ctx_split(_vq, len, ctx, cursor);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_get_buf_premapped);
> +
> +/**
> + * virtqueue_detach - get the dma info of last buf

detach what from what then?
I am guessing this is not the only thing this function does?
sounds like a bad name for a function.

> + * @_vq: the struct virtqueue we're talking about.
> + * @cursor: detach cursor
> + * @addr: the dma address

what address?  it's the 1st time you mention an address ...

> + * @len: the length of the dma address
> + * @dir: the direction of the dma address
> + *
> + * This is used for the premapped vq. The cursor is initialized by
> + * virtqueue_get_buf_premapped or virtqueue_detach_unused_buf_premapped.
> + *
> + * Returns:
> + * -EAGAIN: there are more dma info, this function should be called more.

here too, pls don't return -EAGAIN not in an error case.
something like "1" will do.

> + * -EINVAL: the process is done, should not call this function
> + * 0: no more dma info
> + */
> +int virtqueue_detach(struct virtqueue *_vq, struct virtqueue_detach_cursor *cursor,
> +		     dma_addr_t *addr, u32 *len, enum dma_data_direction *dir)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	return vq->packed_ring ? virtqueue_detach_packed(_vq, cursor, addr, len, dir) :
> +				 virtqueue_detach_split(_vq, cursor, addr, len, dir);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_detach);
> +
>  /**
>   * virtqueue_disable_cb - disable callbacks
>   * @_vq: the struct virtqueue we're talking about.
> @@ -2682,6 +2742,29 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
>  
> +/**
> + * virtqueue_detach_unused_buf_premapped - detach first unused buffer
> + * @_vq: the struct virtqueue we're talking about.
> + * @cursor: detach cursor
> + *
> + * This is used for the premapped vq. The cursor is passed by the dirver, that
> + * is used for virtqueue_detach. That will be initialized by virtio core
> + * internally.
> + *
> + * Returns NULL or the "data" token handed to virtqueue_add_*().
> + * This is not valid on an active queue; it is useful for device
> + * shutdown or the reset queue.
> + */
> +void *virtqueue_detach_unused_buf_premapped(struct virtqueue *_vq,
> +					    struct virtqueue_detach_cursor *cursor)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(_vq, cursor) :
> +				 virtqueue_detach_unused_buf_split(_vq, cursor);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf_premapped);
> +
>  static inline bool more_used(const struct vring_virtqueue *vq)
>  {
>  	return vq->packed_ring ? more_used_packed(vq) : more_used_split(vq);
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 7f137c7a9034..0a11c5b32fe5 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_VIRTIO_H
>  /* Everything a virtio driver needs to work with any particular virtio
>   * implementation. */
> +#include <linux/dma-mapping.h>
>  #include <linux/types.h>
>  #include <linux/scatterlist.h>
>  #include <linux/spinlock.h>
> @@ -88,6 +89,10 @@ void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len);
>  void *virtqueue_get_buf_ctx(struct virtqueue *vq, unsigned int *len,
>  			    void **ctx);
>  
> +void *virtqueue_get_buf_premapped(struct virtqueue *_vq, unsigned int *len,
> +				  void **ctx,
> +				  struct virtqueue_detach_cursor *cursor);
> +
>  void virtqueue_disable_cb(struct virtqueue *vq);
>  
>  bool virtqueue_enable_cb(struct virtqueue *vq);
> @@ -101,6 +106,8 @@ bool virtqueue_poll(struct virtqueue *vq, unsigned);
>  bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
>  
>  void *virtqueue_detach_unused_buf(struct virtqueue *vq);
> +void *virtqueue_detach_unused_buf_premapped(struct virtqueue *_vq,
> +					    struct virtqueue_detach_cursor *cursor);
>  
>  unsigned int virtqueue_get_vring_size(const struct virtqueue *vq);
>  
> @@ -114,6 +121,9 @@ dma_addr_t virtqueue_get_used_addr(const struct virtqueue *vq);
>  int virtqueue_resize(struct virtqueue *vq, u32 num,
>  		     void (*recycle)(struct virtqueue *vq, void *buf));
>  
> +int virtqueue_detach(struct virtqueue *_vq, struct virtqueue_detach_cursor *cursor,
> +		     dma_addr_t *addr, u32 *len, enum dma_data_direction *dir);
> +
>  /**
>   * struct virtio_device - representation of a device using virtio
>   * @index: unique position on the virtio bus
> -- 
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
