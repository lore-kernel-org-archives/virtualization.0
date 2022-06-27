Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A80CC433EF
	for <virtualization@archiver.kernel.org>; Mon, 27 Jun 2022 08:18:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ED7F840BD0;
	Mon, 27 Jun 2022 08:18:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ED7F840BD0
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R3U8/Evm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ctQ7ayLIy342; Mon, 27 Jun 2022 08:18:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7F68440BCC;
	Mon, 27 Jun 2022 08:18:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7F68440BCC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52B3EC0032;
	Mon, 27 Jun 2022 08:18:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04C31C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 08:18:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CC2B4415BA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 08:18:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC2B4415BA
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=R3U8/Evm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EOvNpmbj1J7k
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 08:18:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BD49D4094C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BD49D4094C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 08:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656317888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OPtn4J82OzWsDsVXNRibX7f2Ro4efWlqotHQQJeFEvk=;
 b=R3U8/EvmMWizRkCBzv/ew+E1T7qmsPuOSukCFtmGQp0u8AE0tVCrxgqkaZgGB80YDbBGCq
 +wrwISe4GqvCt+UxhhPxwle60jLTflfnPZulwCpMk4rG+QjVY5MmvTfxwiZC2LtYk36zkG
 toGD4Zk2ll5uZiNv0weiSmWOC+wQRRQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-gHNBwLfZP_KyzJ2Zz0wlkQ-1; Mon, 27 Jun 2022 04:18:07 -0400
X-MC-Unique: gHNBwLfZP_KyzJ2Zz0wlkQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 be18-20020a056512251200b0048120ff434dso554156lfb.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 01:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OPtn4J82OzWsDsVXNRibX7f2Ro4efWlqotHQQJeFEvk=;
 b=JqLI7Hm7tjTqEuxVDM9BYeo3O78w/3l8TN+ljDJ13oi1KbWKlI8JzmiSrcFtuQqiyq
 V729bWsriptJmKxcEti42uGjXmFOJIDofCQ8Wxh6FuhB8JPaBOhMvD+x7gA67hnczhdA
 b+iDw+SelG0reR+IGKCbYPtBD67c22mMC+bYAHM0FcRno1Db71ArYajKadmgUqmZM/Uk
 mNeBPx9yJUfNwSmrgKlJ7+P4Kc23045AsqzrZHDqQmhvRENLSKQyOmJxA9bxA9NmRNUi
 J0llSQMJUbJTEsADl11sHvDclb4YOgjo6kzrwm+rvskQ8rLy1dAgd012TkZmaMGMc9/L
 6UGQ==
X-Gm-Message-State: AJIora94v+ayalkqGzhcqUlEibl32tcGZoSEfAVRQKiAoPr0hMNT5qtA
 zms2Ydnd8G874Ok+50nwUlVjTEHOnnxGn2Cz2ICdP3XYCtbWC8hSZCKeW/GDk8WUttFQo+LSUJM
 3DUZ/zIoz96Jn5QOaAyFdACrf575SzRfifWoDlXM1hcc/i/I6yQmzkHgF3g==
X-Received: by 2002:ac2:51a5:0:b0:47f:79a1:5c02 with SMTP id
 f5-20020ac251a5000000b0047f79a15c02mr7378511lfk.575.1656317885573; 
 Mon, 27 Jun 2022 01:18:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ud5rlcp28+Fmhb5gpV7n5UDaClclIIoV1luhzWBK2LZrI8iuHqy4DEqfW17VF71T1X3oIofm19Bk+5PrzQAPI=
X-Received: by 2002:ac2:51a5:0:b0:47f:79a1:5c02 with SMTP id
 f5-20020ac251a5000000b0047f79a15c02mr7378505lfk.575.1656317885391; Mon, 27
 Jun 2022 01:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220627063656.52397-1-jasowang@redhat.com>
 <20220627033422-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220627033422-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 Jun 2022 16:17:54 +0800
Message-ID: <CACGkMEvhk1UmcMNhYFb8dceoLnNs5Jr4WmKaQ++ZVgR2sOu1QQ@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix race between ndo_open() and
 virtio_device_ready()
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>,
 davem <davem@davemloft.net>, linux-kernel <linux-kernel@vger.kernel.org>,
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

On Mon, Jun 27, 2022 at 3:44 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jun 27, 2022 at 02:36:56PM +0800, Jason Wang wrote:
> > We used to call virtio_device_ready() after netdev registration.
>
> s/used to call/currently call/
>
> > This
> > cause
>
> s/This cause/Since ndo_open can be called immediately
> after register_netdev, this means there exists/
>
> > a race between ndo_open() and virtio_device_ready(): if
> > ndo_open() is called before virtio_device_ready(), the driver may
> > start to use the device before DRIVER_OK which violates the spec.
> >
> > Fixing
>
> s/Fixing/Fix/
>
> > this by switching to use register_netdevice() and protect the
> > virtio_device_ready() with rtnl_lock() to make sure ndo_open() can
> > only be called after virtio_device_ready().
> >
> > Fixes: 4baf1e33d0842 ("virtio_net: enable VQs early")
>
> it's an unusual use of Fixes - the patch in question does not
> introduce the problem, it just does not fix it completely.

Yes, but I couldn't find a better commit.

> But OK I guess.
>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> With commit log changes:

Will post a new version with the above fixed.

Thanks

>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> > ---
> >  drivers/net/virtio_net.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index db05b5e930be..8a5810bcb839 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3655,14 +3655,20 @@ static int virtnet_probe(struct virtio_device *vdev)
> >       if (vi->has_rss || vi->has_rss_hash_report)
> >               virtnet_init_default_rss(vi);
> >
> > -     err = register_netdev(dev);
> > +     /* serialize netdev register + virtio_device_ready() with ndo_open() */
> > +     rtnl_lock();
> > +
> > +     err = register_netdevice(dev);
> >       if (err) {
> >               pr_debug("virtio_net: registering device failed\n");
> > +             rtnl_unlock();
> >               goto free_failover;
> >       }
> >
> >       virtio_device_ready(vdev);
> >
> > +     rtnl_unlock();
> > +
> >       err = virtnet_cpu_notif_add(vi);
> >       if (err) {
> >               pr_debug("virtio_net: registering cpu notifier failed\n");
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
