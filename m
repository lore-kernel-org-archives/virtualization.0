Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CB8C433F5
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 12:13:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD92A81301;
	Wed,  9 Mar 2022 12:13:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id geGF1aZfNlxN; Wed,  9 Mar 2022 12:13:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9F6CC8128C;
	Wed,  9 Mar 2022 12:13:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DC5EC001D;
	Wed,  9 Mar 2022 12:13:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9FC8C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 12:13:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9BC428128C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 12:13:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Aj785Jxv-g_6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 12:13:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 499C88125F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 12:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646828010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vYQs2E+XcAAe9MfZ30EbAKw9lxEpvFskNr2YmmYsy1E=;
 b=MjXOJeW/tP+u0hEnzuWiBCJAKb5UDA57B4ObwXmm0IMA73ZBhqdLcxjV+1jOhgFCqZ5eqg
 /RE6KdV28C+CzknJH8Xz31Fu664M55aqRqshnIjgI0cpQeYvxQXB6yqZHehfmBHVfur7Dt
 41mP0gZqRlsmEv6M3niXUay0N7XgWSo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-akL0ADx2Ove6BexiDuGLMg-1; Wed, 09 Mar 2022 07:13:28 -0500
X-MC-Unique: akL0ADx2Ove6BexiDuGLMg-1
Received: by mail-wm1-f70.google.com with SMTP id
 14-20020a05600c028e00b003897a4056e8so884619wmk.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Mar 2022 04:13:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vYQs2E+XcAAe9MfZ30EbAKw9lxEpvFskNr2YmmYsy1E=;
 b=2d8/TiRPYjl4ZqHAFwpLjwqhUiSM04LnEOLX5VcLfliAqHgUG3+ZUvpdvCot9HP9db
 NZ47B/nmGXVhHzzFyMX5b5wwX8p07FwGJ8wig4euX+UpX+N8Na7NZmrXWQjK1yWnRQFo
 we5VohQr2p0IBR7Gyn0AGx54isbQOvVXZRfGW9aKposjstKgrb/gfsMmTaTYPOBBtKAi
 uBx5wy7tLlufToE2CT55Ykf2Vn1FqRLMpM2ee9XbYIPrR2DYIH3IVv+KE8iYp/wgSlJW
 1ai+jnCEr+KTTzNhKwqsSmg1T6EAlwOAfyDJgPdu0vT4Eji5Ih92Cfo53H3MMhuKEqmo
 bNLw==
X-Gm-Message-State: AOAM5317CUdYbYHn2QEinupu/VbAIqsqPC3sfMjLU52+jjzPByWPYf3Z
 NqSYLOvFoTm/vprG14ojLr6sHe/jKhHQcLKCAW61ZPp0sKyZ4DmHig4gzYA1d15oxbvaGdVWNDs
 GZdF1EE47X/wMShFKS93H520uDIQITAiQX9+ZDmpXGA==
X-Received: by 2002:a5d:6790:0:b0:1f1:dabd:9134 with SMTP id
 v16-20020a5d6790000000b001f1dabd9134mr15627382wru.447.1646828007660; 
 Wed, 09 Mar 2022 04:13:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzdQHXpowEqr6kV6Jv3GkrqllFI6rdvJV7jvHEQewGubXCqEpVxjNhomCEvuh03DqQSTkaaA==
X-Received: by 2002:a5d:6790:0:b0:1f1:dabd:9134 with SMTP id
 v16-20020a5d6790000000b001f1dabd9134mr15627357wru.447.1646828007390; 
 Wed, 09 Mar 2022 04:13:27 -0800 (PST)
Received: from redhat.com ([2.55.24.184]) by smtp.gmail.com with ESMTPSA id
 a14-20020a05600c348e00b00389ab74c033sm1498201wmq.4.2022.03.09.04.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Mar 2022 04:13:26 -0800 (PST)
Date: Wed, 9 Mar 2022 07:13:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH V3 04/10] virtio_pci: harden MSI-X interrupts
Message-ID: <20220309062833-mutt-send-email-mst@kernel.org>
References: <20211019070152.8236-1-jasowang@redhat.com>
 <20211019070152.8236-5-jasowang@redhat.com>
 <87y21kzd3f.wl-maz@kernel.org>
 <20220308113119-mutt-send-email-mst@kernel.org>
 <87v8wnz8li.wl-maz@kernel.org>
MIME-Version: 1.0
In-Reply-To: <87v8wnz8li.wl-maz@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: keirf@google.com, "Paul E . McKenney" <paulmck@kernel.org>,
 david.kaplan@amd.com, konrad.wilk@oracle.com,
 Peter Zijlstra <peterz@infradead.org>, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
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

