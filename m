Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC86C433F5
	for <virtualization@archiver.kernel.org>; Wed, 11 May 2022 02:42:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 58FE040B43;
	Wed, 11 May 2022 02:42:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nmlDb3bmPz3Y; Wed, 11 May 2022 02:42:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D45F6408DF;
	Wed, 11 May 2022 02:42:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2DCFC0032;
	Wed, 11 May 2022 02:42:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19B71C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 02:42:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0406441578
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 02:42:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ae5azJRHC-JJ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 02:42:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E33A84034F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 02:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652236930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4nGkvcvFWz+odk5yhwLYeDyIG2eWn1ClUMoDKPyJdBk=;
 b=GSklQrxnk4oJqeDhQkPUD4cW23eZuuXShA899Dudk4vcn4NGUx345Z3ONrM4+Xxs8moKOH
 vDEDUQZ+NE4rqNmgnf5VLjTA74b/gjIGl3jLOWASkp56OHnfsQDvJZOXiyX9v2BORLN+kh
 0qwnPRjlCou9+hlQcglU02xbpF7mZKo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-3CdE-TGrOia84g02GgUqKw-1; Tue, 10 May 2022 22:42:09 -0400
X-MC-Unique: 3CdE-TGrOia84g02GgUqKw-1
Received: by mail-lf1-f70.google.com with SMTP id
 m2-20020a0565120a8200b00473a809c6e0so282287lfu.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 19:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4nGkvcvFWz+odk5yhwLYeDyIG2eWn1ClUMoDKPyJdBk=;
 b=VBaZJ5DsG31wS5YK1G7MHWzLUZyDiHDGnZzDv6caiqeZKeQWDMnR+gFa7nyUh0Y3tF
 /AN1zAkbpfzu4ztLX+h1j0JwrNWLboRFxAnDVem4sUaSeozeOlqARfnKyYVQIviKOamS
 8cY1tMsOK73EQaFbYYSG7qPlC/3NqPkXKvVwtnbr5EENz2bu1zj6DXsGwx96hcFKTFub
 qUqVuv4mrUwxRtIutodvO8ylMo62eTY1i+XSIzJ1z1TX4q8ZZrLH7E2qD5K8vqZe3NrA
 f67TxZfFfDh2yrWSUW1XUIGz1VO8bq4AcpTU9iomLKLo6Qlmp5JRDWgnlaMrgEEK9viT
 yXYw==
X-Gm-Message-State: AOAM533cmY3c3UsBr5+ll1mNBFEiG6l5+rq4IVviCGuw7Lk/G5WzsL58
 qSiCKtNeCNYyqEs3xJP2ZAPv612An4WycLCfkJ7/VUds608iS1c13F4GLp5yjv5Vb8eTS7HpGGG
 0iEwK8njccjpAS00nhj4cnf/HG611P+SmDeH7lxFXCiOpfCR7srffYpbAng==
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr18230643lfj.587.1652236927994; 
 Tue, 10 May 2022 19:42:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHTIitvlKBo9gntoR+9nuIVQxt66PfDgGM8uDAMiSrYJWVeqcsjWShA2gwMUq9hVPezrkTWEGfgTI37LaNx88=
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr18230621lfj.587.1652236927813; Tue, 10
 May 2022 19:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220507071954.14455-1-jasowang@redhat.com>
 <20220507071954.14455-7-jasowang@redhat.com>
 <20220510072451-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220510072451-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 May 2022 10:41:56 +0800
Message-ID: <CACGkMEvWFyEqeeXYEmbU4TWtnj9Ku6J7jLK_7MueuFvpR7FiGg@mail.gmail.com>
Subject: Re: [PATCH V4 6/9] virtio-ccw: implement synchronize_cbs()
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

