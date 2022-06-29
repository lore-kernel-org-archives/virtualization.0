Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B92FCCA47F
	for <virtualization@archiver.kernel.org>; Wed, 29 Jun 2022 08:35:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EBEC161242;
	Wed, 29 Jun 2022 08:34:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EBEC161242
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZuC6hIFx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fApN-BtrIMOh; Wed, 29 Jun 2022 08:34:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DB37061233;
	Wed, 29 Jun 2022 08:34:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB37061233
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0DF8C0032;
	Wed, 29 Jun 2022 08:34:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03BF0C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 08:34:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C35E141607
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 08:34:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C35E141607
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZuC6hIFx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id geLq0YZ2exaG
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 08:34:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 39BE3410A1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 39BE3410A1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 08:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656491694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uQ1F1gvPgdv/PjO5a7Us1uAB+fd+j8i7Rmby0EI/UmM=;
 b=ZuC6hIFxs5gOTwXpXd4mXLBr3h4IcaQdD+AysCEPSAxpZj1sE/a9d85GoCFvRWO0qhOF9x
 +ewvuwwD97N0eAqMsNb3V5zmMV1y1nugpKQT2KT0EbVUuMTQdQI/CtaYRhlesKUs9QGzd4
 xRUbuhc0vTeY1IuTma/U3uDzzVhVzrY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-Oj4IaJ5-N2mjYBLNkdjmBw-1; Wed, 29 Jun 2022 04:34:50 -0400
X-MC-Unique: Oj4IaJ5-N2mjYBLNkdjmBw-1
Received: by mail-lj1-f200.google.com with SMTP id
 c12-20020a2ebf0c000000b00258e5e6e125so2127866ljr.17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 01:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uQ1F1gvPgdv/PjO5a7Us1uAB+fd+j8i7Rmby0EI/UmM=;
 b=q8JNNbdMFdt0EnnNS5/Bb4KTGY423LeXi7olyGDo0Uk1ojG7jmXvGlh4CD+45xoaO4
 b/AQxiIfKBywEMDiTd81wESrYPYwcOcMIGsIuHkUJf37nOikI6F6bKR6K8SqAWG+ixPv
 w+O1IlX+tuZ6twGij9pkhbNma4b4EnnJ7EaDZX642EHoslDVpvy+zzHpOqE1FSRsrqFI
 EI/ePEpAdrA6LMtWRg8VEedDpxkCtRhIrH/jeAwri4s2kxXrpE6SZrj+gOv8LGz9+JOZ
 /7NRQz7uNFHPqbq2y23D5Y++XA0pt8Y3mHzlweL0J5tcdTFcYZc/hnXcFnEjdjWjqwiQ
 2UtQ==
X-Gm-Message-State: AJIora8hTeVKG6cmEuK7vQiRVsb5Ksuk+XhLgrTfPji87lHE9tYirLtn
 BIiOZKy2ICZWkzyKphxYeQvUgsnDS7Yzu51x9DHzG2PcHxoHMYEp7FMdArPGeg5gJkpXc8Ml5BG
 t3wYnFt9+FXj6EFpyXBlNSgFyUvoH58BZvjAHv+SE3dcktcm/Z4MvbDwIIw==
X-Received: by 2002:a2e:aaa5:0:b0:25b:ae57:4ad7 with SMTP id
 bj37-20020a2eaaa5000000b0025bae574ad7mr1062690ljb.323.1656491688554; 
 Wed, 29 Jun 2022 01:34:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tj3mTezqE26Ub1hg4KnGKyN1R4dLBdYBw/oW4sihfiyNn6+28TEvxAhIEfmZcYsBQyr9V7tEc2W8R79JvvvZI=
X-Received: by 2002:a2e:aaa5:0:b0:25b:ae57:4ad7 with SMTP id
 bj37-20020a2eaaa5000000b0025bae574ad7mr1062675ljb.323.1656491688283; Wed, 29
 Jun 2022 01:34:48 -0700 (PDT)
MIME-Version: 1.0
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
 <20220629030600-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220629030600-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 29 Jun 2022 16:34:36 +0800
Message-ID: <CACGkMEvnUj622FyROUftifSB47wytPg0YAdVO7fdRQmCE+WuBg@mail.gmail.com>
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

