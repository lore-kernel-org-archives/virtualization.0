Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676F72900
	for <virtualization@lists.linux.dev>; Thu,  6 Jun 2024 00:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717633255; cv=none; b=SbISFk9kIghe6QihnV8aYvGTtQuBYjJlc9s2Bj+lyrCpYFFxAMZ0Nv0tBmlpaAtunzm+tr7uYcNUpa4/Lg6cSiq3SHVyjkyIueAH33+4ykCh5fooO8ijDCSOZtfwy/AkBU0/lPTMctK12V20C1J4s+A5kMcCnTLlVNPk5zBFZCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717633255; c=relaxed/simple;
	bh=K4uVHDP87kJCqOj1cXrXMDSpMN9IXZttJ1fRNDFs1AU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AohbLo7ukbcPBE0JjQv/6G8FzV/SkkCWoWI0WT34vPaieFK9ZsAxBC4Tm5lybGsIDOcv+g+gliJnb8MQZ5hXZ495LHzSrW2LcBobdwC9685cwg0jUFpGDSwMkKuoijJ7gOcSW+Y7AyVfw0vWDejQ/8S6ZvY+YXR1eY/NXrqUl1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H0usxsaN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0usxsaN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717633252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NE2ZSKPbjoZZ2kAv+hgjLqmfV3FjYbnLAtY/ism3HQw=;
	b=H0usxsaN7jln7aptK6BSLIqLU43+p1kTF9NZWWcT9YBiZbPF3Tz6LJPjT1zkg4r33kKPfK
	QE0gdgf57eEzYXslZBnqW5FFTQ/Z9kCOBkEK4a/3luO+reVIxHxObkW2nKxiGCPOAtnVx7
	WmzqCiFLyw8BO4brV4ebyPdFu4Ff4uo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-_jdGdzG3Nlq-tsRPHJ2jdg-1; Wed, 05 Jun 2024 20:20:51 -0400
X-MC-Unique: _jdGdzG3Nlq-tsRPHJ2jdg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c241ee8fd5so352829a91.1
        for <virtualization@lists.linux.dev>; Wed, 05 Jun 2024 17:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717633250; x=1718238050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NE2ZSKPbjoZZ2kAv+hgjLqmfV3FjYbnLAtY/ism3HQw=;
        b=uPGw+S3flHOoWKgC2Dja7TAhPuyrzj47OzLhWe9e7ZZ7W2R6fm+ksj0PAXDW/9jxqA
         x2mDvxW5/dWXq2M1pey6D0EzDO+jcjY6tVMaAhhi/MAph8Ir/4piCMxOrnVuBfwqMzQh
         NF8WWifvwrH7xFWHwMrIsEbnVDrxRngxOVoi2Ro7SRsubbNuTwYIqds3Qf9wJ3C5dJgp
         /NilYfczOILFidZo0A/FqbVcaEiGcJxDVqwZ5CgOt6GVdKSZl6KGhjcV3xjfBsZI/cPi
         AnbM4ebhqunPZLCGaVc2ZJpERxlVdXjBic5XPtNe8B/cdaEsgDybqS90piXLT9ZBe+Pz
         KzsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHmTDJB4dPI+xSOgU56Va0bQ7ai2z5Vyr/yIXDE5e9xJz1NVbw2CeAl1UmmFcpPubLYKz/KXv+1O/rVOt/FLOrzISwYWsf2dL2ISvTSXA=
X-Gm-Message-State: AOJu0YxpzMXTCm8XqkpMJob6aTRQkdqKGSXb3Pddp8lB7EjnA2O8WLfR
	/grHGIBrVSU3sA9Hs6gXNh9sVVCE9zE7LJYTXzCc2Yxn8K9K5yO/54pF0V068Say9hCgNvSQ4fX
	wOFtuGMp/Ld/B6L68PyH0JZiy5RQCqAkbRKyWvcxembegLIk51xfPyU5Z/3TEvWPmTtf0oEJwIC
	8yxxr5vVZZLDiOuSyT3Q1m3OIDa6ViaUBpvhvln4Q=
X-Received: by 2002:a17:90a:ba10:b0:2c2:9aa:3969 with SMTP id 98e67ed59e1d1-2c27db63beamr3589279a91.45.1717633250266;
        Wed, 05 Jun 2024 17:20:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+/6jAb4MCPQzpYUmm3uHkW83PLMoW579h8btCPs2vU09fvoId1684R5/Y4niItcO9ltsik/BhTRA7SkwBhp0=
X-Received: by 2002:a17:90a:ba10:b0:2c2:9aa:3969 with SMTP id
 98e67ed59e1d1-2c27db63beamr3589262a91.45.1717633249856; Wed, 05 Jun 2024
 17:20:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240509114615.317450-1-jiri@resnulli.us> <1715325076.4219763-2-hengqi@linux.alibaba.com>
 <ZktGj4nDU4X0Lxtx@nanopsycho.orion> <ZmBMa7Am3LIYQw1x@nanopsycho.orion> <1717587768.1588957-5-hengqi@linux.alibaba.com>
