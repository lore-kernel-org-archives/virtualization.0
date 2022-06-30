Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFB9CCA47E
	for <virtualization@archiver.kernel.org>; Thu, 30 Jun 2022 08:38:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9FD25401D2;
	Thu, 30 Jun 2022 08:38:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9FD25401D2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WUVLC4vb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CW3yh7evZpBg; Thu, 30 Jun 2022 08:38:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5648A40232;
	Thu, 30 Jun 2022 08:38:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5648A40232
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E76EC0021;
	Thu, 30 Jun 2022 08:38:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3ED60C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 08:38:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 14C7F844CE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 08:38:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 14C7F844CE
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WUVLC4vb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cgnLe6XYgpUw
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 08:38:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ACF8E82553
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ACF8E82553
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 08:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656578324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6WRm3fy0BcnwI+eUjjLUjBr4KAT2RKMxDsER6An9Fd0=;
 b=WUVLC4vb0WSno0HsWrFbrjHzw3mPiVqW3XvwERpfTPhg3TMglC0eaFCDy5ZeYZKkaHT4jB
 +bWBVL132/q3I40gDHpG+EZ/wMnxzgF6mUxaZ0hw/w6NhT8Ygjleo5CSy8xWmbG5zCAOeo
 bZCXTqmr/djNoV0Muhb3oCu8/4nXMYY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-zFx34uqIOxKEmRRmNQsCoA-1; Thu, 30 Jun 2022 04:38:42 -0400
X-MC-Unique: zFx34uqIOxKEmRRmNQsCoA-1
Received: by mail-wm1-f71.google.com with SMTP id
 6-20020a1c0206000000b003a02cd754d1so7665497wmc.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 01:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6WRm3fy0BcnwI+eUjjLUjBr4KAT2RKMxDsER6An9Fd0=;
 b=F6rq5TvTZWJu9PD671K6dq7Ix67Ug6PUuDyaiF2xkA8FzMZ4S3bsFy8rK8F68V+3I7
 9ONNNwY5+ObCllc4zecMrO63y3UsjNbw5NetE/tL9IV4VB614k4nOHcV7bX3CgDNjPGC
 gPiNwGfzvz3DmR719yhBHRDzboLcadj9veQes6T5CN4A5HhX/in5pM5rW7iI2b9CFIu+
 kf/xCMw5+jRmPSyYrz5qsv2GC4VdGe1A6vkQB1TV1wg92NXjlAhGzJySwsN0pBvfabTl
 QaoD6I03x3uEHz2B/G/cx9Rs7QUO2RHIzO/8hqNWhaa2ww+2vGd9iojflljb6bUCxYhy
 TkoA==
X-Gm-Message-State: AJIora9ksnxFDdZBYpTQqXIxkw04Q491089WagtPtrsY0kdWrv07nAci
 OzIAee1u8NuQwa2N3tBgFQ3BQOAFXWgmi+oov0rSAThYSkW3z5xt7PxvoPcZtQyPPAaMiPxQHtb
 fwm7gSXzVH40zJdwpjdfl9KpZlKOt/cysESCoQvs+vA==
X-Received: by 2002:a5d:648a:0:b0:21d:2cd8:8b87 with SMTP id
 o10-20020a5d648a000000b0021d2cd88b87mr6207554wri.241.1656578321492; 
 Thu, 30 Jun 2022 01:38:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uB84dWCFdhoY44YSl6bFb5ed+fxro/40jg+eh3ILhMT4LSSay2jdLu2/BfAO2TW+O++ICTBA==
X-Received: by 2002:a5d:648a:0:b0:21d:2cd8:8b87 with SMTP id
 o10-20020a5d648a000000b0021d2cd88b87mr6207525wri.241.1656578321151; 
 Thu, 30 Jun 2022 01:38:41 -0700 (PDT)
Received: from redhat.com ([2.55.3.188]) by smtp.gmail.com with ESMTPSA id
 j22-20020a05600c1c1600b003a046549a85sm1869077wms.37.2022.06.30.01.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jun 2022 01:38:40 -0700 (PDT)
