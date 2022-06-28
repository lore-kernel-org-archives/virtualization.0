Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D82CC43334
	for <virtualization@archiver.kernel.org>; Tue, 28 Jun 2022 06:32:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A26A660D9C;
	Tue, 28 Jun 2022 06:32:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A26A660D9C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R9ZxOZ2Z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 31-kVOa6GlgR; Tue, 28 Jun 2022 06:32:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 89CA460C0F;
	Tue, 28 Jun 2022 06:32:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 89CA460C0F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4703FC0039;
	Tue, 28 Jun 2022 06:32:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53222C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:32:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 266B760C1D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:32:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 266B760C1D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U915q8k12upR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:32:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7777F60C0F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7777F60C0F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656397954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gpmGoo5AF3tbpF/bVoyGJVXL6ZNnSYXhh9Fg3lL2jm4=;
 b=R9ZxOZ2ZrI2xz8OlsidZT+EPOhfJu44OQ83aDAc+0Hk8WVRhMI+hMpXvr4TX6hopvAgTkO
 XPaUlVmXfee1/dxzAFWFPCleZXYKtbjf7OKhBAgcXlxuGxGgBlCnRLSY2cF9mlDVECFqtl
 XHVmQWE+snBW8ykGL4Ojj63M3lxiJA0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-sF22VhtUM5yC-BdIBalGsQ-1; Tue, 28 Jun 2022 02:32:33 -0400
X-MC-Unique: sF22VhtUM5yC-BdIBalGsQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 y8-20020ac24208000000b0047f9fc8f632so5800371lfh.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 23:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gpmGoo5AF3tbpF/bVoyGJVXL6ZNnSYXhh9Fg3lL2jm4=;
 b=iL0RT0iLiuQNMtjMxNpMvsc4TQN0OR1aYU+hqsE45CSV+LXHSkKSLOvx9e4i3FKAVb
 RMq0MIoiWj5dnFrZStT7XPR5+lEtu/XbM1wre8y6H8Bnd+xbo35mhEgm4hXyDqMEH7Xm
 uGlRGhoyKbzOu7HQgBe4tBXBKAFrFh2y1jJRNSWL/cjhIYdFhhI/c/k9wuH+4FfdrpSj
 b1XENtvLFV6z2QiCeajax2yPfY0myuNuNUfq9B3rEq0Xh1yKMxSADlAFCEp3IQyWoBHE
 K2CT/zb3xVJisMhIVySsg5VeY6Z44XCQMdjEyEl08ZiILiBEH6dIPWqFILtYoFhhoDN6
 eLyw==
X-Gm-Message-State: AJIora8BLR2GV62fD2AFgCJD8z8/S8R95cTw1LoMMfgKFJcJ8W1Wlt2r
 2FiLw2x6tOVGZU9HLAVE+VRS8J8KAXBgB2C6Zjwfu0kxDRrxwQdVBtIkE9mmzg7ZR+uxw0UCPwC
 aT2LoK34NAHjyEOHpchZh/9tZKdxOXufeaSJraGIHHoqS+SiQf16V1PKPXw==
X-Received: by 2002:a2e:aaa5:0:b0:25b:ae57:4ad7 with SMTP id
 bj37-20020a2eaaa5000000b0025bae574ad7mr8789390ljb.323.1656397951216; 
 Mon, 27 Jun 2022 23:32:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1saDznI3v2nZMm65bS3Y6PylOqa2OfmMY28kYPHLxfqrbZ+EceiqC0lE4GYRDd7yu4OOYORQrlod/aI9oFrK1c=
