Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1E5C433EF
	for <virtualization@archiver.kernel.org>; Wed, 29 Jun 2022 07:15:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C26BE833CD;
	Wed, 29 Jun 2022 07:15:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C26BE833CD
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fS4xt6XC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A8EAJS3proao; Wed, 29 Jun 2022 07:15:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 12974812B1;
	Wed, 29 Jun 2022 07:15:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 12974812B1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEC11C0039;
	Wed, 29 Jun 2022 07:15:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB207C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 07:15:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A6172415A7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 07:15:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A6172415A7
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fS4xt6XC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qc17NzyzaY0Z
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 07:15:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1E3DD4081F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1E3DD4081F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 07:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656486917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yxaIGjt/4YMOZg4WjQlEh9o2Sctvt7eqfm3ZD+2F0lo=;
 b=fS4xt6XCF11EyeQOu+yMa9oYFqml0DPZmVC8zwNqBnS8abi9bjwXrJjbh6sdB1voI7SrKv
 gSXOxnerdPjpmDvI2jOEw4kP/qyoLKZjhkmwbhsTqn5n4LpruAV+z8M7Tui18oYy050nyt
 4C9kBgNNCkqryMYkRAtCEuYzYVKn2p0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-sLAZvX6XODmSoicW9YhBig-1; Wed, 29 Jun 2022 03:15:16 -0400
X-MC-Unique: sLAZvX6XODmSoicW9YhBig-1
Received: by mail-wm1-f72.google.com with SMTP id
 t20-20020a1c7714000000b003a032360873so9467859wmi.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 00:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yxaIGjt/4YMOZg4WjQlEh9o2Sctvt7eqfm3ZD+2F0lo=;
 b=q5He/t5xXtXPSq6wNEarsKwSNHVw+M06MXgCmzfrW/9nTqNugSZihV5HNHEfc8qZmK
 jym2u/EJXjrFv5mu+/U/i8udjVKOkZS3520npaat1pmwF8we4u78pidWb20oZmfJrNgX
 kt5yz+BBbBXvryRGigkt0w+rIfwLJdkVlTbqcgkLZjAdUhxnAW6xV+1bttLteb5tvJqY
 rUozL/YFCYy8INyW84CYbzC6NlVWWTaKRZYOx4Dgty+Wl77t2m936z1JKxFBWZbwdk5j
 lS4ZU6sdAK74h+GnPOnJ8MWK9n0cAFaSpVI+74DlVaPNplnA1vlfFHA8bb6hTFClr7E0
 aFlg==
X-Gm-Message-State: AJIora+Zyuo8FeiGGZgSezmpCpg95Vu5vNrIaF9xbRreS7jD7eS77Mbd
 Ie+93f++ehPevjuOLootDTdRl417nsYd/Q7yOcVXsdVfYsYDrvBkNWQDFy1ssqLW7+4OfGf/KFO
 v/x0JJeLA2SeNFrpvPcOI/AFSJeohmUyQZXTVUeE4ww==
X-Received: by 2002:a05:600c:3542:b0:3a1:6855:1153 with SMTP id
 i2-20020a05600c354200b003a168551153mr1702703wmq.121.1656486915060; 
 Wed, 29 Jun 2022 00:15:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tpClGQvlBrnG+3cY/I3Shi+z3wdCHGxIqznCCwszS9iYsWm4igce/0pKeAuj4JN2pzhuyLJw==
X-Received: by 2002:a05:600c:3542:b0:3a1:6855:1153 with SMTP id
 i2-20020a05600c354200b003a168551153mr1702662wmq.121.1656486914525; 
 Wed, 29 Jun 2022 00:15:14 -0700 (PDT)
Received: from redhat.com ([2.52.23.204]) by smtp.gmail.com with ESMTPSA id
 h13-20020adff4cd000000b002103aebe8absm15585352wrp.93.2022.06.29.00.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jun 2022 00:15:14 -0700 (PDT)