Date: Thu, 30 Jun 2022 04:38:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3] virtio: disable notification hardening by default
Message-ID: <20220630043219-mutt-send-email-mst@kernel.org>
References: <CACGkMEvcs+9_SHmO1s3nyzgU7oq7jhU2gircVVR3KDsGDikh5Q@mail.gmail.com>
 <20220628004614-mutt-send-email-mst@kernel.org>
 <CACGkMEsC4A+3WejLSOZoH3enXtai=+JyRNbxcpzK4vODYzhaFw@mail.gmail.com>
 <CACGkMEvu0D0XD7udz0ebVjNM0h5+K9Rjd-5ed=PY_+-aduzG2g@mail.gmail.com>
 <20220629022223-mutt-send-email-mst@kernel.org>
 <CACGkMEuwvzkbPUSFueCOjit7pRJ81v3-W3SZD+7jQJN8btEFdg@mail.gmail.com>
 <20220629030600-mutt-send-email-mst@kernel.org>
 <CACGkMEvnUj622FyROUftifSB47wytPg0YAdVO7fdRQmCE+WuBg@mail.gmail.com>
 <20220629044514-mutt-send-email-mst@kernel.org>
 <CACGkMEsW02a1LeiWwUgHfVmDEnC8i49h1L7qHmeoLyJyRS6-zA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsW02a1LeiWwUgHfVmDEnC8i49h1L7qHmeoLyJyRS6-zA@mail.gmail.com>
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

