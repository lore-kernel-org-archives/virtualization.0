Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C58C433FE
	for <virtualization@archiver.kernel.org>; Wed, 16 Feb 2022 04:14:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8FED81A4E;
	Wed, 16 Feb 2022 04:14:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JqOmhCUqIJNA; Wed, 16 Feb 2022 04:14:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 70EF080C52;
	Wed, 16 Feb 2022 04:14:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 491BCC001A;
	Wed, 16 Feb 2022 04:14:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A7DAC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2B5F5817A4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ReFPToyw5rzt
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 715DC80C52
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644984874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E3b3uR5MMPzm1En/lQgKQ0CsRJyNewt+DAjMnvVIPGk=;
 b=Jgeo1fyl45wlx7evaxOfYaDI3iqLo1UMa24bTZvKkYAZsmrF7szrULkTpS6G0XTY/wruAj
 QYFy2TeNbCH7xZ6qx2JF1s/Vv9FEwhmhdluOcDF9GsOBPIQ13rSAkseDJEGnes4iB2N841
 f2LU2rnoiJ828NWPMtIgLki1MH3VLDU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-zq_FzjMgOVK3wX5XAWOcsA-1; Tue, 15 Feb 2022 23:14:32 -0500
X-MC-Unique: zq_FzjMgOVK3wX5XAWOcsA-1
Received: by mail-lj1-f200.google.com with SMTP id
 i10-20020a05651c120a00b00244c2eb1539so440896lja.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 20:14:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E3b3uR5MMPzm1En/lQgKQ0CsRJyNewt+DAjMnvVIPGk=;
 b=i9hg6lvNQja8uEBxW+TqY8Q2gSh40PrxI2AVJLGUxZsCdwN2ZaOYIXtnwIopDAhae1
 dgNL930ljiLHFmCYxF9gbnPLcVFmrIvFwOs5HX5Y+rzPXIDK/d/D3626rNV5igPsnymJ
 AF9pcmXmS7KJgApX252zCCvWL1Djzr/D1lKSP/nIt0TDybP7PgfehwYM5jpHm3OlYG6M
 VpnvGT8qoO7SO968z2ZD9Jj3Ko8f+CcrQ2toBxTZTgFQhczRUgoi5HtJnKPm8rYCNVGz
 I0xm+ekpi2KkB3iGWj914i2ajRY/WfAwq+6Msft9BPshdMRffy8VzclpQTU3REfgIF/i
 RUEw==
X-Gm-Message-State: AOAM533jOxBJsPicou1JGlDl/HHWd61+gbFSAiKog2ayl+5Ur0TeLJtT
 mfMTxSOJolsTk4m7fWxWsnuuoK7G1CDEGWmFHcM0sK5vs9VwsNOKnOSzxjkPbvL3tPiHrRydBbr
 OHIwkVb5IpEmUsp2Ncn+I4lTta4XfTUh3m/SbJ2A3rWdN6tDv3FR0p1/PTw==
X-Received: by 2002:a05:6512:2808:b0:43f:4baa:7e5f with SMTP id
 cf8-20020a056512280800b0043f4baa7e5fmr679407lfb.498.1644984870821; 
 Tue, 15 Feb 2022 20:14:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvGQ/nnJgLPQUQhwuqE8vh7JijE6JMtt5Dan0917QmW8EwCohodifZ+blu+a5ngcwNhPqmxW/s7gwTwysBlsY=
X-Received: by 2002:a05:6512:2808:b0:43f:4baa:7e5f with SMTP id
 cf8-20020a056512280800b0043f4baa7e5fmr679397lfb.498.1644984870621; Tue, 15
 Feb 2022 20:14:30 -0800 (PST)
MIME-Version: 1.0
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
 <20220214081416.117695-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220214081416.117695-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Feb 2022 12:14:19 +0800
Message-ID: <CACGkMEt_WcAzcxYGyEvX8zATrbzxmMZzCJYhW_gsML0Ge5xvEA@mail.gmail.com>
Subject: Re: [PATCH v5 06/22] virtio_ring: queue_reset: packed: support enable
 reset queue
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

On Mon, Feb 14, 2022 at 4:14 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> The purpose of this patch is to make vring packed support re-enable reset
> vq.
>
> Based on whether the incoming vq passed by vring_setup_virtqueue() is
> NULL or not, distinguish whether it is a normal create virtqueue or
> re-enable a reset queue.
>
> When re-enable a reset queue, reuse the original callback, name, indirect.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 4639e1643c78..20659f7ca582 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1683,7 +1683,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
>         bool context,
>         bool (*notify)(struct virtqueue *),
>         void (*callback)(struct virtqueue *),
> -       const char *name)
> +       const char *name,
> +       struct virtqueue *_vq)
>  {
>         struct vring_virtqueue *vq;
>         struct vring_packed_desc *ring;
> @@ -1713,13 +1714,20 @@ static struct virtqueue *vring_create_virtqueue_packed(
>         if (!device)
>                 goto err_device;
>
> -       vq = kmalloc(sizeof(*vq), GFP_KERNEL);
> -       if (!vq)
> -               goto err_vq;
> +       if (_vq) {
> +               vq = to_vvq(_vq);
> +       } else {
> +               vq = kmalloc(sizeof(*vq), GFP_KERNEL);
> +               if (!vq)
> +                       goto err_vq;
> +
> +               vq->vq.callback = callback;
> +               vq->vq.name = name;
> +               vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
> +                       !context;
> +       }

The code looks tricky. Except for the memory we don't even need to
touch any of the other attributes.

I'd suggest splitting out the vring allocation into a dedicated helper
that could be called by both vring_create_queue_XXX and the enable()
logic (and in the enable logic we don't even need to relocate if size
is not changed).

Thanks

>
> -       vq->vq.callback = callback;
>         vq->vq.vdev = vdev;
> -       vq->vq.name = name;
>         vq->vq.num_free = num;
>         vq->vq.index = index;
>         vq->we_own_ring = true;
> @@ -1736,8 +1744,6 @@ static struct virtqueue *vring_create_virtqueue_packed(
>         vq->last_add_time_valid = false;
>  #endif
>
> -       vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
> -               !context;
>         vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
>
>         if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> @@ -1778,7 +1784,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
>                 goto err_desc_extra;
>
>         /* No callback?  Tell other side not to bother us. */
> -       if (!callback) {
> +       if (!vq->vq.callback) {
>                 vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
>                 vq->packed.vring.driver->flags =
>                         cpu_to_le16(vq->packed.event_flags_shadow);
> @@ -1792,7 +1798,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  err_desc_extra:
>         kfree(vq->packed.desc_state);
>  err_desc_state:
> -       kfree(vq);
> +       if (!_vq)
> +               kfree(vq);
>  err_vq:
>         vring_free_queue(vdev, event_size_in_bytes, device, device_event_dma_addr);
>  err_device:
> @@ -2317,7 +2324,7 @@ struct virtqueue *vring_setup_virtqueue(
>         if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
>                 return vring_create_virtqueue_packed(index, num, vring_align,
>                                 vdev, weak_barriers, may_reduce_num,
> -                               context, notify, callback, name);
> +                               context, notify, callback, name, vq);
>
>         return vring_create_virtqueue_split(index, num, vring_align,
>                         vdev, weak_barriers, may_reduce_num,
> --
> 2.31.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
