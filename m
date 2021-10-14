Return-Path: <SRS0=Buhk=PC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85865C433EF
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 05:50:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37092610E8
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 05:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 37092610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D410240409;
	Thu, 14 Oct 2021 05:50:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qlmcRfS6Smwf; Thu, 14 Oct 2021 05:50:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 43952401D8;
	Thu, 14 Oct 2021 05:50:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2301FC0011;
	Thu, 14 Oct 2021 05:50:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D404BC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 05:50:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B3C9540662
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 05:50:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8Z75ew3t891P
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 05:50:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E46594064D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 05:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634190603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kVSsxXTqUF8SgEcg1VdRpaSfaT15nzOVvL9iycEb81M=;
 b=cUwEgTxvohXVieXVQ7OFJiSp9w21224NpwInJS63MD8m2hXnYSE3DJ7FIeQMHKnga4pWNU
 AhjlnM9N+i4gge1jN+QJGZGiJjGLocvYFUEuL/uqS/yybMgcyo/F2ngJKiGwCB3lwASVKY
 rsvwFcQ4z7iC36Y87CBKier87LhN2wc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-ew3GgqtLOiGOwRjUJc55EA-1; Thu, 14 Oct 2021 01:50:00 -0400
X-MC-Unique: ew3GgqtLOiGOwRjUJc55EA-1
Received: by mail-ed1-f72.google.com with SMTP id
 t18-20020a056402021200b003db9e6b0e57so4224367edv.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 22:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kVSsxXTqUF8SgEcg1VdRpaSfaT15nzOVvL9iycEb81M=;
 b=OvuyXVv1tBtHQLySjWDmIQiUzaVzMrCfpEB1dQ9T+r6nW3MX0mkKu7aiWXJHQqqdni
 MNxdDV8LT/DS2FadcLSDt6dMEpVlMxHEPXJgFo+X+l2YqvQ1P/vC1wJmZac5gp2gMmsb
 RayyiW4y/y45iEy2NzZ6SrTTG9L/swSUUI//E8aOpKy947FMjieHsdn+Hgk1ZxGJX0Q5
 /mlk4r9bODdob99EIXn9MFkZs07ULZXdwLZ1SWtTq0ZKe3YgUx993hyIeq1ktAMyAXLq
 oh4ML3302Z4zUX1Vatb0Pt94XtWVLzloLmpdVWRbkIIr0rxPxZPfMrrpG4pzcKwisf26
 RnGA==
X-Gm-Message-State: AOAM530bgj3oeJDK9+PP0o3dDGpmRZTe5URaEI3uqgS8xKzaeBV8jBNA
 WsLpVEq4gvYGAj2bWqOU3bM4uHZsQFW9vUe1QCI4dxLUzFCptpn8ZSk1/A1QZTlUzY01OXg4D5d
 OMZzXI+3geG4B8HbTSkFDbfnHtUbA7w1SVQs20xauNQ==
X-Received: by 2002:a17:906:1c03:: with SMTP id
 k3mr1384544ejg.562.1634190599747; 
 Wed, 13 Oct 2021 22:49:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFOckRJp+uOn9m6c3TPfTw2gelsUrkP7Gyhoffoo3myEf1ta/SG7S3ClgjdMVibRoSVifWjg==
X-Received: by 2002:a17:906:1c03:: with SMTP id
 k3mr1384531ejg.562.1634190599603; 
 Wed, 13 Oct 2021 22:49:59 -0700 (PDT)
Received: from redhat.com ([2.55.16.227])
 by smtp.gmail.com with ESMTPSA id ox9sm1064142ejb.66.2021.10.13.22.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 22:49:58 -0700 (PDT)
Date: Thu, 14 Oct 2021 01:49:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 07/12] virtio-pci: harden INTX interrupts
Message-ID: <20211014014551-mutt-send-email-mst@kernel.org>
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-8-jasowang@redhat.com>
 <20211013053627-mutt-send-email-mst@kernel.org>
 <CACGkMEuRHKJv73oKFNetcBkPSFj034te7N_AJZdRbHe0ObU4Gw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuRHKJv73oKFNetcBkPSFj034te7N_AJZdRbHe0ObU4Gw@mail.gmail.com>
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

