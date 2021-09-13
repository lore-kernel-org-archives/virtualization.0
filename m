Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1923C433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 06:37:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A369560FC1
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 06:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A369560FC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76C1581846;
	Mon, 13 Sep 2021 06:37:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EXSYLcl-BTEu; Mon, 13 Sep 2021 06:37:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 16B0981831;
	Mon, 13 Sep 2021 06:37:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1CDCC0011;
	Mon, 13 Sep 2021 06:37:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40957C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:37:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3B5B140243
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:37:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LQd8b6YSe_SX
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:37:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3CC8440233
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631515028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LqkyzUI1dnGPwIvrGQ+g2Xfc1wH8fcvMTQo++GQRrBM=;
 b=MqDdKUvDYfbmSXPGfRexT26s4gjtoWUgUR/04S8FPxXoYzbm5s19+9cSGloJl9bZ5rOoDU
 j45mKljZdcKix9BqQAKsCJHto8k5cpUyAp/fUQwa/s7zVj+6hBZBYOl0gP/DrYtgenOqRe
 e4QZknOnXox906f/ofrFRGW/0N5rqF0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-ITrQL5AQPbOF2LGOjlaNRQ-1; Mon, 13 Sep 2021 02:37:06 -0400
X-MC-Unique: ITrQL5AQPbOF2LGOjlaNRQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 a38-20020a05651c212600b001ca48d59b47so3705905ljq.22
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 23:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LqkyzUI1dnGPwIvrGQ+g2Xfc1wH8fcvMTQo++GQRrBM=;
 b=a5X7lasyXjO2V+bpWJdWtyxX3P9ddJHCoK6VVy0Ah9edgxAOKVdfhIe47MFet68Szj
 CkaiqbnasbLv+LGJMFTdIN+PEHOOPqL3yi2c8NJLK2GZLimnwZuOMJ2lJGWzQfwW5P/M
 9OqgaPeBqlaTBoRIvussSeQzWpRxULUvWjGd8QVsPeSJkzMAAn5dM3CtugDnfUOrG0DE
 8anBYZJFJOd+gD6GrRjjNHN9wjubKa6UYYBAiXSla+UFOiQv7e0+WwCGvhzq/U8VV41b
 k7zIawPVNaIQMdAfa5Yc+dsI8qqC/DB9WzWCOPPqthsUQEWzuNLLBDYVMzB6zcwDVkD/
 EZ8Q==
X-Gm-Message-State: AOAM530dPwdnVv4Y3p5s0ixchaTSfCavnOdQC6vRdqrtj4WEGL1rRIfC
 7kn7K4lc3gWmQq6DGERiKS9oukO8jkyvJwR40VUGFqcA96H/FN8OX/pKLn6GHtVwL+OkcxnUqgb
 qTVvuxW0CiCkILNtimTJ0mV746O4qiKsm4BXdwy+BLRA08CpHPy0Li11oTA==
X-Received: by 2002:a2e:5353:: with SMTP id t19mr259581ljd.420.1631515025430; 
 Sun, 12 Sep 2021 23:37:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbn7iuunCofdqVJY1OJWnNhI+lYxdwaHwFNiEIVLQCDg/YbWIC45Gj6fnmMR5J32oFhSBKyFcX6loiH4oMsqE=
X-Received: by 2002:a2e:5353:: with SMTP id t19mr259567ljd.420.1631515025176; 
 Sun, 12 Sep 2021 23:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-8-jasowang@redhat.com>
 <20210913022824-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210913022824-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 Sep 2021 14:36:54 +0800
Message-ID: <CACGkMEtnmLzQDNVYnAYSsEmjjRJVDhuK6VNj56S__zU9+5-JQQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] virtio-pci: harden INTX interrupts
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, "kaplan,
 david" <david.kaplan@amd.com>,
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

On Mon, Sep 13, 2021 at 2:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Sep 13, 2021 at 01:53:51PM +0800, Jason Wang wrote:
> > This patch tries to make sure the virtio interrupt handler for INTX
> > won't be called after a reset and before virtio_device_ready(). We
> > can't use IRQF_NO_AUTOEN since we're using shared interrupt
> > (IRQF_SHARED). So this patch tracks the INTX enabling status in a new
> > intx_soft_enabled variable and toggle it during in
> > vp_disable/enable_vectors(). The INTX interrupt handler will check
> > intx_soft_enabled before processing the actual interrupt.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
>
> Not all that excited about all the memory barriers for something
> that should be an extremely rare event (for most kernels -
> literally once per boot). Can't we do better?

I'm not sure, but do we need to care about the slow path (INTX)?

(Or do you have a better approach?)

Thanks

>
> > ---
> >  drivers/virtio/virtio_pci_common.c | 18 ++++++++++++++++--
> >  drivers/virtio/virtio_pci_common.h |  1 +
> >  2 files changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > index 0b9523e6dd39..835197151dc1 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -30,8 +30,12 @@ void vp_disable_vectors(struct virtio_device *vdev)
> >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >       int i;
> >
> > -     if (vp_dev->intx_enabled)
> > +     if (vp_dev->intx_enabled) {
> > +             vp_dev->intx_soft_enabled = false;
> > +             /* ensure the vp_interrupt see this intx_soft_enabled value */
> > +             smp_wmb();
> >               synchronize_irq(vp_dev->pci_dev->irq);
> > +     }
> >
> >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> >               disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > @@ -43,8 +47,12 @@ void vp_enable_vectors(struct virtio_device *vdev)
> >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >       int i;
> >
> > -     if (vp_dev->intx_enabled)
> > +     if (vp_dev->intx_enabled) {
> > +             vp_dev->intx_soft_enabled = true;
> > +             /* ensure the vp_interrupt see this intx_soft_enabled value */
> > +             smp_wmb();
> >               return;
> > +     }
> >
> >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> >               enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > @@ -97,6 +105,12 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
> >       struct virtio_pci_device *vp_dev = opaque;
> >       u8 isr;
> >
> > +     if (!vp_dev->intx_soft_enabled)
> > +             return IRQ_NONE;
> > +
> > +     /* read intx_soft_enabled before read others */
> > +     smp_rmb();
> > +
> >       /* reading the ISR has the effect of also clearing it so it's very
> >        * important to save off the value. */
> >       isr = ioread8(vp_dev->isr);
> > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> > index a235ce9ff6a5..3c06e0f92ee4 100644
> > --- a/drivers/virtio/virtio_pci_common.h
> > +++ b/drivers/virtio/virtio_pci_common.h
> > @@ -64,6 +64,7 @@ struct virtio_pci_device {
> >       /* MSI-X support */
> >       int msix_enabled;
> >       int intx_enabled;
> > +     bool intx_soft_enabled;
> >       cpumask_var_t *msix_affinity_masks;
> >       /* Name strings for interrupts. This size should be enough,
> >        * and I'm too lazy to allocate each name separately. */
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
