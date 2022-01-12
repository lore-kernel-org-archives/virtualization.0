Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB74C433EF
	for <virtualization@archiver.kernel.org>; Wed, 12 Jan 2022 02:30:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF0326FB4A;
	Wed, 12 Jan 2022 02:30:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xLJIALRwnv0w; Wed, 12 Jan 2022 02:30:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 731F060D78;
	Wed, 12 Jan 2022 02:30:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33036C002F;
	Wed, 12 Jan 2022 02:30:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D907FC001E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:30:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C18096FB29
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:30:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2yHN62Q2Jpiz
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:30:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ED0F860D78
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641954599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zzT+v2+KAK5AWi+Z+TA407+5rgna2yXGqEYVPG498cs=;
 b=ALnW85n4ov41aPaNyfJX527k57kW8q2+zkkFdNstvMTtwd32zPP0cOfJed4a87A8m0TuGC
 DWV9rCEU0461riSVOKGWs2eQqQqNXZVWd00O3LLtGa0s0sBlvgarSkDxi9MR2xZTONAxcv
 LGvMub0UXVqM98Dl+YfGThktjMWVYVk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-x34nJA3zPVurJTTMyDlGKQ-1; Tue, 11 Jan 2022 21:29:58 -0500
X-MC-Unique: x34nJA3zPVurJTTMyDlGKQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 bq6-20020a056512150600b0041bf41f5437so622270lfb.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 18:29:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zzT+v2+KAK5AWi+Z+TA407+5rgna2yXGqEYVPG498cs=;
 b=0Zb+sSI0jnKgLvyLY0okmWXAa++UJIdXlCQsm3zLFYJS2Y/iVcrPaLg+D/BPXjLKrO
 i4Ca1WpnoafxgrwFePT8sfIUcmr+JHUU4kNEqF2yZoPANajhU4jX/zZBlSfQUzr6jbgC
 9Hfo4w45xriRZP6w5MNm6dzHS6VBafCUyVfcJ/N9//W4lwH1vyVlu/wbgLUmI3+4oqyq
 RJdmE4lzYCi1fG4EpAv+0W5f5V3SIcx0m6aa3Y6eXqYgo/JwP9Boa9EUCXF7FA1BLBTd
 REWZ5WRCN1igpmX99+JMdHZoPJvSNKJml1xUO9SmtFTogGn8a69UGjCkMstbX2d2pwKy
 8xWg==
X-Gm-Message-State: AOAM530B5Ii2L3rmuEveBOdQI4kgU3rLl8r+xlOyadn7mthKqxsi0fcP
 e+3M8S0AfkOhP8xioSj/tywOIT6SWv+6CvVHElAGtWxh9WrzE1RhFpI8LHPqMmcMIGTjLabwkjZ
 4NVtaV8Mvr1Tck3P7aWDNJIQxiYsC1oWYyxal6joOpRQ+8wdXTTtV0olkww==
X-Received: by 2002:a2e:a40c:: with SMTP id p12mr5011885ljn.369.1641954597307; 
 Tue, 11 Jan 2022 18:29:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBWEpoKypzhZahN5F+2GSOPRZmtZQRYw6yRN7+iH6EYovnie69ibtJ0aVNJcEPEmxoHC7JEoU86WJ2tUdikpw=
X-Received: by 2002:a2e:a40c:: with SMTP id p12mr5011879ljn.369.1641954597135; 
 Tue, 11 Jan 2022 18:29:57 -0800 (PST)
MIME-Version: 1.0
References: <20220111183400.38418-1-elic@nvidia.com>
 <20220111183400.38418-5-elic@nvidia.com>
 <8f1d7e2c-e8ca-4c09-f18c-72cd4c09c44f@oracle.com>
In-Reply-To: <8f1d7e2c-e8ca-4c09-f18c-72cd4c09c44f@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Jan 2022 10:29:46 +0800
Message-ID: <CACGkMEs77urb3Ef++tVHvQow2eRKpzW3c8TPtdiGrq9jQcmWjA@mail.gmail.com>
Subject: Re: [PATCH 4/4] vdpa/mlx5: Fix tracking of current number of VQs
To: Si-Wei Liu <si-wei.liu@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>
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

On Wed, Jan 12, 2022 at 6:15 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
>
> On 1/11/2022 10:34 AM, Eli Cohen wrote:
> > Modify the code such that ndev->cur_num_vqs better reflects the actual
> > number of data virtqueues. The value can be accurately realized after
> > features have been negotiated.
> >
> > This is to prevent possible failures when modifying the RQT object if
> > the cur_num_vqs bears invalid value.
> >
> > No issue was actually encountered but this also makes the code more
> > readable.
> >
> > Fixes: c5a5cd3d3217 ("vdpa/mlx5: Support configuring max data virtqueue")
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > ---
> >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++----
> >   1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 9eacfdb48434..b53603d94082 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -1246,8 +1246,7 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
> >       if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> >               num = 1;
> >       else
> > -             num = mlx5vdpa16_to_cpu(&ndev->mvdev,
> > -                                     ndev->config.max_virtqueue_pairs);
> > +             num = ndev->cur_num_vqs / 2;
> Nit: the if branch can be consolidated
>
> >
> >       max_rqt = min_t(int, roundup_pow_of_two(num),
> >                       1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
> > @@ -1983,6 +1982,11 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
> >               return err;
> >
> >       ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
> > +     if (ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ))
> > +             ndev->cur_num_vqs = 2 * mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
> Hmmm, not this patch, but there should've been validation done in the
> upper layer to guarantee set_featuers() for VIRTIO_NET_F_MQ always comes
> with VIRTIO_NET_F_CTRL_VQ. Maybe checking both: BIT_ULL(VIRTIO_NET_F_MQ)
> |  BIT_ULL(VIRTIO_NET_F_CTRL_VQ)?

So the upper layer is unaware of the device type. It's better to do
that in mlx5's set_features() according to the spec:

The device MUST NOT offer a feature which requires another feature
which was not offered.

Thanks

>
> otherwise it looks good to me.
>
> Reviewed-by: Si-Wei Liu<si-wei.liu@oracle.com>
> > +     else
> > +             ndev->cur_num_vqs = 2;
> > +
> >       update_cvq_info(mvdev);
> >       return err;
> >   }
> > @@ -2233,6 +2237,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
> >       clear_vqs_ready(ndev);
> >       mlx5_vdpa_destroy_mr(&ndev->mvdev);
> >       ndev->mvdev.status = 0;
> > +     ndev->cur_num_vqs = 0;
> >       memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
> >       ndev->mvdev.actual_features = 0;
> >       ++mvdev->generation;
> > @@ -2641,9 +2646,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> >
> >       ndev->nb.notifier_call = event_handler;
> >       mlx5_notifier_register(mdev, &ndev->nb);
> > -     ndev->cur_num_vqs = 2 * mlx5_vdpa_max_qps(max_vqs);
> >       mvdev->vdev.mdev = &mgtdev->mgtdev;
> > -     err = _vdpa_register_device(&mvdev->vdev, ndev->cur_num_vqs + 1);
> > +     err = _vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_vqs) + 1);
> >       if (err)
> >               goto err_reg;
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
