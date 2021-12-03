Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16249C433F5
	for <virtualization@archiver.kernel.org>; Fri,  3 Dec 2021 02:29:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B506C6063A;
	Fri,  3 Dec 2021 02:29:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2tKQwqK1pDSO; Fri,  3 Dec 2021 02:29:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 31A8060629;
	Fri,  3 Dec 2021 02:29:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01A33C0012;
	Fri,  3 Dec 2021 02:29:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D748C000A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 02:29:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 562BF4049B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 02:29:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VyR8_Z_XBCGn
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 02:29:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA02740448
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 02:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638498554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ci4QunVbZvAQNwrLd8tRseNLB1DpnIg+IQ9HEZHuc6o=;
 b=TuIXMyWqnXlZaF2gRsw+dAJc5PjUbzl7aPwLoeg2YNQ06yCYNgovFsgpLuqWr8z7EfwZL8
 uEpsusQP1jHp/ln5w2BVNfEnw3H2y4BHkDnnYy/cY/ihtyMcgI6l/TIifHWHTOr0a10Ci+
 aXPiRc0lMtAGvlqUicefVVNdpGX5l7Q=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-i_91c_S8OnuAnvEdQd47lw-1; Thu, 02 Dec 2021 21:29:13 -0500
X-MC-Unique: i_91c_S8OnuAnvEdQd47lw-1
Received: by mail-lf1-f72.google.com with SMTP id
 g38-20020a0565123ba600b004036147023bso482012lfv.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Dec 2021 18:29:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ci4QunVbZvAQNwrLd8tRseNLB1DpnIg+IQ9HEZHuc6o=;
 b=mrfGCEEornhMBGATKu4iRbsScjw1VsyDHRqrbC5ssT3edzBSQPei/9qjD/6WWA12ua
 ku+BMv322tS+4DiNeHAU3U+00MBxRmpYsfJd33errj61KiHWo0mzsFchuasSWvbB3iwA
 v2uF3j4LaHyuKplNHcHDTvm4S0XE5avi1Ms98IQue2wxVo59zYmnyqMQATp67qEO1XAF
 f6iyiE+l7qtqe+ndd6oiDO7eZkOP9QaRHAQkYP0G6iYeqwrBacrxa9CN9xuF0NLSUvO3
 AXU6ufjR3NCcta9PXEHREhDmvjpwWUZap0ncX77qZ5QPNQrE9V5tELhzdQwmNxCALtMf
 oiDQ==
X-Gm-Message-State: AOAM532Nx/BDWQDKnUCH54AM8HQhONIaWo5V4xhHtJm/UbCI5zRDMVWW
 O38sxftbT1+xJkCScLpHHh065F03K8MkkV6aaBlIjqNE4F/gVxgmgIHYepJFuxtYm0rzsjGwp7L
 TqDShBf/E0Mdo3qX4KezXjni67Z+E7q31HmK6Yg/4MBAwIMHTn+y3ElKd+w==
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr15316578ljp.362.1638498551826; 
 Thu, 02 Dec 2021 18:29:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwD2ZlacIB3sTaa6CcAoU9I2PEwX8D9jPJ17XwTZEFT98b3JHwT3jgkCDvYi88Pz9AD0KCqhf1oN0g7Xx1CD7Y=
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr15316559ljp.362.1638498551592; 
 Thu, 02 Dec 2021 18:29:11 -0800 (PST)
MIME-Version: 1.0
References: <20211201195724.17503-1-elic@nvidia.com>
 <20211201195724.17503-4-elic@nvidia.com>
In-Reply-To: <20211201195724.17503-4-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 3 Dec 2021 10:29:00 +0800
Message-ID: <CACGkMEvwV99zy06QQGmWg-gh_sqxBJKtQTEKEa8nJAx94C8d_Q@mail.gmail.com>
Subject: Re: [PATCH 3/7] vdpa/mlx5: Support configuring max data virtqueue
 pairs
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

