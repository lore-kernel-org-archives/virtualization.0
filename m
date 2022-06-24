Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582FBC433EF
	for <virtualization@archiver.kernel.org>; Fri, 24 Jun 2022 09:05:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C37D6612A9;
	Fri, 24 Jun 2022 09:05:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C37D6612A9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jCNjjWRg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qjk9APcko1j3; Fri, 24 Jun 2022 09:05:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 026B160BB8;
	Fri, 24 Jun 2022 09:05:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 026B160BB8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8A1CC0039;
	Fri, 24 Jun 2022 09:05:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 059D0C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 09:05:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D85D848E5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 09:05:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D85D848E5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jCNjjWRg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lqdRvqYan6u5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 09:05:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6041F848E8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6041F848E8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 09:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656061515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0hr561ihhXsPhogsxkgvSPAdJWrnjtuolGrZFY+sf5U=;
 b=jCNjjWRgcOfDUi9LfAPFLGB2tagFDwBi6lRbqYxXzX2E77PDLj/qEIlnNm8UqYPRraGg1e
 PHgPtuU/n9WkBQbijW8DFnRocZGkcJcP6/gA60DePaqWvAfPu6J5UO+7vMpaF2HxbkPn9c
 G8jaJn4KJsjhoIykC4m+77hwSQuo5Yk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-A_dRrvRmOSKzgu0cXbzUdA-1; Fri, 24 Jun 2022 05:05:13 -0400
X-MC-Unique: A_dRrvRmOSKzgu0cXbzUdA-1
Received: by mail-wm1-f70.google.com with SMTP id
 t20-20020a1c7714000000b003a032360873so2139450wmi.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 02:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0hr561ihhXsPhogsxkgvSPAdJWrnjtuolGrZFY+sf5U=;
 b=bV5Mkn9F02vT8frO0Na/TrRs1tztGf3PxFR+v+6omZ1TwAzd16oV9oX2V/VlEg1Jr7
 Hh1zXH1quFcWm840Op7CZ58g/AlC+jn3ofj01hkdvNaZGHrieZgSglq2rXqLemn6M02M
 dY57kvNJu6yX9R9sI8xsg/ItR4OL1VDPbSR6DJISkxH6OtGn1NZb3bdYfeK6t5YvNMj4
 ayZ2akiqK+9gaLh66R8ixhELGNj1nlM9dsU3Vv5VBv/m2OzNLa0oDa85eGU1YyA/0JJT
 JySWazGUPvhICmdmYMcTtddQyUl0JIX39HdobQ4SXTxY4fGKFp4xtC15oJ4sf+GJyn1u
 7aBA==
X-Gm-Message-State: AJIora84Qpn3TRHugIjVN4dJldGm6Q64ODSLs08trBnCLYkUXQmnFN2O
 mPEvcSJJlTmZkZx5bsEXpgsQN0bqclqNQ7Yeb7UwInVPAIB2QBh7hnY9pGG1FiqeO4QR5QWMrvj
 TJwvsHQIXDuproMw5tf1pQERxq1BdpPze862JlC6O4A==
X-Received: by 2002:adf:e60c:0:b0:21b:8bac:70ff with SMTP id
 p12-20020adfe60c000000b0021b8bac70ffmr12444230wrm.467.1656061512351; 
 Fri, 24 Jun 2022 02:05:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uoe3m5qiYscNMmz7DE+gitHceKjGYr+ohkPwz4GHeoypqq3Oxw5JCxX+Nwl+a0MHZpdtfRxA==
X-Received: by 2002:adf:e60c:0:b0:21b:8bac:70ff with SMTP id
 p12-20020adfe60c000000b0021b8bac70ffmr12444202wrm.467.1656061512057; 
 Fri, 24 Jun 2022 02:05:12 -0700 (PDT)
Received: from redhat.com ([2.55.188.216]) by smtp.gmail.com with ESMTPSA id
 5-20020a05600c230500b0039c8a22554bsm2100129wmo.27.2022.06.24.02.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jun 2022 02:05:11 -0700 (PDT)
Date: Fri, 24 Jun 2022 05:05:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH V3] virtio: disable notification hardening by default
Message-ID: <20220624050500-mutt-send-email-mst@kernel.org>
References: <20220622012940.21441-1-jasowang@redhat.com>
 <1656060115.233734-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1656060115.233734-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, gor@linux.ibm.com,
 cohuck@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, agordeev@linux.ibm.com, ben@decadent.org.uk,
 hca@linux.ibm.com
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

