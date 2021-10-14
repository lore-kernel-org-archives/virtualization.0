Return-Path: <SRS0=Buhk=PC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E3BC433FE
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 06:32:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 512E7606A5
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 06:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 512E7606A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13F8F407B9;
	Thu, 14 Oct 2021 06:32:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4fEs4IBvnkbB; Thu, 14 Oct 2021 06:32:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8C42A40792;
	Thu, 14 Oct 2021 06:32:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 510B0C0011;
	Thu, 14 Oct 2021 06:32:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17293C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 06:32:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D91D04036B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 06:32:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8wtKCaReRQcd
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 06:32:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 67EBA40223
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 06:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634193155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=31s6XV9TstpPEqT0u/Y356vc681kPmYFJLgOI3/TapM=;
 b=VATa/Sno9l0JbQC+xIVrVVJcGByswVENl4U+AbV1M0kXHjFl57eI74ZaWh5jpxa325CVvL
 7TRbkNm+vkLavvlbQGb3qw+eHscD86klnuxK7rS92NAsjRYDC5C9iyBOvdGjjT+1oclOsT
 Tfp4X8K1bYk6WOnfjbgYJKPn86CXZ94=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-TgEJn2fKOnigJb_snrA3PA-1; Thu, 14 Oct 2021 02:32:31 -0400
X-MC-Unique: TgEJn2fKOnigJb_snrA3PA-1
Received: by mail-lf1-f71.google.com with SMTP id
 x7-20020a056512130700b003fd1a7424a8so3647104lfu.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 23:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=31s6XV9TstpPEqT0u/Y356vc681kPmYFJLgOI3/TapM=;
 b=zf/DfmUFH945bp+Kb42WgvZ+WRp6GWM8uqrEIn+75N7GcVFH3dF8vfxrmMcgEz/bWM
 /7L4/NRLZyOraSLo1XckS9pqEmI6v94961c1LImLMkc32J9V9zT3xVykjTH+d9yGDUEW
 VLVL8b5zSX54BM3aSn0iCaqsLsnE1LoebjF5/PPfWX+G5aAjIkWwMgdEuKL2LMRcc452
 J3nmpOWl7ee5IbsNBdniUdcd9P82bNdRJnEfJASrbjG9YCXmbABl2BEzYVIKixjv/ATN
 QqThulw5OszpA+7PEb9tcwvWlt9vflmY2mq6UopoNlLWn7D84p5/SkdseWhtcoRi6LRw
 bliA==
X-Gm-Message-State: AOAM532I+a8JC+8uJ/Dk3QOk6JY75VDFBxAqhe2sg0S/7aQp6A/ljoP7
 hJTw4F1BJSkBAsmfddRgdIGjBqhtEcqgiQDMLbLCc2jOAbC8Y+mXtKcoCSLfyycZWyNZFoBAGbJ
 hXlY3dZmSOJIELZIlUXoHaZdUymX8Igmf0SquIJhvPOiURlME8ofsovanpw==
X-Received: by 2002:a2e:5c8:: with SMTP id 191mr4214622ljf.107.1634193150321; 
 Wed, 13 Oct 2021 23:32:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDlSr4S7th26Srw5czAHLsCG4221sVATfAaUO4erkGDGb7IXMne9Hg9yZCoWNe7TprziQBbKtofGQzlkGjydE=
X-Received: by 2002:a2e:5c8:: with SMTP id 191mr4214590ljf.107.1634193150044; 
 Wed, 13 Oct 2021 23:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-8-jasowang@redhat.com>
 <20211013053627-mutt-send-email-mst@kernel.org>
 <CACGkMEuRHKJv73oKFNetcBkPSFj034te7N_AJZdRbHe0ObU4Gw@mail.gmail.com>
 <20211014014551-mutt-send-email-mst@kernel.org>
 <CACGkMEvB4sMPmMmPQmHFasGLwktyXuCenQKGuoajmoFQYJJeBQ@mail.gmail.com>
 <20211014022438-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211014022438-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Oct 2021 14:32:19 +0800
Message-ID: <CACGkMEsPiHee5A=JymA+RpaN+xqbpw=hU=or29hrHCDk=TK+Hw@mail.gmail.com>
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

