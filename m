Return-Path: <SRS0=Y9jr=OS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA20C4332F
	for <virtualization@archiver.kernel.org>; Tue, 28 Sep 2021 03:20:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23B3B6128A
	for <virtualization@archiver.kernel.org>; Tue, 28 Sep 2021 03:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 23B3B6128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E31D380D22;
	Tue, 28 Sep 2021 03:20:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TZy9g8bh6AR7; Tue, 28 Sep 2021 03:20:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 953C780D14;
	Tue, 28 Sep 2021 03:20:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66888C0011;
	Tue, 28 Sep 2021 03:20:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC26FC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 03:20:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9F96A80D14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 03:20:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WVvgTGVc3sCV
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 03:20:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E6A5780D18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 03:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632799218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kx6fea1Fq7Zi1mNmn/VWrlCh1bjTv9PS8D5opva6ZlI=;
 b=FxZ8mq62hxhgINt1xQiO/81Yl51gvelEr1ORsoUl2a38o7e8OZREEQiJ6AHEA4cAAPjyIo
 updemCj2ETV8Ap94z1y90scd0bDGcfsKOWSfKkBPtzyaR3U2mN6P5g9jEhtoMjfbKoHCom
 sRFVO9NIJRVpiRTazJ++wIUNDYwq7zQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-RLq6AhtBPNiE_t0CzgNZSA-1; Mon, 27 Sep 2021 23:20:17 -0400
X-MC-Unique: RLq6AhtBPNiE_t0CzgNZSA-1
Received: by mail-lf1-f69.google.com with SMTP id
 n22-20020a0565120ad600b003fcc09af59fso12575463lfu.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 20:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kx6fea1Fq7Zi1mNmn/VWrlCh1bjTv9PS8D5opva6ZlI=;
 b=Vj6hx3miFfwUWFIq3FY9qcRqi6shKINlDjBPFW9ZbbsZDm/OkTNzD+IV3q7wzYk4fr
 OsF9RXC/+8uZF3LPEhtqhL5i82JwLYg9KIVRtxWRzq+iYn4XWVsy/8R7LLHl64k6T1Wo
 N3kov1UmpR4t5UmTVDZ7/qvKkG2NshHtI5r8NVMRd0O2GSDbIDfEv05moX/AolikMc1o
 PqyBOrFkCo+kdnHYltsg1oMqPfsNrJdAJEMogsnwDRKbpFI23q673HWYcXwk19AwowLv
 MlBf06hWoiFyHdM/wL6esWgOKGmER9TSz9lz+ht1JpzVMNiX0D2/peECZw85k+qPzT4I
 pfsA==
X-Gm-Message-State: AOAM532ArJzhvU6UvtNPr8S9FWNNRikKN1JnWI6s7IfsPoUyu5/I6DV9
 sXdYBnPmoNn+1K234zbsG6I0eSwIP+2SxZTUGUYzqh2AaRTLxRUKPyEbaRSklJcLZn6k+D0bXJA
 eRgCAaFVX7XlXIwbefCXIeOras7+/lNB2zRRZY7kky3nrk4W3WFaA0BBoMw==
X-Received: by 2002:a05:6512:32ca:: with SMTP id
 f10mr3467264lfg.498.1632799215996; 
 Mon, 27 Sep 2021 20:20:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXXYw8tYC5S6eFE0s95VNWsgfqkdbfpgiCrjeN7mGRhEMQB6BoieKL7Oar/YJNfvFIysot5M/+HOvuIoOzgr8=
X-Received: by 2002:a05:6512:32ca:: with SMTP id
 f10mr3467245lfg.498.1632799215812; 
 Mon, 27 Sep 2021 20:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210927105412.18579-1-xuanzhuo@linux.alibaba.com>
 <20210927105412.18579-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20210927105412.18579-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 28 Sep 2021 11:20:04 +0800
Message-ID: <CACGkMEs4Eo9bx7i2wsc3h=48_iH7Et_mpv=SUWoo2Sewm-NjSQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] virtio_ring: check desc == NULL when packed and
 indirect
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Tiwei Bie <tiwei.bie@intel.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Mon, Sep 27, 2021 at 6:54 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> In the case of packed, use indirect desc, since desc is allocated by
> kmalloc_array(), we should check whether its return value is NULL.
>
> This patch alloc desc inside virtqueue_add_packe(), if desc == NULL,
> fall back to not using indirect.
>
> Fixes: 1ce9e6055fa ("virtio_ring: introduce packed ring support")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/virtio_ring.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 91a46c4da87d..62323c27bfe4 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1051,20 +1051,19 @@ static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
>
>  static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>                                          struct scatterlist *sgs[],
> +                                        struct vring_packed_desc *desc,
>                                          unsigned int total_sg,
>                                          unsigned int out_sgs,
>                                          unsigned int in_sgs,
>                                          void *data,
>                                          gfp_t gfp)
>  {
> -       struct vring_packed_desc *desc;
>         struct scatterlist *sg;
>         unsigned int i, n, err_idx;
>         u16 head, id;
>         dma_addr_t addr;
>
>         head = vq->packed.next_avail_idx;
> -       desc = alloc_indirect_packed(total_sg, gfp);
>
>         if (unlikely(vq->vq.num_free < 1)) {
>                 pr_debug("Can't add buf len 1 - avail = 0\n");
> @@ -1191,9 +1190,14 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>
>         BUG_ON(total_sg == 0);
>
> -       if (virtqueue_use_indirect(_vq, total_sg))
> -               return virtqueue_add_indirect_packed(vq, sgs, total_sg,
> -                               out_sgs, in_sgs, data, gfp);
> +       if (virtqueue_use_indirect(_vq, total_sg)) {
> +               desc = alloc_indirect_packed(total_sg, gfp);
> +               if (desc)
> +                       return virtqueue_add_indirect_packed(vq, sgs, desc,
> +                                                            total_sg,
> +                                                            out_sgs, in_sgs,
> +                                                            data, gfp);
> +       }
>
>         head = vq->packed.next_avail_idx;
>         avail_used_flags = vq->packed.avail_used_flags;
> --
> 2.31.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
