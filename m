Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E870C433F5
	for <virtualization@archiver.kernel.org>; Wed, 12 Jan 2022 03:57:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DCB54148D;
	Wed, 12 Jan 2022 03:57:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v_ALi_FVmuu7; Wed, 12 Jan 2022 03:57:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6E23D410E8;
	Wed, 12 Jan 2022 03:57:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47DAEC0030;
	Wed, 12 Jan 2022 03:57:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF5E8C001E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 03:57:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CC7A760E0B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 03:57:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bcImrVxtc2vI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 03:57:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DF4BB60E02
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 03:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641959846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X47udDaXUSFWGukMiZXXKPaVIKK3e0rMJEb6ecF68dc=;
 b=ZU707KEG97p4maC594jsr/VztDuoWSUcvxsQDJ0QCTxKzFiXtMqy5rGt5UhllN1Hs5+uLN
 qFRUnfUQ3mqs00d3jABxChNZK4BhHPEqZyGPnxo/ZoA05IQwcEtA2G5Fs2zKFMlD05zUKC
 o5hl6Zv1nP1yuKzmp3QZd4oy7KE4cWE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-gKIeExanPQKgYRm4b7uwdg-1; Tue, 11 Jan 2022 22:57:25 -0500
X-MC-Unique: gKIeExanPQKgYRm4b7uwdg-1
Received: by mail-lf1-f72.google.com with SMTP id
 q14-20020ac246ee000000b0042c02909ed4so729853lfo.19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 19:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X47udDaXUSFWGukMiZXXKPaVIKK3e0rMJEb6ecF68dc=;
 b=FzX/KpzN/95GFZIRuxHZMJPxSl98tFvOPz8N/FWstnYo9tWRZI07WPLIZ8a9DMPuY6
 T9QrxX6749BVUQ/s0ZnMjULc0bH+t4EYiR8trTQqWcO1ToEdHTUS5WqmA1ErGvjswuua
 /kWccI1SoSpmlBhnhs3OfyApEioxj24S9EXjq2tpwX/78aNa37kjaBsl9FuJPui3uGRJ
 oWsc7VBuNGR9OZ3fZJNzSdQBpVakBaVjOBy9l97x7GiulzAnH2E23MYOp+uxYknpJ2S9
 Paso4CX76AU/Vs6Awt7idkSKr6tHkqC7C0n+c33f/C4nMdO09+Y/64c4VGGxWwUKbKCj
 f9uQ==
X-Gm-Message-State: AOAM5321Icca6yrcFUeLdDveYLJ6syTu64Ate6DhfYpddIwXD4LfvQ0M
 UJJak2UpEtPOKCu3K+q/2xZjc/9ofEmS1XXyqiNDTyH8RvF+gg8cEwwq6qfHMWJMa+ybtGwYwI8
 4xXeQOEMcNqYia7T2c3EhwKcjrkTPBOjBj850+iqfRojIh97nbNHelY7LLw==
X-Received: by 2002:a05:651c:1a0d:: with SMTP id
 by13mr5166883ljb.107.1641959843866; 
 Tue, 11 Jan 2022 19:57:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyEVzR7UA+DRYH+nRKZAdHSB/pgahUFysrA0GX+HzpFxy+xtPCiyf1lcYYxS8xw1dzNKkVralk5uPDa+ZDQZWE=
X-Received: by 2002:a05:651c:1a0d:: with SMTP id
 by13mr5166869ljb.107.1641959843654; 
 Tue, 11 Jan 2022 19:57:23 -0800 (PST)
MIME-Version: 1.0
References: <20220111183400.38418-1-elic@nvidia.com>
 <20220111183400.38418-5-elic@nvidia.com>
 <8f1d7e2c-e8ca-4c09-f18c-72cd4c09c44f@oracle.com>
 <CACGkMEs77urb3Ef++tVHvQow2eRKpzW3c8TPtdiGrq9jQcmWjA@mail.gmail.com>
 <e65292c9-2d4e-bfb9-545b-75a2f97b67e5@oracle.com>
In-Reply-To: <e65292c9-2d4e-bfb9-545b-75a2f97b67e5@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Jan 2022 11:57:12 +0800
Message-ID: <CACGkMEukUtBmSjmfa5-+uX9hARjoXNGF6=cxptoqLPZF-Sh+eg@mail.gmail.com>
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

