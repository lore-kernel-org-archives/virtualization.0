Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E5AC43334
	for <virtualization@archiver.kernel.org>; Fri,  1 Jul 2022 06:14:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED90C844FA;
	Fri,  1 Jul 2022 06:14:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED90C844FA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a50X7dAS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2u2s8zPkwSSW; Fri,  1 Jul 2022 06:14:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4D125844D8;
	Fri,  1 Jul 2022 06:14:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D125844D8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 239C7C0035;
	Fri,  1 Jul 2022 06:14:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E7B2C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 06:14:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CF5DA844FA
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 06:14:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CF5DA844FA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yIyaRDAV6LiK
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 06:14:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9A18D844D8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9A18D844D8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 06:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656656051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ythCUedG2vrRnKIwBqpNStlM2oVY0Scr8pYplUyMtEo=;
 b=a50X7dASrHgaTrR9DHRCYLRt15j2JM85CzWGuWCCGrurFHLirK9nhtsOPokSP72tGExSzh
 Gq/Woomx7j3zk1xOXDoxmnKSKTYO8xhmPp469OdMgS/FB1QyokH9ASVm3/ZA0oWw4xyl7j
 hdWQgumH1H9FZXevduqg0xOVXPJQ4dQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-o_KnJ19jM86g7UCYJOKagA-1; Fri, 01 Jul 2022 02:14:10 -0400
X-MC-Unique: o_KnJ19jM86g7UCYJOKagA-1
Received: by mail-wr1-f72.google.com with SMTP id
 z11-20020a056000110b00b0021b9c009d09so132879wrw.17
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 23:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ythCUedG2vrRnKIwBqpNStlM2oVY0Scr8pYplUyMtEo=;
 b=JvtTQHcEpPR52pJkCoSQfI1E2/KwCJnd0vT3oLUGplZ+x5oerf4fSNZyznBDjSx7ck
 Kcmu8vSrlPYbHWFGp0cAXHlx4AEQ38AHos13DsTxJBPoAtSFAiov2MI+AWSCQbT4aVXn
 ywEtkhLGDXT92AQfP6mbl6HeeJ7SauI9AQZ17G2dnrqwhplK7Ax2bL1x0oU/R3uB/I7k
 YZdmn3wJZjZooLXgTLTe2xSrtH7r3YYLK/nyC51Jhaj+H8KncJlJD/uSuDeao1PAFYgU
 Dh4Ti0XLs54hnLLb73o8tTleO1Guj8bjjFUxFkZDRc38H/cYpU2ua2ph2GIhhj6xrfXf
 mL+A==
X-Gm-Message-State: AJIora/j52ERJlzi3knXTgPsziFhm6ePk1xWEWUTOSrlSDgI1Z+lyiyC
 YadhoCauOISK6m53dqFVeKKmWO9Q4ehmIwx/3Yx/ynSk1h2zC0moSVWT8kBv/86s6Ajo02wfjGK
 0FF2UBzS0Q7DcvuhQeFuoaEq62M2yfxmpU2zwXk8BXw==
X-Received: by 2002:a05:600c:27d1:b0:3a1:7e0c:56bf with SMTP id
 l17-20020a05600c27d100b003a17e0c56bfmr8192122wmb.186.1656656049034; 
 Thu, 30 Jun 2022 23:14:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tWfXPH4JRr5Y/9TWhFzTtdEZ3IAzORfK6bW3lsT7C+f2SHSanu3xDfGOaAzumyktw+aXz14A==
X-Received: by 2002:a05:600c:27d1:b0:3a1:7e0c:56bf with SMTP id
 l17-20020a05600c27d100b003a17e0c56bfmr8192096wmb.186.1656656048741; 
 Thu, 30 Jun 2022 23:14:08 -0700 (PDT)
Received: from redhat.com ([2.55.35.209]) by smtp.gmail.com with ESMTPSA id
 o19-20020a05600c511300b00397342e3830sm7268555wms.0.2022.06.30.23.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jun 2022 23:14:08 -0700 (PDT)
Date: Fri, 1 Jul 2022 02:14:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v1 1/1] virtio: Restore semantics of vq->broken in
 virtqueues
Message-ID: <20220701021340-mutt-send-email-mst@kernel.org>
References: <20220630093651.25981-1-alexander.atanasov@virtuozzo.com>
 <20220630054532-mutt-send-email-mst@kernel.org>
 <1c72645a-f162-2649-bdb6-a28ba93bccd2@virtuozzo.com>
 <20220630114142-mutt-send-email-mst@kernel.org>
 <CACGkMEu0qZJ34XjbTfp6pTp43bAuhGSgMc=HVepn8UxeQCx9gw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEu0qZJ34XjbTfp6pTp43bAuhGSgMc=HVepn8UxeQCx9gw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
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

