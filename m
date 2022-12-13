Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0577C4332F
	for <virtualization@archiver.kernel.org>; Tue, 13 Dec 2022 15:17:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8E06E405A2;
	Tue, 13 Dec 2022 15:17:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8E06E405A2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TYi22W2P
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cs4zBW4fgvlL; Tue, 13 Dec 2022 15:17:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 02F4E402E8;
	Tue, 13 Dec 2022 15:17:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 02F4E402E8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9A36C0032;
	Tue, 13 Dec 2022 15:17:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D47DC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 15:17:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E0162402E8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 15:17:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E0162402E8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wj_0oSaYArN9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 15:17:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1BEFB404B7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1BEFB404B7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 15:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670944655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IZp9KZbsF+uoWlLQ08ZmpXaPPHMCXsyv2ZzXhMuIWFQ=;
 b=TYi22W2PRsna0mmINgru++Q/k4OBKDldyyp2LTAtqCoMktoaRtLbYOEtvAgns87TUVC99s
 +4vvjkEtpeE8kInjLYBaJbyezGQIZPy+feFfZ/pd7XZYKYhspdcQ8gn0SY6OeyqONUTEk3
 VvD87CJWZOulfiGbUs1XaC1mIMmuipA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-672-q3zbFHkBOlS04N4DX4xOgw-1; Tue, 13 Dec 2022 10:17:30 -0500
X-MC-Unique: q3zbFHkBOlS04N4DX4xOgw-1
Received: by mail-wr1-f72.google.com with SMTP id
 w11-20020adfbacb000000b002418a90da01so2936437wrg.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 07:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IZp9KZbsF+uoWlLQ08ZmpXaPPHMCXsyv2ZzXhMuIWFQ=;
 b=za48RN/Ollb4yc2KyIZUCkD6ZnfSMTcYWPEIVg+/Q8nvezKHL2NtrxdE5uRLHsTfAR
 XRpXSN+NckCKUabpky3D1ywQnGkjKaM/cfvOrnGNgzSjVu1xU9kLAZ+DmIRSYL+Hn5aS
 2F1Ym+uFABeB0PY1cPtkW1pWo4oX1DiGd0arXhsacdl2ynyE07PdjlWKHAHmyJhXBU6y
 eanolTZaGqeRZ8f0UiKc9R46BG/lhMepmPM2gpUQU7yltwktAqV5w2bN048Hsop1Gau/
 Vn4tgFOAa8rxA6Ahuceut8n0f5jHssJ3tb+R3Ddp8mvewS19N6E+Ix7bxLQQ+1+AR97v
 MPqA==
X-Gm-Message-State: ANoB5plMmt+MS4IpQJwkJFIpeYG2P+lA/6oM3hUL+qoHilw5UpC6j0nE
 0eNJ1NRTl0cwSGDOunQdbY8iPm4hUukRyXx9qXEIVDW1mdz6tgcs5HXny9qMQC3QS5gY412slhA
 EKruKsC4E6GYa2Zo/PTOiLVOC1QYU0tVvG+uy0VcFZA==
X-Received: by 2002:a05:600c:1e8f:b0:3cf:f18b:327e with SMTP id
 be15-20020a05600c1e8f00b003cff18b327emr16094847wmb.4.1670944648694; 
 Tue, 13 Dec 2022 07:17:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7U6WfvSTkZxDt9TI9ynmz6s/JFu5zvDh9L0Hru5E9BHzJ/Df/NSYbOJehvtVBlpnSfnwYy4Q==
X-Received: by 2002:a05:600c:1e8f:b0:3cf:f18b:327e with SMTP id
 be15-20020a05600c1e8f00b003cff18b327emr16094836wmb.4.1670944648451; 
 Tue, 13 Dec 2022 07:17:28 -0800 (PST)
Received: from redhat.com ([2.52.138.183]) by smtp.gmail.com with ESMTPSA id
 n22-20020a05600c3b9600b003cfd0bd8c0asm14630548wms.30.2022.12.13.07.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Dec 2022 07:17:28 -0800 (PST)
Date: Tue, 13 Dec 2022 10:17:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa: conditionally fill max max queue pair for stats
Message-ID: <20221213101649-mutt-send-email-mst@kernel.org>
References: <20220907060110.4511-1-jasowang@redhat.com>
 <DM8PR12MB540034620ADF0AE749C2D099AB419@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CACGkMEvjgyxs3HX_ZzUbMticntqnUxDQJMrr2MqTBwuRB7jCdw@mail.gmail.com>
 <DM8PR12MB5400209468A07467499B19BDAB419@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CACGkMEuXbs-2KB28Kft+5jjdQdmMtVTKgjJ26x_U3=tNHvThZw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuXbs-2KB28Kft+5jjdQdmMtVTKgjJ26x_U3=tNHvThZw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eli Cohen <elic@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Tue, Dec 13, 2022 at 03:12:23PM +0800, Jason Wang wrote:
> On Wed, Sep 7, 2022 at 4:11 PM Eli Cohen <elic@nvidia.com> wrote:
> >
> > > From: Jason Wang <jasowang@redhat.com>
> > > Sent: Wednesday, 7 September 2022 9:53
> > > To: Eli Cohen <elic@nvidia.com>
> > > Cc: mst@redhat.com; virtualization@lists.linux-foundation.org; linux-
> > > kernel@vger.kernel.org
> > > Subject: Re: [PATCH] vdpa: conditionally fill max max queue pair for stats
> > >
> > > On Wed, Sep 7, 2022 at 2:11 PM Eli Cohen <elic@nvidia.com> wrote:
> > > >
> > > > > From: Jason Wang <jasowang@redhat.com>
> > > > > Sent: Wednesday, 7 September 2022 9:01
> > > > > To: mst@redhat.com; jasowang@redhat.com; Eli Cohen
> > > <elic@nvidia.com>;
> > > > > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> > > > > Subject: [PATCH] vdpa: conditionally fill max max queue pair for stats
> > > > >
> > > > > For the device without multiqueue feature, we will read 0 as
> > > > > max_virtqueue_pairs from the config.
> > > > If this is the case for other vdpa vendor drivers, shouldn't we fix it there?
> > > After all,
> > > > config->max_virtqueue_pairs should always show valid values.
> > >
> > > Not for the case when the device doesn't offer MQ. According to the
> > > spec, the max_virtqueue_pairs doesn't exist in this case.
> > >
> > I see, thanks.
> >
> > > >
> > > > > So if we fill
> > > > > VDPA_ATTR_DEV_NET_CFG_MAX_VQP with the value we read from the
> > > > > config
> > > > > we will confuse the user.
> > > > >
> > > > > Fixing this by only filling the value when multiqueue is offered by
> > > > > the device so userspace can assume 1 when the attr is not provided.
> > > > >
> > > > > Fixes: 13b00b135665c("vdpa: Add support for querying vendor
> > > statistics")
> > > > > Cc: Eli Cohen <elic@nvidia.com>
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > ---
> > > > >  drivers/vdpa/vdpa.c | 9 ++++-----
> > > > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > > > index c06c02704461..bc328197263f 100644
> > > > > --- a/drivers/vdpa/vdpa.c
> > > > > +++ b/drivers/vdpa/vdpa.c
> > > > > @@ -894,7 +894,6 @@ static int vdpa_fill_stats_rec(struct vdpa_device
> > > > > *vdev, struct sk_buff *msg,
> > > > >  {
> > > > >       struct virtio_net_config config = {};
> > > > >       u64 features;
> > > > > -     u16 max_vqp;
> > > > >       u8 status;
> > > > >       int err;
> > > > >
> > > > > @@ -905,15 +904,15 @@ static int vdpa_fill_stats_rec(struct
> > > vdpa_device
> > > > > *vdev, struct sk_buff *msg,
> > > > >       }
> > > > >       vdpa_get_config_unlocked(vdev, 0, &config, sizeof(config));
> > > > >
> > > > > -     max_vqp = __virtio16_to_cpu(true, config.max_virtqueue_pairs);
> > > > > -     if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
> > > > > max_vqp))
> > > > > -             return -EMSGSIZE;
> > > > > -
> > > > >       features = vdev->config->get_driver_features(vdev);
> > > > >       if (nla_put_u64_64bit(msg,
> > > > > VDPA_ATTR_DEV_NEGOTIATED_FEATURES,
> > > > >                             features, VDPA_ATTR_PAD))
> > > > >               return -EMSGSIZE;
> > > > >
> > > > > +     err = vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
> > > > > +     if (err)
> > > > > +             return err;
> > > > > +
> > > >
> > > > So that means that you can't read statistics when MQ is not supported. Is
> > > this worth sacrificing?
> > >
> > > vdpa_dev_net_mq_config_fill() will return 0 in the case of !MQ, so it
> > > should still work.
> >
> > Right, missed that.
> >
> > Reviewed-by: Eli Cohen <elic@nvidia.com>
> 
> Michael, I don't see this is merged.
> 
> Any comments for this patch?
> 
> Thanks
> 

Will be in the pull. Working on it now, it's pretty big.

> >
> > >
> > > Thanks
> > >
> > >
> > > >
> > > > >       if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
> > > > >               return -EMSGSIZE;
> > > > >
> > > > > --
> > > > > 2.25.1
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
