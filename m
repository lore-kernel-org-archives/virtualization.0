Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AE1C433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Dec 2021 02:06:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF37C408CA;
	Thu,  9 Dec 2021 02:06:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5h0SJDPvu61g; Thu,  9 Dec 2021 02:06:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5A3B9405E4;
	Thu,  9 Dec 2021 02:06:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 340A7C002F;
	Thu,  9 Dec 2021 02:06:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15B7EC0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 02:06:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EAC2D82C21
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 02:06:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e84lehfjdROu
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 02:06:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DBE8382BED
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 02:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639015608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mC887ZdN1WmKD1soOyAa6c3nS8AecZUnCpHC6LAqUl4=;
 b=PDfubalnoz/JcpyEGNcSzzllbTf2VkSKQmM9UXr2y73kfiUK3mnN9tCAsnLtgojOLFgIv0
 fEstuujbv8rn4ziWGXE3+Y3iYT5N6IGFCOclwORqJK9ajDS/G3dM6XKIK2jHKa7sDygSvD
 X1c5Z5l1fz2/tL46yd4k89w/PBrcfCo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-O_lz0domMcCwMtdox839Ig-1; Wed, 08 Dec 2021 21:06:47 -0500
X-MC-Unique: O_lz0domMcCwMtdox839Ig-1
Received: by mail-lf1-f71.google.com with SMTP id
 q26-20020ac2515a000000b0040adfeb8132so1945260lfd.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Dec 2021 18:06:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mC887ZdN1WmKD1soOyAa6c3nS8AecZUnCpHC6LAqUl4=;
 b=SyuFTTXv/K5fZRQ62Q9XPUQAZ4LlgwoPyWZJeYAhvWMSM4AbaUmtZZYYTxIgkwrn5c
 BHqZJCloUNNOvqUbBYcc3kXOBd+bKZCtGvTZH8orShUGWoU2NGQD9XYT0V6nhzWv4ITD
 8n7gTSYeIdjEju/a9tSwjuD5UNJEJFUIPNi7TejQqvRGB/RHmUFuPJJ6INSNvaMH+oqh
 /Z7shH+xp74CfjQikZ1JDhjT2q+HJzhNmtgQDCRCLketcPTi8YQGRxpzZv+KPrZtQJCZ
 CnT+Pw0LM0V10lr5dtZxChGWCPPTeEpcYBKBEn3ZUzOTkcFn6uHE15CwTm2qoZIfhFo2
 xVwA==
X-Gm-Message-State: AOAM530bGo8eFANtIKXVr2DYpXFt+iH8lPcvGKFE4xEfUQmfWtb1u7j0
 KMYPYVPElSf1si7DqWtcqsztjfjha+Wrz+rDULtO4ddxyjkbWTiyCL8jtOGXRME54+O0jDQZU/S
 xHfs+HgKtMgHDJBoOSgR8kOsCChP16Mu9mEXLfkZf9cGd/+WQGS613sK7zg==
X-Received: by 2002:a2e:9f55:: with SMTP id v21mr3240678ljk.420.1639015605818; 
 Wed, 08 Dec 2021 18:06:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyMgJMyiOBAM5SX9gmlUwV16I4ymfq9KkPGUOs3vjrDROmgUpAFQBSghfD4gJUfgUKXQt4JlQabnVDKsCoWztU=
X-Received: by 2002:a2e:9f55:: with SMTP id v21mr3240657ljk.420.1639015605537; 
 Wed, 08 Dec 2021 18:06:45 -0800 (PST)
MIME-Version: 1.0
References: <20211126044102.18374-1-jasowang@redhat.com>
 <20211208151801-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211208151801-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Dec 2021 10:06:34 +0800
Message-ID: <CACGkMEs-ah8VAULcDumPH_u9C2DZQh9SKJ_2bykX5aBCTxnwsA@mail.gmail.com>
Subject: Re: [PATCH V2] virtio-mmio: harden interrupt
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
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

