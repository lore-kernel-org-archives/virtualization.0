Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB3AC433EF
	for <virtualization@archiver.kernel.org>; Mon, 27 Jun 2022 02:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E1B6D40BC5;
	Mon, 27 Jun 2022 02:50:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E1B6D40BC5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dmAfLFQ7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A8HY4EAddwao; Mon, 27 Jun 2022 02:50:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1A94D400F2;
	Mon, 27 Jun 2022 02:50:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1A94D400F2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5120C007A;
	Mon, 27 Jun 2022 02:50:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD65AC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 02:50:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8398182B1E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 02:50:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8398182B1E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dmAfLFQ7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i02agt1sbCfp
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 02:50:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F0E6828DA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6F0E6828DA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 02:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656298232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=biN1ia1/BQslLYkymJMJ0pnjqHIpxR4UA9N5HO9QFXs=;
 b=dmAfLFQ7jwfZ1yMDaSzIvJBwCZi/zH3HTz8fOYRBUQFkr5CIQj5lFlrZwYpbZzspp/QXkF
 tGc6qmgnO8+ephCxEO7+NzTpJZs4u8YDd44wZ+q/NU23bA9w1UnIMVAAabM8RrH1fAkJ07
 0gCz9p2JdPnYuL2LyrqEOLydLPdEm4o=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-duL3g6_EO0u9OACUXQ7zCg-1; Sun, 26 Jun 2022 22:50:30 -0400
X-MC-Unique: duL3g6_EO0u9OACUXQ7zCg-1
Received: by mail-lf1-f71.google.com with SMTP id
 r28-20020ac25c1c000000b004809e9d21e5so2751630lfp.18
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Jun 2022 19:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=biN1ia1/BQslLYkymJMJ0pnjqHIpxR4UA9N5HO9QFXs=;
 b=h4jDaiKMeJs+XiEOvrF71qLWmBIDWyvvvllLyIXykzPZKSXeYRT3P9qxcJUnGfNGk7
 fdN+pszkq/p4BqwOwoH4001Oy5AzgInY7QzBV062aop2blZGGxFYMT/j0mig4i04U0cy
 E53Pk2nGJm9mSSKrGbvDqWpFiPmmR2qknRFzvheeokbstFqvxZkJnFBypbEbfan10vfF
 62v91llf4ARqQtKe5NR2jsDvjc6o6+EwSCZk+PSwJLAbxYTSG87gja1P/q9N5gnT32vL
 brrcm1NvOb/D2uxD2kay60D298V1bdDNcxJEq/rZVWQEo/Qqz8lyAebulgpfyZhTHZ5P
 KGrA==
X-Gm-Message-State: AJIora8PMFkgAykhjWX4LTuNOUi3HO2IxqMoOtUAFlcv+02vLt8x2MHB
 UwPYNCOpmuTjm0GHUCPPDeWjtFxUp+ysBCpO6Zrkq3wgQoKiqza7LXLKtFGz7/c8mhAGdZYGffV
 Dw/a3MGKZCdiH0liD9rgHuo1ftUQlPsVx51gTcKm0lwyVK7KsGXFM62cPoQ==
X-Received: by 2002:a05:6512:158d:b0:47f:718c:28b5 with SMTP id
 bp13-20020a056512158d00b0047f718c28b5mr7251018lfb.397.1656298228911; 
 Sun, 26 Jun 2022 19:50:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ulCpLKIjQVszdgxVzjALf9iZpks66eBcENKIOyoL8+jUQn7V87hzr7NV3Fmj3jrJlmXUV/mhE9ythg/IWkCgA=
X-Received: by 2002:a05:6512:158d:b0:47f:718c:28b5 with SMTP id
 bp13-20020a056512158d00b0047f718c28b5mr7250996lfb.397.1656298228615; Sun, 26
 Jun 2022 19:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220622012940.21441-1-jasowang@redhat.com>
 <20220622025047-mutt-send-email-mst@kernel.org>
 <CACGkMEtJY2ioD0L8ifTrCPatG6-NqQ01V=d2L1FeoweKV74LaA@mail.gmail.com>
 <20220624022622-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220624022622-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 Jun 2022 10:50:17 +0800