On Thu, Jun 30, 2022 at 10:01:16AM +0800, Jason Wang wrote:
> On Wed, Jun 29, 2022 at 4:52 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jun 29, 2022 at 04:34:36PM +0800, Jason Wang wrote:
> > > On Wed, Jun 29, 2022 at 3:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Wed, Jun 29, 2022 at 03:02:21PM +0800, Jason Wang wrote:
> > > > > On Wed, Jun 29, 2022 at 2:31 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Wed, Jun 29, 2022 at 12:07:11PM +0800, Jason Wang wrote:
> > > > > > > On Tue, Jun 28, 2022 at 2:17 PM Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Jun 28, 2022 at 1:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Jun 28, 2022 at 11:49:12AM +0800, Jason Wang wrote:
> > > > > > > > > > > Heh. Yea sure. But things work fine for people. What is the chance
> > > > > > > > > > > your review found and fixed all driver bugs?
> > > > > > > > > >
> > > > > > > > > > I don't/can't audit all bugs but the race between open/close against
> > > > > > > > > > ready/reset. It looks to me a good chance to fix them all but if you
> > > > > > > > > > think differently, let me know
> > > > > > > > > >
> > > > > > > > > > > After two attempts
> > > > > > > > > > > I don't feel like hoping audit will fix all bugs.
> > > > > > > > > >
> > > > > > > > > > I've started the auditing and have 15+ patches in the queue. (only
> > > > > > > > > > covers bluetooth, console, pmem, virtio-net and caif). Spotting the
> > > > > > > > > > issue is not hard but the testing, It would take at least the time of
> > > > > > > > > > one release to finalize I guess.
> > > > > > > > >
> > > > > > > > > Absolutely. So I am looking for a way to implement hardening that does
> > > > > > > > > not break existing drivers.
> > > > > > > >
> > > > > > > > I totally agree with you to seek a way without bothering the drivers.
> > > > > > > > Just wonder if this is possbile.
> > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > The reason config was kind of easy is that config interrupt is rarely
> > > > > > > > > > > > > vital for device function so arbitrarily deferring that does not lead to
> > > > > > > > > > > > > deadlocks - what you are trying to do with VQ interrupts is
> > > > > > > > > > > > > fundamentally different. Things are especially bad if we just drop
> > > > > > > > > > > > > an interrupt but deferring can lead to problems too.
> > > > > > > > > > > >
> > > > > > > > > > > > I'm not sure I see the difference, disable_irq() stuffs also delay the
> > > > > > > > > > > > interrupt processing until enable_irq().
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Absolutely. I am not at all sure disable_irq fixes all problems.
> > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > Consider as an example
> > > > > > > > > > > > >     virtio-net: fix race between ndo_open() and virtio_device_ready()
> > > > > > > > > > > > > if you just defer vq interrupts you get deadlocks.
> > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > I don't see a deadlock here, maybe you can show more detail on this?
> > > > > > > > > > >
> > > > > > > > > > > What I mean is this: if we revert the above commit, things still
> > > > > > > > > > > work (out of spec, but still). If we revert and defer interrupts until
> > > > > > > > > > > device ready then ndo_open that triggers before device ready deadlocks.
> > > > > > > > > >
> > > > > > > > > > Ok, I guess you meant on a hypervisor that is strictly written with spec.
> > > > > > > > >
> > > > > > > > > I mean on hypervisor that starts processing queues after getting a kick
> > > > > > > > > even without DRIVER_OK.
> > > > > > > >
> > > > > > > > Oh right.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > So, thinking about all this, how about a simple per vq flag meaning
> > > > > > > > > > > > > "this vq was kicked since reset"?
> > > > > > > > > > > >
> > > > > > > > > > > > And ignore the notification if vq is not kicked? It sounds like the
> > > > > > > > > > > > callback needs to be synchronized with the kick.
> > > > > > > > > > >
> > > > > > > > > > > Note we only need to synchronize it when it changes, which is
> > > > > > > > > > > only during initialization and reset.
> > > > > > > > > >
> > > > > > > > > > Yes.
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > If driver does not kick then it's not ready to get callbacks, right?
> > > > > > > > > > > > >
> > > > > > > > > > > > > Sounds quite clean, but we need to think through memory ordering
> > > > > > > > > > > > > concerns - I guess it's only when we change the value so
> > > > > > > > > > > > >         if (!vq->kicked) {
> > > > > > > > > > > > >                 vq->kicked = true;
> > > > > > > > > > > > >                 mb();
> > > > > > > > > > > > >         }
> > > > > > > > > > > > >
> > > > > > > > > > > > > will do the trick, right?
> > > > > > > > > > > >
> > > > > > > > > > > > There's no much difference with the existing approach:
> > > > > > > > > > > >
> > > > > > > > > > > > 1) your proposal implicitly makes callbacks ready in virtqueue_kick()
> > > > > > > > > > > > 2) my proposal explicitly makes callbacks ready via virtio_device_ready()
> > > > > > > > > > > >
> > > > > > > > > > > > Both require careful auditing of all the existing drivers to make sure
> > > > > > > > > > > > no kick before DRIVER_OK.
> > > > > > > > > > >
> > > > > > > > > > > Jason, kick before DRIVER_OK is out of spec, sure. But it is unrelated
> > > > > > > > > > > to hardening
> > > > > > > > > >
> > > > > > > > > > Yes but with your proposal, it seems to couple kick with DRIVER_OK somehow.
> > > > > > > > >
> > > > > > > > > I don't see how - my proposal ignores DRIVER_OK issues.
> > > > > > > >
> > > > > > > > Yes, what I meant is, in your proposal, the first kick after rest is a
> > > > > > > > hint that the driver is ok (but actually it could not).
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > > and in absence of config interrupts is generally easily
> > > > > > > > > > > fixed just by sticking virtio_device_ready early in initialization.
> > > > > > > > > >
> > > > > > > > > > So if the kick is done before the subsystem registration, there's
> > > > > > > > > > still a window in the middle (assuming we stick virtio_device_ready()
> > > > > > > > > > early):
> > > > > > > > > >
> > > > > > > > > > virtio_device_ready()
> > > > > > > > > > virtqueue_kick()
> > > > > > > > > > /* the window */
> > > > > > > > > > subsystem_registration()
> > > > > > > > >
> > > > > > > > > Absolutely, however, I do not think we really have many such drivers
> > > > > > > > > since this has been known as a wrong thing to do since the beginning.
> > > > > > > > > Want to try to find any?
> > > > > > > >
> > > > > > > > Yes, let me try and update.
> > > > > > >
> > > > > > > This is basically the device that have an RX queue, so I've found the
> > > > > > > following drivers:
> > > > > > >
> > > > > > > scmi, mac80211_hwsim, vsock, bt, balloon.
> > > > > >
> > > > > > Looked and I don't see it yet. Let's consider
> > > > > > ./net/vmw_vsock/virtio_transport.c for example. Assuming we block
> > > > > > callbacks until the first kick, what is the issue with probe exactly?
> > > > >
> > > > > We need to make sure the callback can survive when it runs before sub
> > > > > system registration.
> > > >
> > > > With my proposal no - only if we also kick before registration.
> > > > So I do not see the issue yet.
> > > >
> > > > Consider ./net/vmw_vsock/virtio_transport.c
> > > >
> > > > kicks: virtio_transport_send_pkt_work,
> > > > virtio_vsock_rx_fill, virtio_vsock_event_fill
> > > >
> > > > which of these triggers before we are ready to
> > > > handle callbacks?
> > >
> > > So:
> > >
> > > virtio_vsock_vqs_init()
> > >     virtio_device_ready()
> > >     virtio_vsock_rx_fill() /* kick there */
> > > rcu_assign_pointer(the_virtio_vsock, vsock)
> > >
> > > It means at least virtio_vsock_rx_done()/virtio_vsock_workqueue needs
> > > to survive. I don't say it has a bug but we do need to audit the code
> > > in this case. The implication is: the virtqueue callback should be
> > > written with no assumption that the driver has registered in the
> > > subsystem. We don't or can't assume all drivers are written in this
> > > way.
> >
> >
> > I thought you said you audited code and found bugs.
> >
> > My claim is that simply because qemu starts processing
> > packets immediately upon kick, if bugs like this
> > existed we would have noticed by now.
> 
> This is true for a well behaved hypervisor. But what we want to deal
> with is the buggy/malicious hypervisors.