In-Reply-To: <1717587768.1588957-5-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Jun 2024 08:20:38 +0800
Message-ID: <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jiri Pirko <jiri@resnulli.us>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 7:51=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> w=
rote:
>
> On Wed, 5 Jun 2024 13:30:51 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
> > Mon, May 20, 2024 at 02:48:15PM CEST, jiri@resnulli.us wrote:
> > >Fri, May 10, 2024 at 09:11:16AM CEST, hengqi@linux.alibaba.com wrote:
> > >>On Thu,  9 May 2024 13:46:15 +0200, Jiri Pirko <jiri@resnulli.us> wro=
te:
> > >>> From: Jiri Pirko <jiri@nvidia.com>
> > >>>
> > >>> Add support for Byte Queue Limits (BQL).
> > >>
> > >>Historically both Jason and Michael have attempted to support BQL
> > >>for virtio-net, for example:
> > >>
> > >>https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@r=
edhat.com/
> > >>
> > >>These discussions focus primarily on:
> > >>
> > >>1. BQL is based on napi tx. Therefore, the transfer of statistical in=
formation
> > >>needs to rely on the judgment of use_napi. When the napi mode is swit=
ched to
> > >>orphan, some statistical information will be lost, resulting in tempo=
rary
> > >>inaccuracy in BQL.
> > >>
> > >>2. If tx dim is supported, orphan mode may be removed and tx irq will=
 be more
> > >>reasonable. This provides good support for BQL.
> > >
> > >But when the device does not support dim, the orphan mode is still
> > >needed, isn't it?
> >
> > Heng, is my assuption correct here? Thanks!
> >
>
> Maybe, according to our cloud data, napi_tx=3Don works better than orphan=
 mode in
> most scenarios. Although orphan mode performs better in specific benckmar=
k,

For example pktgen (I meant even if the orphan mode can break pktgen,
it can finish when there's a new packet that needs to be sent after
pktgen is completed).

> perf of napi_tx can be enhanced through tx dim. Then, there is no reason =
not to
> support dim for devices that want the best performance.

Ideally, if we can drop orphan mode, everything would be simplified.

>
> Back to this patch set, I think BQL as a point that affects performance s=
hould
> deserve more comprehensive test data.

Thanks