On Fri, Jul 01, 2022 at 09:12:58AM +0800, Jason Wang wrote:
> On Thu, Jun 30, 2022 at 11:44 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Jun 30, 2022 at 01:08:53PM +0300, Alexander Atanasov wrote:
> > > Hello,
> > >
> > > On 30/06/2022 12:46, Michael S. Tsirkin wrote:
> > > > On Thu, Jun 30, 2022 at 09:36:46AM +0000, Alexander Atanasov wrote:
> > > > > virtio: harden vring IRQ (8b4ec69d7e09) changed the use
> > > > > of vq->broken. As result vring_interrupt handles IRQs for
> > > > > broken drivers as IRQ_NONE and not IRQ_HANDLED and made impossible
> > > > > to initiallize vqs before the driver is ready, i.e. in probe method.
> > > > > Balloon driver does this and it can not load because it fails in
> > > > > vqs_init with -EIO.
> > > > >
> > > > > So instead of changing the original intent ot the flag introduce
> > > > > a new flag vq->ready which servers the purpose to check of early IRQs
> > > > > and restore the behaviour of the vq->broken flag.
> > > > >
> > > > > Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> > > >
> > > > Does
> > > >
> > > > commit c346dae4f3fbce51bbd4f2ec5e8c6f9b91e93163
> > > > Author: Jason Wang <jasowang@redhat.com>
> > > > Date:   Wed Jun 22 09:29:40 2022 +0800
> > > >
> > > >      virtio: disable notification hardening by default
> > > >
> > > >
> > > > solve the problem for you?
> > >
> > >
> > > No, it won't if CONFIG_VIRTIO_HARDEN_NOTIFICATION is enabled - balloon still
> > > won't be able to init vqs.
> >
> > Yea I intend to make CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > depend on BROKEN for now.
> >
> > > The problem is in virtqueue_add_split and virtqueue_add_packed - can not set
> > > driver_ok without queues.
> > >
> > > The return value of the vring_interrupt gets different - and iirc IRQ_NONE
> > > for broken device can lead to interrupt storms - i am not sure if that is
> > > valid for virtio devices yet but for real harware most likely.
> >
> > No, I think it's the reverse. With IRQ_HANDLED an interrupt
> > storm will keep overloading the CPU since driver tells
> > kernel all is well. With IRQ_NONE kernel will eventually
> > intervene and disable the irq.
> 
> Yes, and users may get a warn.
> 
> For IRQ_HANDLED, it has an issue when the driver is sharing IRQ with
> other drivers.
> 
> Thanks


Couldn't tell whether you are agreeing or disagreeing with me here.

