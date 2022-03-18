Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0222CC433EF
	for <virtualization@archiver.kernel.org>; Fri, 18 Mar 2022 02:22:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77CD5418D1;
	Fri, 18 Mar 2022 02:22:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iNwwkxmVNcdh; Fri, 18 Mar 2022 02:22:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2180C4185A;
	Fri, 18 Mar 2022 02:22:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F4147C0033;
	Fri, 18 Mar 2022 02:22:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0051CC0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 02:22:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DD21760B35
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 02:22:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hWNv01yGucV5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 02:22:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2806E60E40
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 02:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647570125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jcLirLBEGvDklvL5IK4efni0vW6AGIFKCzBkNt8jT7I=;
 b=U2F2de3p4y3J/eyqDtB6RP221bCGKuwDJ/4FVaJcIugU55o6nlT5MgOt+fOf9kswJIIyKf
 7bzkvKqgZsyuEFD3wq2OmN+uy3GsFZvbAvhTBtAfsJw/94ShBqlAHAWeD5bW4JFCO9teTU
 jrtPgQ7JlMpMGC0YVQXC6jQqT3YW+rM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-nNjYkSUcO1OOpyOmCGktiw-1; Thu, 17 Mar 2022 22:22:00 -0400
X-MC-Unique: nNjYkSUcO1OOpyOmCGktiw-1
Received: by mail-lj1-f198.google.com with SMTP id
 j7-20020a2e3c07000000b00247f8eb86a4so2846993lja.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 19:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jcLirLBEGvDklvL5IK4efni0vW6AGIFKCzBkNt8jT7I=;
 b=0aS3ao92RIzoSksMXaV9Tb8AFYlMPQmsZbVT1ool7wRfUxr0H6hpX9yKyEVgaoE5p+
 ysVUUuTNlgYvMhZcCvc1RebyAVyXkoIuwLr7avKY2lyuYslh9wkp6Q+fvWKfADWx6e9n
 7yuNzSqUYNRLJn8MLQAbE7taPnswPJw0pwOwmeE4C1hbSLVnnqebLo/KFHd1N5RRadyt
 FIcJRwt45cCKXNdBNW0HQSuuUxdBKQzhA+mwJtqQ4YMf0UIiJWIavj/NYO7YTsfH8mLO
 VoTqr1vQt5ng9BXk50KL8WOVKc2OvwwRAftEqt09td6TiqarDTz8LvMtT1B8mxQvYsqd
 q0sQ==
X-Gm-Message-State: AOAM531Hpw4G0Wx4UyH7mpmBzwSIFxEt6BhMVfWn4Lpf81/4u4iNePhZ
 4Ai8ARflXExgGwYa66olZ+uO9Tu0oyK4FTPPQkoRat0z+MWs8gu+BTBtdkJBkwuPsRtrVKA0QDP
 tvlPyCuBndB9pEn7/EOMUtDuejZUan+W1fG2NiiL/Mc6ZO0Lz/BR17dYrcg==
X-Received: by 2002:a2e:a54b:0:b0:249:5889:70bb with SMTP id
 e11-20020a2ea54b000000b00249588970bbmr3089130ljn.73.1647570118801; 
 Thu, 17 Mar 2022 19:21:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxk6ZmWwZJZgL5aAwzVCKI91S5sYhdAYPx9fT50h9cafmylYRfNrDC7JqFe8GbC9ScB1+C+LvoG3W2kcLxxVP8=
X-Received: by 2002:a2e:a54b:0:b0:249:5889:70bb with SMTP id
 e11-20020a2ea54b000000b00249588970bbmr3089119ljn.73.1647570118609; Thu, 17
 Mar 2022 19:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220318005858.2141967-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220318005858.2141967-1-chi.minghao@zte.com.cn>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 Mar 2022 10:21:47 +0800
Message-ID: <CACGkMEvFK9O1qzKAeihF-3EGDC=iOmszKUA8QoMnCv5ovrg8yw@mail.gmail.com>
Subject: Re: [PATCH] virito-pci-modern: Remove useless DMA-32 fallback
 configuration
To: cgel.zte@gmail.com
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Zeal Robot <zealci@zte.com.cn>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Minghao Chi <chi.minghao@zte.com.cn>, mst <mst@redhat.com>
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

On Fri, Mar 18, 2022 at 8:59 AM <cgel.zte@gmail.com> wrote:
>
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> As stated in [1], dma_set_mask() with a 64-bit mask will never fail if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
>
> Simplify code and remove some dead code accordingly.
>
> [1]: https://lkml.org/lkml/2021/6/7/398
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/virtio/virtio_pci_modern_dev.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index e8b3ff2b9fbc..dff0b15a239d 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -255,9 +255,6 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
>         }
>
>         err = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64));
> -       if (err)
> -               err = dma_set_mask_and_coherent(&pci_dev->dev,
> -                                               DMA_BIT_MASK(32));

So we had:

        if (!dev->dma_mask || !dma_supported(dev, mask))
                return -EIO;

in dma_set_mask(), any reason dma_supported() can't be false here?

Thanks

>         if (err)
>                 dev_warn(&pci_dev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
>
> --
> 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
