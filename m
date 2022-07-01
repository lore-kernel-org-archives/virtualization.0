Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672FCC43334
	for <virtualization@archiver.kernel.org>; Fri,  1 Jul 2022 01:07:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE1A681AEA;
	Fri,  1 Jul 2022 01:07:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EE1A681AEA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q1PP9Wzf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XJquGNPARu_a; Fri,  1 Jul 2022 01:07:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 38C90819C8;
	Fri,  1 Jul 2022 01:07:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 38C90819C8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DB4CC002D;
	Fri,  1 Jul 2022 01:07:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32B57C0011
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 01:07:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F2C7C41BA8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 01:07:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2C7C41BA8
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q1PP9Wzf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1DGLXe5fg0o7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 01:07:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 692DF41B90
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 692DF41B90
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 01:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656637656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HDRvPOfg2sqIMJ3xvadp3pU7dDplLEAQE44MLsZLEnQ=;
 b=Q1PP9WzfJz6UQ4yyLnL3yw6KEqBL+X0DHJPgcon/35Brhf2U9MKRhXkqmB3RubNLOjAOTy
 sib4L+1iPM63MQbiA92QfUUUT3pENxToej/chPAnqsRxP5F9Eeelx5WcvNDbMUJBBKA7t8
 cAfbVoy43z5VHb+asdR49SG82vVlwfk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-eQydjc0PMMu91gaER2kqaQ-1; Thu, 30 Jun 2022 21:07:34 -0400
X-MC-Unique: eQydjc0PMMu91gaER2kqaQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 o22-20020a05651205d600b004810c974c17so360432lfo.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 18:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HDRvPOfg2sqIMJ3xvadp3pU7dDplLEAQE44MLsZLEnQ=;
 b=XSsS/9iuCy2sSA2RqMHKdRoyEnk9iXXSjdJRYwvMxt/rYKYbXi8sDkKH46PQ1WpLR0
 bDMyBn7kdcYGRJ09uW0ZtFeg7gbYlUgu1KTIDeS0fidHoCY4nn8KyH1mK2VgHmnL9/U3
 7pyGJWF3AwBPmiGw2cJozB36BZXSk4/Q23BYDZrvhhkGPqfVRhNhf+LYAwYufjwoyVER
 E2oGxuTuR+2XdII4d6jqy9Z8PCkaz6bzdgkXLfaE0oV45x0UR8AJDe7zwUL0OE6ZbAmE
 7T/lwY2+8BcTMJAq77l+oMNOE6mtlfKlW1iku2pIJlpBxBrM9swmJMeXfxWgQYLOacV2
 vtKQ==
X-Gm-Message-State: AJIora/9n0JxWPUuXjcTdyriiDOJhc7prbXEW2aU2TEzy9ltKy1i42AI
 rrIoiPnvjiIYo3zq6TbqlxE313YvqPO/JQNySlgOshEzIUJw97I6iCOILMTU7Hl3VwL6vLANNhN
 sUHLssdyyt7aKaw9lsx0iNc2nX0rA3G7eWXgzl145BcBk2LE7QpbZCB0JZA==
X-Received: by 2002:a2e:aaa5:0:b0:25b:ae57:4ad7 with SMTP id
 bj37-20020a2eaaa5000000b0025bae574ad7mr6841042ljb.323.1656637652786; 
 Thu, 30 Jun 2022 18:07:32 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vG3zFm9S/F3A98azRf8TGVuk0Y8Yo6Dm1jFfKZpFBfwd8hhFccNip+jSVwsWmzuwAgKtCF+KqNpsyXuXcyAEc=
X-Received: by 2002:a2e:aaa5:0:b0:25b:ae57:4ad7 with SMTP id
 bj37-20020a2eaaa5000000b0025bae574ad7mr6841026ljb.323.1656637652543; Thu, 30
 Jun 2022 18:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220630093651.25981-1-alexander.atanasov@virtuozzo.com>
 <20220630054532-mutt-send-email-mst@kernel.org>
 <1c72645a-f162-2649-bdb6-a28ba93bccd2@virtuozzo.com>