On Fri, Jun 24, 2022 at 04:41:55PM +0800, Xuan Zhuo wrote:
> On Wed, 22 Jun 2022 09:29:40 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > We try to harden virtio device notifications in 8b4ec69d7e09 ("virtio:
> > harden vring IRQ"). It works with the assumption that the driver or
> > core can properly call virtio_device_ready() at the right
> > place. Unfortunately, this seems to be not true and uncover various
> > bugs of the existing drivers, mainly the issue of using
> > virtio_device_ready() incorrectly.
> >
> > So let's having a Kconfig option and disable it by default. It gives
> > us a breath to fix the drivers and then we can consider to enable it
> > by default.
> 
> 
> hi, I have a question.
> 
> What should we do when the queue is reset and CONFIG_VIRTIO_HARDEN_NOTIFICATION
> is off?
> 
> Since disable_irq() cannot be used, we should trust the device not to send irqs
> again. So we don't have to do anything?

yes

> Thanks.
> 
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > Changes since V2:
> > - Tweak the Kconfig help
> > - Add comment for the read_lock() pairing in virtio_ccw
> > ---
> >  drivers/s390/virtio/virtio_ccw.c |  9 ++++++++-
> >  drivers/virtio/Kconfig           | 13 +++++++++++++
> >  drivers/virtio/virtio.c          |  2 ++
> >  drivers/virtio/virtio_ring.c     | 12 ++++++++++++
> >  include/linux/virtio_config.h    |  2 ++
> >  5 files changed, 37 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > index 97e51c34e6cf..1f6a358f65f0 100644
> > --- a/drivers/s390/virtio/virtio_ccw.c
> > +++ b/drivers/s390/virtio/virtio_ccw.c
> > @@ -1136,8 +1136,13 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> >  			vcdev->err = -EIO;
> >  	}
> >  	virtio_ccw_check_activity(vcdev, activity);
> > -	/* Interrupts are disabled here */
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > +	/*
> > +	 * Paried with virtio_ccw_synchronize_cbs() and interrupts are
> > +	 * disabled here.
> > +	 */
> >  	read_lock(&vcdev->irq_lock);
> > +#endif
> >  	for_each_set_bit(i, indicators(vcdev),
> >  			 sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
> >  		/* The bit clear must happen before the vring kick. */
> > @@ -1146,7 +1151,9 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> >  		vq = virtio_ccw_vq_by_ind(vcdev, i);
> >  		vring_interrupt(0, vq);
> >  	}
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >  	read_unlock(&vcdev->irq_lock);
> > +#endif
> >  	if (test_bit(0, indicators2(vcdev))) {
> >  		virtio_config_changed(&vcdev->vdev);
> >  		clear_bit(0, indicators2(vcdev));
> > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > index b5adf6abd241..c04f370a1e5c 100644
> > --- a/drivers/virtio/Kconfig
> > +++ b/drivers/virtio/Kconfig
> > @@ -35,6 +35,19 @@ menuconfig VIRTIO_MENU
> >
> >  if VIRTIO_MENU
> >
> > +config VIRTIO_HARDEN_NOTIFICATION
> > +        bool "Harden virtio notification"
> > +        help
> > +          Enable this to harden the device notifications and suppress
> > +          those that happen at a time where notifications are illegal.
> > +
> > +          Experimental: Note that several drivers still have bugs that
> > +          may cause crashes or hangs when correct handling of
> > +          notifications is enforced; depending on the subset of
> > +          drivers and devices you use, this may or may not work.
> > +
> > +          If unsure, say N.
> > +
> >  config VIRTIO_PCI
> >  	tristate "PCI driver for virtio devices"
> >  	depends on PCI
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index ef04a96942bf..21dc08d2f32d 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -220,6 +220,7 @@ static int virtio_features_ok(struct virtio_device *dev)
> >   * */
> >  void virtio_reset_device(struct virtio_device *dev)
> >  {
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >  	/*
> >  	 * The below virtio_synchronize_cbs() guarantees that any
> >  	 * interrupt for this line arriving after
> > @@ -228,6 +229,7 @@ void virtio_reset_device(struct virtio_device *dev)
> >  	 */
> >  	virtio_break_device(dev);
> >  	virtio_synchronize_cbs(dev);
> > +#endif
> >
> >  	dev->config->reset(dev);
> >  }
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 13a7348cedff..d9d3b6e201fb 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1688,7 +1688,11 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >  	vq->we_own_ring = true;
> >  	vq->notify = notify;
> >  	vq->weak_barriers = weak_barriers;
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >  	vq->broken = true;
> > +#else
> > +	vq->broken = false;
> > +#endif
> >  	vq->last_used_idx = 0;
> >  	vq->event_triggered = false;
> >  	vq->num_added = 0;
> > @@ -2135,9 +2139,13 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> >  	}
> >
> >  	if (unlikely(vq->broken)) {
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >  		dev_warn_once(&vq->vq.vdev->dev,
> >  			      "virtio vring IRQ raised before DRIVER_OK");
> >  		return IRQ_NONE;
> > +#else
> > +		return IRQ_HANDLED;
> > +#endif
> >  	}
> >
> >  	/* Just a hint for performance: so it's ok that this can be racy! */
> > @@ -2180,7 +2188,11 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> >  	vq->we_own_ring = false;
> >  	vq->notify = notify;
> >  	vq->weak_barriers = weak_barriers;
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >  	vq->broken = true;
> > +#else
> > +	vq->broken = false;
> > +#endif
> >  	vq->last_used_idx = 0;
> >  	vq->event_triggered = false;
> >  	vq->num_added = 0;
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > index 9a36051ceb76..d15c3cdda2d2 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -257,6 +257,7 @@ void virtio_device_ready(struct virtio_device *dev)
> >
> >  	WARN_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> >
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >  	/*
> >  	 * The virtio_synchronize_cbs() makes sure vring_interrupt()
> >  	 * will see the driver specific setup if it sees vq->broken
> > @@ -264,6 +265,7 @@ void virtio_device_ready(struct virtio_device *dev)
> >  	 */
> >  	virtio_synchronize_cbs(dev);
> >  	__virtio_unbreak_device(dev);
> > +#endif
> >  	/*
> >  	 * The transport should ensure the visibility of vq->broken
> >  	 * before setting DRIVER_OK. See the comments for the transport
> > --
> > 2.25.1
> >
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
