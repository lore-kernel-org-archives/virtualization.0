Return-Path: <SRS0=Buhk=PC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3181BC433F5
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 06:20:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFBDC60FF2
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 06:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CFBDC60FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 96F9282B97;
	Thu, 14 Oct 2021 06:20:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id urZGhKZPKwln; Thu, 14 Oct 2021 06:20:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 00F7882F76;
	Thu, 14 Oct 2021 06:20:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFC61C000F;
	Thu, 14 Oct 2021 06:20:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CCAFC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 06:20:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 18D7E82B97
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 06:20:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qM6TI1-6623e
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 06:20:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C64881D24
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 06:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634192433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r8qw60VcUyeef17OqItubKwt1R2Pi+9NdkeAyQiHGSc=;
 b=aCCbQHhV2MHOf8XztFOTXD2+Qy4ITYYCC4EmC2S+kQNoBi5Lc3OhHHc2CeVV7sJ5cMkv6D
 jl1vju85DMK7fn6h9he6rX67Hrt1olQckFvqSPKLWfgQUOZO73mmWUM5KMoLnnzmPyp3hH
 ZJV91PQ29DIrmyK/s58wBk6606wbWkc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-PBbaPUZbOQ2z8cHHFa9FDA-1; Thu, 14 Oct 2021 02:20:30 -0400
X-MC-Unique: PBbaPUZbOQ2z8cHHFa9FDA-1
Received: by mail-lf1-f69.google.com with SMTP id
 bu34-20020a05651216a200b003fd7bb9caa1so3681546lfb.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 23:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=r8qw60VcUyeef17OqItubKwt1R2Pi+9NdkeAyQiHGSc=;
 b=eUnq9UmpEC2p84Ydvq0ysUg0T0keRW1cXpSIdpgmCINuaa+wQ322Lv6ClYPRRSFwPV
 ii/eW/6KwkVXbJXOF+Fof8RIjTDf/Z5ZteHjq5FqCvyvTwxzir5qDcAy8VCeSGaVteN+
 UX59KcWVH9VjJMjJoWtmhMG1a2+ImFz3L3mEN+Arj7EWWqnLoEZXpqFvuOciF3ydGpAk
 tijDGQAseHGIvNbbNKFk82qOi0UiuwLFT6AXyvZXjKJzKnv8AFCOGPuxhmA3O+0UWCqf
 GnDXXC69djsvU/t5DI+OmGd3iSH3mULefXUzjUHPvsrMKSoePSilCnzdULYeVuLhKqL4
 eRsA==
X-Gm-Message-State: AOAM533104vVGSztkSyUgZVnNubfE7T6r01imdIL8LHrtv4afJpeao+d
 q4AlL/I1ltYbH+UO4bCyeuOn7dk8lDcW1sYEyKx/YFPUfxjvv8P6MkMtNSrjfsInJtBR/01v0WS
 1fXIJPCzAFEknr0FkY1Dt1ixrmCQeoEY3cMkbI8hGQv/kWoUTfPgE0DShPQ==
X-Received: by 2002:a2e:a603:: with SMTP id v3mr4213410ljp.369.1634192428547; 
 Wed, 13 Oct 2021 23:20:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJye7uppua2sZrZa7w1wr+6t5eoWajVwze7OfKhmnFm1rTI0pVX6DCy1Zkq8x8wULPHIUzZndOWcXPtoFt4fbk4=
X-Received: by 2002:a2e:a603:: with SMTP id v3mr4213387ljp.369.1634192428297; 
 Wed, 13 Oct 2021 23:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-8-jasowang@redhat.com>
 <20211013053627-mutt-send-email-mst@kernel.org>
 <CACGkMEuRHKJv73oKFNetcBkPSFj034te7N_AJZdRbHe0ObU4Gw@mail.gmail.com>
 <20211014014551-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211014014551-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Oct 2021 14:20:17 +0800