X-Received: by 2002:a2e:aaa5:0:b0:25b:ae57:4ad7 with SMTP id
 bj37-20020a2eaaa5000000b0025bae574ad7mr8789362ljb.323.1656397950821; Mon, 27
 Jun 2022 23:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220622025047-mutt-send-email-mst@kernel.org>
 <CACGkMEtJY2ioD0L8ifTrCPatG6-NqQ01V=d2L1FeoweKV74LaA@mail.gmail.com>
 <20220624022622-mutt-send-email-mst@kernel.org>
 <CACGkMEuurobpUWmDL8zmZ6T6Ygc0OEMx6vx2EDCSoGNnZQ0r-w@mail.gmail.com>
 <20220627024049-mutt-send-email-mst@kernel.org>
 <CACGkMEvrDXDN7FH1vKoYCob2rkxUsctE_=g61kzHSZ8tNNr6vA@mail.gmail.com>
 <20220627053820-mutt-send-email-mst@kernel.org>
 <CACGkMEvcs+9_SHmO1s3nyzgU7oq7jhU2gircVVR3KDsGDikh5Q@mail.gmail.com>
 <20220628004614-mutt-send-email-mst@kernel.org>
 <CACGkMEsC4A+3WejLSOZoH3enXtai=+JyRNbxcpzK4vODYzhaFw@mail.gmail.com>
 <20220628022035-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220628022035-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 28 Jun 2022 14:32:19 +0800
Message-ID: <CACGkMEt=go5qAH+P0to6yyE2dPhyfFmOQP0jfuj=57PmD7Y3zg@mail.gmail.com>
Subject: Re: [PATCH V3] virtio: disable notification hardening by default
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Tue, Jun 28, 2022 at 2:24 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Jun 28, 2022 at 02:17:50PM +0800, Jason Wang wrote:
> > On Tue, Jun 28, 2022 at 1:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Jun 28, 2022 at 11:49:12AM +0800, Jason Wang wrote:
> > > > > Heh. Yea sure. But things work fine for people. What is the chance
> > > > > your review found and fixed all driver bugs?
> > > >
> > > > I don't/can't audit all bugs but the race between open/close against
> > > > ready/reset. It looks to me a good chance to fix them all but if you
> > > > think differently, let me know
> > > >
> > > > > After two attempts
> > > > > I don't feel like hoping audit will fix all bugs.
> > > >
> > > > I've started the auditing and have 15+ patches in the queue. (only
> > > > covers bluetooth, console, pmem, virtio-net and caif). Spotting the
> > > > issue is not hard but the testing, It would take at least the time of
> > > > one release to finalize I guess.
> > >
> > > Absolutely. So I am looking for a way to implement hardening that does
> > > not break existing drivers.
> >
> > I totally agree with you to seek a way without bothering the drivers.
> > Just wonder if this is possbile.
> >
> > >
> > >
> > > > >
> > > > >
> > > > > > >
> > > > > > > The reason config was kind of easy is that config interrupt is rarely
> > > > > > > vital for device function so arbitrarily deferring that does not lead to
> > > > > > > deadlocks - what you are trying to do with VQ interrupts is
> > > > > > > fundamentally different. Things are especially bad if we just drop
> > > > > > > an interrupt but deferring can lead to problems too.
> > > > > >
> > > > > > I'm not sure I see the difference, disable_irq() stuffs also delay the
> > > > > > interrupt processing until enable_irq().
> > > > >
> > > > >
> > > > > Absolutely. I am not at all sure disable_irq fixes all problems.
> > > > >
> > > > > > >
> > > > > > > Consider as an example
> > > > > > >     virtio-net: fix race between ndo_open() and virtio_device_ready()
> > > > > > > if you just defer vq interrupts you get deadlocks.
> > > > > > >
> > > > > > >
> > > > > >
> > > > > > I don't see a deadlock here, maybe you can show more detail on this?
> > > > >
> > > > > What I mean is this: if we revert the above commit, things still
> > > > > work (out of spec, but still). If we revert and defer interrupts until
> > > > > device ready then ndo_open that triggers before device ready deadlocks.
> > > >
> > > > Ok, I guess you meant on a hypervisor that is strictly written with spec.
> > >
> > > I mean on hypervisor that starts processing queues after getting a kick
> > > even without DRIVER_OK.
> >
> > Oh right.
> >
> > >
> > > > >
> > > > >
> > > > > > >
> > > > > > > So, thinking about all this, how about a simple per vq flag meaning
> > > > > > > "this vq was kicked since reset"?
> > > > > >
> > > > > > And ignore the notification if vq is not kicked? It sounds like the
> > > > > > callback needs to be synchronized with the kick.
> > > > >
> > > > > Note we only need to synchronize it when it changes, which is
> > > > > only during initialization and reset.
> > > >
> > > > Yes.
> > > >
> > > > >
> > > > >
> > > > > > >
> > > > > > > If driver does not kick then it's not ready to get callbacks, right?
> > > > > > >
> > > > > > > Sounds quite clean, but we need to think through memory ordering
> > > > > > > concerns - I guess it's only when we change the value so
> > > > > > >         if (!vq->kicked) {
> > > > > > >                 vq->kicked = true;
> > > > > > >                 mb();
> > > > > > >         }
> > > > > > >
> > > > > > > will do the trick, right?
> > > > > >
> > > > > > There's no much difference with the existing approach:
> > > > > >
> > > > > > 1) your proposal implicitly makes callbacks ready in virtqueue_kick()
> > > > > > 2) my proposal explicitly makes callbacks ready via virtio_device_ready()
> > > > > >
> > > > > > Both require careful auditing of all the existing drivers to make sure
> > > > > > no kick before DRIVER_OK.
> > > > >
> > > > > Jason, kick before DRIVER_OK is out of spec, sure. But it is unrelated
> > > > > to hardening
> > > >
> > > > Yes but with your proposal, it seems to couple kick with DRIVER_OK somehow.
> > >
> > > I don't see how - my proposal ignores DRIVER_OK issues.
> >
> > Yes, what I meant is, in your proposal, the first kick after rest is a
> > hint that the driver is ok (but actually it could not).
>
> Question is are there drivers which kick before they are ready
> to handle callbacks?