> >
> > In this case the_virtio_vsock is used for xmit things,
> > callbacks do not seem to use it at all.
> 
> So the hypervisor can trigger the notification just after the kick and
> the work function seems to be safe.
> 
> One another example for this is in virtcons_probe():
> 
>         spin_lock_init(&portdev->ports_lock);
>         INIT_LIST_HEAD(&portdev->ports);
>         INIT_LIST_HEAD(&portdev->list);
> 
>         virtio_device_ready(portdev->vdev);
> 
>         INIT_WORK(&portdev->config_work, &config_work_handler);
>         INIT_WORK(&portdev->control_work, &control_work_handler);
> 
> in control_intr() we had:
> 
> static void control_intr(struct virtqueue *vq)
> {
>         struct ports_device *portdev;
> 
>         portdev = vq->vdev->priv;
>         schedule_work(&portdev->control_work);
> }
> 
> So we might crash if the notification is raised just after
> virtio_device_ready().

Yes! But this is not my proposal. This is yours.
Your patches block interrupts until virtio_device_ready.

My proposal is to block them until kick.

In this case kick is in fill_queue after INIT_WORK.


> This is not an exact example of when a callback is not ready after
> kick, but it demonstrates that the callback could have assumed that
> all setup has been done when it is called.
> 
> Thanks

So if there are not examples of callbacks not ready after kick
then let us block callbacks until first kick. That is my idea.


> >
> > > >
> > > >
> > > > > >
> > > > > >
> > > > > > > >
> > > > > > > > >I couldn't ... except maybe bluetooth
> > > > > > > > > but that's just maintainer nacking fixes saying he'll fix it
> > > > > > > > > his way ...
> > > > > > > > >
> > > > > > > > > > And during remove(), we get another window:
> > > > > > > > > >
> > > > > > > > > > subsysrem_unregistration()
> > > > > > > > > > /* the window */
> > > > > > > > > > virtio_device_reset()
> > > > > > > > >
> > > > > > > > > Same here.
> > > > > > >
> > > > > > > Basically for the drivers that set driver_ok before registration,
> > > > > >
> > > > > > I don't see what does driver_ok have to do with it.
> > > > >
> > > > > I meant for those driver, in probe they do()
> > > > >
> > > > > virtio_device_ready()
> > > > > subsystem_register()
> > > > >
> > > > > In remove() they do
> > > > >
> > > > > subsystem_unregister()
> > > > > virtio_device_reset()
> > > > >
> > > > > for symmetry
> > > >
> > > > Let's leave remove alone for now. I am close to 100% sure we have *lots*
> > > > of issues around it, but while probe is unavoidable remove can be
> > > > avoided by blocking hotplug.
> > >
> > > Unbind can trigger this path as well.
> > >
> > > >
> > > >
> > > > > >
> > > > > > > so
> > > > > > > we have a lot:
> > > > > > >
> > > > > > > blk, net, mac80211_hwsim, scsi, vsock, bt, crypto, gpio, gpu, i2c,
> > > > > > > iommu, caif, pmem, input, mem
> > > > > > >
> > > > > > > So I think there's no easy way to harden the notification without
> > > > > > > auditing the driver one by one (especially considering the driver may
> > > > > > > use bh or workqueue). The problem is the notification hardening
> > > > > > > depends on a correct or race-free probe/remove. So we need to fix the
> > > > > > > issues in probe/remove then do the hardening on the notification.
> > > > > > >
> > > > > > > Thanks
> > > > > >
> > > > > > So if drivers kick but are not ready to get callbacks then let's fix
> > > > > > that first of all, these are racy with existing qemu even ignoring
> > > > > > spec compliance.
> > > > >
> > > > > Yes, (the patches I've posted so far exist even with a well-behaved device).
> > > > >
> > > > > Thanks
> > > >
> > > > patches you posted deal with DRIVER_OK spec compliance.
> > > > I do not see patches for kicks before callbacks are ready to run.
> > >
> > > Yes.
> > >
> > > Thanks
> > >
> > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > MST
> > > > > >
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
