Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434C1CCA47E
	for <virtualization@archiver.kernel.org>; Thu, 30 Jun 2022 06:40:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE75E61319;
	Thu, 30 Jun 2022 06:40:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE75E61319
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fy0BhHnA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JFu3a9cDf5U0; Thu, 30 Jun 2022 06:40:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6215861312;
	Thu, 30 Jun 2022 06:40:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6215861312
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A3BDC0021;
	Thu, 30 Jun 2022 06:40:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A1EBC0021
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 06:40:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 25C8D60EF6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 06:40:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 25C8D60EF6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tWYab_X4SNLP
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 06:40:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3C218600C6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3C218600C6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 06:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656571222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jAHrr0+GxDfej1qVCdn75eKSnjxER8aot4sqAySqnyU=;
 b=Fy0BhHnAxkfS4Aij/b/EnOh1r3YwmwRPwR97MYaXzoVl7CqRKdWiMGv04KZDijJYkUtUH5
 0Jn/v+mqF2u53Hyi28AV9Gp5GVLqgqaFqNNRjSJhCEeqPcNYB1WuqBFg71teBSCjCwo7nL
 8e79dJtz4sQ/Uwz1YAJ1p+8xP8qJw+4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-rVhaZADoOAi6Sn0H_jjXZA-1; Thu, 30 Jun 2022 02:40:15 -0400
X-MC-Unique: rVhaZADoOAi6Sn0H_jjXZA-1
Received: by mail-lf1-f69.google.com with SMTP id
 o7-20020a056512230700b004810a865709so6376980lfu.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 23:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jAHrr0+GxDfej1qVCdn75eKSnjxER8aot4sqAySqnyU=;
 b=ASAxK8tbYAU7U4JUFQbt5dVh0tQA5dj7d6nqc9CZ9CTbVCnaAEWu0V5Zqjk06jtQ8D
 fMJxuSS9nB4UsipUJDdi9VjEXTtvqKrK4Fof3HmOthG+SBC/qx7aMH6K94rVyw7EXF/l
 woVequUolA0LDtDFtqMNGKNp4dJ0VCcBE1tsNr+1OvvHBH9HgxSUVRIK4PZ13si+Qcem
 uldS3FparDRM+0AU8FYLS6FpsjPoRgk/paWeKOlhikiJn/jXQDvAv3RpSyZB3MWE/M9q
 isS5D5TUYeGPeeJdvIloyU0Z1aEYOmblbOhzk1Zpo0sbkEZ4gBKpkyaDaGPUVVWefQ5p
 hGUQ==
X-Gm-Message-State: AJIora97jaTeHBM+zHO01Jq0hwIjTNv+oTMOHjoMtS5sJ8FtyJiGaJak
 Nr3kZRzgfhBBjv/XugC8G9ToFdEjtTR5LbaOb0yK7VfDpu9A7y9qGIGQBzaxlKwDsWb3Xy9LMDV
 C9oHrhZXZ0Bcb8B5euGdSKXHKcLqCB9AM9ID4JaIvpvbjoqGsSLg7jkomiA==
X-Received: by 2002:a05:6512:158d:b0:47f:718c:28b5 with SMTP id
 bp13-20020a056512158d00b0047f718c28b5mr4753521lfb.397.1656571213813; 
 Wed, 29 Jun 2022 23:40:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tAA0XU6ZzbOAb5pqi3g/cuvZsx0P7N9Yp/LWOT+IpPh+uRjEGCtW9glE4GIh09HeOKg0ELev5VqROwEDkQfbM=
X-Received: by 2002:a05:6512:158d:b0:47f:718c:28b5 with SMTP id
 bp13-20020a056512158d00b0047f718c28b5mr4753513lfb.397.1656571213588; Wed, 29
 Jun 2022 23:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220629065656.54420-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 Jun 2022 14:40:02 +0800
Message-ID: <CACGkMEvfFV8w34=SiS4XFyEH5+EEkb9JqYg0t_rKpU1rRBMLiQ@mail.gmail.com>
Subject: Re: [PATCH v11 05/40] virtio_ring: split vring_virtqueue
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm <kvm@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, platform-driver-x86@vger.kernel.org,
 Eric Farman <farman@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, kangjie.xu@linux.alibaba.com,
 Heiko Carstens <hca@linux.ibm.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "open list:XDP \(eXpress Data Path\)" <bpf@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 netdev <netdev@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 Sven Schnelle <svens@linux.ibm.com>, Johannes Berg <johannes@sipsolutions.net>,
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

