Return-Path: <SRS0=Buhk=PC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30364C433F5
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 07:13:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F9F61166
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 07:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D3F9F61166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D83B94042C;
	Thu, 14 Oct 2021 07:13:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FVnD1T99gVpV; Thu, 14 Oct 2021 07:13:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8AE5340402;
	Thu, 14 Oct 2021 07:13:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60AAAC000F;
	Thu, 14 Oct 2021 07:13:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0FDBC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 07:13:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B5764835D9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 07:13:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0rkdHxDWDNRC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 07:13:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BBC6E835CF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 07:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634195588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iFShF0oRg2jAAAZJTTglCrq3sTQZKGoDbjKTIO8b7CA=;
 b=Mk6Iwb7St3d15nZiFVR1lAE43eGYxhs8T8PcXp6enxqzguVoKfG9Rl8Yf9pADD9I3pf6yf
 5stHp2SXFG0ci3uvA0y6beYEtZyzxKfxcLrpZ8cPLd6aahiRw+mhnorGEGKnJBIJAeQRZX
 OWXLLvZAdhWgmpbBOvUXaotc14NiaUY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-ffIS3WSQMV6V3pVf4OhMug-1; Thu, 14 Oct 2021 03:13:07 -0400
X-MC-Unique: ffIS3WSQMV6V3pVf4OhMug-1
Received: by mail-lf1-f72.google.com with SMTP id
 bi16-20020a0565120e9000b003fd56ef5a94so3727229lfb.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 00:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iFShF0oRg2jAAAZJTTglCrq3sTQZKGoDbjKTIO8b7CA=;
 b=I3AEDvyDbem5zOafmyRCmy50H7a6XZrFSe0qoP0bSreJdtk8AY2GWDGX4ooRsWbdF3
 2riAkGs8FhiTSUKBxPVj4CpFzg5GvS605PbETrGzhATBcJoSBKxhntvEu37aGApVMTm2
 VlpHM6BRaFryIzm10IYt/epw9s6OCFUJ902JxeGvZWyTYJBiK7z39mpsqOnoZEuImLpw
 i8FkbDsx1iUSy5OjEnY6uqb1++Q4fJs86vhA4RWXx9o/+kT37nTYHnVeknKgiNwxgCpj
 AiPclz2cOrJTxzwBqTQIkI7IxP5JlRBk3uFfn7WBFhurZPxIA9rj3U9Cpp7SoL9Qet46
 7GeA==
X-Gm-Message-State: AOAM533KjD6MFdOwpKBAbxWbvWc6Bg9uFdajB2gbK5wmJlIsHgwAulcu
 r6Z32U7EA6EJxOrMhts486OSdAv5hlOLJsaEhmVpsgSXj/A4S8WsdWUWU36crio24h3AHmY02wi
 9ZmsDzDGCu3IayPw6F4a4axzWlYGtBL4IqRg1sr2oHuTuOVY2kTPwCx2qFw==
X-Received: by 2002:a2e:a5c8:: with SMTP id n8mr4193064ljp.307.1634195585942; 
 Thu, 14 Oct 2021 00:13:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCvurWQtEznrsARjgbFFDgC2wXd8c48qX4VYg8ZkNC9BGuZYsWAm3Ah1ZFSHJqWsOs7XoDnGLiNR8clAEV9G4=
X-Received: by 2002:a2e:a5c8:: with SMTP id n8mr4193036ljp.307.1634195585654; 
 Thu, 14 Oct 2021 00:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-8-jasowang@redhat.com>
 <20211013053627-mutt-send-email-mst@kernel.org>
 <CACGkMEuRHKJv73oKFNetcBkPSFj034te7N_AJZdRbHe0ObU4Gw@mail.gmail.com>
 <20211014014551-mutt-send-email-mst@kernel.org>
 <CACGkMEvB4sMPmMmPQmHFasGLwktyXuCenQKGuoajmoFQYJJeBQ@mail.gmail.com>
 <20211014022438-mutt-send-email-mst@kernel.org>
 <CACGkMEsPiHee5A=JymA+RpaN+xqbpw=hU=or29hrHCDk=TK+Hw@mail.gmail.com>
 <20211014025815-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211014025815-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Oct 2021 15:12:54 +0800
