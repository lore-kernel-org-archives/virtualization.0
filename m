Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66305C433F5
	for <virtualization@archiver.kernel.org>; Thu,  2 Dec 2021 03:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD0CD607C2;
	Thu,  2 Dec 2021 03:12:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yUkvwLEZI2ZR; Thu,  2 Dec 2021 03:12:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7252760711;
	Thu,  2 Dec 2021 03:12:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BD34C0012;
	Thu,  2 Dec 2021 03:12:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C153CC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 03:12:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A798B607B7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 03:12:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yXXZWsPGMEDq
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 03:12:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 96CAC60711
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 03:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638414759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xVgflJHaF1j7g8uerCAN33DYEdhX1y5Z75xZHZOUsZ0=;
 b=TSA8C+nhJ9HdmtUA0PCtu8GezPfNzBferLUmD4K0VEZaxCpS37IteoFaJQ8/98cMOsjfoA
 e1v+lDzlZtpt8SKjfirh2QxtcisFf0jwILb1RgqRBtp1dURz0NV9d1hF6YCj/KX8iWPeaW
 mtj3BehC+4wbb8JTWysXRKOD5pcrEYI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-fq9NIv5BP12wmnfsHUWqVg-1; Wed, 01 Dec 2021 22:12:38 -0500
X-MC-Unique: fq9NIv5BP12wmnfsHUWqVg-1
Received: by mail-lf1-f69.google.com with SMTP id
 i6-20020a0565123e0600b00417d29eede4so6161461lfv.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Dec 2021 19:12:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xVgflJHaF1j7g8uerCAN33DYEdhX1y5Z75xZHZOUsZ0=;
 b=vjJFS58kRRZZGdSdRARRq04QgI1FJ5uiTbz+AY8m0pMjtt3xwHOszUM03fKOlslZZd
 iESJYozetl+23tDkfHPDwgATYFCrVgL+9TjyT60FRS+feL+tjYObuXE+xkq27IKFtoBM
 ratGOKaIELz5Q+y4DIOv2H/+L4D5R6bVsA3QoAHTHrI1nEERghnrKzga7kmkPtUd5ZZ2
 WEE1Imf3C/+wDAEUxA6TNY0DHSZrVKZ4ZKW2WrHxtVfP2FXsyIX7XOnKcVsa6rITdeio
 j2HBQqLppoPNN99ej6sa6qkMUSXvJtlHMbLYDnMLNwPZC6YwZFmm4Y0yX9004tP6WQ4A
 bnHw==
X-Gm-Message-State: AOAM530D5LxeqfRUGgRyW4G7ZEB9WQV2GtjZtCuC/IkG0p2g3wPvsola
 HlpSuDeoubiLgP8NR6QT2Cv3wFkNBxigCCIAGHEd9lljDo4QLafts9tn0RKpBvj/Xz2FTMLymrT
 0glYXyACryZWBoZr4t6MEVW0vuCuDQdlrCfACLMpq6KeGBm50IOuZdUwpIQ==
X-Received: by 2002:a05:6512:685:: with SMTP id
 t5mr9795911lfe.84.1638414756473; 
 Wed, 01 Dec 2021 19:12:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyw3w5n79ljGY0VlIaSf9/IlrBtw0r+CsnB6lzMaAIT72SuPP/eOUmVRb7AsYoSC0+rAFwjT0tZSpLJXhNsoDU=
X-Received: by 2002:a05:6512:685:: with SMTP id
 t5mr9795887lfe.84.1638414756236; 
 Wed, 01 Dec 2021 19:12:36 -0800 (PST)
MIME-Version: 1.0
References: <20211201112018.25276-1-will@kernel.org>
In-Reply-To: <20211201112018.25276-1-will@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Dec 2021 11:12:25 +0800
Message-ID: <CACGkMEtPaJQQxYOCP2TXXuOdtA5TLCxJQVyjNV6xzsTvycbdog@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: Fix querying of maximum DMA mapping size for
 virtio device
To: Will Deacon <will@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Marc Zyngier <maz@kernel.org>, Quentin Perret <qperret@google.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
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

On Wed, Dec 1, 2021 at 7:20 PM Will Deacon <will@kernel.org> wrote:
>
> virtio_max_dma_size() returns the maximum DMA mapping size of the virtio
> device by querying dma_max_mapping_size() for the device when the DMA
> API is in use for the vring. Unfortunately, the device passed is
> initialised by register_virtio_device() and does not inherit the DMA
> configuration from its parent, resulting in SWIOTLB errors when bouncing
> is enabled and the default 256K mapping limit (IO_TLB_SEGSIZE) is not
> respected:
>
>   | virtio-pci 0000:00:01.0: swiotlb buffer is full (sz: 294912 bytes), total 1024 (slots), used 725 (slots)
>
> Follow the pattern used elsewhere in the virtio_ring code when calling
> into the DMA layer and pass the parent device to dma_max_mapping_size()
> instead.
>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Quentin Perret <qperret@google.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Will Deacon <will@kernel.org>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 6d2614e34470..028b05d44546 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -268,7 +268,7 @@ size_t virtio_max_dma_size(struct virtio_device *vdev)
>         size_t max_segment_size = SIZE_MAX;
>
>         if (vring_use_dma_api(vdev))
> -               max_segment_size = dma_max_mapping_size(&vdev->dev);
> +               max_segment_size = dma_max_mapping_size(vdev->dev.parent);
>
>         return max_segment_size;
>  }
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
