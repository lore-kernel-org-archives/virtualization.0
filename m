Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BD8C05027
	for <virtualization@archiver.kernel.org>; Mon, 20 Feb 2023 05:38:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C9118184F;
	Mon, 20 Feb 2023 05:38:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C9118184F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hySN6llJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8BrYWNMGDrdF; Mon, 20 Feb 2023 05:38:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 679A681762;
	Mon, 20 Feb 2023 05:38:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 679A681762
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51B80C0032;
	Mon, 20 Feb 2023 05:38:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3288C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:38:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AE3A440B86
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:38:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AE3A440B86
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hySN6llJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yuH8cB7TyusL
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:38:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B15A740B6D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B15A740B6D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676871508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vTnQyIhCx2uxkG4bn4TXk2vSJ9Btotn+N1wVG4b4hiE=;
 b=hySN6llJkyTJ7Gne+88m3v1xELNQUiDyo+TKY4yougjWNfG6aEpd04XExWM5+FLapqq91U
 9DjIWdlTWBHQXk49J+s7pJG+9oj8rgqrpG6Yd+bxd/yUkwXm9mlMdoqGcL9LaMVQo1/Jb9
 OGTKGOaKF8y1lafLLAm0Q1LFr5d1nTw=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-343-LAYpwrHyN-q9pahBaENoCQ-1; Mon, 20 Feb 2023 00:38:26 -0500
X-MC-Unique: LAYpwrHyN-q9pahBaENoCQ-1
Received: by mail-oi1-f197.google.com with SMTP id
 bg9-20020a056808178900b0037874eb34c8so116630oib.19
 for <virtualization@lists.linux-foundation.org>;
 Sun, 19 Feb 2023 21:38:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vTnQyIhCx2uxkG4bn4TXk2vSJ9Btotn+N1wVG4b4hiE=;
 b=XrMAJqcVy1EdsPzX0ciQzmdjbYt6vo+qdSrWk+oPk71yqCnUyzjfzC0FlYsli6xeJR
 a+5I4A813cnIDBc94nuFf0vz2P/C3FhCGNay78KA4JfGL0dVRkmzlHvUodSDKw05eoHD
 4JLxP9N/c66LEQcrDKkih1/7wlxsBEUjEVKED2QD2uW3SNsfEMpn3vsTipFTjYGDKezy
 1hKCP0TZZhdNg1aV7WGO5HXwWC2iJA47yOexXC/XLtQ6x/84nNTchJJIoaF2bjHjrlf2
 YI5jmMLO6jKjaxBK195hPaZC3JVbe3fpN+uA6wEhCAiIEAHNL29d33dY73EjJWQswSR8
 XKnw==
X-Gm-Message-State: AO0yUKWPMShOaLIXBf0fyg/1jwD9fT3P74NPwyEbDfdcsFxiNZhUYowF
 L0GVdYJjHHkKfse+CRq/9eUkv6R6hiBtGXlpNFcOMtR9z2jRw9lPo5W1SgEoN0eJ4BF45OEqvW6
 QVuvuvdpbzMIlxr/jR8A8NAp+uO9AB22dt58zUHP5FgBPif54OFgtLE1bv5LWRumnpA==
X-Received: by 2002:a05:6870:610c:b0:171:d1a1:c5cb with SMTP id
 s12-20020a056870610c00b00171d1a1c5cbmr240611oae.217.1676871504970; 
 Sun, 19 Feb 2023 21:38:24 -0800 (PST)
X-Google-Smtp-Source: AK7set+qIpfVZdoJzsfT9kohdhkyIIoLc3ioSNVIhIkaA5PHNryTIpk0YinQI9gZmQzTLHUeRAZQQGjHw2b46r8iJFk=
X-Received: by 2002:a05:6870:610c:b0:171:d1a1:c5cb with SMTP id
 s12-20020a056870610c00b00171d1a1c5cbmr240608oae.217.1676871504711; Sun, 19
 Feb 2023 21:38:24 -0800 (PST)
