Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC67C433F5
	for <virtualization@archiver.kernel.org>; Wed, 23 Feb 2022 03:19:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24A7160B10;
	Wed, 23 Feb 2022 03:19:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pydYmSelocXY; Wed, 23 Feb 2022 03:19:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8BD0860AD8;
	Wed, 23 Feb 2022 03:19:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B2B6C0021;
	Wed, 23 Feb 2022 03:19:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48E26C0011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 03:19:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 230FB813D6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 03:19:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v_dS4jwIs5rd
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 03:19:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CF184812DB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 03:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645586357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o10+oL16B6fHkAqAM1KRvbz+KhlX2puJg4tawglVFis=;
 b=R0OXMYS54TiDF6QLYCJdMmDrkURtpv3hDyhd+FFwijiH4nj5EkLCPjlrNUPJE7NJd+SY7m
 D4nS2qeH2tZH2IcQ3p1m3wNdfeqYU45SpI2ZGm017Rh8QmtlUw+ERoI22/OlhC/VbqiMph
 E86TG3grDy1/+szhugmv7nhJSSIjKGQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-IuXI0OT7NamI6erQrzSnBQ-1; Tue, 22 Feb 2022 22:19:16 -0500
X-MC-Unique: IuXI0OT7NamI6erQrzSnBQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 m24-20020a056512359800b00442b6ff7a0eso3042716lfr.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 19:19:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=o10+oL16B6fHkAqAM1KRvbz+KhlX2puJg4tawglVFis=;
 b=2+C1875IpwKM6zfllAzpCdxgtdYYf26WnziUiCcOuvf4rNn77RTVouPaQv9ZK1hgrw
 0mAx56COhJgEnTpZtWzMOIbmHyiE3w2WTQ5exlrf8c9Yv5icQivSiQkXCIkK/JfmReHW
 r7+Yi0vbE6zc80ZyIQ9rSJ23OYSmrSBpY1fO1m6YCipCSfNE3Xgdb/XbtyEixWy0D9U+
 YaszF1FxjXPX4BfZQEHmV4YxN3LKC7rq6eJ3Z2kHMBSjmHOMCFmpeaef57xfzDmHhZRw
 D0JsRmWsJ7zhv33pQLfzrMcVmsNdqKcZwIYgsJ+jIpq7ASJ2e+xeb5Rc9E4yTqMoa1aJ
 uLYA==
X-Gm-Message-State: AOAM5331iuQw2eKUOfz0ikhQSeZim+LiEiPxDDy2aVwQNy7UPyDN2ivv
 OqJq1MKb/Ywko7CoJG50SThL3AMG0Ytr3yVBWEZE+aNjehgjcqJUfPavJxUVk17vt7Og9Ig9ENE
 VC+RrYtT5FLBqLtnlg/2d2yPOdVJ28cyA3DquPgGmoDXIwC1OD47zQuBZBQ==
X-Received: by 2002:a05:6512:3147:b0:443:323d:179d with SMTP id
 s7-20020a056512314700b00443323d179dmr19712250lfi.98.1645586354943; 
 Tue, 22 Feb 2022 19:19:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzC+VckbRDPD22Vw3cVRNOnTu5Dv3fTch6szAQ3aD8AdD7ESb4+dCSn4ACFp0ue/sa1Fe1eo+0wiUKb44UQGJA=
X-Received: by 2002:a05:6512:3147:b0:443:323d:179d with SMTP id
 s7-20020a056512314700b00443323d179dmr19712239lfi.98.1645586354760; Tue, 22
 Feb 2022 19:19:14 -0800 (PST)
MIME-Version: 1.0
References: <20211108081324.14204-1-jasowang@redhat.com>
In-Reply-To: <20211108081324.14204-1-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Feb 2022 11:19:03 +0800
Message-ID: <CACGkMEucnZPt_dhaSXCegeFE0gs=dSDfv7CJSq4HCW_4a4XfGg@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: aovid reading flag from the descriptor ring
To: mst <mst@redhat.com>, jasowang <jasowang@redhat.com>, 
 virtualization <virtualization@lists.linux-foundation.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Mon, Nov 8, 2021 at 4:13 PM Jason Wang <jasowang@redhat.com> wrote:
>
> Commit 72b5e8958738 ("virtio-ring: store DMA metadata in desc_extra
> for split virtqueue") tries to make it possible for the driver to not
> read from the descriptor ring to prevent the device from corrupting
> the descriptor ring. But it still read the descriptor flag from the
> descriptor ring during buffer detach.
>
> This patch fixes by always store the descriptor flag no matter whether
> DMA API is used and then we can avoid reading descriptor flag from the
> descriptor ring. This eliminates the possibly of unexpected next
> descriptor caused by the wrong flag (e.g the next flag).
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Michael, any comment for this?

Thanks

> ---
>  drivers/virtio/virtio_ring.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 00f64f2f8b72..28734f4e57d3 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -583,7 +583,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>         }
>         /* Last one doesn't continue. */
>         desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> -       if (!indirect && vq->use_dma_api)
> +       if (!indirect)
>                 vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
>                         ~VRING_DESC_F_NEXT;
>
> @@ -713,7 +713,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>         /* Put back on free list: unmap first-level descriptors and find end */
>         i = head;
>
> -       while (vq->split.vring.desc[i].flags & nextflag) {
> +       while (vq->split.desc_extra[i].flags & nextflag) {
>                 vring_unmap_one_split(vq, i);
>                 i = vq->split.desc_extra[i].next;
>                 vq->vq.num_free++;
> --
> 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