On Wed, Mar 09, 2022 at 11:08:41AM +0000, Marc Zyngier wrote:
> On Tue, 08 Mar 2022 16:35:52 +0000,
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > On Tue, Mar 08, 2022 at 03:19:16PM +0000, Marc Zyngier wrote:
> > > On Tue, 19 Oct 2021 08:01:46 +0100,
> > > Jason Wang <jasowang@redhat.com> wrote:
> > > > 
> > > > We used to synchronize pending MSI-X irq handlers via
> > > > synchronize_irq(), this may not work for the untrusted device which
> > > > may keep sending interrupts after reset which may lead unexpected
> > > > results. Similarly, we should not enable MSI-X interrupt until the
> > > > device is ready. So this patch fixes those two issues by:
> > > > 
> > > > 1) switching to use disable_irq() to prevent the virtio interrupt
> > > >    handlers to be called after the device is reset.
> > > > 2) using IRQF_NO_AUTOEN and enable the MSI-X irq during .ready()
> > > > 
> > > > This can make sure the virtio interrupt handler won't be called before
> > > > virtio_device_ready() and after reset.
> > > > 
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  drivers/virtio/virtio_pci_common.c | 27 +++++++++++++++++++++------
> > > >  drivers/virtio/virtio_pci_common.h |  6 ++++--
> > > >  drivers/virtio/virtio_pci_legacy.c |  5 +++--
> > > >  drivers/virtio/virtio_pci_modern.c |  6 ++++--
> > > >  4 files changed, 32 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > > index b35bb2d57f62..8d8f83aca721 100644
> > > > --- a/drivers/virtio/virtio_pci_common.c
> > > > +++ b/drivers/virtio/virtio_pci_common.c
> > > > @@ -24,8 +24,8 @@ MODULE_PARM_DESC(force_legacy,
> > > >  		 "Force legacy mode for transitional virtio 1 devices");
> > > >  #endif
> > > >  
> > > > -/* wait for pending irq handlers */
> > > > -void vp_synchronize_vectors(struct virtio_device *vdev)
> > > > +/* disable irq handlers */
> > > > +void vp_disable_cbs(struct virtio_device *vdev)
> > > >  {
> > > >  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > >  	int i;
> > > > @@ -34,7 +34,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
> > > >  		synchronize_irq(vp_dev->pci_dev->irq);
> > > >  
> > > >  	for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > -		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > +		disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > +}
> > > > +
> > > > +/* enable irq handlers */
> > > > +void vp_enable_cbs(struct virtio_device *vdev)
> > > > +{
> > > > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > +	int i;
> > > > +
> > > > +	if (vp_dev->intx_enabled)
> > > > +		return;
> > > > +
> > > > +	for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > +		enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > 
> > > This results in a splat at boot time if you set maxcpus=<whatever>,
> > > see below. Enabling interrupts that are affinity managed is *bad*. You
> > > don't even know whether the CPU which is supposed to handle this is
> > > online or not.
> > > 
> > > The core kernel notices it, shouts and keeps the interrupt disabled,
> > > but this should be fixed. The whole point of managed interrupts is to
> > > let them be dealt with outside of the drivers, and tied into the CPUs
> > > being brought up and down. If virtio needs (for one reason or another)
> > > to manage interrupts on its own, so be it. But this patch isn't the
> > > way to do it, I'm afraid.
> > > 
> > > 	M.
> > 
> > Thanks for reporting this!
> > 
> > What virtio is doing here isn't unique however.
> 
> Then it is even worse than I though. Can you point me to the other
> drivers doing such thing?


What are you asking? Whether any drivers that set PCI_IRQ_AFFINITY also
set IRQF_NO_AUTOEN? I could not find any other drivers doing that, no.
When I said "isn't unique" I rather meant that other drivers need
something like this, and they likely do it in a driver specific, complex
fashion.

just poking around at random I found
drivers/scsi/mpi3mr/mpi3mr_fw.c

which does this last thing during initialization:

void mpi3mr_ioc_enable_intr(struct mpi3mr_ioc *mrioc)
{
        mrioc->intr_enabled = 1;
}

and the interrupt handler does:

static irqreturn_t mpi3mr_isr_primary(int irq, void *privdata)
{
        struct mpi3mr_intr_info *intr_info = privdata;
        struct mpi3mr_ioc *mrioc;
        u16 midx;
        u32 num_admin_replies = 0, num_op_reply = 0;

        if (!intr_info)
                return IRQ_NONE;

        mrioc = intr_info->mrioc;

        if (!mrioc->intr_enabled)
                return IRQ_NONE;


which seems to be trying to accomplish exactly the same thing and might
or might not actually need WRITE_ONCE or some barriers if it were to be
made 100% foolproof.



> > If device driver is to be hardened against device sending interrupts
> > while driver is initializing/cleaning up, it needs kernel to provide
> > capability to disable these.
> >
> > If we then declare that that is impossible for managed interrupts
> > then that will mean most devices can't use managed interrupts
> > because ideally we'd have all drivers hardened.
> 
> What I find odd is that you want to do the interrupt hardening in the
> individual endpoint drivers. This makes everything complicated, and
> just doesn't scale.
> The natural place for this sort of checks would be in the interrupt
> controller driver, which has all the state as its disposal, and is
> guaranteed to be able to take the right course of action if it sees
> something that contradicts its internal state tracking (affinity,
> masking, interrupt life cycle in general).

Exactly.  So here's what we are trying to do: driver is initializing
both itself and the device. As part of that, it assigns some IRQs. Once that
happens, device can trigger the IRQ callback by sending the interrupt.
If this happens too soon driver is not yet fully initialized and might
access uninitialized memory (and generally get confused because the
state is inconsistent).

Getting the IRQ in a disabled state and only enabling when we are
ready sounds like a very reasonable way to go about it just from
API perspective.





> 
> Because even if you were allowed to mess with the enable state, this
> doesn't give you any guarantee that the interrupt is delivered on the
> correct CPU either.

For virtio affinity is mostly an optimization, I don't think this
affects correctness.

> > Thomas I think you were the one who suggested enabling/disabling
> > interrupts originally - thoughts?
> > 
> > Feedback appreciated.
> 
> Feedback given.
> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
