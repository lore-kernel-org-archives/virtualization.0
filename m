Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0651BC433EF
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 02:33:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93EE960232
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 02:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 93EE960232
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 322FE60AD7;
	Wed, 27 Oct 2021 02:33:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ogEAHH-OHIa3; Wed, 27 Oct 2021 02:33:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5400E60AC5;
	Wed, 27 Oct 2021 02:33:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 016D8C0012;
	Wed, 27 Oct 2021 02:33:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C59EC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 02:33:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 560E9400E6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 02:33:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jr7DMapbufTE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 02:33:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E9729400C1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 02:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635301979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FpY57pN68hypRn3VPWxfGVMWd/Evtah6Ooz3LxnRlCk=;
 b=f6G5ozQStwr4ftPf7BPrRU35OZrKuVeJ/EExyLkxp4wCdfhRSONrX9Vh04DsRSTNqSanl+
 hCa58xJsZeB7VHZEeAt2GQPft0Qa3RqTWbQu03Y9Kk+QR44bO8ZLP4wk9S2NiOk58/R96G
 wdkMYrZ/7TD5PgWk29eHF8M+1mi+H5g=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-7pHEpuCJPBWt4QCRHR4Weg-1; Tue, 26 Oct 2021 22:32:58 -0400
X-MC-Unique: 7pHEpuCJPBWt4QCRHR4Weg-1
Received: by mail-lj1-f197.google.com with SMTP id
 w9-20020a2e9989000000b00210af61ebbdso223344lji.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 19:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FpY57pN68hypRn3VPWxfGVMWd/Evtah6Ooz3LxnRlCk=;
 b=JD/PA80/PUbNLrtGgJv5qlsLLNIikQPWi9ByilMTosTukTdWvu1lX1C59cMV+RK3/J
 UMSNs1cNdl6oPSLwVH3OCueUpx7JyJ1pt+4Cu9zHYsMDkd43Jwq/vPoh7/u7HyTo58l3
 gG1/blJ6ZKIPX9Ud+JW9KF3+RVG6U72grs5hqOC2Bd1qynTrWZofNq6NLucohRwr5Ik6
 USsx2mmmaTahDmnOXLRhX+/BexN7y7vEij5Xaoovc/g3zJn38IevPl/RQkFvzV9Ai6BB
 0CGvVlzQ2LoONW8lwMiJodC9kzbKKo3STodYSXdYPIaGOA5HYpaGFnDCYlx53ayb4wMf
 De9g==
X-Gm-Message-State: AOAM531txh8lgxOw9YCQqQ7MwmWEcXxXf7BAgoi0bEglKlza2F8PXCyi
 46wd0VseYQcAh0X2FEALdUT1XlsTXbELTpmcZOF17htPUNaSfytJTLortjvtriV6T6rDzvx2gco
 G4s9nYWLCdDshPBlKW7kxuO0mVAXKDAx+KVV1mVNITxJU4VevsipQ9fsadg==
X-Received: by 2002:a05:6512:3d11:: with SMTP id
 d17mr21981071lfv.481.1635301976724; 
 Tue, 26 Oct 2021 19:32:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcJzUayQqKMB7n4AC/Y6wG3Ef/heoMjTsB0jO3MjkD2lJ2F5C2jP8JhzR4d7qnIl4V2PhHCNZrWDAvoaUcqvA=
X-Received: by 2002:a05:6512:3d11:: with SMTP id
 d17mr21981052lfv.481.1635301976517; 
 Tue, 26 Oct 2021 19:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211026133100.17541-1-vincent.whitchurch@axis.com>
In-Reply-To: <20211026133100.17541-1-vincent.whitchurch@axis.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Oct 2021 10:32:45 +0800
Message-ID: <CACGkMEvV2HkXyv4RfB3pfmeaG8Nv4=XBG2Y1c+7mi0OnOUCWNA@mail.gmail.com>
Subject: Re: [PATCH] virtio-ring: fix DMA metadata flags
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>, kernel@axis.com,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Tue, Oct 26, 2021 at 9:31 PM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> The flags are currently overwritten, leading to the wrong direction
> being passed to the DMA unmap functions.
>
> Fixes: 72b5e8958738aaa4 ("virtio-ring: store DMA metadata in desc_extra for split virtqueue")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index dd95dfd85e98..3035bb6f5458 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -576,7 +576,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>         /* Last one doesn't continue. */
>         desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
>         if (!indirect && vq->use_dma_api)
> -               vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags =
> +               vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
>                         ~VRING_DESC_F_NEXT;
>
>         if (indirect) {
> --
> 2.28.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
