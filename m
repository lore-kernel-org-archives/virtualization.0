Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB1DCCA479
	for <virtualization@archiver.kernel.org>; Tue, 28 Jun 2022 05:00:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7D89414C3;
	Tue, 28 Jun 2022 05:00:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B7D89414C3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MHx6VDGo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z1_4iM1hfzdp; Tue, 28 Jun 2022 05:00:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4125F4090F;
	Tue, 28 Jun 2022 05:00:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4125F4090F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3E1CC0032;
	Tue, 28 Jun 2022 05:00:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3523C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 05:00:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8F2A140131
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 05:00:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F2A140131
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MHx6VDGo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u8TOymKcbE00
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 04:59:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1622A40017
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1622A40017
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 04:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656392397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rqJ8Mz0V7iRvMVf+6k/sAc03NgI1TMhH5ELxao1WVAc=;
 b=MHx6VDGopxzqT1rOLgolFKZ/fdXwuX6lOsgtdZ51qDtwd4FStFwXF4muq1PKV26hv/LB4+
 nhsF1aXv+m7RgCpoxWpAHqsz5FROXWq4xkZWPlD1q4AeUGkVO+e0Aj0cx5KQDXKvrD+Xv7
 gmFVdvrG0u2mbbtJUIIw2sJtoeH3LTI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-dT7MEB9JNUCzKT651rrURA-1; Tue, 28 Jun 2022 00:59:56 -0400
X-MC-Unique: dT7MEB9JNUCzKT651rrURA-1
Received: by mail-wm1-f70.google.com with SMTP id
 j19-20020a05600c191300b003a048196712so3316891wmq.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 21:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rqJ8Mz0V7iRvMVf+6k/sAc03NgI1TMhH5ELxao1WVAc=;
 b=pTlZx6PO+yu6STa4TYfr4nFfzxwHn9ARpNIWxWNEy9b1/CEJhxfgmv6UWRnZT8zm5u
 2S8EkKfUAqyptwo9KCKIOSenBWmFIJk+AAsPllcGcIvo9/QODYpPmSUaPt4KHUynN5WD
 1p86epmikL9jFZKTnkfrcdrOuAvJiPwvTn6Vh4dC6nbDcS7e7ObBG8qGfDQEbtN0bIQo
 kPrEAmduqs2OP9PFvWQ1M1zd/UVyQfyUNeT9ujxooiomic6SVS23spN0pA8mo4JyLdgY
 MNefxQ7BpJ16oj57oCh7kObs0QWn4m92hYbZN610e4MYSfhzHHJvOk3BEgYlRmMoMUXP
 4quw==
X-Gm-Message-State: AJIora+Bus+r349eNPakpyIRH6ITTS0w156zFydVgSmeZgowjgXn6xKA
 BfmCogpwwb1QJGPvbQNfJIIK3NhfO14BYiJHk1ldBaJKLhhIKNCqvt9FrvgWQspaMVRk0Lx7dAe
 jLEACKkR60hsf2QcBfZdbn5k2eDPYOyOQH+12t+A7LA==
X-Received: by 2002:a5d:6d08:0:b0:21b:bb1b:d5f9 with SMTP id
 e8-20020a5d6d08000000b0021bbb1bd5f9mr15370956wrq.524.1656392395245; 
 Mon, 27 Jun 2022 21:59:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v5yeHYISO0OaJrwRMvUMWb+n4e0V/SE1C0cIYlqxwrXacB6/VsoXWc+4rQto2Jj4E0j1ZU9A==
X-Received: by 2002:a5d:6d08:0:b0:21b:bb1b:d5f9 with SMTP id
 e8-20020a5d6d08000000b0021bbb1bd5f9mr15370938wrq.524.1656392394907; 
 Mon, 27 Jun 2022 21:59:54 -0700 (PDT)
Received: from redhat.com ([2.52.23.204]) by smtp.gmail.com with ESMTPSA id
 i6-20020adfe486000000b0021b892f4b35sm12660358wrm.98.2022.06.27.21.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jun 2022 21:59:54 -0700 (PDT)
