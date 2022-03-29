Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612C3C433FE
	for <virtualization@archiver.kernel.org>; Tue, 29 Mar 2022 04:57:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9D8B60A82;
	Tue, 29 Mar 2022 04:57:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PcO61ZuRSEVH; Tue, 29 Mar 2022 04:57:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9B7CC60A9D;
	Tue, 29 Mar 2022 04:57:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B9A9C002C;
	Tue, 29 Mar 2022 04:57:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4B1BC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 04:57:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 938D960A82
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 04:57:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Oi-ET2FmptmM
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 04:57:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A682F60A9D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 04:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648529820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gdLLGvlsfSndXxLHrwfmGo1wuClHNVPUNMw1k7Q6B5c=;
 b=JhjAfjnwERmJ9cLoj9RYsmhdGUnXIuMXfEsFCzETU0VEEmGYV2KHCmg2HxMKbnTjv3iSS9
 B4lZSOtI9zWHcI/3u88ZoWg4X8vdW6FJsx+wF0bQ7wBMz0wNPN5PHH6gHlDt3BofsghRkq
 aPh6jpaoDn7Aqt57fKYPbIjZlJD7B0U=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-X9E8vGCtNRSAqff0uEJ6RA-1; Tue, 29 Mar 2022 00:56:59 -0400
X-MC-Unique: X9E8vGCtNRSAqff0uEJ6RA-1
Received: by mail-lj1-f198.google.com with SMTP id
 76-20020a2e054f000000b00249606fea4fso6979413ljf.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 21:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gdLLGvlsfSndXxLHrwfmGo1wuClHNVPUNMw1k7Q6B5c=;
 b=YZgggouiviI+ZpBIzbZ7pDr1Z+Q2kC9nNf4XmfIhVyKAbL75OPfC4IXPV+w46Ie60s
 P8ZZqNf+x0mIEX0uAZVGQujmIr7exnIs8xNAyRakEAyT1Fa7roPof121gfLyYWBa27gl
 jw/8YnH4LRcvWjJ0Q+YwKFh05GXUaxWkosR2DUx3oE9w1wKq6k6lo3F7Jad0x0v56nsd
 UssmFrkz7dhr/mcoMcxaKYbKwBXjeoIP1umNUAP5eE9aToMO7F7uUHsgWm3BU+RUiYd5
 lcc4UdeGKdgwViyvEdgGYwNG2knBqBNLm0awlUYhrPk378eoYTy779BbBm9Z5X0lyX8y
 fzFw==
X-Gm-Message-State: AOAM533W6Ra7vfwJp3vymUpgF4pHMKve/KArRld0jvkR4U4Kh1NSjGt9
 RG47qsiT6gWJlUDvHMkkDvSlHbXEmatoV7GNXTx5qYMRi3rc/D/jAxdSZ3pxFdSJ+zlpcYYtIYs
 CS0yE4bCy0SDx1NkU0W+y6P5V1/2p4zTFZTOU0RWyN997Nr3O6zKJX2ny4g==
X-Received: by 2002:ac2:4477:0:b0:44a:55c6:155d with SMTP id
 y23-20020ac24477000000b0044a55c6155dmr955557lfl.376.1648529817594; 
 Mon, 28 Mar 2022 21:56:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMBty9gTNcSKDAu+UruK8Auyu5/UV/1EcCa8Wu0m7ZR4UG4Wnhxa0RW6zMkOug5DsK9BND0duZE1InjsTyS1w=
X-Received: by 2002:ac2:4477:0:b0:44a:55c6:155d with SMTP id
 y23-20020ac24477000000b0044a55c6155dmr955540lfl.376.1648529817389; Mon, 28
 Mar 2022 21:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220328105817.1028065-1-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220328105817.1028065-1-xianting.tian@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 29 Mar 2022 12:56:46 +0800
Message-ID: <CACGkMEvgcJy3k-s39QeLkLFho_wpsBnEbrcHWugajy50qjAo-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio_ring: remove unnecessary to_vvq call in vring
 hot path
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, mst <mst@redhat.com>
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

On Mon, Mar 28, 2022 at 6:58 PM Xianting Tian
<xianting.tian@linux.alibaba.com> wrote:
>
> It passes '_vq' to virtqueue_use_indirect(), which still calls
> to_vvq to get 'vq', let's directly pass 'vq'. It can avoid
> unnecessary call of to_vvq in hot path.
>
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/virtio_ring.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 962f1477b1fa..d597fc0874ec 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -205,11 +205,9 @@ struct vring_virtqueue {
>
>  #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
>
> -static inline bool virtqueue_use_indirect(struct virtqueue *_vq,
> +static inline bool virtqueue_use_indirect(struct vring_virtqueue *vq,
>                                           unsigned int total_sg)
>  {
> -       struct vring_virtqueue *vq = to_vvq(_vq);
> -
>         /*
>          * If the host supports indirect descriptor tables, and we have multiple
>          * buffers, then go indirect. FIXME: tune this threshold
> @@ -507,7 +505,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>
>         head = vq->free_head;
>
> -       if (virtqueue_use_indirect(_vq, total_sg))
> +       if (virtqueue_use_indirect(vq, total_sg))
>                 desc = alloc_indirect_split(_vq, total_sg, gfp);
>         else {
>                 desc = NULL;
> @@ -1194,7 +1192,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>
>         BUG_ON(total_sg == 0);
>
> -       if (virtqueue_use_indirect(_vq, total_sg)) {
> +       if (virtqueue_use_indirect(vq, total_sg)) {
>                 err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
>                                                     in_sgs, data, gfp);
>                 if (err != -ENOMEM) {
> --
> 2.17.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