Message-ID: <CACGkMEuurobpUWmDL8zmZ6T6Ygc0OEMx6vx2EDCSoGNnZQ0r-w@mail.gmail.com>
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

On Fri, Jun 24, 2022 at 2:31 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jun 22, 2022 at 03:09:31PM +0800, Jason Wang wrote:
> > On Wed, Jun 22, 2022 at 3:03 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Wed, Jun 22, 2022 at 09:29:40AM +0800, Jason Wang wrote:
> > > > We try to harden virtio device notifications in 8b4ec69d7e09 ("virtio:
> > > > harden vring IRQ"). It works with the assumption that the driver or
> > > > core can properly call virtio_device_ready() at the right
> > > > place. Unfortunately, this seems to be not true and uncover various
> > > > bugs of the existing drivers, mainly the issue of using
> > > > virtio_device_ready() incorrectly.
> > > >
> > > > So let's having a Kconfig option and disable it by default. It gives
> > > > us a breath to fix the drivers and then we can consider to enable it
> > > > by default.
> > > >
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >
> > >
> > > OK I will queue, but I think the problem is fundamental.
> >
> > If I understand correctly, you want some core IRQ work?
>
> Yes.
>
> > As discussed
> > before, it doesn't solve all the problems, we still need to do per
> > driver audit.
> >
> > Thanks
>
> Maybe, but we don't need to tie things to device_ready then.
> We can do
>
> - disable irqs
> - device ready
> - setup everything
> - enable irqs
>
>
> and this works for most things, the only issue is
> this deadlocks if "setup everything" waits for interrupts.
>
>
> With the current approach there's really no good time:
> 1.- setup everything
> - device ready
>
> can cause kicks before device is ready
>
> 2.- device ready
> - setup everything
>
> can cause callbacks before setup.
>
> So I prefer the 1. and fix the hardening in the core.

So my question is:

1) do similar hardening like config interrupt
or
2) per transport notification work (e.g for PCI core IRQ work)

1) seems easier and universal, but we pay little overhead which could
be eliminated by the config option.
2) seems require more work in the IRQ core and it can not work for all
transports (e.g vDPA would be kind of difficult)

Thanks

