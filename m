Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C36CC433EF
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 06:46:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C639F60F92
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 06:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C639F60F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 90D19608A2;
	Mon, 13 Sep 2021 06:45:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9IfiHlZhbA3k; Mon, 13 Sep 2021 06:45:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2E901607AB;
	Mon, 13 Sep 2021 06:45:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFEC1C0011;
	Mon, 13 Sep 2021 06:45:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED545C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:45:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D5CC86084D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:45:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zFhi6qvhGdWJ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:45:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 21474607AB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631515554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G0ej8XTbwKPpyyCRf+V2wNAvPGgbx3EpHXxZ8UETyS0=;
 b=IDMjYOzQ37M148vlaNxHcd1i8P6vIpITCGZkdCs+veodutv/iP0pdWlkI212n2O6LgU93R
 a6g5khsQUuJ3NUxzDAiENr6GBpkkrelHaEuoUC8nzA2gbEefKNBJpCG7BO00UGrDDUSQhd
 gkJm56GX4kb3pw2FLer8wi24znzB8CM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-U4eG4Z8fOgK4LIEKMvtyAg-1; Mon, 13 Sep 2021 02:45:51 -0400
X-MC-Unique: U4eG4Z8fOgK4LIEKMvtyAg-1
Received: by mail-lf1-f71.google.com with SMTP id
 j13-20020ac253ad000000b003f3c093087fso331084lfh.13
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 23:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G0ej8XTbwKPpyyCRf+V2wNAvPGgbx3EpHXxZ8UETyS0=;
 b=Q1S9+rBoixnJy1QKUNly9QiEP9OecYpBhX9PqAn15O9mti6+vy0HlTkogNWzKx1w3w
 ACuDV0oRm8GNHbDDszE494JYFtHBvdK24qLF3WCH5Xt3v1ieCzSCAICDDojNeMj1eh90
 PDdRYquNbKTZwRFWsYVPymrC+FW+glCUz+bXWDokGFa8KWzEdVYpS1ocsABUryN95SKa
 7g3fpYtMY/l+0Sbcs54jKl8ggX4vXOa5ktRGF7p4/SkpfEOr1lZFCX8oo2qeotc8aOaH
 lNvQEt+9MovgEGPLf84p60gfkToCeFW08ZmlUsQa63yiGAO1pAH6WZWI2+PdzEeHp/+U
 uw6A==
X-Gm-Message-State: AOAM531Xdjz1mhqvU0lca1FFvIIPjekR8bpSVkO0GyhQ5lOm/1wRtlIz
 TARTLKJpOEoOp9rXRot91ufjTo2l6bUEawp1N6hzqNqddgrFsZ0mruop20pCaA3cf4WdHo1aqFR
 Y8Bp5xpLVzhBr+dRC5Meo571ICBnZjhlMPGl6XjX/XDTIMqLV+nlK/Zw0ug==
X-Received: by 2002:a05:651c:b09:: with SMTP id
 b9mr9062305ljr.307.1631515549987; 
 Sun, 12 Sep 2021 23:45:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAlp5VhrDfNq1QxtijJNOsG+u1lm/8be7YTCgCLWeFFvN/SZ849iaepzcduKsQXhYHlrCgcJ/4danq9R0lTiQ=
X-Received: by 2002:a05:651c:b09:: with SMTP id
 b9mr9062284ljr.307.1631515549705; 
 Sun, 12 Sep 2021 23:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-8-jasowang@redhat.com>
 <20210913022824-mutt-send-email-mst@kernel.org>
 <CACGkMEtnmLzQDNVYnAYSsEmjjRJVDhuK6VNj56S__zU9+5-JQQ@mail.gmail.com>
 <20210913023757-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210913023757-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 Sep 2021 14:45:38 +0800
Message-ID: <CACGkMEskmq7azAP6QiNz=_nXaU6vbtr975wk3kr9H6pOGs-ZuQ@mail.gmail.com>
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