Message-ID: <CACGkMEvB4sMPmMmPQmHFasGLwktyXuCenQKGuoajmoFQYJJeBQ@mail.gmail.com>
Subject: Re: [PATCH V2 07/12] virtio-pci: harden INTX interrupts
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Thu, Oct 14, 2021 at 1:50 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Oct 14, 2021 at 10:35:48AM +0800, Jason Wang wrote:
> > On Wed, Oct 13, 2021 at 5:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Oct 12, 2021 at 02:52:22PM +0800, Jason Wang wrote:
> > > > This patch tries to make sure the virtio interrupt handler for INTX
> > > > won't be called after a reset and before virtio_device_ready(). We
> > > > can't use IRQF_NO_AUTOEN since we're using shared interrupt
> > > > (IRQF_SHARED). So this patch tracks the INTX enabling status in a new
> > > > intx_soft_enabled variable and toggle it during in
> > > > vp_disable/enable_vectors(). The INTX interrupt handler will check
> > > > intx_soft_enabled before processing the actual interrupt.
> > > >
> > > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  drivers/virtio/virtio_pci_common.c | 24 ++++++++++++++++++++++--
> > > >  drivers/virtio/virtio_pci_common.h |  1 +
> > > >  2 files changed, 23 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > > index 0b9523e6dd39..5ae6a2a4eb77 100644
> > > > --- a/drivers/virtio/virtio_pci_common.c
> > > > +++ b/drivers/virtio/virtio_pci_common.c
> > > > @@ -30,8 +30,16 @@ void vp_disable_vectors(struct virtio_device *vdev)
> > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > >       int i;
> > > >
> > > > -     if (vp_dev->intx_enabled)
> > > > +     if (vp_dev->intx_enabled) {
> > > > +             /*
> > > > +              * The below synchronize() guarantees that any
> > > > +              * interrupt for this line arriving after
> > > > +              * synchronize_irq() has completed is guaranteed to see
> > > > +              * intx_soft_enabled == false.
> > > > +              */
> > > > +             WRITE_ONCE(vp_dev->intx_soft_enabled, false);
> > > >               synchronize_irq(vp_dev->pci_dev->irq);
> > > > +     }
> > > >
> > > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > >               disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > @@ -43,8 +51,16 @@ void vp_enable_vectors(struct virtio_device *vdev)
> > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > >       int i;
> > > >
> > > > -     if (vp_dev->intx_enabled)
> > > > +     if (vp_dev->intx_enabled) {
> > > > +             disable_irq(vp_dev->pci_dev->irq);
> > > > +             /*
> > > > +              * The above disable_irq() provides TSO ordering and
> > > > +              * as such promotes the below store to store-release.
> > > > +              */
> > > > +             WRITE_ONCE(vp_dev->intx_soft_enabled, true);
> > > > +             enable_irq(vp_dev->pci_dev->irq);
> > > >               return;
> > > > +     }
> > > >
> > > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > >               enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > @@ -97,6 +113,10 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
> > > >       struct virtio_pci_device *vp_dev = opaque;
> > > >       u8 isr;
> > > >
> > > > +     /* read intx_soft_enabled before read others */
> > > > +     if (!smp_load_acquire(&vp_dev->intx_soft_enabled))
> > > > +             return IRQ_NONE;
> > > > +
> > > >       /* reading the ISR has the effect of also clearing it so it's very
> > > >        * important to save off the value. */
> > > >       isr = ioread8(vp_dev->isr);
> > >
> > > I don't see why we need this ordering guarantee here.
> > >
> > > synchronize_irq above makes sure no interrupt handler
> > > is in progress.
> >
> > Yes.
> >
> > > the handler itself thus does not need
> > > any specific order, it is ok if intx_soft_enabled is read
> > > after, not before the rest of it.
> >
> > But the interrupt could be raised after synchronize_irq() which may
> > see a false of the intx_soft_enabled.
>
> You mean a "true" value right? false is what we are writing there.

I meant that we want to not go for stuff like vq->callback after the
synchronize_irq() after setting intx_soft_enabled to false. Otherwise
we may get unexpected results like use after free. Host can craft ISR
in this case.

>
> Are you sure it can happen? I think that synchronize_irq makes the value
> visible on all CPUs running the irq.

Yes, so the false is visible by vp_interrupt(), we can't do the other
task before we check intx_soft_enabled.

>
> > In this case we still need the
> > make sure intx_soft_enbled to be read first instead of allowing other
> > operations to be done first, otherwise the intx_soft_enabled is
> > meaningless.
> >
> > Thanks
>
> If intx_soft_enbled were not visible after synchronize_irq then
> it does not matter in which order we read it wrt other values,
> it still wouldn't work right.

Yes.

Thanks

>
> > >
> > > Just READ_ONCE should be enough, and we can drop the comment.
> > >
> > >
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