>
>
> > >
> > >
> > > > ---
> > > > Changes since V2:
> > > > - Tweak the Kconfig help
> > > > - Add comment for the read_lock() pairing in virtio_ccw
> > > > ---
> > > >  drivers/s390/virtio/virtio_ccw.c |  9 ++++++++-
> > > >  drivers/virtio/Kconfig           | 13 +++++++++++++
> > > >  drivers/virtio/virtio.c          |  2 ++
> > > >  drivers/virtio/virtio_ring.c     | 12 ++++++++++++
> > > >  include/linux/virtio_config.h    |  2 ++
> > > >  5 files changed, 37 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > > > index 97e51c34e6cf..1f6a358f65f0 100644
> > > > --- a/drivers/s390/virtio/virtio_ccw.c
> > > > +++ b/drivers/s390/virtio/virtio_ccw.c
> > > > @@ -1136,8 +1136,13 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> > > >                       vcdev->err = -EIO;
> > > >       }
> > > >       virtio_ccw_check_activity(vcdev, activity);
> > > > -     /* Interrupts are disabled here */
> > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > +     /*
> > > > +      * Paried with virtio_ccw_synchronize_cbs() and interrupts are
> > > > +      * disabled here.
> > > > +      */
> > > >       read_lock(&vcdev->irq_lock);
> > > > +#endif
> > > >       for_each_set_bit(i, indicators(vcdev),
> > > >                        sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
> > > >               /* The bit clear must happen before the vring kick. */
> > > > @@ -1146,7 +1151,9 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> > > >               vq = virtio_ccw_vq_by_ind(vcdev, i);
> > > >               vring_interrupt(0, vq);
> > > >       }
> > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > >       read_unlock(&vcdev->irq_lock);
> > > > +#endif
> > > >       if (test_bit(0, indicators2(vcdev))) {
> > > >               virtio_config_changed(&vcdev->vdev);
> > > >               clear_bit(0, indicators2(vcdev));
> > > > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > > > index b5adf6abd241..c04f370a1e5c 100644
> > > > --- a/drivers/virtio/Kconfig
> > > > +++ b/drivers/virtio/Kconfig
> > > > @@ -35,6 +35,19 @@ menuconfig VIRTIO_MENU
> > > >
> > > >  if VIRTIO_MENU
> > > >
> > > > +config VIRTIO_HARDEN_NOTIFICATION
> > > > +        bool "Harden virtio notification"
> > > > +        help
> > > > +          Enable this to harden the device notifications and suppress
> > > > +          those that happen at a time where notifications are illegal.
> > > > +
> > > > +          Experimental: Note that several drivers still have bugs that
> > > > +          may cause crashes or hangs when correct handling of
> > > > +          notifications is enforced; depending on the subset of
> > > > +          drivers and devices you use, this may or may not work.
> > > > +
> > > > +          If unsure, say N.
> > > > +
> > > >  config VIRTIO_PCI
> > > >       tristate "PCI driver for virtio devices"
> > > >       depends on PCI
> > > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > > index ef04a96942bf..21dc08d2f32d 100644
> > > > --- a/drivers/virtio/virtio.c
> > > > +++ b/drivers/virtio/virtio.c
> > > > @@ -220,6 +220,7 @@ static int virtio_features_ok(struct virtio_device *dev)
> > > >   * */
> > > >  void virtio_reset_device(struct virtio_device *dev)
> > > >  {
> > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > >       /*
> > > >        * The below virtio_synchronize_cbs() guarantees that any
> > > >        * interrupt for this line arriving after
> > > > @@ -228,6 +229,7 @@ void virtio_reset_device(struct virtio_device *dev)
> > > >        */
> > > >       virtio_break_device(dev);
> > > >       virtio_synchronize_cbs(dev);
> > > > +#endif
> > > >
> > > >       dev->config->reset(dev);
> > > >  }
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > index 13a7348cedff..d9d3b6e201fb 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -1688,7 +1688,11 @@ static struct virtqueue *vring_create_virtqueue_packed(
> > > >       vq->we_own_ring = true;
> > > >       vq->notify = notify;
> > > >       vq->weak_barriers = weak_barriers;
> > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > >       vq->broken = true;
> > > > +#else
> > > > +     vq->broken = false;
> > > > +#endif
> > > >       vq->last_used_idx = 0;
> > > >       vq->event_triggered = false;
> > > >       vq->num_added = 0;
> > > > @@ -2135,9 +2139,13 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> > > >       }
> > > >
> > > >       if (unlikely(vq->broken)) {
> > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > >               dev_warn_once(&vq->vq.vdev->dev,
> > > >                             "virtio vring IRQ raised before DRIVER_OK");
> > > >               return IRQ_NONE;
> > > > +#else
> > > > +             return IRQ_HANDLED;
> > > > +#endif
> > > >       }
> > > >
> > > >       /* Just a hint for performance: so it's ok that this can be racy! */
> > > > @@ -2180,7 +2188,11 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> > > >       vq->we_own_ring = false;
> > > >       vq->notify = notify;
> > > >       vq->weak_barriers = weak_barriers;
> > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > >       vq->broken = true;
> > > > +#else
> > > > +     vq->broken = false;
> > > > +#endif
> > > >       vq->last_used_idx = 0;
> > > >       vq->event_triggered = false;
> > > >       vq->num_added = 0;
> > > > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > > > index 9a36051ceb76..d15c3cdda2d2 100644
> > > > --- a/include/linux/virtio_config.h
> > > > +++ b/include/linux/virtio_config.h
> > > > @@ -257,6 +257,7 @@ void virtio_device_ready(struct virtio_device *dev)
> > > >
> > > >       WARN_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> > > >
> > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > >       /*
> > > >        * The virtio_synchronize_cbs() makes sure vring_interrupt()
> > > >        * will see the driver specific setup if it sees vq->broken
> > > > @@ -264,6 +265,7 @@ void virtio_device_ready(struct virtio_device *dev)
> > > >        */
> > > >       virtio_synchronize_cbs(dev);
> > > >       __virtio_unbreak_device(dev);
> > > > +#endif
> > > >       /*
> > > >        * The transport should ensure the visibility of vq->broken
> > > >        * before setting DRIVER_OK. See the comments for the transport
> > > > --
> > > > 2.25.1
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