On Thu, Oct 14, 2021 at 2:26 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Oct 14, 2021 at 02:20:17PM +0800, Jason Wang wrote:
> > On Thu, Oct 14, 2021 at 1:50 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Oct 14, 2021 at 10:35:48AM +0800, Jason Wang wrote:
> > > > On Wed, Oct 13, 2021 at 5:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Tue, Oct 12, 2021 at 02:52:22PM +0800, Jason Wang wrote:
> > > > > > This patch tries to make sure the virtio interrupt handler for INTX
> > > > > > won't be called after a reset and before virtio_device_ready(). We
> > > > > > can't use IRQF_NO_AUTOEN since we're using shared interrupt
> > > > > > (IRQF_SHARED). So this patch tracks the INTX enabling status in a new
> > > > > > intx_soft_enabled variable and toggle it during in
> > > > > > vp_disable/enable_vectors(). The INTX interrupt handler will check
> > > > > > intx_soft_enabled before processing the actual interrupt.
> > > > > >
> > > > > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > ---
> > > > > >  drivers/virtio/virtio_pci_common.c | 24 ++++++++++++++++++++++--
> > > > > >  drivers/virtio/virtio_pci_common.h |  1 +
> > > > > >  2 files changed, 23 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > > > > index 0b9523e6dd39..5ae6a2a4eb77 100644
> > > > > > --- a/drivers/virtio/virtio_pci_common.c
> > > > > > +++ b/drivers/virtio/virtio_pci_common.c
> > > > > > @@ -30,8 +30,16 @@ void vp_disable_vectors(struct virtio_device *vdev)
> > > > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > > >       int i;
> > > > > >
> > > > > > -     if (vp_dev->intx_enabled)
> > > > > > +     if (vp_dev->intx_enabled) {
> > > > > > +             /*
> > > > > > +              * The below synchronize() guarantees that any
> > > > > > +              * interrupt for this line arriving after
> > > > > > +              * synchronize_irq() has completed is guaranteed to see
> > > > > > +              * intx_soft_enabled == false.
> > > > > > +              */
> > > > > > +             WRITE_ONCE(vp_dev->intx_soft_enabled, false);
> > > > > >               synchronize_irq(vp_dev->pci_dev->irq);
> > > > > > +     }
> > > > > >
> > > > > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > > >               disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > > @@ -43,8 +51,16 @@ void vp_enable_vectors(struct virtio_device *vdev)
> > > > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > > >       int i;
> > > > > >
> > > > > > -     if (vp_dev->intx_enabled)
> > > > > > +     if (vp_dev->intx_enabled) {
> > > > > > +             disable_irq(vp_dev->pci_dev->irq);
> > > > > > +             /*
> > > > > > +              * The above disable_irq() provides TSO ordering and
> > > > > > +              * as such promotes the below store to store-release.
> > > > > > +              */
> > > > > > +             WRITE_ONCE(vp_dev->intx_soft_enabled, true);
> > > > > > +             enable_irq(vp_dev->pci_dev->irq);
> > > > > >               return;
> > > > > > +     }
> > > > > >
> > > > > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > > >               enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > > @@ -97,6 +113,10 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
> > > > > >       struct virtio_pci_device *vp_dev = opaque;
> > > > > >       u8 isr;
> > > > > >
> > > > > > +     /* read intx_soft_enabled before read others */
> > > > > > +     if (!smp_load_acquire(&vp_dev->intx_soft_enabled))
> > > > > > +             return IRQ_NONE;
> > > > > > +
> > > > > >       /* reading the ISR has the effect of also clearing it so it's very
> > > > > >        * important to save off the value. */
> > > > > >       isr = ioread8(vp_dev->isr);
> > > > >
> > > > > I don't see why we need this ordering guarantee here.
> > > > >
> > > > > synchronize_irq above makes sure no interrupt handler
> > > > > is in progress.
> > > >
> > > > Yes.
> > > >
> > > > > the handler itself thus does not need
> > > > > any specific order, it is ok if intx_soft_enabled is read
> > > > > after, not before the rest of it.
> > > >
> > > > But the interrupt could be raised after synchronize_irq() which may
> > > > see a false of the intx_soft_enabled.
> > >
> > > You mean a "true" value right? false is what we are writing there.
> >
> > I meant that we want to not go for stuff like vq->callback after the
> > synchronize_irq() after setting intx_soft_enabled to false. Otherwise
> > we may get unexpected results like use after free. Host can craft ISR
> > in this case.
> > >
> > > Are you sure it can happen? I think that synchronize_irq makes the value
> > > visible on all CPUs running the irq.
> >
> > Yes, so the false is visible by vp_interrupt(), we can't do the other
> > task before we check intx_soft_enabled.
>
> But the order does not matter. synchronize_irq will make sure
> everything is visible.

Not the thing that happens after synchronize_irq().

E.g for remove_vq_common():

static void remove_vq_common(struct virtnet_info *vi)
{
        vi->vdev->config->reset(vi->vdev);

        /* Free unused buffers in both send and recv, if any. */
        free_unused_bufs(vi);

        free_receive_bufs(vi);

        free_receive_page_frags(vi);

        virtnet_del_vqs(vi);
}

The interrupt could be raised by the device after .reset().

Thanks

>
> > >
> > > > In this case we still need the
> > > > make sure intx_soft_enbled to be read first instead of allowing other
> > > > operations to be done first, otherwise the intx_soft_enabled is
> > > > meaningless.
> > > >
> > > > Thanks
> > >
> > > If intx_soft_enbled were not visible after synchronize_irq then
> > > it does not matter in which order we read it wrt other values,
> > > it still wouldn't work right.
> >
> > Yes.
> >
> > Thanks
>
>
> We are agreed then? No need for a barrier here, READ_ONCE is enough?
>
> > >
> > > > >
> > > > > Just READ_ONCE should be enough, and we can drop the comment.
> > > > >
> > > > >
> > > > > > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> > > > > > index a235ce9ff6a5..3c06e0f92ee4 100644
> > > > > > --- a/drivers/virtio/virtio_pci_common.h
> > > > > > +++ b/drivers/virtio/virtio_pci_common.h
> > > > > > @@ -64,6 +64,7 @@ struct virtio_pci_device {
> > > > > >       /* MSI-X support */
> > > > > >       int msix_enabled;
> > > > > >       int intx_enabled;
> > > > > > +     bool intx_soft_enabled;
> > > > > >       cpumask_var_t *msix_affinity_masks;
> > > > > >       /* Name strings for interrupts. This size should be enough,
> > > > > >        * and I'm too lazy to allocate each name separately. */
> > > > > > --
> > > > > > 2.25.1
> > > > >
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
