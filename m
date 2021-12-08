Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9716FC433EF
	for <virtualization@archiver.kernel.org>; Wed,  8 Dec 2021 03:29:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 22515400C7;
	Wed,  8 Dec 2021 03:29:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I4FmDB3_JYQ8; Wed,  8 Dec 2021 03:29:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4B363400D7;
	Wed,  8 Dec 2021 03:29:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBB2DC001E;
	Wed,  8 Dec 2021 03:29:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BA92C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 03:29:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 24C4D60EFC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 03:29:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tNzbaQ3LBkfJ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 03:29:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 376A760EE5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 03:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638934192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ArnDNpHopfGh0i4NCrnd66DmjtZ6oAppphdppVhtZgs=;
 b=HD5WIV+JU5rNtvioWh7ngx2Muo1PiFmaOHuPQFOKWvWcGzZCQfKWWNDdOCZGK5MCC4t+Ad
 iQ6Nm22dMlTC5Xm+0zzY79ZZSVjSpvs9RQLOgSn9/9hszBv+ynbNZfFEOWD5PRHFTiRPuh
 KpVpQ0lEsW+baBH6jVrKKAKup4go0VA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-188-lc-yqzfFN9ualqTlG4dzFA-1; Tue, 07 Dec 2021 22:29:49 -0500
X-MC-Unique: lc-yqzfFN9ualqTlG4dzFA-1
Received: by mail-lf1-f72.google.com with SMTP id
 m2-20020a056512014200b0041042b64791so491518lfo.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Dec 2021 19:29:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ArnDNpHopfGh0i4NCrnd66DmjtZ6oAppphdppVhtZgs=;
 b=ZKZjUQFD0sJ5HNHAFIXSto8mAzK1tI/WJ+ku5pwAgycejn5G//A/580esjNkqVrWt/
 pJnm5/RX7rSnBwEocwPk5RbPKYSzV1dE3PgLkbU6H6DeBPjVicrH1H8T/3ehWxSx8Oc5
 5oLNW/TpXDxwX0OO+ITRP7AI/zAUS5Zqm9Ie2VL0xPbrqhoARLR4/Np03d0QRhVEWTXA
 TOrcfTTcZeu6mtqFN+zCTR92L/J0qz19gYeuL+JC3gC4KdOfDVm8itIM6LYbL6V1KBG+
 QPS3kkNQnxTVAmCFqU42XYSxW8vE0rWpG/WN7gnHyDy07MKNMn5NQUmCeuoX52m++6pT
 ISdA==
X-Gm-Message-State: AOAM532cEOIQhr0ZiX7fIf7kgv4phYwnNze7aaqKDvQOJ4CxfyAY3eRC
 lyZkk0YiA/xNt4KtQwlXwP+uX9BfchZ1rWBCgpODXyoHeXnwrqYty1+NV3GjVcFOlqlyaTZO3Qr
 02Ib/so8QgHXpBbwJbppVHGkfhxXYSfcVz0r1q6B05+fV+naJxep/ShsQuA==
X-Received: by 2002:a05:6512:685:: with SMTP id
 t5mr46112200lfe.84.1638934187629; 
 Tue, 07 Dec 2021 19:29:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnKjQtGOE2ugjyvOKCFK2Dtt12M+yPcePUWoXu6Z54E6U5OBZP8DssEA1DdLfY5TpWb6xn8bnRLwpVKfd0dxo=
X-Received: by 2002:a05:6512:685:: with SMTP id
 t5mr46112169lfe.84.1638934187349; 
 Tue, 07 Dec 2021 19:29:47 -0800 (PST)
MIME-Version: 1.0
References: <20211201195724.17503-1-elic@nvidia.com>
 <20211201195724.17503-4-elic@nvidia.com>
 <0e6de504-38e8-a1a9-5dc9-00c52571b21b@oracle.com>
 <20211207081946.GE15767@mtl-vdi-166.wap.labs.mlnx>
 <8a196015-4024-4e56-4d21-80033322cb85@oracle.com>
In-Reply-To: <8a196015-4024-4e56-4d21-80033322cb85@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Dec 2021 11:29:36 +0800
Message-ID: <CACGkMEs69DHUCZxx0SwkkOt6x2XOoU+_1ynnB4rEEcq2UwFvfQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] vdpa/mlx5: Support configuring max data virtqueue
 pairs
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

