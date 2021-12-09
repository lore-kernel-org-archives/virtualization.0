Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0A1C433F5
	for <virtualization@archiver.kernel.org>; Thu,  9 Dec 2021 05:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4410560762;
	Thu,  9 Dec 2021 05:43:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5icqIPYeTUUH; Thu,  9 Dec 2021 05:43:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BB46360585;
	Thu,  9 Dec 2021 05:43:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A523C001E;
	Thu,  9 Dec 2021 05:43:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C37C3C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 05:43:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AC18480BB7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 05:43:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 01Y0x9hQ4D9u
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 05:43:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DC54480BB3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 05:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639028617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dd9005uJ4CjOxUd/6wAOfDUgPMSiyRieyL5eMd/S00A=;
 b=QUfmbO43zTgWtVSCiNgiy+rsE+3vbqUB9w+DTk+TKvULhly4yDdhS1EtnxsMfiDkviN45V
 dVjFbV8zILG90GGNx1IdDoU6yXE9DiE++wKTOhTO6uRAns2VuXfrB2I/sVx5tv2ldG8cXd
 8e9SV6QqZrxMkskI14JK1zvjpaGDfZw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-YyA-5d3INpu2m52nJveXRg-1; Thu, 09 Dec 2021 00:43:35 -0500
X-MC-Unique: YyA-5d3INpu2m52nJveXRg-1
Received: by mail-lj1-f197.google.com with SMTP id
 n6-20020a2e82c6000000b00221698ffa68so1325435ljh.17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Dec 2021 21:43:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dd9005uJ4CjOxUd/6wAOfDUgPMSiyRieyL5eMd/S00A=;
 b=xaYD3ZMbTnb3ZtlaXhFiuvqqXdzkzPSgraDOKrY9GgQSQytD93KmAvhkfdmenmogMr
 cwCXPooGJdobssETpQ/MuemctM9sH4Ggg6E2bPK2xWGiTBW6255sCI8CYb0dDRKAgOH8
 KCCwcBRStlRkWN82O+jFX/qABDYFLT3xGKWE9KZXcFawltPNWq/tSoI6awQJ5G+6RnL7
 hno3N3izDHV+iy2GmHy/CnOYYg1sCQso2ghTYqvh87IR+6l6LnzVZ3BCCUWkBwDX3/ol
 TC7EYEMTf8sJyojsl5eYKazkNB7+uOlfu2+j+GCkD2g1srI1v6nLggVQ6njux3PUdJrV
 YIMg==
X-Gm-Message-State: AOAM533dqQR8Nm34KbuwOOK5mDwsU9AfhHezLA4Pf3BDfAq/S8TW9lPZ
 jKdeI5vYdk2IFIT1ZgpjJjBEkFnymxJQD2mpV3NlfR8A1ma1QYwzx4jCMZJ50zSs8Rn7wNIXZFO
 G7Uu6VmiLOHASj3gquq9IHDYTpPUTlCtQoUlTmXIYfLCXK0lvQt9gbqXapw==
X-Received: by 2002:ac2:50c6:: with SMTP id h6mr650141lfm.580.1639028613769;
 Wed, 08 Dec 2021 21:43:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzoMS4Y7JP8LbQZeMYQ6285hY2hqNqhIQzNlRO6TLgzppvO8rAzZ1QwlgMWkJBHFv/HhQVxOSvv2V8dmP+RB4o=
X-Received: by 2002:ac2:50c6:: with SMTP id h6mr650111lfm.580.1639028613514;
 Wed, 08 Dec 2021 21:43:33 -0800 (PST)
MIME-Version: 1.0
References: <20211208201430.73720-1-elic@nvidia.com>
 <20211208201430.73720-6-elic@nvidia.com>
In-Reply-To: <20211208201430.73720-6-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Dec 2021 13:43:22 +0800
Message-ID: <CACGkMEu35hKcJYOFCZs5g8+VtfoBGFO05DdsCvyN+WU5SZYYCA@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] vdpa/mlx5: Support configuring max data virtqueue
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

On Thu, Dec 9, 2021 at 4:15 AM Eli Cohen <elic@nvidia.com> wrote:
>
> Check whether the max number of data virtqueue pairs was provided when a
> adding a new device and verify the new value does not exceed device
> capabilities.
>
> In addition, change the arrays holding virtqueue and callback contexts
> to be dynamically allocated.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
> v0->v1:
> 1. Remove requirement to configure power of two virtqueue pairs
> 2. Fix cleanup if kcalloc failed
>
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 43 +++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 1ec29879fc2c..4f0b8bba8b58 100644
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
> +       max_rqt = min_t(int, roundup_pow_of_two(ndev->mvdev.max_vqs  / 2),
>                         1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
>         if (max_rqt < 1)
>                 return -EOPNOTSUPP;
> @@ -2219,7 +2214,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>         clear_vqs_ready(ndev);
>         mlx5_vdpa_destroy_mr(&ndev->mvdev);
>         ndev->mvdev.status = 0;
> -       memset(ndev->event_cbs, 0, sizeof(ndev->event_cbs));
> +       memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
>         ndev->mvdev.actual_features = 0;
>         ++mvdev->generation;
>         if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
> @@ -2292,6 +2287,8 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
>         }
>         mlx5_vdpa_free_resources(&ndev->mvdev);
>         mutex_destroy(&ndev->reslock);
> +       kfree(ndev->event_cbs);
> +       kfree(ndev->vqs);
>  }
>
>  static struct vdpa_notification_area mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
> @@ -2537,15 +2534,33 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>                 return -EOPNOTSUPP;
>         }
>
> -       /* we save one virtqueue for control virtqueue should we require it */
>         max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
> -       max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
> +       if (max_vqs < 2) {
> +               dev_warn(mdev->device,
> +                        "%d virtqueues are supported. At least 2 are required\n",
> +                        max_vqs);
> +               return -EAGAIN;
> +       }
> +
> +       if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) {
> +               if (add_config->net.max_vq_pairs > max_vqs / 2)
> +                       return -EINVAL;
> +               max_vqs = min_t(u32, max_vqs, 2 * add_config->net.max_vq_pairs);
> +       } else {
> +               max_vqs = 2;
> +       }
>
>         ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
>                                  name, false);
>         if (IS_ERR(ndev))
>                 return PTR_ERR(ndev);
>
> +       ndev->vqs = kcalloc(max_vqs, sizeof(*ndev->vqs), GFP_KERNEL);
> +       ndev->event_cbs = kcalloc(max_vqs + 1, sizeof(*ndev->event_cbs), GFP_KERNEL);
> +       if (!ndev->vqs || !ndev->event_cbs) {
> +               err = -ENOMEM;
> +               goto err_alloc;
> +       }
>         ndev->mvdev.max_vqs = max_vqs;
>         mvdev = &ndev->mvdev;
>         mvdev->mdev = mdev;
> @@ -2626,6 +2641,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>                 mlx5_mpfs_del_mac(pfmdev, config->mac);
>  err_mtu:
>         mutex_destroy(&ndev->reslock);
> +err_alloc:
>         put_device(&mvdev->vdev.dev);
>         return err;
>  }
> @@ -2668,7 +2684,8 @@ static int mlx5v_probe(struct auxiliary_device *adev,
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
