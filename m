Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00072C43334
	for <virtualization@archiver.kernel.org>; Tue, 21 Jun 2022 09:36:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7DA5D408DD;
	Tue, 21 Jun 2022 09:36:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7DA5D408DD
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i4KS9I/2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mZYJ0cwe9cJW; Tue, 21 Jun 2022 09:36:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8E9C24091D;
	Tue, 21 Jun 2022 09:36:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8E9C24091D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F8EBC0032;
	Tue, 21 Jun 2022 09:36:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E288FC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 09:36:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB3BF4091D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 09:36:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CB3BF4091D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DWp81fP51-8J
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 09:36:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4FF23408DD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4FF23408DD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 09:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655804197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NcXrei2y1YJ8W4iMhBTE/8lC+VPJchskiCKRKCR2d9s=;
 b=i4KS9I/2XQCQTAPK5aPHsCn79CcE0vQYaDZSk40VxSdne0XByS80xZ+v0Z0EtQnqFkr3bm
 iPzeBE3CF3bygg25ueG/zQFKSriJsrUf00uPzCZG/Wtvf7/zX9AnF2sdvHWjrOZNXHQQca
 vsnla0Rc2ugbC/wNEO2/y9MDyZSbGJo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-kYoZjSl-ORyxf2lnaZRupQ-1; Tue, 21 Jun 2022 05:36:36 -0400
X-MC-Unique: kYoZjSl-ORyxf2lnaZRupQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 bi38-20020a0565120ea600b0047f640eaee0so3386181lfb.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 02:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NcXrei2y1YJ8W4iMhBTE/8lC+VPJchskiCKRKCR2d9s=;
 b=iZ1iMinlR9yAA/KWm1NGbG00PpRO0OnaDvCuB3ZoSdG1xuj9YiDIMUGH3bWjeBNNUp
 U62ozhwuDpwXG1tfM7cgS1zPaq8dtT/WWtCPD2wTuHgI7SLYVli7Q6bOEnkt1OG9IEh+
 IWCs2j3sZWeDWgb03I3rJftujXIIddPdtjvcLzP0Xkl5d1U7s17OPvETvm03XhNj2aAT
 HlDWLjYu9TBs0dd0MsUO54dT/SW8BVbulcN9C2XoRliKWFKB9/jHKecPVRGIopaE5Cek
 3CSljzKRECdqejoJEMQM5hKvSrbjzmKoaEDQPuWEkbBQjxnkydAjTCW+6+u7Z5WW+vs3
 Kn0A==
X-Gm-Message-State: AJIora8vsOTPmp/onKHXNa+t7JFaZO1t/3Wlu1UaZuI2HNOQ3bmraEd6
 XMtNky1/bNb0fUqp5jUIm5wc5Nuac2shc3DYX3wrsYnWKWyMx7RFen0aIN863Z8sOhw8J9SRogU
 1pBk5Yc42otvy6zKYh/B9Xx1FyZSKiT1sLuOlQZiKTjLmvCYt0xFBlfDTxQ==
X-Received: by 2002:a05:6512:13a5:b0:47d:c1d9:dea8 with SMTP id
 p37-20020a05651213a500b0047dc1d9dea8mr16179013lfa.442.1655804194871; 
 Tue, 21 Jun 2022 02:36:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vYHin7RcteM0oZeoqpcOaahexAusmGmc0X7KmU5H3LSzGjszNsAIJFXEvBb7MZram6VDes8GvKxQzQWHh+L8w=
X-Received: by 2002:a05:6512:13a5:b0:47d:c1d9:dea8 with SMTP id
 p37-20020a05651213a500b0047dc1d9dea8mr16178998lfa.442.1655804194646; Tue, 21
 Jun 2022 02:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220620024158.2505-1-jasowang@redhat.com>
 <87y1xq8jgw.fsf@redhat.com>
In-Reply-To: <87y1xq8jgw.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Jun 2022 17:36:23 +0800
Message-ID: <CACGkMEun6C9RgQVGq1B8BJMd9DyRQkSXj8shXVVhDymQYQLxgA@mail.gmail.com>
Subject: Re: [PATCH V2] virtio: disable notification hardening by default
To: Cornelia Huck <cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-s390@vger.kernel.org, kvm <kvm@vger.kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, mst <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
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

On Tue, Jun 21, 2022 at 5:16 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Mon, Jun 20 2022, Jason Wang <jasowang@redhat.com> wrote:
>
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
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > Changes since V1:
> > - tweak the Kconfig prompt
> > - don't hold spinlock for IRQ path in s390
> > ---
> >  drivers/s390/virtio/virtio_ccw.c |  4 ++++
> >  drivers/virtio/Kconfig           | 11 +++++++++++
> >  drivers/virtio/virtio.c          |  2 ++
> >  drivers/virtio/virtio_ring.c     | 12 ++++++++++++
> >  include/linux/virtio_config.h    |  2 ++
> >  5 files changed, 31 insertions(+)
> >
> > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > index 97e51c34e6cf..89bbf7ccfdd1 100644
> > --- a/drivers/s390/virtio/virtio_ccw.c
> > +++ b/drivers/s390/virtio/virtio_ccw.c
> > @@ -1136,8 +1136,10 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> >                       vcdev->err = -EIO;
> >       }
> >       virtio_ccw_check_activity(vcdev, activity);
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >       /* Interrupts are disabled here */
> >       read_lock(&vcdev->irq_lock);
>
> Should we add a comment that this pairs with
> virtio_ccw_synchronize_cbs()? Just to avoid future headscratching as to
> why this lock is only needed when notification hardening is enabled.

Fine.

>
> > +#endif
> >       for_each_set_bit(i, indicators(vcdev),
> >                        sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
> >               /* The bit clear must happen before the vring kick. */
> > @@ -1146,7 +1148,9 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> >               vq = virtio_ccw_vq_by_ind(vcdev, i);
> >               vring_interrupt(0, vq);
> >       }
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >       read_unlock(&vcdev->irq_lock);
> > +#endif
> >       if (test_bit(0, indicators2(vcdev))) {
> >               virtio_config_changed(&vcdev->vdev);
> >               clear_bit(0, indicators2(vcdev));
> > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > index b5adf6abd241..96ec56d44b91 100644
> > --- a/drivers/virtio/Kconfig
> > +++ b/drivers/virtio/Kconfig
> > @@ -35,6 +35,17 @@ menuconfig VIRTIO_MENU
> >
> >  if VIRTIO_MENU
> >
> > +config VIRTIO_HARDEN_NOTIFICATION
> > +        bool "Harden virtio notification"
> > +        help
> > +          Enable this to harden the device notifications and supress
> > +          the ones that are illegal.
>
> "...and suppress those that happen at a time where notifications are
> illegal." ?

Ok.

>
> > +
> > +          Experimental: not all drivers handle this correctly at this
> > +          point.
>
> "Note that several drivers still have bugs that may cause crashes or
> hangs when correct handling of notifications is enforced; depending on
> the subset of drivers and devices you use, this may or may not work."
>
> Or is that too verbose?

Looks fine.

>
> > +
> > +          If unsure, say N.
> > +
> >  config VIRTIO_PCI
> >       tristate "PCI driver for virtio devices"
> >       depends on PCI
>
> The ifdeffery looks a big ugly, but I don't have a better idea.

I guess you meant the ccw part, I leave the spinlock here in V1, but
Michael prefers to have that.

In the future, we may consider removing that, one possible way is to
have a per driver boolean for the hardening.

Tanks

>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
