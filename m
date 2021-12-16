Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264B9C43217
	for <virtualization@archiver.kernel.org>; Thu, 16 Dec 2021 02:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CAB91416AA;
	Thu, 16 Dec 2021 02:55:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CNWcWRYHmPaW; Thu, 16 Dec 2021 02:55:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 67E06416A7;
	Thu, 16 Dec 2021 02:55:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B2CBC002F;
	Thu, 16 Dec 2021 02:55:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 773A4C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 02:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5100D60FB2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 02:55:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uBwpQTCaXYCU
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 02:55:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A80A760F94
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 02:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639623340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lHb0FpSfdJrFyMaV6hFgu2fdNBhYpmwh4Vr9EjdXA7I=;
 b=V7fqPzTa+FNC/KA/T5F/6eKRLNu/uANt/jlpw9NPhbhzHm5Tsgx6PxWAhFi3qBsdff4Nga
 oAaqHsCEWKOlwCq/NxUXbcJFqnVdGM8yMczd4BuGcQiU5dlN9hgPb9kwPAjCzme0G77og6
 6o4B3/ONMI+9uS14kF2RW0qjMQG+//4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-VaZBkSlKP0mKsGKccm3RXA-1; Wed, 15 Dec 2021 21:55:38 -0500
X-MC-Unique: VaZBkSlKP0mKsGKccm3RXA-1
Received: by mail-lj1-f200.google.com with SMTP id
 a7-20020a05651c210700b00219132ab503so7916217ljq.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 18:55:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lHb0FpSfdJrFyMaV6hFgu2fdNBhYpmwh4Vr9EjdXA7I=;
 b=538Xg19jK7Z8DoskqLdrrSYFw6C4IaEZQBMU2ZYRgtAzFVKfTmCgcgRPuPjSMzRn1i
 5Je8kDTvCUJBE+Mw+gWTQRr4GQOxyFXwKOoDfRJGBsd/30ykWQeiFGU8TzWFxQG+8tCK
 Kgno0ddcpR4mqcPOhqdiEJdL9/RiZP9v0NnJJIOi8plVAeiZqxd8+IjXvLfg3ZDWJ5g4
 XRL4DGFhA8Vt+X5ps1YQallxE2/PDTYfAxXMKykxg1xhBZRnrwZMNCjPD+xqMGdH6gAL
 jlCw8Mz0JjxWjkn9LO75ECiBdvwpnXrwYrJfsqrylQg99Lg8jZ9n1NTSgYKiC3M2Lu2e
 8tVg==
X-Gm-Message-State: AOAM531g4Aw1i0adcP+E88WrHR6sJTQ+YNojW2M3o9WVJj/+ajZr7Be6
 IdxjJctCfw6ADH6MbCycEQTXHy00EiD8Qwp2wa3u/jVs6wEudtmyz8znAOygUo1sjjBeqdmuGZI
 bOHNkB3HLyy8FuLzOKmmz8+NZQy2Bu9KcPx7fM9LHdoR3fP4GnFLIgXl++Q==
X-Received: by 2002:ac2:50c6:: with SMTP id h6mr13087318lfm.580.1639623337212; 
 Wed, 15 Dec 2021 18:55:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEaePdKwOsy6o2ElaN+kafbYdaIkSCJskpkCCD/qWZS+GwLQO/M7hxc16ufrBlfJopt6w+yPAPlHUPigIX++Q=
X-Received: by 2002:ac2:50c6:: with SMTP id h6mr13087306lfm.580.1639623337053; 
 Wed, 15 Dec 2021 18:55:37 -0800 (PST)
MIME-Version: 1.0
References: <20211214163249.GA253555@opensynergy.com>
 <20211214182611-mutt-send-email-mst@kernel.org>
 <20211215172739.GA77225@opensynergy.com>
In-Reply-To: <20211215172739.GA77225@opensynergy.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 Dec 2021 10:55:25 +0800
Message-ID: <CACGkMEvLD-qSR4KDSjnq+LJTEaoHoqm1NySUnBvOUGhV9LTxEg@mail.gmail.com>
Subject: Re: [RFC PATCH] virtio: do not reset stateful devices on resume
To: Mikhail Golubev <mgo@opensynergy.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
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

On Thu, Dec 16, 2021 at 1:27 AM Mikhail Golubev <mgo@opensynergy.com> wrote:
>
> The 12/14/2021 18:26, Michael S. Tsirkin wrote:
> > On Tue, Dec 14, 2021 at 05:33:05PM +0100, Mikhail Golubev wrote:
> > > From: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
> > >
> > > We assume that stateful devices can maintain their state while
> > > suspended. And for this reason they don't have a freeze callback. If
> > > such a device is reset during resume, the device state/context will be
> > > lost on the device side. And the virtual device will stop working.
> > >
> > > Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
> > > Signed-off-by: Mikhail Golubev <mikhail.golubev@opensynergy.com>
> >
> > A bit more specific? Which configs does this patch fix?
>
> We had encountered an issue related to 'stateful' GPU 3d (virglrenderer) and
> video (gstreamer) devices.

Adding Gerd and Stefan.

I wonder if we suffer from a similar issue with virtio-fs.

Thanks

>
> BR,
> Mikhail
>
> >
> > > ---
> > >  drivers/virtio/virtio.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > index 236081afe9a2..defa15b56eb8 100644
> > > --- a/drivers/virtio/virtio.c
> > > +++ b/drivers/virtio/virtio.c
> > > @@ -472,6 +472,13 @@ int virtio_device_restore(struct virtio_device *dev)
> > >     struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> > >     int ret;
> > >
> > > +   /* Short path for stateful devices. Here we assume that if the device
> > > +    * does not have a freeze callback, its state was not changed when
> > > +    * suspended.
> > > +    */
> > > +   if (drv && !drv->freeze)
> > > +           goto on_config_enable;
> > > +
> > >     /* We always start by resetting the device, in case a previous
> > >      * driver messed it up. */
> > >     dev->config->reset(dev);
> > > @@ -503,6 +510,7 @@ int virtio_device_restore(struct virtio_device *dev)
> > >     /* Finally, tell the device we're all set */
> > >     virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
> > >
> > > +on_config_enable:
> > >     virtio_config_enable(dev);
> > >
> > >     return 0;
> > > --
> > > 2.34.1
> > >
> > >
> > > --
> >
>
> --
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