On Wed, Dec 8, 2021 at 7:16 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
>
> On 12/7/2021 12:19 AM, Eli Cohen wrote:
> > On Thu, Dec 02, 2021 at 11:28:12PM -0800, Si-Wei Liu wrote:
> >>
> >> On 12/1/2021 11:57 AM, Eli Cohen wrote:
> >>> Check whether the max number of data virtqueue pairs was provided when a
> >>> adding a new device and verify the new value does not exceed device
> >>> capabilities.
> >>>
> >>> In addition, change the arrays holding virtqueue and callback contexts
> >>> to be dynamically allocated.
> >>>
> >>> Signed-off-by: Eli Cohen <elic@nvidia.com>
> >>> ---
> >>>    drivers/vdpa/mlx5/net/mlx5_vnet.c | 33 ++++++++++++++++++++-----------
> >>>    1 file changed, 21 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >>> index b66f41ccbac2..62aba5dbd8fa 100644
> >>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >>> @@ -131,11 +131,6 @@ struct mlx5_vdpa_virtqueue {
> >>>     struct mlx5_vq_restore_info ri;
> >>>    };
> >>> -/* We will remove this limitation once mlx5_vdpa_alloc_resources()
> >>> - * provides for driver space allocation
> >> Is this comment outdated, i.e. driver space allocation in
> >> mlx5_vdpa_alloc_resources() already provided?
> >>
> > Not sure I follow. The comment was removed in this patch since we no
> > longer depend on MLX5_MAX_SUPPORTED_VQS and rather use dynamic
> > allocations.
> >>> - */
> >>> -#define MLX5_MAX_SUPPORTED_VQS 16
> >>> -
> >>>    static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
> >>>    {
> >>>     if (unlikely(idx > mvdev->max_idx))
> >>> @@ -148,8 +143,8 @@ struct mlx5_vdpa_net {
> >>>     struct mlx5_vdpa_dev mvdev;
> >>>     struct mlx5_vdpa_net_resources res;
> >>>     struct virtio_net_config config;
> >>> -   struct mlx5_vdpa_virtqueue vqs[MLX5_MAX_SUPPORTED_VQS];
> >>> -   struct vdpa_callback event_cbs[MLX5_MAX_SUPPORTED_VQS + 1];
> >>> +   struct mlx5_vdpa_virtqueue *vqs;
> >>> +   struct vdpa_callback *event_cbs;
> >>>     /* Serialize vq resources creation and destruction. This is required
> >>>      * since memory map might change and we need to destroy and create
> >>> @@ -1218,7 +1213,7 @@ static void suspend_vqs(struct mlx5_vdpa_net *ndev)
> >>>    {
> >>>     int i;
> >>> -   for (i = 0; i < MLX5_MAX_SUPPORTED_VQS; i++)
> >>> +   for (i = 0; i < ndev->mvdev.max_vqs; i++)
> >>>             suspend_vq(ndev, &ndev->vqs[i]);
> >>>    }
> >>> @@ -1245,7 +1240,7 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
> >>>     int i, j;
> >>>     int err;
> >>> -   max_rqt = min_t(int, MLX5_MAX_SUPPORTED_VQS / 2,
> >>> +   max_rqt = min_t(int, ndev->mvdev.max_vqs  / 2,
> >>>                     1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
> >>>     if (max_rqt < 1)
> >>>             return -EOPNOTSUPP;
> >>> @@ -2235,7 +2230,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
> >>>     clear_vqs_ready(ndev);
> >>>     mlx5_vdpa_destroy_mr(&ndev->mvdev);
> >>>     ndev->mvdev.status = 0;
> >>> -   memset(ndev->event_cbs, 0, sizeof(ndev->event_cbs));
> >>> +   memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
> >>>     ndev->mvdev.actual_features = 0;
> >>>     ++mvdev->generation;
> >>>     if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
> >>> @@ -2308,6 +2303,8 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
> >>>     }
> >>>     mlx5_vdpa_free_resources(&ndev->mvdev);
> >>>     mutex_destroy(&ndev->reslock);
> >>> +   kfree(ndev->event_cbs);
> >>> +   kfree(ndev->vqs);
> >>>    }
> >>>    static struct vdpa_notification_area mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
> >>> @@ -2547,13 +2544,24 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> >>>     /* we save one virtqueue for control virtqueue should we require it */
> >>>     max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
> >>> -   max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
> >>> +   if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) {
> >>> +           if (add_config->max_vq_pairs & (add_config->max_vq_pairs - 1) ||
> >>> +               add_config->max_vq_pairs > max_vqs / 2)
> >>> +                   return -EINVAL;
> >> It'd be the best to describe the failing cause here, the power of 2
> >> limitation is known to me, but not friendly enough for first time user.
> >> dev_warn would work for me.
> > I could add a warning but if some test script does this plenty of times
> > you will clutter dmesg. You do fail if you provide a non power of two
> > value.
> You could pick dev_warn_once() and fix other similar dev_warn() usage in
> the same function. But I do wonder why your firmware has this power-of-2
> limitation for the number of data queues.

It looks like a defect.

> Are you going to remove this
> limitation by working around it in driver? I thought only queue size has
> such power-of-2 limitation.

Only for split virtqueue, we don't have this for packed virtqueue.

Thanks

>
> Thanks,
> -Siwei
> >>> +           max_vqs = min_t(u32, max_vqs, 2 * add_config->max_vq_pairs);
> >>> +   }
> >>>     ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
> >>>                              name, false);
> >>>     if (IS_ERR(ndev))
> >>>             return PTR_ERR(ndev);
> >>> +   ndev->vqs = kcalloc(max_vqs, sizeof(*ndev->vqs), GFP_KERNEL);
> >>> +   ndev->event_cbs = kcalloc(max_vqs + 1, sizeof(*ndev->event_cbs), GFP_KERNEL);
> >>> +   if (!ndev->vqs || !ndev->event_cbs) {
> >>> +           err = -ENOMEM;
> >>> +           goto err_mtu;
> >> Not a good idea to call mutex_destroy() without calling mutex_init() ahead.
> >> Introduce another err label before put_device()?
> > Thanks, will fix.
> >> -Siwei
> >>
> >>> +   }
> >>>     ndev->mvdev.max_vqs = max_vqs;
> >>>     mvdev = &ndev->mvdev;
> >>>     mvdev->mdev = mdev;
> >>> @@ -2676,7 +2684,8 @@ static int mlx5v_probe(struct auxiliary_device *adev,
> >>>     mgtdev->mgtdev.ops = &mdev_ops;
> >>>     mgtdev->mgtdev.device = mdev->device;
> >>>     mgtdev->mgtdev.id_table = id_table;
> >>> -   mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
> >>> +   mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR) |
> >>> +                                     BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
> >>>     mgtdev->madev = madev;
> >>>     err = vdpa_mgmtdev_register(&mgtdev->mgtdev);
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