Date: Wed, 29 Jun 2022 03:15:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3] virtio: disable notification hardening by default
Message-ID: <20220629030600-mutt-send-email-mst@kernel.org>
References: <CACGkMEuurobpUWmDL8zmZ6T6Ygc0OEMx6vx2EDCSoGNnZQ0r-w@mail.gmail.com>
 <20220627024049-mutt-send-email-mst@kernel.org>
 <CACGkMEvrDXDN7FH1vKoYCob2rkxUsctE_=g61kzHSZ8tNNr6vA@mail.gmail.com>
 <20220627053820-mutt-send-email-mst@kernel.org>
 <CACGkMEvcs+9_SHmO1s3nyzgU7oq7jhU2gircVVR3KDsGDikh5Q@mail.gmail.com>
 <20220628004614-mutt-send-email-mst@kernel.org>
 <CACGkMEsC4A+3WejLSOZoH3enXtai=+JyRNbxcpzK4vODYzhaFw@mail.gmail.com>
 <CACGkMEvu0D0XD7udz0ebVjNM0h5+K9Rjd-5ed=PY_+-aduzG2g@mail.gmail.com>
 <20220629022223-mutt-send-email-mst@kernel.org>
 <CACGkMEuwvzkbPUSFueCOjit7pRJ81v3-W3SZD+7jQJN8btEFdg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuwvzkbPUSFueCOjit7pRJ81v3-W3SZD+7jQJN8btEFdg@mail.gmail.com>
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

On Wed, Jun 29, 2022 at 03:02:21PM +0800, Jason Wang wrote:
> On Wed, Jun 29, 2022 at 2:31 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jun 29, 2022 at 12:07:11PM +0800, Jason Wang wrote:
> > > On Tue, Jun 28, 2022 at 2:17 PM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Tue, Jun 28, 2022 at 1:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Tue, Jun 28, 2022 at 11:49:12AM +0800, Jason Wang wrote:
> > > > > > > Heh. Yea sure. But things work fine for people. What is the chance
> > > > > > > your review found and fixed all driver bugs?
> > > > > >
> > > > > > I don't/can't audit all bugs but the race between open/close against
> > > > > > ready/reset. It looks to me a good chance to fix them all but if you
> > > > > > think differently, let me know
> > > > > >
> > > > > > > After two attempts
> > > > > > > I don't feel like hoping audit will fix all bugs.
> > > > > >
> > > > > > I've started the auditing and have 15+ patches in the queue. (only
> > > > > > covers bluetooth, console, pmem, virtio-net and caif). Spotting the
> > > > > > issue is not hard but the testing, It would take at least the time of
> > > > > > one release to finalize I guess.
> > > > >
> > > > > Absolutely. So I am looking for a way to implement hardening that does
> > > > > not break existing drivers.
> > > >
> > > > I totally agree with you to seek a way without bothering the drivers.
> > > > Just wonder if this is possbile.
> > > >
> > > > >
> > > > >
> > > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > The reason config was kind of easy is that config interrupt is rarely
> > > > > > > > > vital for device function so arbitrarily deferring that does not lead to
> > > > > > > > > deadlocks - what you are trying to do with VQ interrupts is
> > > > > > > > > fundamentally different. Things are especially bad if we just drop
> > > > > > > > > an interrupt but deferring can lead to problems too.
> > > > > > > >
> > > > > > > > I'm not sure I see the difference, disable_irq() stuffs also delay the
> > > > > > > > interrupt processing until enable_irq().
> > > > > > >
> > > > > > >
> > > > > > > Absolutely. I am not at all sure disable_irq fixes all problems.
> > > > > > >
> > > > > > > > >
> > > > > > > > > Consider as an example
> > > > > > > > >     virtio-net: fix race between ndo_open() and virtio_device_ready()
> > > > > > > > > if you just defer vq interrupts you get deadlocks.
> > > > > > > > >
> > > > > > > > >
> > > > > > > >
> > > > > > > > I don't see a deadlock here, maybe you can show more detail on this?
> > > > > > >
> > > > > > > What I mean is this: if we revert the above commit, things still
> > > > > > > work (out of spec, but still). If we revert and defer interrupts until
> > > > > > > device ready then ndo_open that triggers before device ready deadlocks.
> > > > > >
> > > > > > Ok, I guess you meant on a hypervisor that is strictly written with spec.
> > > > >
> > > > > I mean on hypervisor that starts processing queues after getting a kick
> > > > > even without DRIVER_OK.
> > > >
> > > > Oh right.
> > > >
> > > > >
> > > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > So, thinking about all this, how about a simple per vq flag meaning
> > > > > > > > > "this vq was kicked since reset"?
> > > > > > > >
> > > > > > > > And ignore the notification if vq is not kicked? It sounds like the
> > > > > > > > callback needs to be synchronized with the kick.
> > > > > > >
> > > > > > > Note we only need to synchronize it when it changes, which is
> > > > > > > only during initialization and reset.
> > > > > >
> > > > > > Yes.
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > If driver does not kick then it's not ready to get callbacks, right?
> > > > > > > > >
> > > > > > > > > Sounds quite clean, but we need to think through memory ordering
> > > > > > > > > concerns - I guess it's only when we change the value so
> > > > > > > > >         if (!vq->kicked) {
> > > > > > > > >                 vq->kicked = true;
> > > > > > > > >                 mb();
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > > > will do the trick, right?
> > > > > > > >
> > > > > > > > There's no much difference with the existing approach:
> > > > > > > >
> > > > > > > > 1) your proposal implicitly makes callbacks ready in virtqueue_kick()
> > > > > > > > 2) my proposal explicitly makes callbacks ready via virtio_device_ready()
> > > > > > > >
> > > > > > > > Both require careful auditing of all the existing drivers to make sure
> > > > > > > > no kick before DRIVER_OK.
> > > > > > >
> > > > > > > Jason, kick before DRIVER_OK is out of spec, sure. But it is unrelated
> > > > > > > to hardening
> > > > > >
> > > > > > Yes but with your proposal, it seems to couple kick with DRIVER_OK somehow.
> > > > >
> > > > > I don't see how - my proposal ignores DRIVER_OK issues.
> > > >
> > > > Yes, what I meant is, in your proposal, the first kick after rest is a
> > > > hint that the driver is ok (but actually it could not).
> > > >
> > > > >
> > > > > > > and in absence of config interrupts is generally easily
> > > > > > > fixed just by sticking virtio_device_ready early in initialization.
> > > > > >
> > > > > > So if the kick is done before the subsystem registration, there's
> > > > > > still a window in the middle (assuming we stick virtio_device_ready()
> > > > > > early):
> > > > > >
> > > > > > virtio_device_ready()
> > > > > > virtqueue_kick()
> > > > > > /* the window */
> > > > > > subsystem_registration()
> > > > >
> > > > > Absolutely, however, I do not think we really have many such drivers
> > > > > since this has been known as a wrong thing to do since the beginning.
> > > > > Want to try to find any?
> > > >
> > > > Yes, let me try and update.
> > >
> > > This is basically the device that have an RX queue, so I've found the
> > > following drivers:
> > >
> > > scmi, mac80211_hwsim, vsock, bt, balloon.
> >
> > Looked and I don't see it yet. Let's consider
> > ./net/vmw_vsock/virtio_transport.c for example. Assuming we block
> > callbacks until the first kick, what is the issue with probe exactly?
> 
> We need to make sure the callback can survive when it runs before sub
> system registration.

