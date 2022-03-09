Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB069C433FE
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 12:30:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A9AF60D4D;
	Wed,  9 Mar 2022 12:30:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iwIfoiGhh6dk; Wed,  9 Mar 2022 12:30:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DB5E160C29;
	Wed,  9 Mar 2022 12:30:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5A70C001D;
	Wed,  9 Mar 2022 12:30:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BCB9C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 12:30:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E921E41821
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 12:30:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g9cwjzEMEeQ5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 12:30:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7BE1841820
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 12:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646829043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rWD9XGlU43T/hPebWYiaS1wUvBoZOFcW/XaMqLKoWQI=;
 b=CUFODuCcdiA7avhUpyr7sPIhEKsIAUdSPtvjoayeEZ3AhnW9hS/agH/Jx988hxz+IhQFYG
 c30zBNKxjmzTyHlcreopbbznuYirgXr/9Jbg80HzAr+YxvYHntgjhRoF4QkDpOihNWGLPU
 H8lJ0z1PeXDJcfTSTFWR/ZznKclsrVk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-Np61nPlZOWiAa7ZlJW6LpQ-1; Wed, 09 Mar 2022 07:30:42 -0500
X-MC-Unique: Np61nPlZOWiAa7ZlJW6LpQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 c62-20020a1c3541000000b003815245c642so2527140wma.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Mar 2022 04:30:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rWD9XGlU43T/hPebWYiaS1wUvBoZOFcW/XaMqLKoWQI=;
 b=Drs4Tih/PcHXr6hRh7oWmvLz9nwqcpwquUSgN1ABslPK+nntsOj1VNXlRORJOAKmF7
 fxqvVzTqKwioeyNrDILY8u1n2aJxK/rraMrx2w+AueEi+HhB+3levp4yWyR6dbYmggPR
 Yl8rkYc/Mr5gTYklNiH8JyyQ6HY4CDxTuF+nnZEtz04jD5tGX1nUMSYoHU+DeVQbEnvJ
 t3ckBV1yFJ57Y9rlKEishzUQyjyefol9X6A+iHZ7bm6GlNDsj+CHtREjQewiykmns7Km
 bx7W9Re3lpr/NJHsXtAajlLbN1bzy12NucbqGgqzJag6R/JtHoy6nstaE6hjH/rnSr4P
 NClQ==
X-Gm-Message-State: AOAM5310ilD0C9JuyoffJDyZrYa76FhDPyqE79PKaw1fAUuLcQB9QLsj
 vsrBV1p4m2VO5Z9QU2Ix/gXMqbTt/DoVbZydDJ2z91dVEATpjdgd0crvZa6z71pDfz+0oqSgkkW
 XPPo3noRVfr3x/g8u6h/QP+xV+K3UP5mvOmK2p9Y82Q==
X-Received: by 2002:a05:600c:2c49:b0:384:7202:358e with SMTP id
 r9-20020a05600c2c4900b003847202358emr7429080wmg.108.1646829040670; 
 Wed, 09 Mar 2022 04:30:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwyqRzrqdmt6mSw8F1TISW3RDhJuVWNHY3lY/ou1l4KKPFruQUAGgW3P4b4WhUkqDohG+UKOA==
X-Received: by 2002:a05:600c:2c49:b0:384:7202:358e with SMTP id
 r9-20020a05600c2c4900b003847202358emr7429060wmg.108.1646829040356; 
 Wed, 09 Mar 2022 04:30:40 -0800 (PST)
Received: from redhat.com ([2.55.24.184]) by smtp.gmail.com with ESMTPSA id
 m18-20020a05600c3b1200b003899d242c3asm5123290wms.44.2022.03.09.04.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Mar 2022 04:30:39 -0800 (PST)
Date: Wed, 9 Mar 2022 07:30:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH V3 05/10] virtio-pci: harden INTX interrupts
Message-ID: <20220309071710-mutt-send-email-mst@kernel.org>
References: <20211019070152.8236-1-jasowang@redhat.com>
 <20211019070152.8236-6-jasowang@redhat.com>
 <87wnh3z9nm.wl-maz@kernel.org>
 <20220309060703-mutt-send-email-mst@kernel.org>
 <87tuc7z5k9.wl-maz@kernel.org>
MIME-Version: 1.0
In-Reply-To: <87tuc7z5k9.wl-maz@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: keirf@google.com, "Paul E . McKenney" <paulmck@kernel.org>,
 david.kaplan@amd.com, konrad.wilk@oracle.com,
 Peter Zijlstra <peterz@infradead.org>, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>
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

