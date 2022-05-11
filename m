Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B0EC433EF
	for <virtualization@archiver.kernel.org>; Wed, 11 May 2022 02:40:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0D85831F5;
	Wed, 11 May 2022 02:40:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RlCVgxpYU7pc; Wed, 11 May 2022 02:40:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5B98481343;
	Wed, 11 May 2022 02:40:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32349C0032;
	Wed, 11 May 2022 02:40:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A078FC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 02:40:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9C2264017A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 02:40:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id apU2uy1weRWg
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 02:40:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B20E04011F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 02:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652236825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4rsScbuPuNJutA0AJwuwsA+ysprCiaTZ/68Y1lfAnjY=;
 b=jHBPqCSTfMrOcvKYiM0amDZvtmg2qEgQ5Uul7HgAcDO3Ze9A6LnUQad1hpMODAGYDinzyR
 cSKAO9nkRxbZYwpb1vrnMpKSvVYAGlSAWE8yMs1r++ov9BSzkR6t6E09iJwoz9nGTN9GJD
 2E9lF3v7I2t+cJRJhbbt2QlSPLc8npE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-LgPIHaUXOJ6IGrWm951EmQ-1; Tue, 10 May 2022 22:40:24 -0400
X-MC-Unique: LgPIHaUXOJ6IGrWm951EmQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 l19-20020ac24313000000b004739dbba717so288244lfh.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 19:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4rsScbuPuNJutA0AJwuwsA+ysprCiaTZ/68Y1lfAnjY=;
 b=WqeF2VQGAkQTaBaGDzm7tkzQJIoa7MyEwHUHIQtHaR6dSVQeAkx8vTu8eiCZSBzfb5
 EhT/JvBQIUBaDPvwISiLglfvhgPg7Uv9g9OH9gh31C6xVrbf3bBTBYwfCD4n8tl2so8j
 9295bGyvb7lYcnhVfy+jUoP5vmww5IA1SHqM296RiOBWWss1NOgbciCm5gqZofH+q0rX
 cJDTxnj9BEZMkwEp7ipnS2uX4Vykk1ljoI9CHQT2EqOMYv5NkkwePXapEe3g2HGPTUT4
 KyP0GdZ06Vd7BMAXvcwSnSRMnqbv/j56QbYXmo88K0xuEqw+54rea+NZHsZu2/3yCmV1
 7ZaQ==
X-Gm-Message-State: AOAM533FHraqSvO7zvY8mKx9DSHau0Rh3hfiQ3w2BHpjBZP8vnWxqSCe
 HxlS9e1D75Go//TRS/1b5pNfJ9I5gXhzuljPiG68HibAJJqidw6GKqR3rM+usHvEzW8YiP2H2/t
 m8YCAbAVzLalX9X2ISCI4AOaIq4jaxTvr5PHmRP+HBtpPfWIp/WViFUulhw==
X-Received: by 2002:a05:6512:33d0:b0:473:a25e:f9fb with SMTP id
 d16-20020a05651233d000b00473a25ef9fbmr18536568lfg.98.1652236822581; 
 Tue, 10 May 2022 19:40:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXPhsS7aZArFqRm1KQv3WcIM3fpOGbBNyqmSsuzU0vfQIcoWpVROQBx3w5Yryj7t+vM1cSBoexVRWIu8KK29c=
X-Received: by 2002:a05:6512:33d0:b0:473:a25e:f9fb with SMTP id
 d16-20020a05651233d000b00473a25ef9fbmr18536556lfg.98.1652236822393; Tue, 10
 May 2022 19:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220507071954.14455-1-jasowang@redhat.com>
 <20220507071954.14455-9-jasowang@redhat.com>
 <20220510072833-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220510072833-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 May 2022 10:40:11 +0800
Message-ID: <CACGkMEtBfdhx-9CMKD0F4+536e5ewf6NQJGPTEBX00uby-C8+w@mail.gmail.com>
Subject: Re: [PATCH V4 8/9] virtio: harden vring IRQ
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Cindy Lu <lulu@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, eperezma <eperezma@redhat.com>,
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