>
> Thanks.
>
> > >
> > >>
> > >>Thanks.
> > >>
> > >>>
> > >>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> > >>> ---
> > >>>  drivers/net/virtio_net.c | 33 ++++++++++++++++++++-------------
> > >>>  1 file changed, 20 insertions(+), 13 deletions(-)
> > >>>
> > >>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > >>> index 218a446c4c27..c53d6dc6d332 100644
> > >>> --- a/drivers/net/virtio_net.c
> > >>> +++ b/drivers/net/virtio_net.c
> > >>> @@ -84,7 +84,9 @@ struct virtnet_stat_desc {
> > >>>
> > >>>  struct virtnet_sq_free_stats {
> > >>>   u64 packets;
> > >>> + u64 xdp_packets;
> > >>>   u64 bytes;
> > >>> + u64 xdp_bytes;
> > >>>  };
> > >>>
> > >>>  struct virtnet_sq_stats {
> > >>> @@ -512,19 +514,19 @@ static void __free_old_xmit(struct send_queue=
 *sq, bool in_napi,
> > >>>   void *ptr;
> > >>>
> > >>>   while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NULL) {
> > >>> -         ++stats->packets;
> > >>> -
> > >>>           if (!is_xdp_frame(ptr)) {
> > >>>                   struct sk_buff *skb =3D ptr;
> > >>>
> > >>>                   pr_debug("Sent skb %p\n", skb);
> > >>>
> > >>> +                 stats->packets++;
> > >>>                   stats->bytes +=3D skb->len;
> > >>>                   napi_consume_skb(skb, in_napi);
> > >>>           } else {
> > >>>                   struct xdp_frame *frame =3D ptr_to_xdp(ptr);
> > >>>
> > >>> -                 stats->bytes +=3D xdp_get_frame_len(frame);
> > >>> +                 stats->xdp_packets++;
> > >>> +                 stats->xdp_bytes +=3D xdp_get_frame_len(frame);
> > >>>                   xdp_return_frame(frame);
> > >>>           }
> > >>>   }
> > >>> @@ -965,7 +967,8 @@ static void virtnet_rq_unmap_free_buf(struct vi=
rtqueue *vq, void *buf)
> > >>>   virtnet_rq_free_buf(vi, rq, buf);
> > >>>  }
> > >>>
> > >>> -static void free_old_xmit(struct send_queue *sq, bool in_napi)
> > >>> +static void free_old_xmit(struct send_queue *sq, struct netdev_que=
ue *txq,
> > >>> +                   bool in_napi)
> > >>>  {
> > >>>   struct virtnet_sq_free_stats stats =3D {0};
> > >>>
> > >>> @@ -974,9 +977,11 @@ static void free_old_xmit(struct send_queue *s=
q, bool in_napi)
> > >>>   /* Avoid overhead when no packets have been processed
> > >>>    * happens when called speculatively from start_xmit.
> > >>>    */
> > >>> - if (!stats.packets)
> > >>> + if (!stats.packets && !stats.xdp_packets)
> > >>>           return;
> > >>>
> > >>> + netdev_tx_completed_queue(txq, stats.packets, stats.bytes);
> > >>> +
> > >>>   u64_stats_update_begin(&sq->stats.syncp);
> > >>>   u64_stats_add(&sq->stats.bytes, stats.bytes);
> > >>>   u64_stats_add(&sq->stats.packets, stats.packets);
> > >>> @@ -1013,13 +1018,15 @@ static void check_sq_full_and_disable(struc=
t virtnet_info *vi,
> > >>>    * early means 16 slots are typically wasted.
> > >>>    */
> > >>>   if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> > >>> -         netif_stop_subqueue(dev, qnum);
> > >>> +         struct netdev_queue *txq =3D netdev_get_tx_queue(dev, qnu=
m);
> > >>> +
> > >>> +         netif_tx_stop_queue(txq);
> > >>>           if (use_napi) {
> > >>>                   if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)=
))
> > >>>                           virtqueue_napi_schedule(&sq->napi, sq->vq=
);
> > >>>           } else if (unlikely(!virtqueue_enable_cb_delayed(sq->vq))=
) {
> > >>>                   /* More just got used, free them then recheck. */
> > >>> -                 free_old_xmit(sq, false);
> > >>> +                 free_old_xmit(sq, txq, false);
> > >>>                   if (sq->vq->num_free >=3D 2+MAX_SKB_FRAGS) {
> > >>>                           netif_start_subqueue(dev, qnum);
> > >>>                           virtqueue_disable_cb(sq->vq);
> > >>> @@ -2319,7 +2326,7 @@ static void virtnet_poll_cleantx(struct recei=
ve_queue *rq)
> > >>>
> > >>>           do {
> > >>>                   virtqueue_disable_cb(sq->vq);
> > >>> -                 free_old_xmit(sq, true);
> > >>> +                 free_old_xmit(sq, txq, true);
> > >>>           } while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > >>>
> > >>>           if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS)
> > >>> @@ -2471,7 +2478,7 @@ static int virtnet_poll_tx(struct napi_struct=
 *napi, int budget)
> > >>>   txq =3D netdev_get_tx_queue(vi->dev, index);
> > >>>   __netif_tx_lock(txq, raw_smp_processor_id());
> > >>>   virtqueue_disable_cb(sq->vq);
> > >>> - free_old_xmit(sq, true);
> > >>> + free_old_xmit(sq, txq, true);
> > >>>
> > >>>   if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS)
> > >>>           netif_tx_wake_queue(txq);
> > >>> @@ -2553,7 +2560,7 @@ static netdev_tx_t start_xmit(struct sk_buff =
*skb, struct net_device *dev)
> > >>>   struct send_queue *sq =3D &vi->sq[qnum];
> > >>>   int err;
> > >>>   struct netdev_queue *txq =3D netdev_get_tx_queue(dev, qnum);
> > >>> - bool kick =3D !netdev_xmit_more();
> > >>> + bool xmit_more =3D netdev_xmit_more();
> > >>>   bool use_napi =3D sq->napi.weight;
> > >>>
> > >>>   /* Free up any pending old buffers before queueing new ones. */
> > >>> @@ -2561,9 +2568,9 @@ static netdev_tx_t start_xmit(struct sk_buff =
*skb, struct net_device *dev)
> > >>>           if (use_napi)
> > >>>                   virtqueue_disable_cb(sq->vq);
> > >>>
> > >>> -         free_old_xmit(sq, false);
> > >>> +         free_old_xmit(sq, txq, false);
> > >>>
> > >>> - } while (use_napi && kick &&
> > >>> + } while (use_napi && !xmit_more &&
> > >>>          unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > >>>
> > >>>   /* timestamp packet in software */
> > >>> @@ -2592,7 +2599,7 @@ static netdev_tx_t start_xmit(struct sk_buff =
*skb, struct net_device *dev)
> > >>>
> > >>>   check_sq_full_and_disable(vi, dev, sq);
> > >>>
> > >>> - if (kick || netif_xmit_stopped(txq)) {
> > >>> + if (__netdev_tx_sent_queue(txq, skb->len, xmit_more)) {
> > >>>           if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq=
->vq)) {
> > >>>                   u64_stats_update_begin(&sq->stats.syncp);
> > >>>                   u64_stats_inc(&sq->stats.kicks);
> > >>> --
> > >>> 2.44.0
> > >>>
> > >>>
>