On Mon, Sep 13, 2021 at 2:41 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Sep 13, 2021 at 02:36:54PM +0800, Jason Wang wrote:
> > On Mon, Sep 13, 2021 at 2:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Sep 13, 2021 at 01:53:51PM +0800, Jason Wang wrote:
> > > > This patch tries to make sure the virtio interrupt handler for INTX
> > > > won't be called after a reset and before virtio_device_ready(). We
> > > > can't use IRQF_NO_AUTOEN since we're using shared interrupt
> > > > (IRQF_SHARED). So this patch tracks the INTX enabling status in a new
> > > > intx_soft_enabled variable and toggle it during in
> > > > vp_disable/enable_vectors(). The INTX interrupt handler will check
> > > > intx_soft_enabled before processing the actual interrupt.
> > > >
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >
> > >
> > > Not all that excited about all the memory barriers for something
> > > that should be an extremely rare event (for most kernels -
> > > literally once per boot). Can't we do better?
> >
> > I'm not sure, but do we need to care about the slow path (INTX)?
>
> Otherwise we won't try to support this, right?

Sorry, what I meant is "do we need to care about the performance of
the slow path".

>
> > (Or do you have a better approach?)
> >
> > Thanks
>
> Don't know really, maybe rcu or whatever?

I am sure it's worth it to bother since it's the slow path.

> But let's try to be much more specific - is there anything
> specific we are trying to protect against here?

The unexpected calling of the vring or config interrupt handler. (The
same as MSI-X, e.g the untrusted device can send irq at any time).

Thanks

>
>
>
> > >
> > > > ---
> > > >  drivers/virtio/virtio_pci_common.c | 18 ++++++++++++++++--
> > > >  drivers/virtio/virtio_pci_common.h |  1 +
> > > >  2 files changed, 17 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > > index 0b9523e6dd39..835197151dc1 100644
> > > > --- a/drivers/virtio/virtio_pci_common.c
> > > > +++ b/drivers/virtio/virtio_pci_common.c
> > > > @@ -30,8 +30,12 @@ void vp_disable_vectors(struct virtio_device *vdev)
> > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > >       int i;
> > > >
> > > > -     if (vp_dev->intx_enabled)
> > > > +     if (vp_dev->intx_enabled) {
> > > > +             vp_dev->intx_soft_enabled = false;
> > > > +             /* ensure the vp_interrupt see this intx_soft_enabled value */
> > > > +             smp_wmb();
> > > >               synchronize_irq(vp_dev->pci_dev->irq);
> > > > +     }
> > > >
> > > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > >               disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > @@ -43,8 +47,12 @@ void vp_enable_vectors(struct virtio_device *vdev)
> > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > >       int i;
> > > >
> > > > -     if (vp_dev->intx_enabled)
> > > > +     if (vp_dev->intx_enabled) {
> > > > +             vp_dev->intx_soft_enabled = true;
> > > > +             /* ensure the vp_interrupt see this intx_soft_enabled value */
> > > > +             smp_wmb();
> > > >               return;
> > > > +     }
> > > >
> > > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > >               enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > @@ -97,6 +105,12 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
> > > >       struct virtio_pci_device *vp_dev = opaque;
> > > >       u8 isr;
> > > >
> > > > +     if (!vp_dev->intx_soft_enabled)
> > > > +             return IRQ_NONE;
> > > > +
> > > > +     /* read intx_soft_enabled before read others */
> > > > +     smp_rmb();
> > > > +
> > > >       /* reading the ISR has the effect of also clearing it so it's very
> > > >        * important to save off the value. */
> > > >       isr = ioread8(vp_dev->isr);
> > > > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> > > > index a235ce9ff6a5..3c06e0f92ee4 100644
> > > > --- a/drivers/virtio/virtio_pci_common.h
> > > > +++ b/drivers/virtio/virtio_pci_common.h
> > > > @@ -64,6 +64,7 @@ struct virtio_pci_device {
> > > >       /* MSI-X support */
> > > >       int msix_enabled;
> > > >       int intx_enabled;
> > > > +     bool intx_soft_enabled;
> > > >       cpumask_var_t *msix_affinity_masks;
> > > >       /* Name strings for interrupts. This size should be enough,
> > > >        * and I'm too lazy to allocate each name separately. */
> > > > --
> > > > 2.25.1
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
