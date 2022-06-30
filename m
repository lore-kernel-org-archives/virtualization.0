Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB8ACCA47B
	for <virtualization@archiver.kernel.org>; Thu, 30 Jun 2022 15:44:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86674613CC;
	Thu, 30 Jun 2022 15:44:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 86674613CC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bYy6/uTw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BQPoK7u1sQc8; Thu, 30 Jun 2022 15:44:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9E14C613B0;
	Thu, 30 Jun 2022 15:44:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9E14C613B0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 704C2C002D;
	Thu, 30 Jun 2022 15:44:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B7A9C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 15:44:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 66DCC40B16
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 15:44:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 66DCC40B16
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bYy6/uTw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uZgj8NyBAr-Q
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 15:44:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 054DE40178
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 054DE40178
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 15:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656603841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b2JRsgc2hWOY7hbuh3CsyQAbWyr8QoHDSpgMdwF3Wow=;
 b=bYy6/uTwWkCTLik2kdiO+o5nyfWuOVC1s5OKRgIojz3mgIl6GG4MpblL1Ua3vs0zgRH717
 t/L7Mpz7G07Zjuz3y7h0wXNEUnepky8KCBTV1fAZ/Yb3hd7rNrLYEpdbCiS1j1niRhzWWX
 UZUmj2ZzNhj0+uX6Hyf2pkOOKMXDCfM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-Lg1pgaD2ODCmlaxGRpsXAQ-1; Thu, 30 Jun 2022 11:43:59 -0400
X-MC-Unique: Lg1pgaD2ODCmlaxGRpsXAQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 j35-20020a05600c1c2300b003a167dfa0ecso1658581wms.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 08:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=b2JRsgc2hWOY7hbuh3CsyQAbWyr8QoHDSpgMdwF3Wow=;
 b=BMy71xC4+5Xi8d2O27Q0GLlI2z3MmC1IOzsJLRc8HQL00GZC5zbY8fqMEG38cEnNgh
 CniZWRUaczl+IbtjtZszU0vPJkPzmQgGvrmreo2cs7zfbHUbq2qLAxsAmOuR0qcWMPTg
 mPvNVgkbagvxLtjyopg+bHnkEOCv/Sv2XjxwBCCEibEtald979cOvpnjmdF/TOtcqNRM
 5aYGgo9by8cPtLGGg9zfJer5w8Zfu2qND4JD7EhD68OA3lRPCpY/ru+IAxF5gnqO1/u4
 1bkoMZ7t4TAJOIQNO0Q4zM81dlxZb4TbMaa+vKegujd5Of1ZE8REF9WSVwGTC+kxJ/p/
 7hEQ==
X-Gm-Message-State: AJIora8/wDeTOeIfJf35/FGgQ0OgD5smp09YCN0smFbjZyhB83cpCI9+
 zKpxh4KZhVgK2qKAv/CPOSzaBQikmVuGr5hsTZkMfo58owIYSoHfEqDLoYcp2phY35PxmhsNapl
 hQtbmwq58GiUtMdeJMOYqdPODlAUqvi1gcuEKi12Fng==
X-Received: by 2002:a5d:6487:0:b0:21b:983c:5508 with SMTP id
 o7-20020a5d6487000000b0021b983c5508mr8957410wri.185.1656603837954; 
 Thu, 30 Jun 2022 08:43:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s2tgO1/wtgZNb3F5h0bZwn+9gYHXB01spFOKXbw+pimANXZJW4Rt7moQE8g9ZSuC2ZSNSp/A==
X-Received: by 2002:a5d:6487:0:b0:21b:983c:5508 with SMTP id
 o7-20020a5d6487000000b0021b983c5508mr8957377wri.185.1656603837707; 
 Thu, 30 Jun 2022 08:43:57 -0700 (PDT)
Received: from redhat.com ([2.55.3.188]) by smtp.gmail.com with ESMTPSA id
 j14-20020adfa54e000000b0021b93b29cacsm24532667wrb.99.2022.06.30.08.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jun 2022 08:43:57 -0700 (PDT)
Date: Thu, 30 Jun 2022 11:43:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Subject: Re: [PATCH v1 1/1] virtio: Restore semantics of vq->broken in
 virtqueues
