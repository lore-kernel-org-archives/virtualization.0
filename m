Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1565C43334
	for <virtualization@archiver.kernel.org>; Fri, 17 Jun 2022 12:33:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0E8D641106;
	Fri, 17 Jun 2022 12:33:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0E8D641106
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WuQ3MeR0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I_WWuvQ2buot; Fri, 17 Jun 2022 12:33:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 03078405E9;
	Fri, 17 Jun 2022 12:33:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 03078405E9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B24BC0032;
	Fri, 17 Jun 2022 12:33:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D238C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 12:33:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E589E60E51
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 12:33:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E589E60E51
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WuQ3MeR0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w-Z2QotcdwW6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 12:33:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 064F260B53
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 064F260B53
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 12:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655469182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=92UlDs3RgFNfmwdasYrOfS3jw16tdOBEhgL58+p+c74=;
 b=WuQ3MeR0sXBUPv9us2tVCxtjfad63GnSez8l3yFY+ODrygdg3sSJ8FrV/2BL0e3fC6Gca0
 2BVunJCqqyx/5C3IJxWU/x5wdlE+M+XjTcEsqBOdCjgb6BUxEcJMIq2RDOTi7c4UeRTor9
 Bf8Rj2Io03RIQd1YnhWnt/uVzB0x9d0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-5GHhOGUJNMKqFzQ0n3f8LA-1; Fri, 17 Jun 2022 08:33:01 -0400
X-MC-Unique: 5GHhOGUJNMKqFzQ0n3f8LA-1
Received: by mail-wr1-f72.google.com with SMTP id
 n7-20020adfc607000000b0021a37d8f93aso956470wrg.21
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 05:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=92UlDs3RgFNfmwdasYrOfS3jw16tdOBEhgL58+p+c74=;
 b=KzZXQnrJzqhgLRfsFL7ad5dQFTkguLBBHa9zhFT6GZvR5Q4knyTpgbIjo+z4fvkELn
 YoalbhasjDxYnymP16GIF8qNbvNs4WgOhCKNxIxvB1Zsv4pfhwL/bwln2vcBb1BirrTC
 g71LOfc4qOiwg5Rzql4WtFsG6Gri3tnSmmtfJZz7bH3FRr6gvGDZt2GvNq29TGdsB//u
 RQJ1+VpDFiHTJTsK1peDSSBx9m1isgHaGsbaBWF3r3m2aUiDCdPqKh2nQv1gBR7r5Vdr
 fAwevgAfHlR9iUb0nq1PeaQjkn5GF8XhSet4Kd4cHXScJIgk9qKwJm2TmHFuyRb3eBEs
 Bj6g==
X-Gm-Message-State: AJIora9y89gnm16tj/7pyv+CoVDVO/g06I4vKv/CbfICarYYtcY6I/GY
 VQMruyRnNB/sWBOCju+g1db2HL4uN5p/6vofdZDramrXTQu5a0aUYpCdycfKeC+wXG70y0N0UJP
 K5UN3BuMCRYjvDX/4TVifiK8lN4gHZPMHkScmibdxpQ==
X-Received: by 2002:a5d:4dc9:0:b0:215:c611:db73 with SMTP id
 f9-20020a5d4dc9000000b00215c611db73mr9566016wru.551.1655469179982; 
 Fri, 17 Jun 2022 05:32:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vrMleQODBYjJTSi8fIIhoUhRue0NuBsJFkxO9IRFJgdZFWFEeDm8+sGhF94gyh54rHFnh3Dw==
X-Received: by 2002:a5d:4dc9:0:b0:215:c611:db73 with SMTP id
 f9-20020a5d4dc9000000b00215c611db73mr9565992wru.551.1655469179714; 
 Fri, 17 Jun 2022 05:32:59 -0700 (PDT)
Received: from redhat.com ([2.54.189.19]) by smtp.gmail.com with ESMTPSA id
 c5-20020a05600c0a4500b0039c4ba160absm18336881wmq.2.2022.06.17.05.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jun 2022 05:32:59 -0700 (PDT)
Date: Fri, 17 Jun 2022 08:32:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio-net: fix race between ndo_open() and
 virtio_device_ready()
Message-ID: <20220617083141-mutt-send-email-mst@kernel.org>
References: <20220617072949.30734-1-jasowang@redhat.com>
 <20220617060632-mutt-send-email-mst@kernel.org>
 <CACGkMEtTVs5W+qqt9Z6BcorJ6wcqcnSVuCBrHrLZbbKzG-7ULQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtTVs5W+qqt9Z6BcorJ6wcqcnSVuCBrHrLZbbKzG-7ULQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Fri, Jun 17, 2022 at 07:46:23PM +0800, Jason Wang wrote:
> On Fri, Jun 17, 2022 at 6:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Jun 17, 2022 at 03:29:49PM +0800, Jason Wang wrote:
> > > We used to call virtio_device_ready() after netdev registration. This
> > > cause a race between ndo_open() and virtio_device_ready(): if
> > > ndo_open() is called before virtio_device_ready(), the driver may
> > > start to use the device before DRIVER_OK which violates the spec.
> > >
> > > Fixing this by switching to use register_netdevice() and protect the
> > > virtio_device_ready() with rtnl_lock() to make sure ndo_open() can
> > > only be called after virtio_device_ready().
> > >
> > > Fixes: 4baf1e33d0842 ("virtio_net: enable VQs early")
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/net/virtio_net.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index db05b5e930be..8a5810bcb839 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -3655,14 +3655,20 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >       if (vi->has_rss || vi->has_rss_hash_report)
> > >               virtnet_init_default_rss(vi);
> > >
> > > -     err = register_netdev(dev);
> > > +     /* serialize netdev register + virtio_device_ready() with ndo_open() */
> > > +     rtnl_lock();
> > > +
> > > +     err = register_netdevice(dev);
> > >       if (err) {
> > >               pr_debug("virtio_net: registering device failed\n");
> > > +             rtnl_unlock();
> > >               goto free_failover;
> > >       }
> > >
> > >       virtio_device_ready(vdev);
> > >
> > > +     rtnl_unlock();
> > > +
> > >       err = virtnet_cpu_notif_add(vi);
> > >       if (err) {
> > >               pr_debug("virtio_net: registering cpu notifier failed\n");
> >
> >
> > Looks good but then don't we have the same issue when removing the
> > device?
> >
> > Actually I looked at  virtnet_remove and I see
> >         unregister_netdev(vi->dev);
> >
> >         net_failover_destroy(vi->failover);
> >
> >         remove_vq_common(vi); <- this will reset the device
> >
> > a window here?
> 
> Probably. For safety, we probably need to reset before unregistering.


careful not to create new races, let's analyse this one to be
sure first.

> >
> >
> > Really, I think what we had originally was a better idea -
> > instead of dropping interrupts they were delayed and
> > when driver is ready to accept them it just enables them.
> 
> The problem is that it works only on some specific setup:
> 
> - doesn't work on shared IRQ
> - doesn't work on some specific driver e.g virtio-blk

can some core irq work fix that?

> > We just need to make sure driver does not wait for
> > interrupts before enabling them.
> >
> > And I suspect we need to make this opt-in on a per driver
> > basis.
> 
> Exactly.
> 
> Thanks
> 
> >
> >
> >
> > > --
> > > 2.25.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