On Wed, Jun 29, 2022 at 2:57 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> Separate the two inline structures(split and packed) from the structure
> vring_virtqueue.
>
> In this way, we can use these two structures later to pass parameters
> and retain temporary variables.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/virtio_ring.c | 116 ++++++++++++++++++-----------------
>  1 file changed, 60 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index bb4e8ae09c9b..2806e033a651 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -85,6 +85,64 @@ struct vring_desc_extra {
>         u16 next;                       /* The next desc state in a list. */
>  };
>
> +struct vring_virtqueue_split {
> +       /* Actual memory layout for this queue. */
> +       struct vring vring;
> +
> +       /* Last written value to avail->flags */
> +       u16 avail_flags_shadow;
> +
> +       /*
> +        * Last written value to avail->idx in
> +        * guest byte order.
> +        */
> +       u16 avail_idx_shadow;
> +
> +       /* Per-descriptor state. */
> +       struct vring_desc_state_split *desc_state;
> +       struct vring_desc_extra *desc_extra;
> +
> +       /* DMA address and size information */
> +       dma_addr_t queue_dma_addr;
> +       size_t queue_size_in_bytes;
> +};
> +
> +struct vring_virtqueue_packed {
> +       /* Actual memory layout for this queue. */
> +       struct {
> +               unsigned int num;
> +               struct vring_packed_desc *desc;
> +               struct vring_packed_desc_event *driver;
> +               struct vring_packed_desc_event *device;
> +       } vring;
> +
> +       /* Driver ring wrap counter. */
> +       bool avail_wrap_counter;
> +
> +       /* Avail used flags. */
> +       u16 avail_used_flags;
> +
> +       /* Index of the next avail descriptor. */
> +       u16 next_avail_idx;
> +
> +       /*
> +        * Last written value to driver->flags in
> +        * guest byte order.
> +        */
> +       u16 event_flags_shadow;
> +
> +       /* Per-descriptor state. */
> +       struct vring_desc_state_packed *desc_state;
> +       struct vring_desc_extra *desc_extra;
> +
> +       /* DMA address and size information */
> +       dma_addr_t ring_dma_addr;
> +       dma_addr_t driver_event_dma_addr;
> +       dma_addr_t device_event_dma_addr;
> +       size_t ring_size_in_bytes;
> +       size_t event_size_in_bytes;
> +};
> +
>  struct vring_virtqueue {
>         struct virtqueue vq;
>
> @@ -124,64 +182,10 @@ struct vring_virtqueue {
>
>         union {
>                 /* Available for split ring */
> -               struct {
> -                       /* Actual memory layout for this queue. */
> -                       struct vring vring;
> -
> -                       /* Last written value to avail->flags */
> -                       u16 avail_flags_shadow;
> -
> -                       /*
> -                        * Last written value to avail->idx in
> -                        * guest byte order.
> -                        */
> -                       u16 avail_idx_shadow;
> -
> -                       /* Per-descriptor state. */
> -                       struct vring_desc_state_split *desc_state;
> -                       struct vring_desc_extra *desc_extra;
> -
> -                       /* DMA address and size information */
> -                       dma_addr_t queue_dma_addr;
> -                       size_t queue_size_in_bytes;
> -               } split;
> +               struct vring_virtqueue_split split;
>
>                 /* Available for packed ring */
> -               struct {
> -                       /* Actual memory layout for this queue. */
> -                       struct {
> -                               unsigned int num;
> -                               struct vring_packed_desc *desc;
> -                               struct vring_packed_desc_event *driver;
> -                               struct vring_packed_desc_event *device;
> -                       } vring;
> -
> -                       /* Driver ring wrap counter. */
> -                       bool avail_wrap_counter;
> -
> -                       /* Avail used flags. */
> -                       u16 avail_used_flags;
> -
> -                       /* Index of the next avail descriptor. */
> -                       u16 next_avail_idx;
> -
> -                       /*
> -                        * Last written value to driver->flags in
> -                        * guest byte order.
> -                        */
> -                       u16 event_flags_shadow;
> -
> -                       /* Per-descriptor state. */
> -                       struct vring_desc_state_packed *desc_state;
> -                       struct vring_desc_extra *desc_extra;
> -
> -                       /* DMA address and size information */
> -                       dma_addr_t ring_dma_addr;
> -                       dma_addr_t driver_event_dma_addr;
> -                       dma_addr_t device_event_dma_addr;
> -                       size_t ring_size_in_bytes;
> -                       size_t event_size_in_bytes;
> -               } packed;
> +               struct vring_virtqueue_packed packed;
>         };
>
>         /* How to notify other side. FIXME: commonalize hcalls! */
> --
> 2.31.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