In-Reply-To: <1c72645a-f162-2649-bdb6-a28ba93bccd2@virtuozzo.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 1 Jul 2022 09:07:21 +0800
Message-ID: <CACGkMEsZHB9opC6frbSwNmE1d9=yt3npZCHWcK25Xe52VJzwGQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] virtio: Restore semantics of vq->broken in
 virtqueues
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-s390@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Marc Zyngier <maz@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 Peter Oberparleiter <oberpar@linux.ibm.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, kernel@openvz.org,
 Vineeth Vijayan <vneethv@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>
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

On Thu, Jun 30, 2022 at 6:09 PM Alexander Atanasov
<alexander.atanasov@virtuozzo.com> wrote:
>
> Hello,
>
> On 30/06/2022 12:46, Michael S. Tsirkin wrote:
> > On Thu, Jun 30, 2022 at 09:36:46AM +0000, Alexander Atanasov wrote:
> >> virtio: harden vring IRQ (8b4ec69d7e09) changed the use
> >> of vq->broken. As result vring_interrupt handles IRQs for
> >> broken drivers as IRQ_NONE and not IRQ_HANDLED and made impossible
> >> to initiallize vqs before the driver is ready, i.e. in probe method.
> >> Balloon driver does this and it can not load because it fails in
> >> vqs_init with -EIO.
> >>
> >> So instead of changing the original intent ot the flag introduce
> >> a new flag vq->ready which servers the purpose to check of early IRQs
> >> and restore the behaviour of the vq->broken flag.
> >>
> >> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> >
> > Does
> >
> > commit c346dae4f3fbce51bbd4f2ec5e8c6f9b91e93163
> > Author: Jason Wang <jasowang@redhat.com>
> > Date:   Wed Jun 22 09:29:40 2022 +0800
> >
> >      virtio: disable notification hardening by default
> >
> >
> > solve the problem for you?
>
>
> No, it won't if CONFIG_VIRTIO_HARDEN_NOTIFICATION is enabled - balloon
> still won't be able to init vqs.
>
> The problem is in virtqueue_add_split and virtqueue_add_packed - can not
> set driver_ok without queues.
>
> The return value of the vring_interrupt gets different - and iirc
> IRQ_NONE for broken device can lead to interrupt storms - i am not sure
> if that is valid for virtio devices yet but for real harware most
> likely.

Valid but the interrupt will be noted and disabled by the kernel then.

> Either way if you have a mix of  drivers working differently
> depending on return of the handler  it would get really messy.

Yes, IRQ_HANDLED may break the driver that shares a single IRQ.

>
> RR's original intent was to flag a driver as bad why reuse it like that  ?

It's somehow the same, we want to prevent the driver from using the
malicious or buggy device.

Anyhow, I think using a dedicated variable is better.