Let me try to have a look at all the drivers to answer this.

>
> > >
> > > > > and in absence of config interrupts is generally easily
> > > > > fixed just by sticking virtio_device_ready early in initialization.
> > > >
> > > > So if the kick is done before the subsystem registration, there's
> > > > still a window in the middle (assuming we stick virtio_device_ready()
> > > > early):
> > > >
> > > > virtio_device_ready()
> > > > virtqueue_kick()
> > > > /* the window */
> > > > subsystem_registration()
> > >
> > > Absolutely, however, I do not think we really have many such drivers
> > > since this has been known as a wrong thing to do since the beginning.
> > > Want to try to find any?
> >
> > Yes, let me try and update.
> >
> > >I couldn't ... except maybe bluetooth
> > > but that's just maintainer nacking fixes saying he'll fix it
> > > his way ...
> > >
> > > > And during remove(), we get another window:
> > > >
> > > > subsysrem_unregistration()
> > > > /* the window */
> > > > virtio_device_reset()
> > >
> > > Same here.
> > >
> > > > if we do reset before, we may end up with other issues like deadlock.
> > > >
> > > > So I think it's probably very hard to fix issues only at the virtio
> > > > core since we need subsystem specific knowledge to make sure
> > > > everything is synchronized.
> > >
> > > How many drivers do you see with the issue above?
> >
> > E.g for virtio-net, except for the ndo_open()/driver_ok races I
> > spotted another two.
>
> two issues causing kick before DRIVER_OK? or two issues
> causing kick before driver can handle callbacks?

1) A window between netdev_unregisger() and virtio_device_reset(), tx
callbacks may came and try to wake up the TX queue
2) refill_work can still be scheduled by the rx callback after
cancel_delayed_work_sync()

>
>
> > > As compared to yours which has 16 patches just in your queue.
> > >
> > > > > With the current approach one has to *also* not do virtio_device_ready
> > > > > too early - and it's really tricky.
> > > >
> > > > Not sure how much we differ here, during the probe driver can just
> > > > place the virtio_device_ready() after the kick.
> > >
> > > Not so easy. For example, consider virtio net without your
> > > locking change. kick is part of a command vq operation
> > > which does not directly have anything to do with probe.
> > > Same for many other devices - once you register,
> > > linux can send commands immediately.
> > > Yes we can invent per device flags and locking rules to
> > > try and suppress commands until device_ready. I am not
> > > all that happy with this idea to be frank ...
> >
> > Actuall, I meant we need to depend on the subsystem facilities to
> > handle this (e.g the rtnl_lock() ndo_XYZ) instead of inventing per
> > driver flags.
>
> Yep. And that makes it very messy to handle.