On Wed, Mar 09, 2022 at 12:14:14PM +0000, Marc Zyngier wrote:
> On Wed, 09 Mar 2022 11:27:42 +0000,
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > On Wed, Mar 09, 2022 at 10:45:49AM +0000, Marc Zyngier wrote:
> > > [Adding Will to check on my understanding of the interactions between
> > >  spinlocks and WRITE_ONCE()]
> > > 
> > > On Tue, 19 Oct 2021 08:01:47 +0100,
> > > Jason Wang <jasowang@redhat.com> wrote:
> > > > 
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
> > > >  drivers/virtio/virtio_pci_common.c | 23 +++++++++++++++++++++--
> > > >  drivers/virtio/virtio_pci_common.h |  1 +
> > > >  2 files changed, 22 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > > index 8d8f83aca721..1bce254a462a 100644
> > > > --- a/drivers/virtio/virtio_pci_common.c
> > > > +++ b/drivers/virtio/virtio_pci_common.c
> > > > @@ -30,8 +30,16 @@ void vp_disable_cbs(struct virtio_device *vdev)
> > > >  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > >  	int i;
> > > >  
> > > > -	if (vp_dev->intx_enabled)
> > > > +	if (vp_dev->intx_enabled) {
> > > > +		/*
> > > > +		 * The below synchronize() guarantees that any
> > > > +		 * interrupt for this line arriving after
> > > > +		 * synchronize_irq() has completed is guaranteed to see
> > > > +		 * intx_soft_enabled == false.
> > > > +		 */
> > > > +		WRITE_ONCE(vp_dev->intx_soft_enabled, false);
> > > >  		synchronize_irq(vp_dev->pci_dev->irq);
> > > > +	}
> > > >  
> > > >  	for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > >  		disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > @@ -43,8 +51,16 @@ void vp_enable_cbs(struct virtio_device *vdev)
> > > >  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > >  	int i;
> > > >  
> > > > -	if (vp_dev->intx_enabled)
> > > > +	if (vp_dev->intx_enabled) {
> > > > +		disable_irq(vp_dev->pci_dev->irq);
> > > > +		/*
> > > > +		 * The above disable_irq() provides TSO ordering and
> > > > +		 * as such promotes the below store to store-release.
> > > > +		 */
> > > > +		WRITE_ONCE(vp_dev->intx_soft_enabled, true);
> > > 
> > > What do you mean by TSO here? AFAICT, the CPU is allowed hoist this
> > > write up into the lock used by disable_irq(), as the unlock only has
> > > release semantics. Is that what you are relying on? I don't see how
> > > this upgrades WRITE_ONCE() to have release semantics.
> > > 
> > > > +		enable_irq(vp_dev->pci_dev->irq);
> > > 
> > > Same thing does here: my understanding is that the write can be pushed
> > > down into the lock, which has acquire semantics only.
> > > 
> > > Thanks,
> > > 
> > > 	M.
> > 
> > Overall I feel what we are doing here is very standard and should be
> > pretty common for a driver that wants to be protected against a
> > malicious device:
> > 
> > 
> > 1- get IRQ
> > 2- initialize device with IRQ
> > 3- enable IRQ
> > 
> > Doing it in the core kernel helps make sure interrupts are
> > not lost if they trigger during 2.
> 
> But this isn't the core kernel. You're doing that in some random
> driver (and even more, only for the PCI version of that driver).


Oh, I'm answering on the INTX patch. I was referring to the MSIX
path actually. Yes INTX can not currently start in disabled state
because it's shared.


> > 
> > Without core kernel support one has to refactor the driver along the lines of:
> > 
> > a- initialize driver
> > b- get IRQ
> > c- initialize device with IRQ
> > 
> > and this is often tricky especially if one wants to do things like
> > discover device configuration and reconfigure the driver accordingly.
> 
> But this isn't what this patch is about, is it? You are just tracking
> whether interrupts are enabled or not. To which my reply to you on the
> previous patch still applies (this is the wrong place to track such
> state).

It's not that we care. What we need is to make sure that interrupts sent
before driver is ready to accept them do not cause a callback.
If there was a way to tell kernel "I'm ready to accept callbacks now"
problem would be solved.



> You also haven't answered my question: what are your ordering
> expectations wrt the WRITE_ONCE() above? The comment says 'TSO', and I
> don't really understand how this is enforced.
> 
> Thanks,
> 
> 	M.

It's based on Peter's suggestion:
https://lore.kernel.org/r/YUCBZjjk77q8JS4f%40hirez.programming.kicks-ass.net


> -- 
> Without deviation from the norm, progress is not possible.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
