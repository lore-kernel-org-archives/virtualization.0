Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D7EC433EF
	for <virtualization@archiver.kernel.org>; Fri, 17 Jun 2022 11:47:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E313981428;
	Fri, 17 Jun 2022 11:47:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E313981428
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AkZmWCvw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id djb6w58InvFA; Fri, 17 Jun 2022 11:47:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5880781415;
	Fri, 17 Jun 2022 11:47:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5880781415
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DA3EC0039;
	Fri, 17 Jun 2022 11:47:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C965BC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 11:47:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9550140181
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 11:47:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9550140181
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AkZmWCvw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FEERSX7MzzzB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 11:47:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9E3FD400E5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9E3FD400E5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 11:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655466455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sjDQFwJzUbTNmx5JYS5EoPwX+v2MHv1quBw00Z1i85g=;
 b=AkZmWCvwUkQK7ZB0qzVEQ0Bl4Ph6VhmLC9HsPHs4fKmkXl7Y86hkJT0w7esu8/50lcK73e
 TgEo8sJbYCj91miRLe7YRrXRR1ZnUZRsWC+3+FaQcIFGUlZH9YnOrj9j5M+ki/tuqG/Wna
 VghHNWt/Lngnea6nFG6yslVwMDTcFRw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-gCLgo70lPeK0puJ9dZ7lNg-1; Fri, 17 Jun 2022 07:47:34 -0400
X-MC-Unique: gCLgo70lPeK0puJ9dZ7lNg-1
Received: by mail-lf1-f71.google.com with SMTP id
 l12-20020a056512110c00b0047961681d22so2261316lfg.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 04:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sjDQFwJzUbTNmx5JYS5EoPwX+v2MHv1quBw00Z1i85g=;
 b=aGBvFrbkENxzIuy9F+0PqRo9LOr5GykyTmd+nrSLim2O65E+MfmMAGNFkf9HmPpLbk
 Sq4oDZ6SgugdzPZcw6ZtV0QBpGN0Zn9Tk+L1BmXro+S50FJ3/h1XGR8z7IYBQnBFyISJ
 fvmUqXYa5ss6kSKbRhHfviEAGXS4d2dCl4nhnIwjviZRYjkYnMJsXGuwcwu57FgDbKhC
 7IsDgdylpySqN5uPBHHTrJxzOarllQPYdpCi5u2RmXbCH5cTEdOn/gwiliZq3HvSwr4O
 lsdkmEEcryC2OkWxg7DDsPFNZG3glG2W+j7+/XjVNwMN5Ptzn1RxSU4+Bpgrxu+eAgut
 yKmw==
X-Gm-Message-State: AJIora+fREju9DvN48i3G+321nhbJDtHLF+A76VYaJgm5ahElUCZPbUR
 GGf7q11vVb9lIQ/JABBpF9JKUKCXm1AJSlrz0ftwXMOQLT6PpK/kFYSdltjcoRwH8h/K2qZgOXU
 7pckO1OMxHLUJ3j1PGV1PZsuuvDvan4ZucwdBwLmOwO7BBK/TbsQ0txRuNw==
X-Received: by 2002:a05:6512:1047:b0:479:7805:5f with SMTP id
 c7-20020a056512104700b004797805005fmr5480997lfb.238.1655466452709; 
 Fri, 17 Jun 2022 04:47:32 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vsA2h2VwhQVyDmfmK0zw2nue8iMARvRgpx2KzikIV14kLezZ2kWnli9gvS2xSPBzPxb+ykQuVHaGLmaXgjO6o=
X-Received: by 2002:a05:6512:1047:b0:479:7805:5f with SMTP id
 c7-20020a056512104700b004797805005fmr5480981lfb.238.1655466452430; Fri, 17
 Jun 2022 04:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220617072626.30503-1-jasowang@redhat.com>
 <20220617060111-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220617060111-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 17 Jun 2022 19:47:21 +0800
