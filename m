Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A696C4332F
	for <virtualization@archiver.kernel.org>; Tue, 13 Dec 2022 07:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACB40416CA;
	Tue, 13 Dec 2022 07:12:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ACB40416CA
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TMLJT1Qk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C3AC0tWgUoPf; Tue, 13 Dec 2022 07:12:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DB8074169E;
	Tue, 13 Dec 2022 07:12:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DB8074169E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEB12C0033;
	Tue, 13 Dec 2022 07:12:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C13BC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 07:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 12D0E605B5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 07:12:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 12D0E605B5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TMLJT1Qk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wiKOSNypCVqp
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 07:12:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0916660597
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0916660597
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 07:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670915556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rMebFWdEdtkJjFFWamjr+NWxVNJ3wKKuSE9Jjikeu1s=;
 b=TMLJT1Qk99ISEgCbu8CsBZ65p+HHMLIc/IhhjmS2kaViISGHJCyC4QNV+fWJ4aWbmmk1k4
 YMkjHDhEs8JKEFecyiurV26UTOJOmposYmolEm1wzpjZ1WgTqj4E4vO7sBJfpdOGjmJhv+
 CFbhj0fibXeDbeQFzE91kX3wK0L7Goo=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-608-XGz90hrYMyyTX-u3n9eNlA-1; Tue, 13 Dec 2022 02:12:35 -0500
X-MC-Unique: XGz90hrYMyyTX-u3n9eNlA-1
Received: by mail-ot1-f72.google.com with SMTP id
 e8-20020a9d63c8000000b006704cedcfe2so8287401otl.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 23:12:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rMebFWdEdtkJjFFWamjr+NWxVNJ3wKKuSE9Jjikeu1s=;
 b=7fhiC3Gu68d+LMiIPKkGTXNMrODCjhzsYFEdioKVO7minJ6EOw+IuxuMtGinb5n7P1
 8TWV/PD5/hwnRJdYy6hxg9Pl5ZpfP2SxWI5NKp/NrgVbKWXSz/dcjRQYEE14lKrTUUhw
 7vjAPfELycdNqUrnPqBRRjAORPNoKKyZoQASVvAvee3Qc//jNy8GeZ6ydkxqwYD9oqmf
 G4hVroFCGgphgjT5XANFoQ7UajymWaHV3/69L9DD+XfSJXZpgr0plt75wFoHlqqCYnhT
 CuWQuo2yExFJlytnUO3Oz8ZPWw5rASJmsZBlFd37Coik9LSbQyfDG8ew0GtXarN1No5P
 re6g==
X-Gm-Message-State: ANoB5pk4NJKssEZTo41cgiIkAwivC+AZjENVzS7vscelhZ+xARbUdFQb
 GEw+1PwSnvB/iNx9VpFglE3JtkAZNMwPhpey4L8mPfRbcx/PowYWgMBgODodsFvnmH5rVZUyrJb
 84Miw2U4eiSiFI319tXmY3sqCnov7jl8O+hc8ATtj5Z6wO2i15aQuT/5h2A==
X-Received: by 2002:a05:6808:114c:b0:35e:7a42:7ab5 with SMTP id
 u12-20020a056808114c00b0035e7a427ab5mr101805oiu.280.1670915554339; 
 Mon, 12 Dec 2022 23:12:34 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7bOxvXY5V4JuTJUsGbVhkXkh2+HEeWmtUf1eSQx3I5QF29ADy9ENjFVggDW3zwY3hcJPkL8/gGz7lS+U6DYgM=
X-Received: by 2002:a05:6808:114c:b0:35e:7a42:7ab5 with SMTP id
 u12-20020a056808114c00b0035e7a427ab5mr101800oiu.280.1670915554149; Mon, 12
 Dec 2022 23:12:34 -0800 (PST)
MIME-Version: 1.0
References: <20220907060110.4511-1-jasowang@redhat.com>
 <DM8PR12MB540034620ADF0AE749C2D099AB419@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CACGkMEvjgyxs3HX_ZzUbMticntqnUxDQJMrr2MqTBwuRB7jCdw@mail.gmail.com>
 <DM8PR12MB5400209468A07467499B19BDAB419@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB5400209468A07467499B19BDAB419@DM8PR12MB5400.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 13 Dec 2022 15:12:23 +0800