With my proposal no - only if we also kick before registration.
So I do not see the issue yet.

Consider ./net/vmw_vsock/virtio_transport.c

kicks: virtio_transport_send_pkt_work,
virtio_vsock_rx_fill, virtio_vsock_event_fill

which of these triggers before we are ready to
handle callbacks?


> >
> >
> > > >
> > > > >I couldn't ... except maybe bluetooth
> > > > > but that's just maintainer nacking fixes saying he'll fix it
> > > > > his way ...
> > > > >
> > > > > > And during remove(), we get another window:
> > > > > >
> > > > > > subsysrem_unregistration()
> > > > > > /* the window */
> > > > > > virtio_device_reset()
> > > > >
> > > > > Same here.
> > >
> > > Basically for the drivers that set driver_ok before registration,
> >
> > I don't see what does driver_ok have to do with it.
> 
> I meant for those driver, in probe they do()
> 
> virtio_device_ready()
> subsystem_register()
> 
> In remove() they do
> 
> subsystem_unregister()
> virtio_device_reset()
> 
> for symmetry

Let's leave remove alone for now. I am close to 100% sure we have *lots*
of issues around it, but while probe is unavoidable remove can be
avoided by blocking hotplug.


> >
> > > so
> > > we have a lot:
> > >
> > > blk, net, mac80211_hwsim, scsi, vsock, bt, crypto, gpio, gpu, i2c,
> > > iommu, caif, pmem, input, mem
> > >
> > > So I think there's no easy way to harden the notification without
> > > auditing the driver one by one (especially considering the driver may
> > > use bh or workqueue). The problem is the notification hardening
> > > depends on a correct or race-free probe/remove. So we need to fix the
> > > issues in probe/remove then do the hardening on the notification.
> > >
> > > Thanks
> >
> > So if drivers kick but are not ready to get callbacks then let's fix
> > that first of all, these are racy with existing qemu even ignoring
> > spec compliance.
> 
> Yes, (the patches I've posted so far exist even with a well-behaved device).
> 
> Thanks

patches you posted deal with DRIVER_OK spec compliance.
I do not see patches for kicks before callbacks are ready to run.

> >
> >
> > --
> > MST
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