On Thu, Dec 2, 2021 at 3:58 AM Eli Cohen <elic@nvidia.com> wrote:
>
> Check whether the max number of data virtqueue pairs was provided when a
> adding a new device and verify the new value does not exceed device
> capabilities.
>
> In addition, change the arrays holding virtqueue and callback contexts
> to be dynamically allocated.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 33 ++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index b66f41ccbac2..62aba5dbd8fa 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -131,11 +131,6 @@ struct mlx5_vdpa_virtqueue {
>         struct mlx5_vq_restore_info ri;
>  };
>
> -/* We will remove this limitation once mlx5_vdpa_alloc_resources()
> - * provides for driver space allocation
> - */
> -#define MLX5_MAX_SUPPORTED_VQS 16
> -
>  static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
>  {
>         if (unlikely(idx > mvdev->max_idx))
> @@ -148,8 +143,8 @@ struct mlx5_vdpa_net {
>         struct mlx5_vdpa_dev mvdev;
>         struct mlx5_vdpa_net_resources res;
>         struct virtio_net_config config;
> -       struct mlx5_vdpa_virtqueue vqs[MLX5_MAX_SUPPORTED_VQS];
> -       struct vdpa_callback event_cbs[MLX5_MAX_SUPPORTED_VQS + 1];
> +       struct mlx5_vdpa_virtqueue *vqs;
> +       struct vdpa_callback *event_cbs;
>
>         /* Serialize vq resources creation and destruction. This is required
>          * since memory map might change and we need to destroy and create
> @@ -1218,7 +1213,7 @@ static void suspend_vqs(struct mlx5_vdpa_net *ndev)
>  {
>         int i;
>
> -       for (i = 0; i < MLX5_MAX_SUPPORTED_VQS; i++)
> +       for (i = 0; i < ndev->mvdev.max_vqs; i++)
>                 suspend_vq(ndev, &ndev->vqs[i]);
>  }
>
> @@ -1245,7 +1240,7 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>         int i, j;
>         int err;
>
> -       max_rqt = min_t(int, MLX5_MAX_SUPPORTED_VQS / 2,
> +       max_rqt = min_t(int, ndev->mvdev.max_vqs  / 2,
>                         1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
>         if (max_rqt < 1)
>                 return -EOPNOTSUPP;
> @@ -2235,7 +2230,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>         clear_vqs_ready(ndev);
>         mlx5_vdpa_destroy_mr(&ndev->mvdev);
>         ndev->mvdev.status = 0;
> -       memset(ndev->event_cbs, 0, sizeof(ndev->event_cbs));
> +       memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
>         ndev->mvdev.actual_features = 0;
>         ++mvdev->generation;
>         if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
> @@ -2308,6 +2303,8 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
>         }
>         mlx5_vdpa_free_resources(&ndev->mvdev);
>         mutex_destroy(&ndev->reslock);
> +       kfree(ndev->event_cbs);
> +       kfree(ndev->vqs);
>  }
>
>  static struct vdpa_notification_area mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
> @@ -2547,13 +2544,24 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>
>         /* we save one virtqueue for control virtqueue should we require it */
>         max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
> -       max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
> +       if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) {
> +               if (add_config->max_vq_pairs & (add_config->max_vq_pairs - 1) ||
> +                   add_config->max_vq_pairs > max_vqs / 2)
> +                       return -EINVAL;
> +               max_vqs = min_t(u32, max_vqs, 2 * add_config->max_vq_pairs);
> +       }

Not for this patch, but this seems to mean without max_vqp, a vdpa
with maximum number of qps are provisioned? Is this intended?

>
>         ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
>                                  name, false);
>         if (IS_ERR(ndev))
>                 return PTR_ERR(ndev);
>
> +       ndev->vqs = kcalloc(max_vqs, sizeof(*ndev->vqs), GFP_KERNEL);
> +       ndev->event_cbs = kcalloc(max_vqs + 1, sizeof(*ndev->event_cbs), GFP_KERNEL);
> +       if (!ndev->vqs || !ndev->event_cbs) {

Do we need to kfree if any of the two allocations succeeded?

Thanks

> +               err = -ENOMEM;
> +               goto err_mtu;
> +       }
>         ndev->mvdev.max_vqs = max_vqs;
>         mvdev = &ndev->mvdev;
>         mvdev->mdev = mdev;
> @@ -2676,7 +2684,8 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>         mgtdev->mgtdev.ops = &mdev_ops;
>         mgtdev->mgtdev.device = mdev->device;
>         mgtdev->mgtdev.id_table = id_table;
> -       mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
> +       mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR) |
> +                                         BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
>         mgtdev->madev = madev;
>
>         err = vdpa_mgmtdev_register(&mgtdev->mgtdev);
> --
> 2.33.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