On Wed, Jun 29, 2022 at 3:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jun 29, 2022 at 03:02:21PM +0800, Jason Wang wrote:
> > On Wed, Jun 29, 2022 at 2:31 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Wed, Jun 29, 2022 at 12:07:11PM +0800, Jason Wang wrote:
> > > > On Tue, Jun 28, 2022 at 2:17 PM Jason Wang <jasowang@redhat.com> wrote:
> > > > >
> > > > > On Tue, Jun 28, 2022 at 1:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Jun 28, 2022 at 11:49:12AM +0800, Jason Wang wrote:
> > > > > > > > Heh. Yea sure. But things work fine for people. What is the chance
> > > > > > > > your review found and fixed all driver bugs?
> > > > > > >
> > > > > > > I don't/can't audit all bugs but the race between open/close against
> > > > > > > ready/reset. It looks to me a good chance to fix them all but if you
> > > > > > > think differently, let me know
> > > > > > >
> > > > > > > > After two attempts
> > > > > > > > I don't feel like hoping audit will fix all bugs.
> > > > > > >
> > > > > > > I've started the auditing and have 15+ patches in the queue. (only
> > > > > > > covers bluetooth, console, pmem, virtio-net and caif). Spotting the
> > > > > > > issue is not hard but the testing, It would take at least the time of
> > > > > > > one release to finalize I guess.
> > > > > >
> > > > > > Absolutely. So I am looking for a way to implement hardening that does
> > > > > > not break existing drivers.
> > > > >
> > > > > I totally agree with you to seek a way without bothering the drivers.
> > > > > Just wonder if this is possbile.
> > > > >
> > > > > >
> > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > The reason config was kind of easy is that config interrupt is rarely
> > > > > > > > > > vital for device function so arbitrarily deferring that does not lead to
> > > > > > > > > > deadlocks - what you are trying to do with VQ interrupts is
> > > > > > > > > > fundamentally different. Things are especially bad if we just drop
> > > > > > > > > > an interrupt but deferring can lead to problems too.
> > > > > > > > >
> > > > > > > > > I'm not sure I see the difference, disable_irq() stuffs also delay the
> > > > > > > > > interrupt processing until enable_irq().
> > > > > > > >
> > > > > > > >
> > > > > > > > Absolutely. I am not at all sure disable_irq fixes all problems.
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Consider as an example
> > > > > > > > > >     virtio-net: fix race between ndo_open() and virtio_device_ready()
> > > > > > > > > > if you just defer vq interrupts you get deadlocks.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > I don't see a deadlock here, maybe you can show more detail on this?
> > > > > > > >
> > > > > > > > What I mean is this: if we revert the above commit, things still
> > > > > > > > work (out of spec, but still). If we revert and defer interrupts until
> > > > > > > > device ready then ndo_open that triggers before device ready deadlocks.
> > > > > > >
> > > > > > > Ok, I guess you meant on a hypervisor that is strictly written with spec.
> > > > > >
> > > > > > I mean on hypervisor that starts processing queues after getting a kick
> > > > > > even without DRIVER_OK.
> > > > >
> > > > > Oh right.
> > > > >
> > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > So, thinking about all this, how about a simple per vq flag meaning
> > > > > > > > > > "this vq was kicked since reset"?
> > > > > > > > >
> > > > > > > > > And ignore the notification if vq is not kicked? It sounds like the
> > > > > > > > > callback needs to be synchronized with the kick.
> > > > > > > >
> > > > > > > > Note we only need to synchronize it when it changes, which is
> > > > > > > > only during initialization and reset.
> > > > > > >
> > > > > > > Yes.
> > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > If driver does not kick then it's not ready to get callbacks, right?
> > > > > > > > > >
> > > > > > > > > > Sounds quite clean, but we need to think through memory ordering
> > > > > > > > > > concerns - I guess it's only when we change the value so
> > > > > > > > > >         if (!vq->kicked) {
> > > > > > > > > >                 vq->kicked = true;
> > > > > > > > > >                 mb();
> > > > > > > > > >         }
> > > > > > > > > >
> > > > > > > > > > will do the trick, right?
> > > > > > > > >
> > > > > > > > > There's no much difference with the existing approach:
> > > > > > > > >
> > > > > > > > > 1) your proposal implicitly makes callbacks ready in virtqueue_kick()
> > > > > > > > > 2) my proposal explicitly makes callbacks ready via virtio_device_ready()
> > > > > > > > >
> > > > > > > > > Both require careful auditing of all the existing drivers to make sure
> > > > > > > > > no kick before DRIVER_OK.
> > > > > > > >
> > > > > > > > Jason, kick before DRIVER_OK is out of spec, sure. But it is unrelated
> > > > > > > > to hardening
> > > > > > >
> > > > > > > Yes but with your proposal, it seems to couple kick with DRIVER_OK somehow.
> > > > > >
> > > > > > I don't see how - my proposal ignores DRIVER_OK issues.
> > > > >
> > > > > Yes, what I meant is, in your proposal, the first kick after rest is a
> > > > > hint that the driver is ok (but actually it could not).
> > > > >
> > > > > >
> > > > > > > > and in absence of config interrupts is generally easily
> > > > > > > > fixed just by sticking virtio_device_ready early in initialization.
> > > > > > >
> > > > > > > So if the kick is done before the subsystem registration, there's
> > > > > > > still a window in the middle (assuming we stick virtio_device_ready()
> > > > > > > early):
> > > > > > >
> > > > > > > virtio_device_ready()
> > > > > > > virtqueue_kick()
> > > > > > > /* the window */
> > > > > > > subsystem_registration()
> > > > > >
> > > > > > Absolutely, however, I do not think we really have many such drivers
> > > > > > since this has been known as a wrong thing to do since the beginning.
> > > > > > Want to try to find any?
> > > > >
> > > > > Yes, let me try and update.
> > > >
> > > > This is basically the device that have an RX queue, so I've found the
> > > > following drivers:
> > > >
> > > > scmi, mac80211_hwsim, vsock, bt, balloon.
> > >
> > > Looked and I don't see it yet. Let's consider
> > > ./net/vmw_vsock/virtio_transport.c for example. Assuming we block
> > > callbacks until the first kick, what is the issue with probe exactly?
> >
> > We need to make sure the callback can survive when it runs before sub
> > system registration.
>
> With my proposal no - only if we also kick before registration.
> So I do not see the issue yet.
>
> Consider ./net/vmw_vsock/virtio_transport.c
>
> kicks: virtio_transport_send_pkt_work,
> virtio_vsock_rx_fill, virtio_vsock_event_fill
>
> which of these triggers before we are ready to
> handle callbacks?