Date: Tue, 28 Jun 2022 00:59:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3] virtio: disable notification hardening by default
Message-ID: <20220628004614-mutt-send-email-mst@kernel.org>
References: <20220622012940.21441-1-jasowang@redhat.com>
 <20220622025047-mutt-send-email-mst@kernel.org>
 <CACGkMEtJY2ioD0L8ifTrCPatG6-NqQ01V=d2L1FeoweKV74LaA@mail.gmail.com>
 <20220624022622-mutt-send-email-mst@kernel.org>
 <CACGkMEuurobpUWmDL8zmZ6T6Ygc0OEMx6vx2EDCSoGNnZQ0r-w@mail.gmail.com>
 <20220627024049-mutt-send-email-mst@kernel.org>
 <CACGkMEvrDXDN7FH1vKoYCob2rkxUsctE_=g61kzHSZ8tNNr6vA@mail.gmail.com>
 <20220627053820-mutt-send-email-mst@kernel.org>
 <CACGkMEvcs+9_SHmO1s3nyzgU7oq7jhU2gircVVR3KDsGDikh5Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvcs+9_SHmO1s3nyzgU7oq7jhU2gircVVR3KDsGDikh5Q@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, kvm <kvm@vger.kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Ben Hutchings <ben@decadent.org.uk>
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

On Tue, Jun 28, 2022 at 11:49:12AM +0800, Jason Wang wrote:
> > Heh. Yea sure. But things work fine for people. What is the chance
> > your review found and fixed all driver bugs?
> 
> I don't/can't audit all bugs but the race between open/close against
> ready/reset. It looks to me a good chance to fix them all but if you
> think differently, let me know
> 
> > After two attempts
> > I don't feel like hoping audit will fix all bugs.
> 
> I've started the auditing and have 15+ patches in the queue. (only
> covers bluetooth, console, pmem, virtio-net and caif). Spotting the
> issue is not hard but the testing, It would take at least the time of
> one release to finalize I guess.

Absolutely. So I am looking for a way to implement hardening that does
not break existing drivers.


> >
> >
> > > >
> > > > The reason config was kind of easy is that config interrupt is rarely
> > > > vital for device function so arbitrarily deferring that does not lead to
> > > > deadlocks - what you are trying to do with VQ interrupts is
> > > > fundamentally different. Things are especially bad if we just drop
> > > > an interrupt but deferring can lead to problems too.
> > >
> > > I'm not sure I see the difference, disable_irq() stuffs also delay the
> > > interrupt processing until enable_irq().
> >
> >
> > Absolutely. I am not at all sure disable_irq fixes all problems.
> >
> > > >
> > > > Consider as an example
> > > >     virtio-net: fix race between ndo_open() and virtio_device_ready()
> > > > if you just defer vq interrupts you get deadlocks.
> > > >
> > > >
> > >
> > > I don't see a deadlock here, maybe you can show more detail on this?
> >
> > What I mean is this: if we revert the above commit, things still
> > work (out of spec, but still). If we revert and defer interrupts until
> > device ready then ndo_open that triggers before device ready deadlocks.
> 
> Ok, I guess you meant on a hypervisor that is strictly written with spec.

I mean on hypervisor that starts processing queues after getting a kick
even without DRIVER_OK.

> >
> >
> > > >
> > > > So, thinking about all this, how about a simple per vq flag meaning
> > > > "this vq was kicked since reset"?
> > >
> > > And ignore the notification if vq is not kicked? It sounds like the
> > > callback needs to be synchronized with the kick.
> >
> > Note we only need to synchronize it when it changes, which is
> > only during initialization and reset.
> 
> Yes.
> 
> >
> >
> > > >
> > > > If driver does not kick then it's not ready to get callbacks, right?
> > > >
> > > > Sounds quite clean, but we need to think through memory ordering
> > > > concerns - I guess it's only when we change the value so
> > > >         if (!vq->kicked) {
> > > >                 vq->kicked = true;
> > > >                 mb();
> > > >         }
> > > >
> > > > will do the trick, right?
> > >
> > > There's no much difference with the existing approach:
> > >
> > > 1) your proposal implicitly makes callbacks ready in virtqueue_kick()
> > > 2) my proposal explicitly makes callbacks ready via virtio_device_ready()
> > >
> > > Both require careful auditing of all the existing drivers to make sure
> > > no kick before DRIVER_OK.
> >
> > Jason, kick before DRIVER_OK is out of spec, sure. But it is unrelated
> > to hardening
> 
> Yes but with your proposal, it seems to couple kick with DRIVER_OK somehow.