Message-ID: <CACGkMEtS1QWita4uKsR0bZOuSk5QnGkD47AwL5-cx=70=MQp-w@mail.gmail.com>
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

On Thu, Oct 14, 2021 at 3:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Oct 14, 2021 at 02:32:19PM +0800, Jason Wang wrote:
> > On Thu, Oct 14, 2021 at 2:26 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Oct 14, 2021 at 02:20:17PM +0800, Jason Wang wrote:
> > > > On Thu, Oct 14, 2021 at 1:50 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Thu, Oct 14, 2021 at 10:35:48AM +0800, Jason Wang wrote:
> > > > > > On Wed, Oct 13, 2021 at 5:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > >
> > > > > > > On Tue, Oct 12, 2021 at 02:52:22PM +0800, Jason Wang wrote:
> > > > > > > > This patch tries to make sure the virtio interrupt handler for INTX
> > > > > > > > won't be called after a reset and before virtio_device_ready(). We
> > > > > > > > can't use IRQF_NO_AUTOEN since we're using shared interrupt
> > > > > > > > (IRQF_SHARED). So this patch tracks the INTX enabling status in a new
> > > > > > > > intx_soft_enabled variable and toggle it during in
> > > > > > > > vp_disable/enable_vectors(). The INTX interrupt handler will check
> > > > > > > > intx_soft_enabled before processing the actual interrupt.
> > > > > > > >
> > > > > > > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > ---
> > > > > > > >  drivers/virtio/virtio_pci_common.c | 24 ++++++++++++++++++++++--
> > > > > > > >  drivers/virtio/virtio_pci_common.h |  1 +
> > > > > > > >  2 files changed, 23 insertions(+), 2 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > > > > > > index 0b9523e6dd39..5ae6a2a4eb77 100644
> > > > > > > > --- a/drivers/virtio/virtio_pci_common.c
> > > > > > > > +++ b/drivers/virtio/virtio_pci_common.c
> > > > > > > > @@ -30,8 +30,16 @@ void vp_disable_vectors(struct virtio_device *vdev)
> > > > > > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > > > > >       int i;
> > > > > > > >
> > > > > > > > -     if (vp_dev->intx_enabled)
> > > > > > > > +     if (vp_dev->intx_enabled) {
> > > > > > > > +             /*
> > > > > > > > +              * The below synchronize() guarantees that any
> > > > > > > > +              * interrupt for this line arriving after
> > > > > > > > +              * synchronize_irq() has completed is guaranteed to see
> > > > > > > > +              * intx_soft_enabled == false.
> > > > > > > > +              */
> > > > > > > > +             WRITE_ONCE(vp_dev->intx_soft_enabled, false);
> > > > > > > >               synchronize_irq(vp_dev->pci_dev->irq);
> > > > > > > > +     }
> > > > > > > >
> > > > > > > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > > > > >               disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > > > > @@ -43,8 +51,16 @@ void vp_enable_vectors(struct virtio_device *vdev)
> > > > > > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > > > > >       int i;
> > > > > > > >
> > > > > > > > -     if (vp_dev->intx_enabled)
> > > > > > > > +     if (vp_dev->intx_enabled) {
> > > > > > > > +             disable_irq(vp_dev->pci_dev->irq);
> > > > > > > > +             /*
> > > > > > > > +              * The above disable_irq() provides TSO ordering and
> > > > > > > > +              * as such promotes the below store to store-release.
> > > > > > > > +              */
> > > > > > > > +             WRITE_ONCE(vp_dev->intx_soft_enabled, true);
> > > > > > > > +             enable_irq(vp_dev->pci_dev->irq);
> > > > > > > >               return;
> > > > > > > > +     }
> > > > > > > >
> > > > > > > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > > > > >               enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > > > > @@ -97,6 +113,10 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
> > > > > > > >       struct virtio_pci_device *vp_dev = opaque;
> > > > > > > >       u8 isr;
> > > > > > > >
> > > > > > > > +     /* read intx_soft_enabled before read others */
> > > > > > > > +     if (!smp_load_acquire(&vp_dev->intx_soft_enabled))
> > > > > > > > +             return IRQ_NONE;
> > > > > > > > +
> > > > > > > >       /* reading the ISR has the effect of also clearing it so it's very
> > > > > > > >        * important to save off the value. */
> > > > > > > >       isr = ioread8(vp_dev->isr);
> > > > > > >
> > > > > > > I don't see why we need this ordering guarantee here.
> > > > > > >
> > > > > > > synchronize_irq above makes sure no interrupt handler
> > > > > > > is in progress.
> > > > > >
> > > > > > Yes.
> > > > > >
> > > > > > > the handler itself thus does not need
> > > > > > > any specific order, it is ok if intx_soft_enabled is read
> > > > > > > after, not before the rest of it.
> > > > > >
> > > > > > But the interrupt could be raised after synchronize_irq() which may
> > > > > > see a false of the intx_soft_enabled.
> > > > >
> > > > > You mean a "true" value right? false is what we are writing there.
> > > >
> > > > I meant that we want to not go for stuff like vq->callback after the
> > > > synchronize_irq() after setting intx_soft_enabled to false. Otherwise
> > > > we may get unexpected results like use after free. Host can craft ISR
> > > > in this case.
> > > > >
> > > > > Are you sure it can happen? I think that synchronize_irq makes the value
> > > > > visible on all CPUs running the irq.
> > > >
> > > > Yes, so the false is visible by vp_interrupt(), we can't do the other
> > > > task before we check intx_soft_enabled.
> > >
> > > But the order does not matter. synchronize_irq will make sure
> > > everything is visible.
> >
> > Not the thing that happens after synchronize_irq().
> >
> > E.g for remove_vq_common():
> >
> > static void remove_vq_common(struct virtnet_info *vi)
> > {
> >         vi->vdev->config->reset(vi->vdev);
> >
> >         /* Free unused buffers in both send and recv, if any. */
> >         free_unused_bufs(vi);
> >
> >         free_receive_bufs(vi);
> >
> >         free_receive_page_frags(vi);
> >
> >         virtnet_del_vqs(vi);
> > }
> >
> > The interrupt could be raised by the device after .reset().
> >
> > Thanks
>
> That's why your patches set intx_soft_enabled to false within reset.
> Then you sync so all other CPUs see the false value.
> Then it's ok to proceed with reset.
> What does the interrupt handler *do* with the value
> does not matter as long as it sees that it is false.