> >
> > > Either way if
> > > you have a mix of  drivers working differently depending on return of the
> > > handler  it would get really messy.
> > >
> > > RR's original intent was to flag a driver as bad why reuse it like that  ?
> > >
> > >
> > > > >   drivers/virtio/virtio_ring.c  | 20 ++++++++++++++------
> > > > >   include/linux/virtio.h        |  2 +-
> > > > >   include/linux/virtio_config.h | 10 +++++-----
> > > > >   3 files changed, 20 insertions(+), 12 deletions(-)
> > > > >
> > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > > Cc: Halil Pasic <pasic@linux.ibm.com>
> > > > > Cc: Cornelia Huck <cohuck@redhat.com>
> > > > > Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
> > > > > Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> > > > > Cc: linux-s390@vger.kernel.org
> > > > > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > >
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > index 13a7348cedff..dca3cc774584 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -100,6 +100,9 @@ struct vring_virtqueue {
> > > > >           /* Other side has made a mess, don't try any more. */
> > > > >           bool broken;
> > > > > + /* the queue is ready to handle interrupts  */
> > > > > + bool ready;
> > > > > +
> > > > >           /* Host supports indirect buffers */
> > > > >           bool indirect;
> > > > > @@ -1688,7 +1691,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
> > > > >           vq->we_own_ring = true;
> > > > >           vq->notify = notify;
> > > > >           vq->weak_barriers = weak_barriers;
> > > > > - vq->broken = true;
> > > > > + vq->broken = false;
> > > > > + vq->ready = false;
> > > > >           vq->last_used_idx = 0;
> > > > >           vq->event_triggered = false;
> > > > >           vq->num_added = 0;
> > > > > @@ -2134,7 +2138,10 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> > > > >                   return IRQ_NONE;
> > > > >           }
> > > > > - if (unlikely(vq->broken)) {
> > > > > + if (unlikely(vq->broken))
> > > > > +         return IRQ_HANDLED;
> > > > > +
> > > > > + if (unlikely(!vq->ready)) {
> > > > >                   dev_warn_once(&vq->vq.vdev->dev,
> > > > >                                 "virtio vring IRQ raised before DRIVER_OK");
> > > > >                   return IRQ_NONE;
> > > > > @@ -2180,7 +2187,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> > > > >           vq->we_own_ring = false;
> > > > >           vq->notify = notify;
> > > > >           vq->weak_barriers = weak_barriers;
> > > > > - vq->broken = true;
> > > > > + vq->broken = false;
> > > > > + vq->ready = false;
> > > > >           vq->last_used_idx = 0;
> > > > >           vq->event_triggered = false;
> > > > >           vq->num_added = 0;
> > > > > @@ -2405,7 +2413,7 @@ EXPORT_SYMBOL_GPL(virtio_break_device);
> > > > >    * (probing and restoring). This function should only be called by the
> > > > >    * core, not directly by the driver.
> > > > >    */
> > > > > -void __virtio_unbreak_device(struct virtio_device *dev)
> > > > > +void __virtio_device_ready(struct virtio_device *dev)
> > > > >   {
> > > > >           struct virtqueue *_vq;
> > > > > @@ -2414,11 +2422,11 @@ void __virtio_unbreak_device(struct virtio_device *dev)
> > > > >                   struct vring_virtqueue *vq = to_vvq(_vq);
> > > > >                   /* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> > > > > -         WRITE_ONCE(vq->broken, false);
> > > > > +         WRITE_ONCE(vq->ready, true);
> > > > >           }
> > > > >           spin_unlock(&dev->vqs_list_lock);
> > > > >   }
> > > > > -EXPORT_SYMBOL_GPL(__virtio_unbreak_device);
> > > > > +EXPORT_SYMBOL_GPL(__virtio_device_ready);
> > > > >   dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
> > > > >   {
> > > > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > > > index d8fdf170637c..538c5959949a 100644
> > > > > --- a/include/linux/virtio.h
> > > > > +++ b/include/linux/virtio.h
> > > > > @@ -131,7 +131,7 @@ void unregister_virtio_device(struct virtio_device *dev);
> > > > >   bool is_virtio_device(struct device *dev);
> > > > >   void virtio_break_device(struct virtio_device *dev);
> > > > > -void __virtio_unbreak_device(struct virtio_device *dev);
> > > > > +void __virtio_device_ready(struct virtio_device *dev);
> > > > >   void virtio_config_changed(struct virtio_device *dev);
> > > > >   #ifdef CONFIG_PM_SLEEP
> > > > > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > > > > index 49c7c32815f1..35cf1b26e05a 100644
> > > > > --- a/include/linux/virtio_config.h
> > > > > +++ b/include/linux/virtio_config.h
> > > > > @@ -259,21 +259,21 @@ void virtio_device_ready(struct virtio_device *dev)
> > > > >           /*
> > > > >            * The virtio_synchronize_cbs() makes sure vring_interrupt()
> > > > > -  * will see the driver specific setup if it sees vq->broken
> > > > > +  * will see the driver specific setup if it sees vq->ready
> > > > >            * as false (even if the notifications come before DRIVER_OK).
> > > > >            */
> > > > >           virtio_synchronize_cbs(dev);
> > > > > - __virtio_unbreak_device(dev);
> > > > > + __virtio_device_ready(dev);
> > > > >           /*
> > > > > -  * The transport should ensure the visibility of vq->broken
> > > > > +  * The transport should ensure the visibility of vq->ready
> > > > >            * before setting DRIVER_OK. See the comments for the transport
> > > > >            * specific set_status() method.
> > > > >            *
> > > > >            * A well behaved device will only notify a virtqueue after
> > > > >            * DRIVER_OK, this means the device should "see" the coherenct
> > > > > -  * memory write that set vq->broken as false which is done by
> > > > > +  * memory write that set vq->ready as true which is done by
> > > > >            * the driver when it sees DRIVER_OK, then the following
> > > > > -  * driver's vring_interrupt() will see vq->broken as false so
> > > > > +  * driver's vring_interrupt() will see vq->true as true so
> > > > >            * we won't lose any notification.
> > > > >            */
> > > > >           dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
> > > > > --
> > > > > 2.25.1
> > >
> > > --
> > > Regards,
> > > Alexander Atanasov
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