On Thu, Dec 9, 2021 at 4:27 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Nov 26, 2021 at 12:41:02PM +0800, Jason Wang wrote:
> > This patch tries to make sure the virtio interrupt handler for MMIO
> > won't be called after a reset and before virtio_device_ready(). We
> > can't use IRQF_NO_AUTOEN since we're using shared interrupt
> > (IRQF_SHARED). So this patch tracks the interrupt enabling status in a
> > new intr_soft_enabled variable and toggle it during in
> > vm_disable/enable_interrupts(). The MMIO interrupt handler will check
> > intr_soft_enabled before processing the actual interrupt.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > Changes since V1:
> > - Silent compling warnings
> >  drivers/virtio/virtio_mmio.c | 37 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> > index 56128b9c46eb..c517afdd2cc5 100644
> > --- a/drivers/virtio/virtio_mmio.c
> > +++ b/drivers/virtio/virtio_mmio.c
> > @@ -90,6 +90,7 @@ struct virtio_mmio_device {
> >       /* a list of queues so we can dispatch IRQs */
> >       spinlock_t lock;
> >       struct list_head virtqueues;
> > +     bool intr_soft_enabled;
> >  };
> >
> >  struct virtio_mmio_vq_info {
> > @@ -100,7 +101,37 @@ struct virtio_mmio_vq_info {
> >       struct list_head node;
> >  };
> >
> > +/* disable irq handlers */
> > +static void vm_disable_cbs(struct virtio_device *vdev)
> > +{
> > +     struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> > +     int irq = platform_get_irq(vm_dev->pdev, 0);
> >
> > +     /*
> > +      * The below synchronize() guarantees that any
> > +      * interrupt for this line arriving after
> > +      * synchronize_irq() has completed is guaranteed to see
> > +      * intx_soft_enabled == false.
> > +      */
> > +     WRITE_ONCE(vm_dev->intr_soft_enabled, false);
> > +     synchronize_irq(irq);
> > +}
> > +
> > +/* enable irq handlers */
> > +static void vm_enable_cbs(struct virtio_device *vdev)
> > +{
> > +     struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> > +     int irq = platform_get_irq(vm_dev->pdev, 0);
> > +
> > +     disable_irq(irq);
> > +     /*
> > +      * The above disable_irq() provides TSO ordering and
> > +      * as such promotes the below store to store-release.
> > +      */
> > +     WRITE_ONCE(vm_dev->intr_soft_enabled, true);
> > +     enable_irq(irq);
> > +     return;
> > +}
> >
> >  /* Configuration interface */
> >
> > @@ -262,6 +293,8 @@ static void vm_reset(struct virtio_device *vdev)
> >
> >       /* 0 status means a reset. */
> >       writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
>
> There was a discussion about reading status to make sure it is clear.
> The spec says we should, this can't hurt as a further hardening measure.
> In fact, let's do it in the core maybe? Spec says it applies to all
> devices ...

We can do that, but I'm not sure if we break some existing device.

>
> > +     /* Disable VQ/configuration callbacks. */
> > +     vm_disable_cbs(vdev);
> >  }
> >
> >
> > @@ -288,6 +321,9 @@ static irqreturn_t vm_interrupt(int irq, void *opaque)
> >       unsigned long flags;
> >       irqreturn_t ret = IRQ_NONE;
> >
> > +     if (!READ_ONCE(vm_dev->intr_soft_enabled))
> > +             return IRQ_NONE;
> > +
>
> So if the write is seen before reset happened (should not happen, but we
> are talking a buggy device) then it won't be acknowledged and device
> will keep pulling the interrupt. I think as long as we are hardening
> this, let's go the full mile and try to avoid DoS if we can, do the
> check before invoking the callback, but do not skip the read.
> Whether to still return IRQ_NONE is a good question.

Did you mean something like this:

        /* Read and acknowledge interrupts */
        status = readl(vm_dev->base + VIRTIO_MMIO_INTERRUPT_STATUS);
        writel(status, vm_dev->base + VIRTIO_MMIO_INTERRUPT_ACK);

        if (status)
                ret = IRQ_HANDLED;

       if (!READ_ONCE(vm_dev->intr_soft_enabled))
               return ret;

Thanks

>
>
>
>
> >       /* Read and acknowledge interrupts */
> >       status = readl(vm_dev->base + VIRTIO_MMIO_INTERRUPT_STATUS);
> >       writel(status, vm_dev->base + VIRTIO_MMIO_INTERRUPT_ACK);
> > @@ -529,6 +565,7 @@ static bool vm_get_shm_region(struct virtio_device *vdev,
> >  }
> >
> >  static const struct virtio_config_ops virtio_mmio_config_ops = {
> > +     .enable_cbs     = vm_enable_cbs,
> >       .get            = vm_get,
> >       .set            = vm_set,
> >       .generation     = vm_generation,
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