On Thu, Oct 14, 2021 at 10:35:48AM +0800, Jason Wang wrote:
> On Wed, Oct 13, 2021 at 5:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Oct 12, 2021 at 02:52:22PM +0800, Jason Wang wrote:
> > > This patch tries to make sure the virtio interrupt handler for INTX
> > > won't be called after a reset and before virtio_device_ready(). We
> > > can't use IRQF_NO_AUTOEN since we're using shared interrupt
> > > (IRQF_SHARED). So this patch tracks the INTX enabling status in a new
> > > intx_soft_enabled variable and toggle it during in
> > > vp_disable/enable_vectors(). The INTX interrupt handler will check
> > > intx_soft_enabled before processing the actual interrupt.
> > >
> > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/virtio/virtio_pci_common.c | 24 ++++++++++++++++++++++--
> > >  drivers/virtio/virtio_pci_common.h |  1 +
> > >  2 files changed, 23 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > index 0b9523e6dd39..5ae6a2a4eb77 100644
> > > --- a/drivers/virtio/virtio_pci_common.c
> > > +++ b/drivers/virtio/virtio_pci_common.c
> > > @@ -30,8 +30,16 @@ void vp_disable_vectors(struct virtio_device *vdev)
> > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > >       int i;
> > >
> > > -     if (vp_dev->intx_enabled)
> > > +     if (vp_dev->intx_enabled) {
> > > +             /*
> > > +              * The below synchronize() guarantees that any
> > > +              * interrupt for this line arriving after
> > > +              * synchronize_irq() has completed is guaranteed to see
> > > +              * intx_soft_enabled == false.
> > > +              */
> > > +             WRITE_ONCE(vp_dev->intx_soft_enabled, false);
> > >               synchronize_irq(vp_dev->pci_dev->irq);
> > > +     }
> > >
> > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > >               disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > @@ -43,8 +51,16 @@ void vp_enable_vectors(struct virtio_device *vdev)
> > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > >       int i;
> > >
> > > -     if (vp_dev->intx_enabled)
> > > +     if (vp_dev->intx_enabled) {
> > > +             disable_irq(vp_dev->pci_dev->irq);
> > > +             /*
> > > +              * The above disable_irq() provides TSO ordering and
> > > +              * as such promotes the below store to store-release.
> > > +              */
> > > +             WRITE_ONCE(vp_dev->intx_soft_enabled, true);
> > > +             enable_irq(vp_dev->pci_dev->irq);
> > >               return;
> > > +     }
> > >
> > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > >               enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > @@ -97,6 +113,10 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
> > >       struct virtio_pci_device *vp_dev = opaque;
> > >       u8 isr;
> > >
> > > +     /* read intx_soft_enabled before read others */
> > > +     if (!smp_load_acquire(&vp_dev->intx_soft_enabled))
> > > +             return IRQ_NONE;
> > > +
> > >       /* reading the ISR has the effect of also clearing it so it's very
> > >        * important to save off the value. */
> > >       isr = ioread8(vp_dev->isr);
> >
> > I don't see why we need this ordering guarantee here.
> >
> > synchronize_irq above makes sure no interrupt handler
> > is in progress.
> 
> Yes.
> 
> > the handler itself thus does not need
> > any specific order, it is ok if intx_soft_enabled is read
> > after, not before the rest of it.
> 
> But the interrupt could be raised after synchronize_irq() which may
> see a false of the intx_soft_enabled.

You mean a "true" value right? false is what we are writing there.

Are you sure it can happen? I think that synchronize_irq makes the value
visible on all CPUs running the irq.

> In this case we still need the
> make sure intx_soft_enbled to be read first instead of allowing other
> operations to be done first, otherwise the intx_soft_enabled is
> meaningless.
> 
> Thanks

If intx_soft_enbled were not visible after synchronize_irq then
it does not matter in which order we read it wrt other values,
it still wouldn't work right.

> >
> > Just READ_ONCE should be enough, and we can drop the comment.
> >
> >
> > > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> > > index a235ce9ff6a5..3c06e0f92ee4 100644
> > > --- a/drivers/virtio/virtio_pci_common.h
> > > +++ b/drivers/virtio/virtio_pci_common.h
> > > @@ -64,6 +64,7 @@ struct virtio_pci_device {
> > >       /* MSI-X support */
> > >       int msix_enabled;
> > >       int intx_enabled;
> > > +     bool intx_soft_enabled;
> > >       cpumask_var_t *msix_affinity_masks;
> > >       /* Name strings for interrupts. This size should be enough,
> > >        * and I'm too lazy to allocate each name separately. */
> > > --
> > > 2.25.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