On Tue, May 10, 2022 at 7:32 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sat, May 07, 2022 at 03:19:53PM +0800, Jason Wang wrote:
> > This is a rework on the previous IRQ hardening that is done for
> > virtio-pci where several drawbacks were found and were reverted:
> >
> > 1) try to use IRQF_NO_AUTOEN which is not friendly to affinity managed IRQ
> >    that is used by some device such as virtio-blk
> > 2) done only for PCI transport
> >
> > The vq->broken is re-used in this patch for implementing the IRQ
> > hardening. The vq->broken is set to true during both initialization
> > and reset. And the vq->broken is set to false in
> > virtio_device_ready(). Then vring_interrupt can check and return when
> > vq->broken is true. And in this case, switch to return IRQ_NONE to let
> > the interrupt core aware of such invalid interrupt to prevent IRQ
> > storm.
> >
> > The reason of using a per queue variable instead of a per device one
> > is that we may need it for per queue reset hardening in the future.
> >
> > Note that the hardening is only done for vring interrupt since the
> > config interrupt hardening is already done in commit 22b7050a024d7
> > ("virtio: defer config changed notifications"). But the method that is
> > used by config interrupt can't be reused by the vring interrupt
> > handler because it uses spinlock to do the synchronization which is
> > expensive.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Halil Pasic <pasic@linux.ibm.com>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio.c       | 15 ++++++++++++---
> >  drivers/virtio/virtio_ring.c  | 11 +++++++----
> >  include/linux/virtio_config.h | 12 ++++++++++++
> >  3 files changed, 31 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index 8dde44ea044a..696f5ba4f38e 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -220,6 +220,15 @@ static int virtio_features_ok(struct virtio_device *dev)
> >   * */
> >  void virtio_reset_device(struct virtio_device *dev)
> >  {
> > +     /*
> > +      * The below virtio_synchronize_cbs() guarantees that any
> > +      * interrupt for this line arriving after
> > +      * virtio_synchronize_vqs() has completed is guaranteed to see
> > +      * driver_ready == false.
> > +      */
> > +     virtio_break_device(dev);
> > +     virtio_synchronize_cbs(dev);
> > +
> >       dev->config->reset(dev);
> >  }
> >  EXPORT_SYMBOL_GPL(virtio_reset_device);
> > @@ -428,6 +437,9 @@ int register_virtio_device(struct virtio_device *dev)
> >       dev->config_enabled = false;
> >       dev->config_change_pending = false;
> >
> > +     INIT_LIST_HEAD(&dev->vqs);
> > +     spin_lock_init(&dev->vqs_list_lock);
> > +
> >       /* We always start by resetting the device, in case a previous
> >        * driver messed it up.  This also tests that code path a little. */
> >       virtio_reset_device(dev);
> > @@ -435,9 +447,6 @@ int register_virtio_device(struct virtio_device *dev)
> >       /* Acknowledge that we've seen the device. */
> >       virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> >
> > -     INIT_LIST_HEAD(&dev->vqs);
> > -     spin_lock_init(&dev->vqs_list_lock);
> > -
> >       /*
> >        * device_add() causes the bus infrastructure to look for a matching
> >        * driver.
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 5b7df7c455f0..9dfad2890d7a 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1690,7 +1690,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >       vq->we_own_ring = true;
> >       vq->notify = notify;
> >       vq->weak_barriers = weak_barriers;
> > -     vq->broken = false;
> > +     vq->broken = true;
> >       vq->last_used_idx = 0;
> >       vq->event_triggered = false;
> >       vq->num_added = 0;
> > @@ -2136,8 +2136,11 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> >               return IRQ_NONE;
> >       }
> >
> > -     if (unlikely(vq->broken))
> > -             return IRQ_HANDLED;
> > +     if (unlikely(vq->broken)) {
> > +             dev_warn_once(&vq->vq.vdev->dev,
> > +                           "virtio vring IRQ raised before DRIVER_OK");
> > +             return IRQ_NONE;
> > +     }
> >
> >       /* Just a hint for performance: so it's ok that this can be racy! */
> >       if (vq->event)
> > @@ -2179,7 +2182,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> >       vq->we_own_ring = false;
> >       vq->notify = notify;
> >       vq->weak_barriers = weak_barriers;
> > -     vq->broken = false;
> > +     vq->broken = true;
> >       vq->last_used_idx = 0;
> >       vq->event_triggered = false;
> >       vq->num_added = 0;
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > index d8a2340f928e..23f1694cdbd5 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -256,6 +256,18 @@ void virtio_device_ready(struct virtio_device *dev)
> >       unsigned status = dev->config->get_status(dev);
> >
> >       BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> > +
> > +     /*
> > +      * The virtio_synchronize_cbs() makes sure vring_interrupt()
> > +      * will see the driver specific setup if it sees vq->broken
> > +      * as false.
> > +      */
> > +     virtio_synchronize_cbs(dev);
>
> since you mention vq->broken above, maybe add
>         "set vq->broken to false"

Ok.

>
> > +     __virtio_unbreak_device(dev);
> > +     /*
> > +      * The transport is expected ensure the visibility of
>
> to ensure

Will fix.

>
> > +      * vq->broken
>
> let's add: "visibility by vq callbacks"

Sure.

>
> > before setting VIRTIO_CONFIG_S_DRIVER_OK.
> > +      */
>
>
> Can I see some analysis of existing transports showing
> this is actually the case for them?

Yes.

> And maybe add a comment near set_status to document the
> requirement.

For PCI and MMIO, we can quote the memory-barriers.txt or explain that
wmb() is not needed before the MMIO writel().
For CCW, it looks not obvious, it looks to me the IO was submitted via
__ssch() which has an inline assembly.  Cornelia and Hali, could you
help me to understand if and how did virtio_ccw_set_status() can
ensure the visibility of the previous driver setup and vq->broken
here?

Thanks

>
> >       dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
> >  }
> >
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
