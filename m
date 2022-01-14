Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355A2C433F5
	for <virtualization@archiver.kernel.org>; Fri, 14 Jan 2022 06:08:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCC2384D3F;
	Fri, 14 Jan 2022 06:08:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iBWAP8rBTAhK; Fri, 14 Jan 2022 06:08:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BD86C84D3B;
	Fri, 14 Jan 2022 06:08:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C13FC0030;
	Fri, 14 Jan 2022 06:08:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2964EC001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 06:08:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0FD9E6FC7A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 06:08:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NYGA3302ZZaO
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 06:08:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F355F60AAC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 06:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642140522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RcHQ4+Zlxmp91107kcUXsQ7A+H/nshf0iNiIKM59kWk=;
 b=MESPste0WfvhNE1zHOLqMmts3M2c8/wP4eWESQKqgITPKIWoCjmDF4pTl6/BEhhdA1WXbe
 VIkdPAm0sNB5BT+z2O5eaDP0bujb08BisFRlluFV4/EucsDW0vXhmyU7+nFmh6xpamClOE
 kyjIwlDc5nBM4TPbPiuy8miZcKz68Vs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-548-VWQXfFqRPR290tOmG4acCw-1; Fri, 14 Jan 2022 01:08:38 -0500
X-MC-Unique: VWQXfFqRPR290tOmG4acCw-1
Received: by mail-lf1-f71.google.com with SMTP id
 v12-20020ac2558c000000b0042c81cc06afso5539472lfg.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 22:08:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RcHQ4+Zlxmp91107kcUXsQ7A+H/nshf0iNiIKM59kWk=;
 b=ZeTdPrwtQHjDPIfhxTTLDCcJp3GyW++Wf1wGEH94TA4JkmChY3wbG/GF94e55rCUcx
 rkBaF97GcYKz6vs8ZxcJEz8SFxURDh8qpPuet78vKN67Xvq9ZTQNPoHUsxrbiZ3H9fJz
 KffkX7gCeRWnIHPVTnDkn3ZZilnO96d2kYYT2piSKDWh8ijqRNYRCyO3ihP49l+HJocY
 X3134klw2PN84nyAeonupvHaQZnfJNOmEeQATm9pfgX17zoaUKPCHCQ5H1qZPgH8CBFY
 xfJJ6badR6a7NmPB/745BTgtlcsKUmbbWIOWlbD0UI/yK3fZB186qfRNrHs5CWorTbLy
 JT6Q==
X-Gm-Message-State: AOAM532cpDYxk7pY4eLv1qN6a8Aicf/6v991ZMRZirY0Vyjc+te7fD2M
 3SZji04Ah5B6ozhkya6IU6Hql/xltpb6Wbdd/SE9ouFPQxwFPsBcpIyvqiGSkOd7pl14Ouc0Alq
 oW+b0vCrzER4QOaemSlEjNXkIvISgzNIp0itQKM8j75kICDapt6mq1qWBag==
X-Received: by 2002:a05:6512:3b0a:: with SMTP id
 f10mr2766012lfv.629.1642140516989; 
 Thu, 13 Jan 2022 22:08:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwN/botfZCaCaAAz6XQzLOwJ8W0MT4Nz5I6tWkG6u4NWmo3gmFwHfeJxlFxZfpDLx+rdBiqLXj0L1FbLWgiaZY=
X-Received: by 2002:a05:6512:3b0a:: with SMTP id
 f10mr2765998lfv.629.1642140516832; 
 Thu, 13 Jan 2022 22:08:36 -0800 (PST)
MIME-Version: 1.0
References: <1642050651-16197-1-git-send-email-si-wei.liu@oracle.com>
 <1642050651-16197-3-git-send-email-si-wei.liu@oracle.com>
 <20220113080914.GB1312@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20220113080914.GB1312@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Jan 2022 14:08:26 +0800
Message-ID: <CACGkMEuMmqoZ4f9s4dULa9=rvgGtL6wXejGDZ1giTsZ7aA=p=g@mail.gmail.com>
Subject: Re: [PATCH 2/3] vdpa/mlx5: set_features should nack MQ if no CTRL_VQ
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
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

On Thu, Jan 13, 2022 at 4:09 PM Eli Cohen <elic@nvidia.com> wrote:
>
> On Thu, Jan 13, 2022 at 12:10:50AM -0500, Si-Wei Liu wrote:
> > Made corresponding change per spec:
> >
> > The device MUST NOT offer a feature which requires another feature
> > which was not offered.
> >
> > Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")
> > Signed-off-by: Si-Wei Liu<si-wei.liu@oracle.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index b53603d..46d4deb 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -1897,11 +1897,21 @@ static u64 mlx5_vdpa_get_device_features(struct vdpa_device *vdev)
> >       return ndev->mvdev.mlx_features;
> >  }
> >
> > -static int verify_min_features(struct mlx5_vdpa_dev *mvdev, u64 features)
> > +static int verify_driver_features(struct mlx5_vdpa_dev *mvdev, u64 *features)
> >  {
> > -     if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
> > +     /* minimum features to expect */
> > +     if (!(*features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
> >               return -EOPNOTSUPP;
> >
> > +     /* Double check features combination sent down by the driver.
> > +      * NACK invalid feature due to the absence of depended feature.
> > +      * Driver is expected to re-read the negotiated features once
> > +      * return from set_driver_features.
> > +      */
> > +     if ((*features & (BIT_ULL(VIRTIO_NET_F_MQ) | BIT_ULL(VIRTIO_NET_F_CTRL_VQ))) ==
> > +            BIT_ULL(VIRTIO_NET_F_MQ))
> > +             *features &= ~BIT_ULL(VIRTIO_NET_F_MQ);
>
> I would not expect this kind check to be enforced in vhost_vdpa and
> apply to all drivers.

We want to make vhost_vdpa type agnostic to make it simple and clean.
So there's no type specific code there. So my understanding is that,
if this is the mandate behavior of the device, it needs to be done at
device level (mlx5_vdpa) right now.

Thanks

>
> > +
> >       return 0;
> >  }
> >
> > @@ -1977,7 +1987,7 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
> >
> >       print_features(mvdev, features, true);
> >
> > -     err = verify_min_features(mvdev, features);
> > +     err = verify_driver_features(mvdev, &features);
> >       if (err)
> >               return err;
> >
> > --
> > 1.8.3.1
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
