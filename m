Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1143AC433EF
	for <virtualization@archiver.kernel.org>; Fri, 17 Jun 2022 11:46:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9750060E00;
	Fri, 17 Jun 2022 11:46:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9750060E00
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=heYdIgIb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DABcpj-k3ivc; Fri, 17 Jun 2022 11:46:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2003860AC1;
	Fri, 17 Jun 2022 11:46:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2003860AC1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5066C0039;
	Fri, 17 Jun 2022 11:46:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2146C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 11:46:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7CA4040985
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 11:46:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7CA4040985
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=heYdIgIb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xX6fRHJyNLI7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 11:46:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F12BB40925
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F12BB40925
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 11:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655466397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vJxPwhoLbaKs+wOSU5jOxy6yO7pPmPyKxZbTAbJ5Bhs=;
 b=heYdIgIbnXFyXXaM7Adwb2oe/4qb12/4pi1Wxllr4i1OKZ2G2E7aOqM19QU8ZNjMCZNrM0
 328vLC0Dr7kHSkUlSc5Bh7g3fXF0inmPNwSVAhfuG7Oaw5e0NEMUmIk1RB6LlevLz3Ibm7
 caNy2xLBehLTm8Q5tJ0bz6V/4PxRSxY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-sT64ldVSM7qyCZDjN_PGRw-1; Fri, 17 Jun 2022 07:46:36 -0400
X-MC-Unique: sT64ldVSM7qyCZDjN_PGRw-1
Received: by mail-lf1-f71.google.com with SMTP id
 p36-20020a05651213a400b004779d806c13so2267231lfa.10
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 04:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vJxPwhoLbaKs+wOSU5jOxy6yO7pPmPyKxZbTAbJ5Bhs=;
 b=qc9C8qlAiYIrCJ4rGa80vsFnHba26cU47OM8LYgsKbQW1f568Q5+7xBD+9lVOVdIrm
 gahd/v7zj8WlDqUA80gU1SRwSPycWnYij469V0u9NasHt+RcUhijpcdZOtkBxRZb1t5/
 7etUUws0h4GxyIPHwyy8lKqpg/uVTWdOCaMlpDygHjTs370CGDuttg47skEksgXSeSF/
 q4AqeoVJkXRdeRbxgOcrX5X6znWotMQWrl+PRCg2059EDQn76U1GIFjwkzESGxRnMx9I
 AHMP6sMjm/ylEIT2q4BaU1kLQJ0SmkiUDz3GaH+g/sFiU15gf+XDO6nPhUGJQc8BcDGK
 svzQ==
X-Gm-Message-State: AJIora+f38tU+gw3X6W1iTAEgd5DiHW1EEpdP1bHktb2El67yD94CNBP
 iQxpIT/POOZilCgDkr6tJmTglFNSxg1EdO0T4n6PDnCuNgxg8caLbyB5JBC3R/VwSgRB5ZxNu45
 KJoYBQ2MZsJzut+QZxak869ud4a47tjnqzFP3mpQrcN8rdxBaZDa807EBhw==
X-Received: by 2002:a2e:3a16:0:b0:255:7811:2827 with SMTP id
 h22-20020a2e3a16000000b0025578112827mr4795105lja.130.1655466394857; 
 Fri, 17 Jun 2022 04:46:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1usiehNBiJgZQo1bsGFNg6l50ktCIvyeJlM0jBKDnmj4hJgsSR+BG5DO/5SLPoPh0QWt9BnTFShfMemRsCNrzY=
X-Received: by 2002:a2e:3a16:0:b0:255:7811:2827 with SMTP id
 h22-20020a2e3a16000000b0025578112827mr4795094lja.130.1655466394657; Fri, 17
 Jun 2022 04:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220617072949.30734-1-jasowang@redhat.com>
 <20220617060632-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220617060632-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 17 Jun 2022 19:46:23 +0800
Message-ID: <CACGkMEtTVs5W+qqt9Z6BcorJ6wcqcnSVuCBrHrLZbbKzG-7ULQ@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: fix race between ndo_open() and
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

On Fri, Jun 17, 2022 at 6:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Jun 17, 2022 at 03:29:49PM +0800, Jason Wang wrote:
> > We used to call virtio_device_ready() after netdev registration. This
> > cause a race between ndo_open() and virtio_device_ready(): if
> > ndo_open() is called before virtio_device_ready(), the driver may
> > start to use the device before DRIVER_OK which violates the spec.
> >
> > Fixing this by switching to use register_netdevice() and protect the
> > virtio_device_ready() with rtnl_lock() to make sure ndo_open() can
> > only be called after virtio_device_ready().
> >
> > Fixes: 4baf1e33d0842 ("virtio_net: enable VQs early")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
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
>
>
> Looks good but then don't we have the same issue when removing the
> device?
>
> Actually I looked at  virtnet_remove and I see
>         unregister_netdev(vi->dev);
>
>         net_failover_destroy(vi->failover);
>
>         remove_vq_common(vi); <- this will reset the device
>
> a window here?

Probably. For safety, we probably need to reset before unregistering.

>
>
> Really, I think what we had originally was a better idea -
> instead of dropping interrupts they were delayed and
> when driver is ready to accept them it just enables them.

The problem is that it works only on some specific setup:

- doesn't work on shared IRQ
- doesn't work on some specific driver e.g virtio-blk

> We just need to make sure driver does not wait for
> interrupts before enabling them.
>
> And I suspect we need to make this opt-in on a per driver
> basis.

Exactly.

Thanks

>
>
>
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