But this is how other drivers use to handle those races.

>My hope is
> that for years we got callbacks right after adding buffers
> so the races have been ironed out by now.

This sounds just like what you propose here or is it something other?

Thanks

>
>
> > I believe virtio is not the only driver that suffers
> > from those races.
> > >
> > >
> > > > >
> > > > > With the proposal I think that we don't need to fix all drivers and
> > > > > in my eyes that is a huge advantage because frankly I'm fine with
> > > > > more work on strict spec compliance taking more than expected
> > > > > but I would like the hardening work to finally be done.
> > > >
> > > > Ok, but what I meant is, with your proposal if a buggy drive kicks
> > > > before DRIVER_OK, it suppresses the effect of hardening?
> > >
> > > I don't see how. DRIVER_OK is for device's benefit, guest does not need
> > > it.
> > >
> > > > > I am not sure the amount of effort expended on the hardening here is
> > > > > proportionate to the benefit it provides.
> > > >
> > > > Probably, but we received those bug reports from the confidential
> > > > computing guys.
> > > >
> > > > Or can we choose to go another way, let the kconfig option enabled for
> > > > TDX/SEV, and then fix the bugs only if it is reported?
> > >
> > > Nah that's really fragmenting out userbase.
> >
> > True.
> >
> > >
> > > > >
> > > > >
> > > > >
> > > > > > >
> > > > > > > need to think about the reset path - it already synchronizes callbacks
> > > > > > > and already can lose interrupts so we just need to clear vq->kicked
> > > > > > > before that, right?
> > > > > >
> > > > > > Probably.
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > 2) seems require more work in the IRQ core and it can not work for all
> > > > > > > > transports (e.g vDPA would be kind of difficult)
> > > > > > > >
> > > > > > > > Thanks
> > > > > > >
> > > > > > > Hmm I don't really get why would it be difficult.
> > > > > > > VDPA is mostly PCI isn't it? With PCI both level INT#x and edge MSI
> > > > > > > have interrupt masking support.
> > > > > >
> > > > > > Yes, but consider the case of mlx5_vdpa, PCI stuff was hidden under
> > > > > > the auxiliary bus. And that is the way another vendor will go.
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > A bunch of callbacks will do it I guess.
> > > >
> > > > Possible but looks like a layer violation, I think auxiliary stuff
> > > > wants to hide the underlayer architecture. That is why I tend to do it
> > > > in the virtio core. And actually, transport is freed to implement
> > > > another layer of those synchronization if it wants.
> > > >
> > > > Thanks
> > >
> > > As usual a level of indirection will help with layering.
> >
> > Probably.
> >
> > Thanks
> >
> > >
> > > > >
> > > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > ---
> > > > > > > > > > > > Changes since V2:
> > > > > > > > > > > > - Tweak the Kconfig help
> > > > > > > > > > > > - Add comment for the read_lock() pairing in virtio_ccw
> > > > > > > > > > > > ---
> > > > > > > > > > > >  drivers/s390/virtio/virtio_ccw.c |  9 ++++++++-
> > > > > > > > > > > >  drivers/virtio/Kconfig           | 13 +++++++++++++
> > > > > > > > > > > >  drivers/virtio/virtio.c          |  2 ++
> > > > > > > > > > > >  drivers/virtio/virtio_ring.c     | 12 ++++++++++++
> > > > > > > > > > > >  include/linux/virtio_config.h    |  2 ++
> > > > > > > > > > > >  5 files changed, 37 insertions(+), 1 deletion(-)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > > > > > > > > > > > index 97e51c34e6cf..1f6a358f65f0 100644
> > > > > > > > > > > > --- a/drivers/s390/virtio/virtio_ccw.c
> > > > > > > > > > > > +++ b/drivers/s390/virtio/virtio_ccw.c
> > > > > > > > > > > > @@ -1136,8 +1136,13 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> > > > > > > > > > > >                       vcdev->err = -EIO;
> > > > > > > > > > > >       }
> > > > > > > > > > > >       virtio_ccw_check_activity(vcdev, activity);
> > > > > > > > > > > > -     /* Interrupts are disabled here */
> > > > > > > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > > > > > > > +     /*
> > > > > > > > > > > > +      * Paried with virtio_ccw_synchronize_cbs() and interrupts are
> > > > > > > > > > > > +      * disabled here.
> > > > > > > > > > > > +      */
> > > > > > > > > > > >       read_lock(&vcdev->irq_lock);
> > > > > > > > > > > > +#endif
> > > > > > > > > > > >       for_each_set_bit(i, indicators(vcdev),
> > > > > > > > > > > >                        sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
> > > > > > > > > > > >               /* The bit clear must happen before the vring kick. */
> > > > > > > > > > > > @@ -1146,7 +1151,9 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> > > > > > > > > > > >               vq = virtio_ccw_vq_by_ind(vcdev, i);
> > > > > > > > > > > >               vring_interrupt(0, vq);
> > > > > > > > > > > >       }
> > > > > > > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > > > > > > >       read_unlock(&vcdev->irq_lock);
> > > > > > > > > > > > +#endif
> > > > > > > > > > > >       if (test_bit(0, indicators2(vcdev))) {
> > > > > > > > > > > >               virtio_config_changed(&vcdev->vdev);
> > > > > > > > > > > >               clear_bit(0, indicators2(vcdev));
> > > > > > > > > > > > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > > > > > > > > > > > index b5adf6abd241..c04f370a1e5c 100644
> > > > > > > > > > > > --- a/drivers/virtio/Kconfig
> > > > > > > > > > > > +++ b/drivers/virtio/Kconfig
> > > > > > > > > > > > @@ -35,6 +35,19 @@ menuconfig VIRTIO_MENU
> > > > > > > > > > > >
> > > > > > > > > > > >  if VIRTIO_MENU
> > > > > > > > > > > >
> > > > > > > > > > > > +config VIRTIO_HARDEN_NOTIFICATION
> > > > > > > > > > > > +        bool "Harden virtio notification"
> > > > > > > > > > > > +        help
> > > > > > > > > > > > +          Enable this to harden the device notifications and suppress
> > > > > > > > > > > > +          those that happen at a time where notifications are illegal.
> > > > > > > > > > > > +
> > > > > > > > > > > > +          Experimental: Note that several drivers still have bugs that
> > > > > > > > > > > > +          may cause crashes or hangs when correct handling of
> > > > > > > > > > > > +          notifications is enforced; depending on the subset of
> > > > > > > > > > > > +          drivers and devices you use, this may or may not work.
> > > > > > > > > > > > +
> > > > > > > > > > > > +          If unsure, say N.
> > > > > > > > > > > > +
> > > > > > > > > > > >  config VIRTIO_PCI
> > > > > > > > > > > >       tristate "PCI driver for virtio devices"
> > > > > > > > > > > >       depends on PCI
> > > > > > > > > > > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > > > > > > > > > > index ef04a96942bf..21dc08d2f32d 100644
> > > > > > > > > > > > --- a/drivers/virtio/virtio.c
> > > > > > > > > > > > +++ b/drivers/virtio/virtio.c
> > > > > > > > > > > > @@ -220,6 +220,7 @@ static int virtio_features_ok(struct virtio_device *dev)
> > > > > > > > > > > >   * */
> > > > > > > > > > > >  void virtio_reset_device(struct virtio_device *dev)
> > > > > > > > > > > >  {
> > > > > > > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > > > > > > >       /*
> > > > > > > > > > > >        * The below virtio_synchronize_cbs() guarantees that any
> > > > > > > > > > > >        * interrupt for this line arriving after
> > > > > > > > > > > > @@ -228,6 +229,7 @@ void virtio_reset_device(struct virtio_device *dev)
> > > > > > > > > > > >        */
> > > > > > > > > > > >       virtio_break_device(dev);
> > > > > > > > > > > >       virtio_synchronize_cbs(dev);
> > > > > > > > > > > > +#endif
> > > > > > > > > > > >
> > > > > > > > > > > >       dev->config->reset(dev);
> > > > > > > > > > > >  }
> > > > > > > > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > > > > > > > index 13a7348cedff..d9d3b6e201fb 100644
> > > > > > > > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > > > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > > > > > > > @@ -1688,7 +1688,11 @@ static struct virtqueue *vring_create_virtqueue_packed(
> > > > > > > > > > > >       vq->we_own_ring = true;
> > > > > > > > > > > >       vq->notify = notify;
> > > > > > > > > > > >       vq->weak_barriers = weak_barriers;
> > > > > > > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > > > > > > >       vq->broken = true;
> > > > > > > > > > > > +#else
> > > > > > > > > > > > +     vq->broken = false;
> > > > > > > > > > > > +#endif
> > > > > > > > > > > >       vq->last_used_idx = 0;
> > > > > > > > > > > >       vq->event_triggered = false;
> > > > > > > > > > > >       vq->num_added = 0;
> > > > > > > > > > > > @@ -2135,9 +2139,13 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> > > > > > > > > > > >       }
> > > > > > > > > > > >
> > > > > > > > > > > >       if (unlikely(vq->broken)) {
> > > > > > > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > > > > > > >               dev_warn_once(&vq->vq.vdev->dev,
> > > > > > > > > > > >                             "virtio vring IRQ raised before DRIVER_OK");
> > > > > > > > > > > >               return IRQ_NONE;
> > > > > > > > > > > > +#else
> > > > > > > > > > > > +             return IRQ_HANDLED;
> > > > > > > > > > > > +#endif
> > > > > > > > > > > >       }
> > > > > > > > > > > >
> > > > > > > > > > > >       /* Just a hint for performance: so it's ok that this can be racy! */
> > > > > > > > > > > > @@ -2180,7 +2188,11 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> > > > > > > > > > > >       vq->we_own_ring = false;
> > > > > > > > > > > >       vq->notify = notify;
> > > > > > > > > > > >       vq->weak_barriers = weak_barriers;
> > > > > > > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > > > > > > >       vq->broken = true;
> > > > > > > > > > > > +#else
> > > > > > > > > > > > +     vq->broken = false;
> > > > > > > > > > > > +#endif
> > > > > > > > > > > >       vq->last_used_idx = 0;
> > > > > > > > > > > >       vq->event_triggered = false;
> > > > > > > > > > > >       vq->num_added = 0;
> > > > > > > > > > > > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > > > > > > > > > > > index 9a36051ceb76..d15c3cdda2d2 100644
> > > > > > > > > > > > --- a/include/linux/virtio_config.h
> > > > > > > > > > > > +++ b/include/linux/virtio_config.h
> > > > > > > > > > > > @@ -257,6 +257,7 @@ void virtio_device_ready(struct virtio_device *dev)
> > > > > > > > > > > >
> > > > > > > > > > > >       WARN_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> > > > > > > > > > > >
> > > > > > > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > > > > > > >       /*
> > > > > > > > > > > >        * The virtio_synchronize_cbs() makes sure vring_interrupt()
> > > > > > > > > > > >        * will see the driver specific setup if it sees vq->broken
> > > > > > > > > > > > @@ -264,6 +265,7 @@ void virtio_device_ready(struct virtio_device *dev)
> > > > > > > > > > > >        */
> > > > > > > > > > > >       virtio_synchronize_cbs(dev);
> > > > > > > > > > > >       __virtio_unbreak_device(dev);
> > > > > > > > > > > > +#endif
> > > > > > > > > > > >       /*
> > > > > > > > > > > >        * The transport should ensure the visibility of vq->broken
> > > > > > > > > > > >        * before setting DRIVER_OK. See the comments for the transport
> > > > > > > > > > > > --
> > > > > > > > > > > > 2.25.1
> > > > > > > > > > >
> > > > > > > > >
> > > > > > >
> > > > >
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