I don't see how - my proposal ignores DRIVER_OK issues.

> > and in absence of config interrupts is generally easily
> > fixed just by sticking virtio_device_ready early in initialization.
> 
> So if the kick is done before the subsystem registration, there's
> still a window in the middle (assuming we stick virtio_device_ready()
> early):
> 
> virtio_device_ready()
> virtqueue_kick()
> /* the window */
> subsystem_registration()

Absolutely, however, I do not think we really have many such drivers
since this has been known as a wrong thing to do since the beginning.
Want to try to find any? I couldn't ... except maybe bluetooth
but that's just maintainer nacking fixes saying he'll fix it
his way ...

> And during remove(), we get another window:
> 
> subsysrem_unregistration()
> /* the window */
> virtio_device_reset()

Same here.

> if we do reset before, we may end up with other issues like deadlock.
> 
> So I think it's probably very hard to fix issues only at the virtio
> core since we need subsystem specific knowledge to make sure
> everything is synchronized.

How many drivers do you see with the issue above?
As compared to yours which has 16 patches just in your queue.

> > With the current approach one has to *also* not do virtio_device_ready
> > too early - and it's really tricky.
> 
> Not sure how much we differ here, during the probe driver can just
> place the virtio_device_ready() after the kick.

Not so easy. For example, consider virtio net without your
locking change. kick is part of a command vq operation
which does not directly have anything to do with probe.
Same for many other devices - once you register,
linux can send commands immediately.
Yes we can invent per device flags and locking rules to
try and suppress commands until device_ready. I am not
all that happy with this idea to be frank ...


> >
> > With the proposal I think that we don't need to fix all drivers and
> > in my eyes that is a huge advantage because frankly I'm fine with
> > more work on strict spec compliance taking more than expected
> > but I would like the hardening work to finally be done.
> 
> Ok, but what I meant is, with your proposal if a buggy drive kicks
> before DRIVER_OK, it suppresses the effect of hardening?

I don't see how. DRIVER_OK is for device's benefit, guest does not need
it.

> > I am not sure the amount of effort expended on the hardening here is
> > proportionate to the benefit it provides.
> 
> Probably, but we received those bug reports from the confidential
> computing guys.
> 
> Or can we choose to go another way, let the kconfig option enabled for
> TDX/SEV, and then fix the bugs only if it is reported?

Nah that's really fragmenting out userbase.

> >
> >
> >
> > > >
> > > > need to think about the reset path - it already synchronizes callbacks
> > > > and already can lose interrupts so we just need to clear vq->kicked
> > > > before that, right?
> > >
> > > Probably.
> > >
> > > >
> > > >
> > > > > 2) seems require more work in the IRQ core and it can not work for all
> > > > > transports (e.g vDPA would be kind of difficult)
> > > > >
> > > > > Thanks
> > > >
> > > > Hmm I don't really get why would it be difficult.
> > > > VDPA is mostly PCI isn't it? With PCI both level INT#x and edge MSI
> > > > have interrupt masking support.
> > >
> > > Yes, but consider the case of mlx5_vdpa, PCI stuff was hidden under
> > > the auxiliary bus. And that is the way another vendor will go.
> > >
> > > Thanks
> >
> > A bunch of callbacks will do it I guess.
> 
> Possible but looks like a layer violation, I think auxiliary stuff
> wants to hide the underlayer architecture. That is why I tend to do it
> in the virtio core. And actually, transport is freed to implement
> another layer of those synchronization if it wants.
> 
> Thanks

As usual a level of indirection will help with layering.