Message-ID: <20220630114142-mutt-send-email-mst@kernel.org>
References: <20220630093651.25981-1-alexander.atanasov@virtuozzo.com>
 <20220630054532-mutt-send-email-mst@kernel.org>
 <1c72645a-f162-2649-bdb6-a28ba93bccd2@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <1c72645a-f162-2649-bdb6-a28ba93bccd2@virtuozzo.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Peter Oberparleiter <oberpar@linux.ibm.com>,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 kernel@openvz.org, Vineeth Vijayan <vneethv@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Jun 30, 2022 at 01:08:53PM +0300, Alexander Atanasov wrote:
> Hello,
> =

> On 30/06/2022 12:46, Michael S. Tsirkin wrote:
> > On Thu, Jun 30, 2022 at 09:36:46AM +0000, Alexander Atanasov wrote:
> > > virtio: harden vring IRQ (8b4ec69d7e09) changed the use
> > > of vq->broken. As result vring_interrupt handles IRQs for
> > > broken drivers as IRQ_NONE and not IRQ_HANDLED and made impossible
> > > to initiallize vqs before the driver is ready, i.e. in probe method.
> > > Balloon driver does this and it can not load because it fails in
> > > vqs_init with -EIO.
> > > =

> > > So instead of changing the original intent ot the flag introduce
> > > a new flag vq->ready which servers the purpose to check of early IRQs
> > > and restore the behaviour of the vq->broken flag.
> > > =

> > > Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> > =

> > Does
> > =

> > commit c346dae4f3fbce51bbd4f2ec5e8c6f9b91e93163
> > Author: Jason Wang <jasowang@redhat.com>
> > Date:   Wed Jun 22 09:29:40 2022 +0800
> > =

> >      virtio: disable notification hardening by default
> > =

> > =

> > solve the problem for you?
> =

> =

> No, it won't if CONFIG_VIRTIO_HARDEN_NOTIFICATION is enabled - balloon st=
ill
> won't be able to init vqs.

Yea I intend to make CONFIG_VIRTIO_HARDEN_NOTIFICATION =

depend on BROKEN for now.

> The problem is in virtqueue_add_split and virtqueue_add_packed - can not =
set
> driver_ok without queues.
> =

> The return value of the vring_interrupt gets different - and iirc IRQ_NONE
> for broken device can lead to interrupt storms - i am not sure if that is
> valid for virtio devices yet but for real harware most likely.

No, I think it's the reverse. With IRQ_HANDLED an interrupt
storm will keep overloading the CPU since driver tells
kernel all is well. With IRQ_NONE kernel will eventually
intervene and disable the irq.

> Either way if
> you have a mix of=A0 drivers working differently depending on return of t=
he
> handler=A0 it would get really messy.
> =

> RR's original intent was to flag a driver as bad why reuse it like that=
=A0 ?
> =

> =

> > >   drivers/virtio/virtio_ring.c  | 20 ++++++++++++++------
> > >   include/linux/virtio.h        |  2 +-
> > >   include/linux/virtio_config.h | 10 +++++-----
> > >   3 files changed, 20 insertions(+), 12 deletions(-)
> > > =

> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > Cc: Marc Zyngier <maz@kernel.org>
> > > Cc: Halil Pasic <pasic@linux.ibm.com>
> > > Cc: Cornelia Huck <cohuck@redhat.com>
> > > Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
> > > Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> > > Cc: linux-s390@vger.kernel.org
> > > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > =

> > > =

> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 13a7348cedff..dca3cc774584 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -100,6 +100,9 @@ struct vring_virtqueue {
> > >   	/* Other side has made a mess, don't try any more. */
> > >   	bool broken;
> > > +	/* the queue is ready to handle interrupts  */
> > > +	bool ready;
> > > +
> > >   	/* Host supports indirect buffers */
> > >   	bool indirect;
> > > @@ -1688,7 +1691,8 @@ static struct virtqueue *vring_create_virtqueue=
_packed(
> > >   	vq->we_own_ring =3D true;
> > >   	vq->notify =3D notify;
> > >   	vq->weak_barriers =3D weak_barriers;
> > > -	vq->broken =3D true;
> > > +	vq->broken =3D false;
> > > +	vq->ready =3D false;
> > >   	vq->last_used_idx =3D 0;
> > >   	vq->event_triggered =3D false;
> > >   	vq->num_added =3D 0;
> > > @@ -2134,7 +2138,10 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> > >   		return IRQ_NONE;
> > >   	}
> > > -	if (unlikely(vq->broken)) {
> > > +	if (unlikely(vq->broken))
> > > +		return IRQ_HANDLED;
> > > +
> > > +	if (unlikely(!vq->ready)) {
> > >   		dev_warn_once(&vq->vq.vdev->dev,
> > >   			      "virtio vring IRQ raised before DRIVER_OK");
> > >   		return IRQ_NONE;
> > > @@ -2180,7 +2187,8 @@ struct virtqueue *__vring_new_virtqueue(unsigne=
d int index,
> > >   	vq->we_own_ring =3D false;
> > >   	vq->notify =3D notify;
> > >   	vq->weak_barriers =3D weak_barriers;
> > > -	vq->broken =3D true;
> > > +	vq->broken =3D false;
> > > +	vq->ready =3D false;
> > >   	vq->last_used_idx =3D 0;
> > >   	vq->event_triggered =3D false;
> > >   	vq->num_added =3D 0;
> > > @@ -2405,7 +2413,7 @@ EXPORT_SYMBOL_GPL(virtio_break_device);
> > >    * (probing and restoring). This function should only be called by =
the
> > >    * core, not directly by the driver.
> > >    */
> > > -void __virtio_unbreak_device(struct virtio_device *dev)
> > > +void __virtio_device_ready(struct virtio_device *dev)
> > >   {
> > >   	struct virtqueue *_vq;
> > > @@ -2414,11 +2422,11 @@ void __virtio_unbreak_device(struct virtio_de=
vice *dev)
> > >   		struct vring_virtqueue *vq =3D to_vvq(_vq);
> > >   		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> > > -		WRITE_ONCE(vq->broken, false);
> > > +		WRITE_ONCE(vq->ready, true);
> > >   	}
> > >   	spin_unlock(&dev->vqs_list_lock);
> > >   }
> > > -EXPORT_SYMBOL_GPL(__virtio_unbreak_device);
> > > +EXPORT_SYMBOL_GPL(__virtio_device_ready);
> > >   dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
> > >   {
> > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > index d8fdf170637c..538c5959949a 100644
> > > --- a/include/linux/virtio.h
> > > +++ b/include/linux/virtio.h
> > > @@ -131,7 +131,7 @@ void unregister_virtio_device(struct virtio_devic=
e *dev);
> > >   bool is_virtio_device(struct device *dev);
> > >   void virtio_break_device(struct virtio_device *dev);
> > > -void __virtio_unbreak_device(struct virtio_device *dev);
> > > +void __virtio_device_ready(struct virtio_device *dev);
> > >   void virtio_config_changed(struct virtio_device *dev);
> > >   #ifdef CONFIG_PM_SLEEP
> > > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_con=
fig.h
> > > index 49c7c32815f1..35cf1b26e05a 100644
> > > --- a/include/linux/virtio_config.h
> > > +++ b/include/linux/virtio_config.h
> > > @@ -259,21 +259,21 @@ void virtio_device_ready(struct virtio_device *=
dev)
> > >   	/*
> > >   	 * The virtio_synchronize_cbs() makes sure vring_interrupt()
> > > -	 * will see the driver specific setup if it sees vq->broken
> > > +	 * will see the driver specific setup if it sees vq->ready
> > >   	 * as false (even if the notifications come before DRIVER_OK).
> > >   	 */
> > >   	virtio_synchronize_cbs(dev);
> > > -	__virtio_unbreak_device(dev);
> > > +	__virtio_device_ready(dev);
> > >   	/*
> > > -	 * The transport should ensure the visibility of vq->broken
> > > +	 * The transport should ensure the visibility of vq->ready
> > >   	 * before setting DRIVER_OK. See the comments for the transport
> > >   	 * specific set_status() method.
> > >   	 *
> > >   	 * A well behaved device will only notify a virtqueue after
> > >   	 * DRIVER_OK, this means the device should "see" the coherenct
> > > -	 * memory write that set vq->broken as false which is done by
> > > +	 * memory write that set vq->ready as true which is done by
> > >   	 * the driver when it sees DRIVER_OK, then the following
> > > -	 * driver's vring_interrupt() will see vq->broken as false so
> > > +	 * driver's vring_interrupt() will see vq->true as true so
> > >   	 * we won't lose any notification.
> > >   	 */
> > >   	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
> > > -- =

> > > 2.25.1
> =

> -- =

> Regards,
> Alexander Atanasov

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
