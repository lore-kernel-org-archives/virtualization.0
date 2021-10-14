Return-Path: <SRS0=Buhk=PC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC822C433FE
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 06:26:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72D3F61152
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 06:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 72D3F61152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C00A60B0C;
	Thu, 14 Oct 2021 06:26:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aZpgBMI26U90; Thu, 14 Oct 2021 06:26:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8525960AFB;
	Thu, 14 Oct 2021 06:26:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F3B4C0011;
	Thu, 14 Oct 2021 06:26:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD0A7C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 06:26:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CCFBF831F2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 06:26:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zbsHIOrI4VeC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 06:26:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 08A2183211
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 06:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634192782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m3t/7R6S2CelPayMck1RShDg4UT2EYxbMkdKbDf9kTk=;
 b=SrFBf1lEXN5UOdqQKpbPeGA0jXlCSFg7UK464HIDDJk1D1ZsgNBIMmji/FzElk6xKvSAxG
 H9SC1YUZ71TGL78vAPUw9q/RMEBlbTKF+mjwgJKndgctiMZZNM3/xaWLEnUBNfmJbQsyri
 jFWgod3XCBf4JBqv/txnICTmCNlzqlw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-JrMuewLLOMmcQbEHKEKTEQ-1; Thu, 14 Oct 2021 02:26:21 -0400
X-MC-Unique: JrMuewLLOMmcQbEHKEKTEQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 k2-20020adfc702000000b0016006b2da9bso3756189wrg.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 23:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=m3t/7R6S2CelPayMck1RShDg4UT2EYxbMkdKbDf9kTk=;
 b=d2iHVdGZdT5PI2o5adoJFseloBLgSQYpVtDn6+1XvgudZxYaQQ421ecqEn4JuzmAtc
 ZGMyuYbNVYC8ksXtpUlSyXTS/3MhHy6VsdGqE2lf5TyhGlOQSLdeTRdiEy/O5driziwJ
 iSw+x7yVNglbMeqp9EBpYCUx7wMlLjZ5TN7nqg+ZxkpbPnC8ZQi3pha12Dy7HPbjPpVu
 HTmrtBt6+8E8KiGlQBxicvYG3zPqFpG2L//SygjcyScojKPEgs+Q+Gfi3h/pt0i8zRTc
 +S6Yj9RCB9gd5aL9ExZEWXc3F+FlsxOg09O0AdG8NGU9HbDoESJDLxogLnIi/+kdH/Hy
 41wg==
X-Gm-Message-State: AOAM533teWKHWLqCnfEUh1evwUAIH1Gkt5UZ+Y4Psb/9kt5DkuRpIkxS
 cfdVG7qrklFVREKbgzHPeEcELqwQmRGR6MgSOlr/S6KVqkb1Caewew6pffO6PgVNqvZe1TocZ9C
 eYKhhpCEUpHoNCZx35PiZ7aDvrg+FrgYonr3V/32muw==
X-Received: by 2002:adf:bb52:: with SMTP id x18mr4466585wrg.169.1634192780433; 
 Wed, 13 Oct 2021 23:26:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcQRcXMC+TNkHuH5Wvah6xBHmzWHV3BqXPD9HbXnBWYaJumLOJJxaOEL/b4XK83F5MoBufoA==
X-Received: by 2002:adf:bb52:: with SMTP id x18mr4466559wrg.169.1634192780256; 
 Wed, 13 Oct 2021 23:26:20 -0700 (PDT)
Received: from redhat.com ([2.55.16.227])
 by smtp.gmail.com with ESMTPSA id v185sm7114302wme.35.2021.10.13.23.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 23:26:19 -0700 (PDT)
Date: Thu, 14 Oct 2021 02:26:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 07/12] virtio-pci: harden INTX interrupts
Message-ID: <20211014022438-mutt-send-email-mst@kernel.org>
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-8-jasowang@redhat.com>
 <20211013053627-mutt-send-email-mst@kernel.org>
 <CACGkMEuRHKJv73oKFNetcBkPSFj034te7N_AJZdRbHe0ObU4Gw@mail.gmail.com>
 <20211014014551-mutt-send-email-mst@kernel.org>
 <CACGkMEvB4sMPmMmPQmHFasGLwktyXuCenQKGuoajmoFQYJJeBQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvB4sMPmMmPQmHFasGLwktyXuCenQKGuoajmoFQYJJeBQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Paul E . McKenney" <paulmck@kernel.org>, "kaplan,
 david" <david.kaplan@amd.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Thu, Oct 14, 2021 at 02:20:17PM +0800, Jason Wang wrote:
> On Thu, Oct 14, 2021 at 1:50 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Oct 14, 2021 at 10:35:48AM +0800, Jason Wang wrote:
> > > On Wed, Oct 13, 2021 at 5:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Oct 12, 2021 at 02:52:22PM +0800, Jason Wang wrote:
> > > > > This patch tries to make sure the virtio interrupt handler for INTX
> > > > > won't be called after a reset and before virtio_device_ready(). We
> > > > > can't use IRQF_NO_AUTOEN since we're using shared interrupt
> > > > > (IRQF_SHARED). So this patch tracks the INTX enabling status in a new
> > > > > intx_soft_enabled variable and toggle it during in
> > > > > vp_disable/enable_vectors(). The INTX interrupt handler will check
> > > > > intx_soft_enabled before processing the actual interrupt.
> > > > >
> > > > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > ---
> > > > >  drivers/virtio/virtio_pci_common.c | 24 ++++++++++++++++++++++--
> > > > >  drivers/virtio/virtio_pci_common.h |  1 +
> > > > >  2 files changed, 23 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > > > index 0b9523e6dd39..5ae6a2a4eb77 100644
> > > > > --- a/drivers/virtio/virtio_pci_common.c
> > > > > +++ b/drivers/virtio/virtio_pci_common.c
> > > > > @@ -30,8 +30,16 @@ void vp_disable_vectors(struct virtio_device *vdev)
> > > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > >       int i;
> > > > >
> > > > > -     if (vp_dev->intx_enabled)
> > > > > +     if (vp_dev->intx_enabled) {
> > > > > +             /*
> > > > > +              * The below synchronize() guarantees that any
> > > > > +              * interrupt for this line arriving after
> > > > > +              * synchronize_irq() has completed is guaranteed to see
> > > > > +              * intx_soft_enabled == false.
> > > > > +              */
> > > > > +             WRITE_ONCE(vp_dev->intx_soft_enabled, false);
> > > > >               synchronize_irq(vp_dev->pci_dev->irq);
> > > > > +     }
> > > > >
> > > > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > >               disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > @@ -43,8 +51,16 @@ void vp_enable_vectors(struct virtio_device *vdev)
> > > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > >       int i;
> > > > >
> > > > > -     if (vp_dev->intx_enabled)
> > > > > +     if (vp_dev->intx_enabled) {
> > > > > +             disable_irq(vp_dev->pci_dev->irq);
> > > > > +             /*
> > > > > +              * The above disable_irq() provides TSO ordering and
> > > > > +              * as such promotes the below store to store-release.
> > > > > +              */
> > > > > +             WRITE_ONCE(vp_dev->intx_soft_enabled, true);
> > > > > +             enable_irq(vp_dev->pci_dev->irq);
> > > > >               return;
> > > > > +     }
> > > > >
> > > > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > >               enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > @@ -97,6 +113,10 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
> > > > >       struct virtio_pci_device *vp_dev = opaque;
> > > > >       u8 isr;
> > > > >
> > > > > +     /* read intx_soft_enabled before read others */
> > > > > +     if (!smp_load_acquire(&vp_dev->intx_soft_enabled))
> > > > > +             return IRQ_NONE;
> > > > > +
> > > > >       /* reading the ISR has the effect of also clearing it so it's very
> > > > >        * important to save off the value. */
> > > > >       isr = ioread8(vp_dev->isr);
> > > >
> > > > I don't see why we need this ordering guarantee here.
> > > >
> > > > synchronize_irq above makes sure no interrupt handler
> > > > is in progress.
> > >
> > > Yes.
> > >
> > > > the handler itself thus does not need
> > > > any specific order, it is ok if intx_soft_enabled is read
> > > > after, not before the rest of it.
> > >
> > > But the interrupt could be raised after synchronize_irq() which may
> > > see a false of the intx_soft_enabled.
> >
> > You mean a "true" value right? false is what we are writing there.
> 
> I meant that we want to not go for stuff like vq->callback after the
> synchronize_irq() after setting intx_soft_enabled to false. Otherwise
> we may get unexpected results like use after free. Host can craft ISR
> in this case.
> >
> > Are you sure it can happen? I think that synchronize_irq makes the value
> > visible on all CPUs running the irq.
> 
> Yes, so the false is visible by vp_interrupt(), we can't do the other
> task before we check intx_soft_enabled.

But the order does not matter. synchronize_irq will make sure
everything is visible.

> >
> > > In this case we still need the
> > > make sure intx_soft_enbled to be read first instead of allowing other
> > > operations to be done first, otherwise the intx_soft_enabled is
> > > meaningless.
> > >
> > > Thanks
> >
> > If intx_soft_enbled were not visible after synchronize_irq then
> > it does not matter in which order we read it wrt other values,
> > it still wouldn't work right.
> 
> Yes.
> 
> Thanks


We are agreed then? No need for a barrier here, READ_ONCE is enough?

> >
> > > >
> > > > Just READ_ONCE should be enough, and we can drop the comment.
> > > >
> > > >
> > > > > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> > > > > index a235ce9ff6a5..3c06e0f92ee4 100644
> > > > > --- a/drivers/virtio/virtio_pci_common.h
> > > > > +++ b/drivers/virtio/virtio_pci_common.h
> > > > > @@ -64,6 +64,7 @@ struct virtio_pci_device {
> > > > >       /* MSI-X support */
> > > > >       int msix_enabled;
> > > > >       int intx_enabled;
> > > > > +     bool intx_soft_enabled;
> > > > >       cpumask_var_t *msix_affinity_masks;
> > > > >       /* Name strings for interrupts. This size should be enough,
> > > > >        * and I'm too lazy to allocate each name separately. */
> > > > > --
> > > > > 2.25.1
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
