Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F1AC25B0E
	for <virtualization@archiver.kernel.org>; Fri, 19 Aug 2022 06:30:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8F2D040484;
	Fri, 19 Aug 2022 06:30:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F2D040484
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NHrLS6Nn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FjNfg-TGLDYC; Fri, 19 Aug 2022 06:30:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1A750400CE;
	Fri, 19 Aug 2022 06:30:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1A750400CE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3921C0032;
	Fri, 19 Aug 2022 06:30:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C953DC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 06:30:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9E7DF60E68
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 06:30:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9E7DF60E68
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NHrLS6Nn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XVveZm-bevxI
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 06:30:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C6287607F0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C6287607F0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 06:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660890626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+STKAMW3/WbwF0Tt2g3VL2URFydCHd++2Kywb8yKSF4=;
 b=NHrLS6Nn+MH4/ndcQwePQA81grRHSlQf4Y713TPYqLLXwa6urLI67FBb41ZpthhiT6GBkd
 KSWJxUg5DKkWS5UTjwcAjhjIy3QV8We95dslUgnoOdDvAtlIbJPn5mjSVtHFRF89mHRrHU
 UlyvqQjbfb4WxkF/avelcoMpwkjpZPA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-58-6a94908ZNcyAO9viiRPNhw-1; Fri, 19 Aug 2022 02:30:25 -0400
X-MC-Unique: 6a94908ZNcyAO9viiRPNhw-1
Received: by mail-lj1-f198.google.com with SMTP id
 l6-20020a2ea306000000b0025ff55d64afso772818lje.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 23:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=+STKAMW3/WbwF0Tt2g3VL2URFydCHd++2Kywb8yKSF4=;
 b=Xn9pTxJP+cVjLe19hm/myEDA0eZdXQMmlD11FJ9rJbldtwE99+YR4C5GKEvnzhcP7a
 GaEBe0b54oN3GlvMiOkAhh07Fgue3vrw1uhhd9XyVZpXYYhc0lwrqM4UAbmGvNhYdmkX
 ketC+21MNSm0foS0lKEjgMTHfdu57yJpCD7+ZmgiDcCH78brcEtpYnAGPBXH+qUytaHr
 6k/E06QTTmq0TYp8h4iQ2eTHnn9B23Q8d40TZv79sok+3bxIML7jr8m/H6akjGLchAIM
 Hyo9Wxc4nPzj3r88BtWaohCN3b9imau7ptY5knu5SqnRzXJzjdpPU1RP7rMWXXPvH5tY
 qpuA==
X-Gm-Message-State: ACgBeo3lCq5BTJrmPzrzJAMjcMOedSJNBoitoV4YnkMIPx0gatcsYF2M
 Ls2stCVWYzTzUJLDePbyN6RpbuG0iFHZRaeg9mtTziNLQ0n9KVAAYdqh9KXMxLpkr+fnt0X22dZ
 oDzEbgNfpVsV7HrE80ROYiJWk9xUWEiNZzidwOT22WoI8MvQACgu23fHNeA==
X-Received: by 2002:a2e:a983:0:b0:25f:f273:548e with SMTP id
 x3-20020a2ea983000000b0025ff273548emr1648859ljq.141.1660890623789; 
 Thu, 18 Aug 2022 23:30:23 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6MLby3Xdd24ymmMjmVShJty7uFiB8RdFBLg1mr1gsAbSkF+k1zZcFZLUTomkcvmEeC1Vt7QAF8K47YYb/Hyd4=
X-Received: by 2002:a2e:a983:0:b0:25f:f273:548e with SMTP id
 x3-20020a2ea983000000b0025ff273548emr1648847ljq.141.1660890623580; Thu, 18
 Aug 2022 23:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220816030559.111057-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220816030559.111057-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Aug 2022 14:30:12 +0800
Message-ID: <CACGkMEsZrbbi6uWBWumrrfYzD+UySsK4ZTtoOZ0wOMZDAgfnmw@mail.gmail.com>
Subject: Re: [PATCH] virtio_pci: use container_of replace type conversion
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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

On Tue, Aug 16, 2022 at 11:06 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> Replace type conversion with container_of() in
> vp_modern_set_queue_reset()/vp_modern_get_queue_reset() .
> Also combine declarations and assignments.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/virtio_pci_modern_dev.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index 869cb46bef96..530c954439de 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -482,12 +482,12 @@ EXPORT_SYMBOL_GPL(vp_modern_set_status);
>   */
>  int vp_modern_get_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
>  {
> -       struct virtio_pci_modern_common_cfg __iomem *cfg;
> -
> -       cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev->common;
> +       struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> +       struct virtio_pci_modern_common_cfg __iomem *mcfg =
> +               container_of(cfg, struct virtio_pci_modern_common_cfg, cfg);
>
> -       vp_iowrite16(index, &cfg->cfg.queue_select);
> -       return vp_ioread16(&cfg->queue_reset);
> +       vp_iowrite16(index, &cfg->queue_select);
> +       return vp_ioread16(&mcfg->queue_reset);
>  }
>  EXPORT_SYMBOL_GPL(vp_modern_get_queue_reset);
>
> @@ -498,17 +498,17 @@ EXPORT_SYMBOL_GPL(vp_modern_get_queue_reset);
>   */
>  void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
>  {
> -       struct virtio_pci_modern_common_cfg __iomem *cfg;
> -
> -       cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev->common;
> +       struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> +       struct virtio_pci_modern_common_cfg __iomem *mcfg =
> +               container_of(cfg, struct virtio_pci_modern_common_cfg, cfg);
>
> -       vp_iowrite16(index, &cfg->cfg.queue_select);
> -       vp_iowrite16(1, &cfg->queue_reset);
> +       vp_iowrite16(index, &cfg->queue_select);
> +       vp_iowrite16(1, &mcfg->queue_reset);
>
> -       while (vp_ioread16(&cfg->queue_reset))
> +       while (vp_ioread16(&mcfg->queue_reset))
>                 msleep(1);
>
> -       while (vp_ioread16(&cfg->cfg.queue_enable))
> +       while (vp_ioread16(&cfg->queue_enable))
>                 msleep(1);
>  }
>  EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
> --
> 2.31.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