Message-ID: <CACGkMEsx77aTyx84Q6OAmogni97nt3wWsRguzTBKY8msqrYK-A@mail.gmail.com>
Subject: Re: [PATCH] virtio: disable notification hardening by default
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Fri, Jun 17, 2022 at 6:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Jun 17, 2022 at 03:26:26PM +0800, Jason Wang wrote:
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
>
>
> Do you want to drop irq_lock lock/unlock in ccw too?

Not a must I think. But if you insist, I can remove them.

Thanks

>
> > ---
> >  drivers/virtio/Kconfig        |  6 ++++++
> >  drivers/virtio/virtio.c       |  2 ++
> >  drivers/virtio/virtio_ring.c  | 12 ++++++++++++
> >  include/linux/virtio_config.h |  2 ++
> >  4 files changed, 22 insertions(+)
> >
> > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > index b5adf6abd241..b059c39af3d4 100644
> > --- a/drivers/virtio/Kconfig
> > +++ b/drivers/virtio/Kconfig
> > @@ -35,6 +35,12 @@ menuconfig VIRTIO_MENU
> >
> >  if VIRTIO_MENU
> >
> > +config VIRTIO_HARDEN_NOTIFICATION
> > +        bool "Harden virtio notification"
> > +        help
> > +          Enable to this to harden the device notifications and
> > +          supress the ones that are illegal.
> > +
> >  config VIRTIO_PCI
> >       tristate "PCI driver for virtio devices"
> >       depends on PCI
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index ef04a96942bf..21dc08d2f32d 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -220,6 +220,7 @@ static int virtio_features_ok(struct virtio_device *dev)
> >   * */
> >  void virtio_reset_device(struct virtio_device *dev)
> >  {
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >       /*
> >        * The below virtio_synchronize_cbs() guarantees that any
> >        * interrupt for this line arriving after
> > @@ -228,6 +229,7 @@ void virtio_reset_device(struct virtio_device *dev)
> >        */
> >       virtio_break_device(dev);
> >       virtio_synchronize_cbs(dev);
> > +#endif
> >
> >       dev->config->reset(dev);
> >  }
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 13a7348cedff..d9d3b6e201fb 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1688,7 +1688,11 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >       vq->we_own_ring = true;
> >       vq->notify = notify;
> >       vq->weak_barriers = weak_barriers;
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >       vq->broken = true;
> > +#else
> > +     vq->broken = false;
> > +#endif
> >       vq->last_used_idx = 0;
> >       vq->event_triggered = false;
> >       vq->num_added = 0;
> > @@ -2135,9 +2139,13 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> >       }
> >
> >       if (unlikely(vq->broken)) {
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >               dev_warn_once(&vq->vq.vdev->dev,
> >                             "virtio vring IRQ raised before DRIVER_OK");
> >               return IRQ_NONE;
> > +#else
> > +             return IRQ_HANDLED;
> > +#endif
> >       }
> >
> >       /* Just a hint for performance: so it's ok that this can be racy! */
> > @@ -2180,7 +2188,11 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> >       vq->we_own_ring = false;
> >       vq->notify = notify;
> >       vq->weak_barriers = weak_barriers;
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >       vq->broken = true;
> > +#else
> > +     vq->broken = false;
> > +#endif
> >       vq->last_used_idx = 0;
> >       vq->event_triggered = false;
> >       vq->num_added = 0;
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > index 9a36051ceb76..d15c3cdda2d2 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -257,6 +257,7 @@ void virtio_device_ready(struct virtio_device *dev)
> >
> >       WARN_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> >
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >       /*
> >        * The virtio_synchronize_cbs() makes sure vring_interrupt()
> >        * will see the driver specific setup if it sees vq->broken
> > @@ -264,6 +265,7 @@ void virtio_device_ready(struct virtio_device *dev)
> >        */
> >       virtio_synchronize_cbs(dev);
> >       __virtio_unbreak_device(dev);
> > +#endif
> >       /*
> >        * The transport should ensure the visibility of vq->broken
> >        * before setting DRIVER_OK. See the comments for the transport
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
