Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41532C43334
	for <virtualization@archiver.kernel.org>; Fri, 17 Jun 2022 12:34:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFFFA84564;
	Fri, 17 Jun 2022 12:34:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CFFFA84564
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SjwTb5Ht
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DRaCvRvgL1VE; Fri, 17 Jun 2022 12:34:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 251348455B;
	Fri, 17 Jun 2022 12:34:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 251348455B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A479C0032;
	Fri, 17 Jun 2022 12:34:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D25DC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 12:34:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 55A4160E51
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 12:34:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 55A4160E51
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SjwTb5Ht
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NSz1F3iBmaQh
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 12:34:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6468B60B53
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6468B60B53
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 12:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655469255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sNsK5VV48v+4Pt6W8O4pM7sdsWEZT55OqmvpYIk2hsQ=;
 b=SjwTb5Ht4zgqOwe9BgqqEJiKls4sTWYAqniFeX7ZIvGzsORO56J3tMLvcy3WWQch9okLeZ
 UFg/IODHXEkafntUxS+UJiGBwrzGYbujK7wLv+sDYc/vVPGch7vUuAJf7ZgrjuIziVw2MA
 hMsxPMNlQnC8a21ksWYMI/Q88xS9F4A=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-avCvCTE2Nk6Js32T2u4jeg-1; Fri, 17 Jun 2022 08:34:14 -0400
X-MC-Unique: avCvCTE2Nk6Js32T2u4jeg-1
Received: by mail-ed1-f69.google.com with SMTP id
 b7-20020a056402350700b004355e4d1e36so1388687edd.10
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 05:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sNsK5VV48v+4Pt6W8O4pM7sdsWEZT55OqmvpYIk2hsQ=;
 b=ToH5qj/rx0vZtQyiKSK1+9f+5zV8gdf8Kwjv2q3Zyh9aiVMdwmw+OXXUjPkV+YesXv
 En9s3fGhqKfByuy1Z1gHvGipM66BR1HI3VCPucLp+b39VR/ajaVswSvlTi3SPY5W97mN
 WGT5fswMZKEIE74x8AnazSRtNGSrW7VojAf0wISZhBEgJ3VDXlZmiWpALZ0AyBrEp35h
 qvH1666tPkjKPCwCFllutirajS/HrSmxJv07Vq5lltYiHqvd2c0c8vnH/Z79El1S2RBm
 alairEBPcJhpp1SXsylll3wF8znmRcad9YFV9x1ebppq92Boz9cBTooKfbddnIk45/FY
 xmHA==
X-Gm-Message-State: AJIora/MJstrxJ6nd+5SR2L1pLtiTuoucoENxKBtF8Eg1auGnX6qzlI2
 n81cXu4GDfmf3h5gAZRgyS2adOW9d9Uv5dnENNV9KHdkV5I34rT2lhAYKt3docSEFE+u5VT/M2o
 ptwHm+QO2jWtEDa7MCHRPJ4cJ31zaZwgl9Xo8NaGnxQ==
X-Received: by 2002:a17:906:a57:b0:718:bd7e:e45b with SMTP id
 x23-20020a1709060a5700b00718bd7ee45bmr8973405ejf.204.1655469252665; 
 Fri, 17 Jun 2022 05:34:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uetBAoDUswjTrKzjPLBZk+a2VJDZzU+POciodvxjH1l6wMuN3Sr6EJUi2y+5mbeAOAFWQM3Q==
X-Received: by 2002:a17:906:a57:b0:718:bd7e:e45b with SMTP id
 x23-20020a1709060a5700b00718bd7ee45bmr8973378ejf.204.1655469252385; 
 Fri, 17 Jun 2022 05:34:12 -0700 (PDT)
Received: from redhat.com ([2.54.189.19]) by smtp.gmail.com with ESMTPSA id
 g18-20020a17090604d200b0070d9aad64a1sm2041541eja.208.2022.06.17.05.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jun 2022 05:34:11 -0700 (PDT)
Date: Fri, 17 Jun 2022 08:34:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio: disable notification hardening by default
Message-ID: <20220617083353-mutt-send-email-mst@kernel.org>
References: <20220617072626.30503-1-jasowang@redhat.com>
 <20220617060111-mutt-send-email-mst@kernel.org>
 <CACGkMEsx77aTyx84Q6OAmogni97nt3wWsRguzTBKY8msqrYK-A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsx77aTyx84Q6OAmogni97nt3wWsRguzTBKY8msqrYK-A@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Fri, Jun 17, 2022 at 07:47:21PM +0800, Jason Wang wrote:
> On Fri, Jun 17, 2022 at 6:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Jun 17, 2022 at 03:26:26PM +0800, Jason Wang wrote:
> > > We try to harden virtio device notifications in 8b4ec69d7e09 ("virtio:
> > > harden vring IRQ"). It works with the assumption that the driver or
> > > core can properly call virtio_device_ready() at the right
> > > place. Unfortunately, this seems to be not true and uncover various
> > > bugs of the existing drivers, mainly the issue of using
> > > virtio_device_ready() incorrectly.
> > >
> > > So let's having a Kconfig option and disable it by default. It gives
> > > us a breath to fix the drivers and then we can consider to enable it
> > > by default.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> >
> > Do you want to drop irq_lock lock/unlock in ccw too?
> 
> Not a must I think. But if you insist, I can remove them.
> 
> Thanks


With the ifdef. Seems safer ...

> >
> > > ---
> > >  drivers/virtio/Kconfig        |  6 ++++++
> > >  drivers/virtio/virtio.c       |  2 ++
> > >  drivers/virtio/virtio_ring.c  | 12 ++++++++++++
> > >  include/linux/virtio_config.h |  2 ++
> > >  4 files changed, 22 insertions(+)
> > >
> > > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > > index b5adf6abd241..b059c39af3d4 100644
> > > --- a/drivers/virtio/Kconfig
> > > +++ b/drivers/virtio/Kconfig
> > > @@ -35,6 +35,12 @@ menuconfig VIRTIO_MENU
> > >
> > >  if VIRTIO_MENU
> > >
> > > +config VIRTIO_HARDEN_NOTIFICATION
> > > +        bool "Harden virtio notification"
> > > +        help
> > > +          Enable to this to harden the device notifications and
> > > +          supress the ones that are illegal.
> > > +
> > >  config VIRTIO_PCI
> > >       tristate "PCI driver for virtio devices"
> > >       depends on PCI
> > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > index ef04a96942bf..21dc08d2f32d 100644
> > > --- a/drivers/virtio/virtio.c
> > > +++ b/drivers/virtio/virtio.c
> > > @@ -220,6 +220,7 @@ static int virtio_features_ok(struct virtio_device *dev)
> > >   * */
> > >  void virtio_reset_device(struct virtio_device *dev)
> > >  {
> > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > >       /*
> > >        * The below virtio_synchronize_cbs() guarantees that any
> > >        * interrupt for this line arriving after
> > > @@ -228,6 +229,7 @@ void virtio_reset_device(struct virtio_device *dev)
> > >        */
> > >       virtio_break_device(dev);
> > >       virtio_synchronize_cbs(dev);
> > > +#endif
> > >
> > >       dev->config->reset(dev);
> > >  }
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 13a7348cedff..d9d3b6e201fb 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -1688,7 +1688,11 @@ static struct virtqueue *vring_create_virtqueue_packed(
> > >       vq->we_own_ring = true;
> > >       vq->notify = notify;
> > >       vq->weak_barriers = weak_barriers;
> > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > >       vq->broken = true;
> > > +#else
> > > +     vq->broken = false;
> > > +#endif
> > >       vq->last_used_idx = 0;
> > >       vq->event_triggered = false;
> > >       vq->num_added = 0;
> > > @@ -2135,9 +2139,13 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> > >       }
> > >
> > >       if (unlikely(vq->broken)) {
> > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > >               dev_warn_once(&vq->vq.vdev->dev,
> > >                             "virtio vring IRQ raised before DRIVER_OK");
> > >               return IRQ_NONE;
> > > +#else
> > > +             return IRQ_HANDLED;
> > > +#endif
> > >       }
> > >
> > >       /* Just a hint for performance: so it's ok that this can be racy! */
> > > @@ -2180,7 +2188,11 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> > >       vq->we_own_ring = false;
> > >       vq->notify = notify;
> > >       vq->weak_barriers = weak_barriers;
> > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > >       vq->broken = true;
> > > +#else
> > > +     vq->broken = false;
> > > +#endif
> > >       vq->last_used_idx = 0;
> > >       vq->event_triggered = false;
> > >       vq->num_added = 0;
> > > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > > index 9a36051ceb76..d15c3cdda2d2 100644
> > > --- a/include/linux/virtio_config.h
> > > +++ b/include/linux/virtio_config.h
> > > @@ -257,6 +257,7 @@ void virtio_device_ready(struct virtio_device *dev)
> > >
> > >       WARN_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> > >
> > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > >       /*
> > >        * The virtio_synchronize_cbs() makes sure vring_interrupt()
> > >        * will see the driver specific setup if it sees vq->broken
> > > @@ -264,6 +265,7 @@ void virtio_device_ready(struct virtio_device *dev)
> > >        */
> > >       virtio_synchronize_cbs(dev);
> > >       __virtio_unbreak_device(dev);
> > > +#endif
> > >       /*
> > >        * The transport should ensure the visibility of vq->broken
> > >        * before setting DRIVER_OK. See the comments for the transport
> > > --
> > > 2.25.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