We are discussing a better approach for hardening the notifications.
But in case, this will be merged:

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
>
> >>   drivers/virtio/virtio_ring.c  | 20 ++++++++++++++------
> >>   include/linux/virtio.h        |  2 +-
> >>   include/linux/virtio_config.h | 10 +++++-----
> >>   3 files changed, 20 insertions(+), 12 deletions(-)
> >>
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >> Cc: Marc Zyngier <maz@kernel.org>
> >> Cc: Halil Pasic <pasic@linux.ibm.com>
> >> Cc: Cornelia Huck <cohuck@redhat.com>
> >> Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
> >> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> >> Cc: linux-s390@vger.kernel.org
> >> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >>
> >>
> >> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> >> index 13a7348cedff..dca3cc774584 100644
> >> --- a/drivers/virtio/virtio_ring.c
> >> +++ b/drivers/virtio/virtio_ring.c
> >> @@ -100,6 +100,9 @@ struct vring_virtqueue {
> >>      /* Other side has made a mess, don't try any more. */
> >>      bool broken;
> >>
> >> +    /* the queue is ready to handle interrupts  */
> >> +    bool ready;
> >> +
> >>      /* Host supports indirect buffers */
> >>      bool indirect;
> >>
> >> @@ -1688,7 +1691,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >>      vq->we_own_ring = true;
> >>      vq->notify = notify;
> >>      vq->weak_barriers = weak_barriers;
> >> -    vq->broken = true;
> >> +    vq->broken = false;
> >> +    vq->ready = false;
> >>      vq->last_used_idx = 0;
> >>      vq->event_triggered = false;
> >>      vq->num_added = 0;
> >> @@ -2134,7 +2138,10 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> >>              return IRQ_NONE;
> >>      }
> >>
> >> -    if (unlikely(vq->broken)) {
> >> +    if (unlikely(vq->broken))
> >> +            return IRQ_HANDLED;
> >> +
> >> +    if (unlikely(!vq->ready)) {
> >>              dev_warn_once(&vq->vq.vdev->dev,
> >>                            "virtio vring IRQ raised before DRIVER_OK");
> >>              return IRQ_NONE;
> >> @@ -2180,7 +2187,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> >>      vq->we_own_ring = false;
> >>      vq->notify = notify;
> >>      vq->weak_barriers = weak_barriers;
> >> -    vq->broken = true;
> >> +    vq->broken = false;
> >> +    vq->ready = false;
> >>      vq->last_used_idx = 0;
> >>      vq->event_triggered = false;
> >>      vq->num_added = 0;
> >> @@ -2405,7 +2413,7 @@ EXPORT_SYMBOL_GPL(virtio_break_device);
> >>    * (probing and restoring). This function should only be called by the
> >>    * core, not directly by the driver.
> >>    */
> >> -void __virtio_unbreak_device(struct virtio_device *dev)
> >> +void __virtio_device_ready(struct virtio_device *dev)
> >>   {
> >>      struct virtqueue *_vq;
> >>
> >> @@ -2414,11 +2422,11 @@ void __virtio_unbreak_device(struct virtio_device *dev)
> >>              struct vring_virtqueue *vq = to_vvq(_vq);
> >>
> >>              /* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> >> -            WRITE_ONCE(vq->broken, false);
> >> +            WRITE_ONCE(vq->ready, true);
> >>      }
> >>      spin_unlock(&dev->vqs_list_lock);
> >>   }
> >> -EXPORT_SYMBOL_GPL(__virtio_unbreak_device);
> >> +EXPORT_SYMBOL_GPL(__virtio_device_ready);
> >>
> >>   dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
> >>   {
> >> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> >> index d8fdf170637c..538c5959949a 100644
> >> --- a/include/linux/virtio.h
> >> +++ b/include/linux/virtio.h
> >> @@ -131,7 +131,7 @@ void unregister_virtio_device(struct virtio_device *dev);
> >>   bool is_virtio_device(struct device *dev);
> >>
> >>   void virtio_break_device(struct virtio_device *dev);
> >> -void __virtio_unbreak_device(struct virtio_device *dev);
> >> +void __virtio_device_ready(struct virtio_device *dev);
> >>
> >>   void virtio_config_changed(struct virtio_device *dev);
> >>   #ifdef CONFIG_PM_SLEEP
> >> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> >> index 49c7c32815f1..35cf1b26e05a 100644
> >> --- a/include/linux/virtio_config.h
> >> +++ b/include/linux/virtio_config.h
> >> @@ -259,21 +259,21 @@ void virtio_device_ready(struct virtio_device *dev)
> >>
> >>      /*
> >>       * The virtio_synchronize_cbs() makes sure vring_interrupt()
> >> -     * will see the driver specific setup if it sees vq->broken
> >> +     * will see the driver specific setup if it sees vq->ready
> >>       * as false (even if the notifications come before DRIVER_OK).
> >>       */
> >>      virtio_synchronize_cbs(dev);
> >> -    __virtio_unbreak_device(dev);
> >> +    __virtio_device_ready(dev);
> >>      /*
> >> -     * The transport should ensure the visibility of vq->broken
> >> +     * The transport should ensure the visibility of vq->ready
> >>       * before setting DRIVER_OK. See the comments for the transport
> >>       * specific set_status() method.
> >>       *
> >>       * A well behaved device will only notify a virtqueue after
> >>       * DRIVER_OK, this means the device should "see" the coherenct
> >> -     * memory write that set vq->broken as false which is done by
> >> +     * memory write that set vq->ready as true which is done by
> >>       * the driver when it sees DRIVER_OK, then the following
> >> -     * driver's vring_interrupt() will see vq->broken as false so
> >> +     * driver's vring_interrupt() will see vq->true as true so
> >>       * we won't lose any notification.
> >>       */
> >>      dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
> >> --
> >> 2.25.1
>
> --
> Regards,
> Alexander Atanasov
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