I'm not sure I get here, if we allow the interrupt handler to access
the vq before checking intx_soft_enabled, won't there be a
use-after-free?

>
> OTOH if you are really worried about spectre type speculative attacks,
> that is a different matter, and would force us to stick expensive
> barriers around hardware accessible buffers just like we have in
> copy_XXX_user. I am not sure this is in scope for TDX, and
> certainly out of scope for regular driver ardening.
> If yes worth hiding that behind a kernel option.

Right.

Thanks

>
>
> > >
> > > > >
> > > > > > In this case we still need the
> > > > > > make sure intx_soft_enbled to be read first instead of allowing other
> > > > > > operations to be done first, otherwise the intx_soft_enabled is
> > > > > > meaningless.
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > If intx_soft_enbled were not visible after synchronize_irq then
> > > > > it does not matter in which order we read it wrt other values,
> > > > > it still wouldn't work right.
> > > >
> > > > Yes.
> > > >
> > > > Thanks
> > >
> > >
> > > We are agreed then? No need for a barrier here, READ_ONCE is enough?
> > >
> > > > >
> > > > > > >
> > > > > > > Just READ_ONCE should be enough, and we can drop the comment.
> > > > > > >
> > > > > > >
> > > > > > > > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> > > > > > > > index a235ce9ff6a5..3c06e0f92ee4 100644
> > > > > > > > --- a/drivers/virtio/virtio_pci_common.h
> > > > > > > > +++ b/drivers/virtio/virtio_pci_common.h
> > > > > > > > @@ -64,6 +64,7 @@ struct virtio_pci_device {
> > > > > > > >       /* MSI-X support */
> > > > > > > >       int msix_enabled;
> > > > > > > >       int intx_enabled;
> > > > > > > > +     bool intx_soft_enabled;
> > > > > > > >       cpumask_var_t *msix_affinity_masks;
> > > > > > > >       /* Name strings for interrupts. This size should be enough,
> > > > > > > >        * and I'm too lazy to allocate each name separately. */
> > > > > > > > --
> > > > > > > > 2.25.1
> > > > > > >
> > > > >
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