MIME-Version: 1.0
References: <20230214072704.126660-1-xuanzhuo@linux.alibaba.com>
 <20230214072704.126660-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230214072704.126660-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Feb 2023 13:38:13 +0800
Message-ID: <CACGkMEvWG1VVPHQd64SsdB52tgimoN_Dd6QT2Uvc5S8Qmrdcow@mail.gmail.com>
Subject: Re: [PATCH vhost 04/10] virtio_ring: split: introduce
 virtqueue_add_split_premapped()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

On Tue, Feb 14, 2023 at 3:27 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> virtqueue_add_split() only supports virtual addresses, dma is completed
> in virtqueue_add_split().
>
> In some scenarios (such as the AF_XDP scenario), the memory is allocated
> and DMA is completed in advance, so it is necessary for us to support
> passing the DMA address to virtio core.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 100 +++++++++++++++++++++++++++++++++--
>  include/linux/virtio.h       |   5 ++
>  2 files changed, 100 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 47b6f9152f9f..a31155abe101 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -70,6 +70,7 @@
>  struct vring_desc_state_split {
>         void *data;                     /* Data for callback. */
>         struct vring_desc *indir_desc;  /* Indirect descriptor, if any. */
> +       bool premapped;

Better with a comment.

Not native speaker, but "dma_addr" might be better?

>  };
>
>  struct vring_desc_state_packed {
> @@ -440,7 +441,7 @@ static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
>  }
>
>  static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
> -                                         unsigned int i)
> +                                         unsigned int i, bool premapped)
>  {
>         struct vring_desc_extra *extra = vq->split.desc_extra;
>         u16 flags;
> @@ -457,6 +458,9 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
>                                  (flags & VRING_DESC_F_WRITE) ?
>                                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
>         } else {
> +               if (premapped)
> +                       goto out;
> +
>                 dma_unmap_page(vring_dma_dev(vq),
>                                extra[i].addr,
>                                extra[i].len,
> @@ -788,6 +792,47 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>         return err;
>  }
>
> +static inline int virtqueue_add_split_premapped(struct virtqueue *_vq,
> +                                               struct scatterlist *sgs[],
> +                                               unsigned int total_sg,
> +                                               unsigned int out_sgs,
> +                                               unsigned int in_sgs,
> +                                               void *data,
> +                                               void *ctx,
> +                                               gfp_t gfp)
> +{
> +       struct vring_virtqueue *vq = to_vvq(_vq);
> +       struct vring_desc *desc;
> +       int head;
> +       int err;
> +
> +       START_USE(vq);
> +
> +       /* check vq state and try to alloc desc for indirect. */
> +       err = virtqueue_add_split_prepare(vq, total_sg, out_sgs, data, ctx, gfp, &desc);
> +       if (err)
> +               goto end;
> +
> +       head = vq->free_head;
> +       err = virtqueue_add_split_vring(vq, sgs, total_sg, out_sgs, in_sgs, desc);
> +       if (err)
> +               goto err;
> +
> +       /* Store token and indirect buffer state. */
> +       vq->split.desc_state[head].data = data;
> +       vq->split.desc_state[head].indir_desc = desc ? desc : ctx;
> +       vq->split.desc_state[head].premapped = true;

This function duplicates most of the logic of virtqueue_add_split()
let's unify it.

probably:

__virtqueue_add_split(..., bool premapped);
virtqueue_add_split()
{
    __virtqueue_add_split(..., false);
}

virtqueue_add_split_premapped()
{
   __virtqueue_add_split(..., true);
}

?

And so did for packed (patch 5).

Thanks



> +
> +       goto end;
> +
> +err:
> +       kfree(desc);
> +
> +end:
> +       END_USE(vq);
> +       return err;
> +}
> +
>  static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
>  {
>         struct vring_virtqueue *vq = to_vvq(_vq);
> @@ -824,20 +869,23 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  {
>         unsigned int i, j;
>         __virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
> +       bool premapped;
>
>         /* Clear data ptr. */
>         vq->split.desc_state[head].data = NULL;
>
> +       premapped = vq->split.desc_state[head].premapped;
> +
>         /* Put back on free list: unmap first-level descriptors and find end */
>         i = head;
>
>         while (vq->split.vring.desc[i].flags & nextflag) {
> -               vring_unmap_one_split(vq, i);
> +               vring_unmap_one_split(vq, i, premapped);
>                 i = vq->split.desc_extra[i].next;
>                 vq->vq.num_free++;
>         }
>
> -       vring_unmap_one_split(vq, i);
> +       vring_unmap_one_split(vq, i, premapped);
>         vq->split.desc_extra[i].next = vq->free_head;
>         vq->free_head = head;
>
> @@ -859,8 +907,10 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>                                 VRING_DESC_F_INDIRECT));
>                 BUG_ON(len == 0 || len % sizeof(struct vring_desc));
>
> -               for (j = 0; j < len / sizeof(struct vring_desc); j++)
> -                       vring_unmap_one_split_indirect(vq, &indir_desc[j]);
> +               if (!premapped) {
> +                       for (j = 0; j < len / sizeof(struct vring_desc); j++)
> +                               vring_unmap_one_split_indirect(vq, &indir_desc[j]);
> +               }
>
>                 kfree(indir_desc);
>                 vq->split.desc_state[head].indir_desc = NULL;
> @@ -2204,6 +2254,21 @@ static inline int virtqueue_add(struct virtqueue *_vq,
>                                         out_sgs, in_sgs, data, ctx, gfp);
>  }
>
> +static inline int virtqueue_add_premapped(struct virtqueue *_vq,
> +                                         struct scatterlist *sgs[],
> +                                         unsigned int total_sg,
> +                                         unsigned int out_sgs,
> +                                         unsigned int in_sgs,
> +                                         void *data,
> +                                         void *ctx,
> +                                         gfp_t gfp)
> +{
> +       struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +       return virtqueue_add_split_premapped(_vq, sgs, total_sg, out_sgs,
> +                                            in_sgs, data, ctx, gfp);
> +}
> +
>  /**
>   * virtqueue_add_sgs - expose buffers to other end
>   * @_vq: the struct virtqueue we're talking about.
> @@ -2261,6 +2326,31 @@ int virtqueue_add_outbuf(struct virtqueue *vq,
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
>
> +/**
> + * virtqueue_add_outbuf_premapped - expose output buffers to other end
> + * @vq: the struct virtqueue we're talking about.
> + * @sg: scatterlist (must be well-formed and terminated!)
> + * @num: the number of entries in @sg readable by other side
> + * @data: the token identifying the buffer.
> + * @gfp: how to do memory allocations (if necessary).
> + *
> + * Caller must ensure we don't call this with other virtqueue operations
> + * at the same time (except where noted).
> + *
> + * It is required that all addrs have completed DMA operations. And use
> + * sg->dma_address, sg->length to pass addr and length.
> + *
> + * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
> + */
> +int virtqueue_add_outbuf_premapped(struct virtqueue *vq,
> +                                  struct scatterlist *sg, unsigned int num,
> +                                  void *data,
> +                                  gfp_t gfp)
> +{
> +       return virtqueue_add_premapped(vq, &sg, num, 1, 0, data, NULL, gfp);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_add_outbuf_premapped);
> +
>  /**
>   * virtqueue_add_inbuf - expose input buffers to other end
>   * @vq: the struct virtqueue we're talking about.
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index dcab9c7e8784..d8b472a7dcae 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -43,6 +43,11 @@ int virtqueue_add_outbuf(struct virtqueue *vq,
>                          void *data,
>                          gfp_t gfp);
>
> +int virtqueue_add_outbuf_premapped(struct virtqueue *vq,
> +                                  struct scatterlist *sg, unsigned int num,
> +                                  void *data,
> +                                  gfp_t gfp);
> +
>  int virtqueue_add_inbuf(struct virtqueue *vq,
>                         struct scatterlist sg[], unsigned int num,
>                         void *data,
> --
> 2.32.0.3.g01195cf9f
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