On Tue, May 10, 2022 at 7:28 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sat, May 07, 2022 at 03:19:51PM +0800, Jason Wang wrote:
> > This patch tries to implement the synchronize_cbs() for ccw. For the
> > vring_interrupt() that is called via virtio_airq_handler(), the
> > synchronization is simply done via the airq_info's lock. For the
> > vring_interrupt() that is called via virtio_ccw_int_handler(), a per
> > device spinlock for irq is introduced ans used in the synchronization
> > method.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Halil Pasic <pasic@linux.ibm.com>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/s390/virtio/virtio_ccw.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > index d35e7a3f7067..001e1f0e6037 100644
> > --- a/drivers/s390/virtio/virtio_ccw.c
> > +++ b/drivers/s390/virtio/virtio_ccw.c
> > @@ -62,6 +62,7 @@ struct virtio_ccw_device {
> >       unsigned int revision; /* Transport revision */
> >       wait_queue_head_t wait_q;
> >       spinlock_t lock;
> > +     rwlock_t irq_lock;
> >       struct mutex io_lock; /* Serializes I/O requests */
> >       struct list_head virtqueues;
> >       bool is_thinint;
> > @@ -984,6 +985,27 @@ static const char *virtio_ccw_bus_name(struct virtio_device *vdev)
> >       return dev_name(&vcdev->cdev->dev);
> >  }
> >
> > +static void virtio_ccw_synchronize_cbs(struct virtio_device *vdev)
> > +{
> > +     struct virtio_ccw_device *vcdev = to_vc_device(vdev);
> > +     struct airq_info *info = vcdev->airq_info;
> > +
> > +     if (info) {
> > +             /*
> > +              * Synchronize with the vring_interrupt() with airq indicator
> > +              */
> > +             write_lock(&info->lock);
> > +             write_unlock(&info->lock);
> > +     } else {
> > +             /*
> > +              * Synchronize with the vring_interrupt() called by
> > +              * virtio_ccw_int_handler().
> > +              */
> > +             write_lock(&vcdev->irq_lock);
> > +             write_unlock(&vcdev->irq_lock);
> > +     }
> > +}
> > +
> >  static const struct virtio_config_ops virtio_ccw_config_ops = {
> >       .get_features = virtio_ccw_get_features,
> >       .finalize_features = virtio_ccw_finalize_features,
> > @@ -995,6 +1017,7 @@ static const struct virtio_config_ops virtio_ccw_config_ops = {
> >       .find_vqs = virtio_ccw_find_vqs,
> >       .del_vqs = virtio_ccw_del_vqs,
> >       .bus_name = virtio_ccw_bus_name,
> > +     .synchronize_cbs = virtio_ccw_synchronize_cbs,
> >  };
> >
> >
> > @@ -1079,6 +1102,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> >  {
> >       __u32 activity = intparm & VIRTIO_CCW_INTPARM_MASK;
> >       struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
> > +     unsigned long flags;
> >       int i;
> >       struct virtqueue *vq;
> >
> > @@ -1106,6 +1130,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> >                       vcdev->err = -EIO;
> >       }
> >       virtio_ccw_check_activity(vcdev, activity);
> > +     read_lock_irqsave(&vcdev->irq_lock, flags);
> >       for_each_set_bit(i, indicators(vcdev),
> >                        sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
> >               /* The bit clear must happen before the vring kick. */
>
> Cornelia sent a lockdep trace on this.
>
> Basically I think this gets the irqsave/restore logic wrong.
> It attempts to disable irqs in the handler (which is an interrupt
> anyway).

The reason I use irqsave/restore is that it can be called from process
context (if I was not wrong), e.g from io_subchannel_quiesce().

> And it does not disable irqs in the synchronize_cbs.
>
> As a result in interrupt might try to take a read lock while
> .synchronize_cbs has the writer lock, resulting in a deadlock.
>
> I think you want regular read_lock + write_lock_irq.

Yes.

Thanks

>
>
> > @@ -1114,6 +1139,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> >               vq = virtio_ccw_vq_by_ind(vcdev, i);
> >               vring_interrupt(0, vq);
> >       }
> > +     read_unlock_irqrestore(&vcdev->irq_lock, flags);
> >       if (test_bit(0, indicators2(vcdev))) {
> >               virtio_config_changed(&vcdev->vdev);
> >               clear_bit(0, indicators2(vcdev));
> > @@ -1284,6 +1310,7 @@ static int virtio_ccw_online(struct ccw_device *cdev)
> >       init_waitqueue_head(&vcdev->wait_q);
> >       INIT_LIST_HEAD(&vcdev->virtqueues);
> >       spin_lock_init(&vcdev->lock);
> > +     rwlock_init(&vcdev->irq_lock);
> >       mutex_init(&vcdev->io_lock);
> >
> >       spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