On Wed, Jan 12, 2022 at 11:12 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
>
> On 1/11/2022 6:29 PM, Jason Wang wrote:
> > On Wed, Jan 12, 2022 at 6:15 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> >>
> >>
> >> On 1/11/2022 10:34 AM, Eli Cohen wrote:
> >>> Modify the code such that ndev->cur_num_vqs better reflects the actual
> >>> number of data virtqueues. The value can be accurately realized after
> >>> features have been negotiated.
> >>>
> >>> This is to prevent possible failures when modifying the RQT object if
> >>> the cur_num_vqs bears invalid value.
> >>>
> >>> No issue was actually encountered but this also makes the code more
> >>> readable.
> >>>
> >>> Fixes: c5a5cd3d3217 ("vdpa/mlx5: Support configuring max data virtqueue")
> >>> Signed-off-by: Eli Cohen <elic@nvidia.com>
> >>> ---
> >>>    drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++----
> >>>    1 file changed, 8 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >>> index 9eacfdb48434..b53603d94082 100644
> >>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >>> @@ -1246,8 +1246,7 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
> >>>        if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> >>>                num = 1;
> >>>        else
> >>> -             num = mlx5vdpa16_to_cpu(&ndev->mvdev,
> >>> -                                     ndev->config.max_virtqueue_pairs);
> >>> +             num = ndev->cur_num_vqs / 2;
> >> Nit: the if branch can be consolidated
> >>
> >>>        max_rqt = min_t(int, roundup_pow_of_two(num),
> >>>                        1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
> >>> @@ -1983,6 +1982,11 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
> >>>                return err;
> >>>
> >>>        ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
> >>> +     if (ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ))
> >>> +             ndev->cur_num_vqs = 2 * mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
> >> Hmmm, not this patch, but there should've been validation done in the
> >> upper layer to guarantee set_featuers() for VIRTIO_NET_F_MQ always comes
> >> with VIRTIO_NET_F_CTRL_VQ. Maybe checking both: BIT_ULL(VIRTIO_NET_F_MQ)
> >> |  BIT_ULL(VIRTIO_NET_F_CTRL_VQ)?
> > So the upper layer is unaware of the device type. It's better to do
> > that in mlx5's set_features()
> That'll be fine. I thought the upper layer can be made device type aware
> and consolidate it to common library routines avoiding duplicated code
> in every individual driver of the same type.

This is possible but not implemented so far. It looks more like an
intermediate layer between vdpa and it's parent.

> If this is against the goal
> of making vdpa core device type agnostic, then it's perhaps not needed.

Yes, that's the goal when developing vDPA core.

Thanks

>
> -Siwei
>
> > according to the spec:
> >
> > The device MUST NOT offer a feature which requires another feature
> > which was not offered.
> >
> > Thanks
> >
> >> otherwise it looks good to me.
> >>
> >> Reviewed-by: Si-Wei Liu<si-wei.liu@oracle.com>
> >>> +     else
> >>> +             ndev->cur_num_vqs = 2;
> >>> +
> >>>        update_cvq_info(mvdev);
> >>>        return err;
> >>>    }
> >>> @@ -2233,6 +2237,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
> >>>        clear_vqs_ready(ndev);
> >>>        mlx5_vdpa_destroy_mr(&ndev->mvdev);
> >>>        ndev->mvdev.status = 0;
> >>> +     ndev->cur_num_vqs = 0;
> >>>        memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
> >>>        ndev->mvdev.actual_features = 0;
> >>>        ++mvdev->generation;
> >>> @@ -2641,9 +2646,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> >>>
> >>>        ndev->nb.notifier_call = event_handler;
> >>>        mlx5_notifier_register(mdev, &ndev->nb);
> >>> -     ndev->cur_num_vqs = 2 * mlx5_vdpa_max_qps(max_vqs);
> >>>        mvdev->vdev.mdev = &mgtdev->mgtdev;
> >>> -     err = _vdpa_register_device(&mvdev->vdev, ndev->cur_num_vqs + 1);
> >>> +     err = _vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_vqs) + 1);
> >>>        if (err)
> >>>                goto err_reg;
> >>>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