> >
> > > >
> > > >
> > > > > >
> > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > > ---
> > > > > > > > > Changes since V2:
> > > > > > > > > - Tweak the Kconfig help
> > > > > > > > > - Add comment for the read_lock() pairing in virtio_ccw
> > > > > > > > > ---
> > > > > > > > >  drivers/s390/virtio/virtio_ccw.c |  9 ++++++++-
> > > > > > > > >  drivers/virtio/Kconfig           | 13 +++++++++++++
> > > > > > > > >  drivers/virtio/virtio.c          |  2 ++
> > > > > > > > >  drivers/virtio/virtio_ring.c     | 12 ++++++++++++
> > > > > > > > >  include/linux/virtio_config.h    |  2 ++
> > > > > > > > >  5 files changed, 37 insertions(+), 1 deletion(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > > > > > > > > index 97e51c34e6cf..1f6a358f65f0 100644
> > > > > > > > > --- a/drivers/s390/virtio/virtio_ccw.c
> > > > > > > > > +++ b/drivers/s390/virtio/virtio_ccw.c
> > > > > > > > > @@ -1136,8 +1136,13 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> > > > > > > > >                       vcdev->err = -EIO;
> > > > > > > > >       }
> > > > > > > > >       virtio_ccw_check_activity(vcdev, activity);
> > > > > > > > > -     /* Interrupts are disabled here */
> > > > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > > > > +     /*
> > > > > > > > > +      * Paried with virtio_ccw_synchronize_cbs() and interrupts are
> > > > > > > > > +      * disabled here.
> > > > > > > > > +      */
> > > > > > > > >       read_lock(&vcdev->irq_lock);
> > > > > > > > > +#endif
> > > > > > > > >       for_each_set_bit(i, indicators(vcdev),
> > > > > > > > >                        sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
> > > > > > > > >               /* The bit clear must happen before the vring kick. */
> > > > > > > > > @@ -1146,7 +1151,9 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> > > > > > > > >               vq = virtio_ccw_vq_by_ind(vcdev, i);
> > > > > > > > >               vring_interrupt(0, vq);
> > > > > > > > >       }
> > > > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > > > >       read_unlock(&vcdev->irq_lock);
> > > > > > > > > +#endif
> > > > > > > > >       if (test_bit(0, indicators2(vcdev))) {
> > > > > > > > >               virtio_config_changed(&vcdev->vdev);
> > > > > > > > >               clear_bit(0, indicators2(vcdev));
> > > > > > > > > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > > > > > > > > index b5adf6abd241..c04f370a1e5c 100644
> > > > > > > > > --- a/drivers/virtio/Kconfig
> > > > > > > > > +++ b/drivers/virtio/Kconfig
> > > > > > > > > @@ -35,6 +35,19 @@ menuconfig VIRTIO_MENU
> > > > > > > > >
> > > > > > > > >  if VIRTIO_MENU
> > > > > > > > >
> > > > > > > > > +config VIRTIO_HARDEN_NOTIFICATION
> > > > > > > > > +        bool "Harden virtio notification"
> > > > > > > > > +        help
> > > > > > > > > +          Enable this to harden the device notifications and suppress
> > > > > > > > > +          those that happen at a time where notifications are illegal.
> > > > > > > > > +
> > > > > > > > > +          Experimental: Note that several drivers still have bugs that
> > > > > > > > > +          may cause crashes or hangs when correct handling of
> > > > > > > > > +          notifications is enforced; depending on the subset of
> > > > > > > > > +          drivers and devices you use, this may or may not work.
> > > > > > > > > +
> > > > > > > > > +          If unsure, say N.
> > > > > > > > > +
> > > > > > > > >  config VIRTIO_PCI
> > > > > > > > >       tristate "PCI driver for virtio devices"
> > > > > > > > >       depends on PCI
> > > > > > > > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > > > > > > > index ef04a96942bf..21dc08d2f32d 100644
> > > > > > > > > --- a/drivers/virtio/virtio.c
> > > > > > > > > +++ b/drivers/virtio/virtio.c
> > > > > > > > > @@ -220,6 +220,7 @@ static int virtio_features_ok(struct virtio_device *dev)
> > > > > > > > >   * */
> > > > > > > > >  void virtio_reset_device(struct virtio_device *dev)
> > > > > > > > >  {
> > > > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > > > >       /*
> > > > > > > > >        * The below virtio_synchronize_cbs() guarantees that any
> > > > > > > > >        * interrupt for this line arriving after
> > > > > > > > > @@ -228,6 +229,7 @@ void virtio_reset_device(struct virtio_device *dev)
> > > > > > > > >        */
> > > > > > > > >       virtio_break_device(dev);
> > > > > > > > >       virtio_synchronize_cbs(dev);
> > > > > > > > > +#endif
> > > > > > > > >
> > > > > > > > >       dev->config->reset(dev);
> > > > > > > > >  }
> > > > > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > > > > index 13a7348cedff..d9d3b6e201fb 100644
> > > > > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > > > > @@ -1688,7 +1688,11 @@ static struct virtqueue *vring_create_virtqueue_packed(
> > > > > > > > >       vq->we_own_ring = true;
> > > > > > > > >       vq->notify = notify;
> > > > > > > > >       vq->weak_barriers = weak_barriers;
> > > > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > > > >       vq->broken = true;
> > > > > > > > > +#else
> > > > > > > > > +     vq->broken = false;
> > > > > > > > > +#endif
> > > > > > > > >       vq->last_used_idx = 0;
> > > > > > > > >       vq->event_triggered = false;
> > > > > > > > >       vq->num_added = 0;
> > > > > > > > > @@ -2135,9 +2139,13 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> > > > > > > > >       }
> > > > > > > > >
> > > > > > > > >       if (unlikely(vq->broken)) {
> > > > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > > > >               dev_warn_once(&vq->vq.vdev->dev,
> > > > > > > > >                             "virtio vring IRQ raised before DRIVER_OK");
> > > > > > > > >               return IRQ_NONE;
> > > > > > > > > +#else
> > > > > > > > > +             return IRQ_HANDLED;
> > > > > > > > > +#endif
> > > > > > > > >       }
> > > > > > > > >
> > > > > > > > >       /* Just a hint for performance: so it's ok that this can be racy! */
> > > > > > > > > @@ -2180,7 +2188,11 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> > > > > > > > >       vq->we_own_ring = false;
> > > > > > > > >       vq->notify = notify;
> > > > > > > > >       vq->weak_barriers = weak_barriers;
> > > > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > > > >       vq->broken = true;
> > > > > > > > > +#else
> > > > > > > > > +     vq->broken = false;
> > > > > > > > > +#endif
> > > > > > > > >       vq->last_used_idx = 0;
> > > > > > > > >       vq->event_triggered = false;
> > > > > > > > >       vq->num_added = 0;
> > > > > > > > > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > > > > > > > > index 9a36051ceb76..d15c3cdda2d2 100644
> > > > > > > > > --- a/include/linux/virtio_config.h
> > > > > > > > > +++ b/include/linux/virtio_config.h
> > > > > > > > > @@ -257,6 +257,7 @@ void virtio_device_ready(struct virtio_device *dev)
> > > > > > > > >
> > > > > > > > >       WARN_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> > > > > > > > >
> > > > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > > > >       /*
> > > > > > > > >        * The virtio_synchronize_cbs() makes sure vring_interrupt()
> > > > > > > > >        * will see the driver specific setup if it sees vq->broken
> > > > > > > > > @@ -264,6 +265,7 @@ void virtio_device_ready(struct virtio_device *dev)
> > > > > > > > >        */
> > > > > > > > >       virtio_synchronize_cbs(dev);
> > > > > > > > >       __virtio_unbreak_device(dev);
> > > > > > > > > +#endif
> > > > > > > > >       /*
> > > > > > > > >        * The transport should ensure the visibility of vq->broken
> > > > > > > > >        * before setting DRIVER_OK. See the comments for the transport
> > > > > > > > > --
> > > > > > > > > 2.25.1
> > > > > > > >
> > > > > >
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