So:

virtio_vsock_vqs_init()
    virtio_device_ready()
    virtio_vsock_rx_fill() /* kick there */
rcu_assign_pointer(the_virtio_vsock, vsock)

It means at least virtio_vsock_rx_done()/virtio_vsock_workqueue needs
to survive. I don't say it has a bug but we do need to audit the code
in this case. The implication is: the virtqueue callback should be
written with no assumption that the driver has registered in the
subsystem. We don't or can't assume all drivers are written in this
way.

>
>
> > >
> > >
> > > > >
> > > > > >I couldn't ... except maybe bluetooth
> > > > > > but that's just maintainer nacking fixes saying he'll fix it
> > > > > > his way ...
> > > > > >
> > > > > > > And during remove(), we get another window:
> > > > > > >
> > > > > > > subsysrem_unregistration()
> > > > > > > /* the window */
> > > > > > > virtio_device_reset()
> > > > > >
> > > > > > Same here.
> > > >
> > > > Basically for the drivers that set driver_ok before registration,
> > >
> > > I don't see what does driver_ok have to do with it.
> >
> > I meant for those driver, in probe they do()
> >
> > virtio_device_ready()
> > subsystem_register()
> >
> > In remove() they do
> >
> > subsystem_unregister()
> > virtio_device_reset()
> >
> > for symmetry
>
> Let's leave remove alone for now. I am close to 100% sure we have *lots*
> of issues around it, but while probe is unavoidable remove can be
> avoided by blocking hotplug.

Unbind can trigger this path as well.

>
>
> > >
> > > > so
> > > > we have a lot:
> > > >
> > > > blk, net, mac80211_hwsim, scsi, vsock, bt, crypto, gpio, gpu, i2c,
> > > > iommu, caif, pmem, input, mem
> > > >
> > > > So I think there's no easy way to harden the notification without
> > > > auditing the driver one by one (especially considering the driver may
> > > > use bh or workqueue). The problem is the notification hardening
> > > > depends on a correct or race-free probe/remove. So we need to fix the
> > > > issues in probe/remove then do the hardening on the notification.
> > > >
> > > > Thanks
> > >
> > > So if drivers kick but are not ready to get callbacks then let's fix
> > > that first of all, these are racy with existing qemu even ignoring
> > > spec compliance.
> >
> > Yes, (the patches I've posted so far exist even with a well-behaved device).
> >
> > Thanks
>
> patches you posted deal with DRIVER_OK spec compliance.
> I do not see patches for kicks before callbacks are ready to run.

Yes.

Thanks

>
> > >
> > >
> > > --
> > > MST
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