Message-ID: <CACGkMEuXbs-2KB28Kft+5jjdQdmMtVTKgjJ26x_U3=tNHvThZw@mail.gmail.com>
Subject: Re: [PATCH] vdpa: conditionally fill max max queue pair for stats
To: Eli Cohen <elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>
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

On Wed, Sep 7, 2022 at 4:11 PM Eli Cohen <elic@nvidia.com> wrote:
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, 7 September 2022 9:53
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: mst@redhat.com; virtualization@lists.linux-foundation.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH] vdpa: conditionally fill max max queue pair for stats
> >
> > On Wed, Sep 7, 2022 at 2:11 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Wednesday, 7 September 2022 9:01
> > > > To: mst@redhat.com; jasowang@redhat.com; Eli Cohen
> > <elic@nvidia.com>;
> > > > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> > > > Subject: [PATCH] vdpa: conditionally fill max max queue pair for stats
> > > >
> > > > For the device without multiqueue feature, we will read 0 as
> > > > max_virtqueue_pairs from the config.
> > > If this is the case for other vdpa vendor drivers, shouldn't we fix it there?
> > After all,
> > > config->max_virtqueue_pairs should always show valid values.
> >
> > Not for the case when the device doesn't offer MQ. According to the
> > spec, the max_virtqueue_pairs doesn't exist in this case.
> >
> I see, thanks.
>
> > >
> > > > So if we fill
> > > > VDPA_ATTR_DEV_NET_CFG_MAX_VQP with the value we read from the
> > > > config
> > > > we will confuse the user.
> > > >
> > > > Fixing this by only filling the value when multiqueue is offered by
> > > > the device so userspace can assume 1 when the attr is not provided.
> > > >
> > > > Fixes: 13b00b135665c("vdpa: Add support for querying vendor
> > statistics")
> > > > Cc: Eli Cohen <elic@nvidia.com>
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  drivers/vdpa/vdpa.c | 9 ++++-----
> > > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > > index c06c02704461..bc328197263f 100644
> > > > --- a/drivers/vdpa/vdpa.c
> > > > +++ b/drivers/vdpa/vdpa.c
> > > > @@ -894,7 +894,6 @@ static int vdpa_fill_stats_rec(struct vdpa_device
> > > > *vdev, struct sk_buff *msg,
> > > >  {
> > > >       struct virtio_net_config config = {};
> > > >       u64 features;
> > > > -     u16 max_vqp;
> > > >       u8 status;
> > > >       int err;
> > > >
> > > > @@ -905,15 +904,15 @@ static int vdpa_fill_stats_rec(struct
> > vdpa_device
> > > > *vdev, struct sk_buff *msg,
> > > >       }
> > > >       vdpa_get_config_unlocked(vdev, 0, &config, sizeof(config));
> > > >
> > > > -     max_vqp = __virtio16_to_cpu(true, config.max_virtqueue_pairs);
> > > > -     if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
> > > > max_vqp))
> > > > -             return -EMSGSIZE;
> > > > -
> > > >       features = vdev->config->get_driver_features(vdev);
> > > >       if (nla_put_u64_64bit(msg,
> > > > VDPA_ATTR_DEV_NEGOTIATED_FEATURES,
> > > >                             features, VDPA_ATTR_PAD))
> > > >               return -EMSGSIZE;
> > > >
> > > > +     err = vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
> > > > +     if (err)
> > > > +             return err;
> > > > +
> > >
> > > So that means that you can't read statistics when MQ is not supported. Is
> > this worth sacrificing?
> >
> > vdpa_dev_net_mq_config_fill() will return 0 in the case of !MQ, so it
> > should still work.
>
> Right, missed that.
>
> Reviewed-by: Eli Cohen <elic@nvidia.com>

Michael, I don't see this is merged.

Any comments for this patch?

Thanks


>
> >
> > Thanks
> >
> >
> > >
> > > >       if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
> > > >               return -EMSGSIZE;
> > > >
> > > > --
> > > > 2.25.1
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
