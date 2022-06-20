Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C61C43334
	for <virtualization@archiver.kernel.org>; Mon, 20 Jun 2022 08:47:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CD69540919;
	Mon, 20 Jun 2022 08:47:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CD69540919
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E2DBoyh4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gar-sQjfPl5S; Mon, 20 Jun 2022 08:47:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1342F40491;
	Mon, 20 Jun 2022 08:47:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1342F40491
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE92CC0032;
	Mon, 20 Jun 2022 08:47:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E350EC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 08:47:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AD35360F31
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 08:47:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD35360F31
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=E2DBoyh4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E46tf8XES6t8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 08:47:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 92ADE60D88
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 92ADE60D88
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 08:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655714838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z08htlmkz0DJSJ9iXibcm1dQjAm709AtQlsm4GUcgAE=;
 b=E2DBoyh4hy6fSc0cGSJSOy1MKMtzSkwSwM+qdspxAGS2wNfdjFFQJNU5fyLmDD1gI1K2E/
 nQEFgYnpN+7rQ/9VD263ePAVP2/rNbSkkG9EVnGj4iBLdZMLM2LX5Cjxt1GCnTXndJzKuM
 vf76A2cU6igmSVtHKQukvobbXUI4TZw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-ZDS1SgZ1O0eIDEv4eMe3gw-1; Mon, 20 Jun 2022 04:47:16 -0400
X-MC-Unique: ZDS1SgZ1O0eIDEv4eMe3gw-1
Received: by mail-lj1-f199.google.com with SMTP id
 h23-20020a2e3a17000000b00255788e9a7fso1173830lja.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 01:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z08htlmkz0DJSJ9iXibcm1dQjAm709AtQlsm4GUcgAE=;
 b=GMGeSsM0wGFvZDOnWnJOPE9S7evRUdwgbyBXqGBM5aw9c1seVhPv4UCUb6dg0VLACx
 ZMzD3scyqFMsUqMqfdk0sNw7gIm4KfFQyoFs1fFNV8xYA59T5MJc2DM3bBOd04zxYjAr
 a53BTnPSIYgsRykT4aCq9zpXBL0EW/RTPy2L4eLyzRVD2BaZOeUo7WXFHW5PALh64ilX
 oNYLEIwZOeYh4AMnpR4aLXQX5e6sZiw8VHN5ksJa2EYuQIc2x4HX+SG9RMQKaJJa/2Ej
 SBxHRvcf4be/Z1jMwIfKZvqrLlJKjxFSzIzJT/dGTK96CJKGc5ScE4JuyzBwvrx8CNlB
 E1MQ==
X-Gm-Message-State: AJIora/Ans68rFEUIN4/LZKifEgg+LKilAFY++zd2pmKhKKA7ZZ2Oa3m
 10nhBYfojocBhbz+Hs5Hei6JrVqOSyho0kf4wCbTnVY13shpjsMdmC7OqgpWUxDwZPhB/xalqkP
 YR/O86Wfn7pTMuEyyKDfW9cvghLKt+SSrc3Hqgfrcq6biuOosuAtLPM8VZg==
X-Received: by 2002:a05:6512:13a5:b0:47d:c1d9:dea8 with SMTP id
 p37-20020a05651213a500b0047dc1d9dea8mr13075770lfa.442.1655714834746; 
 Mon, 20 Jun 2022 01:47:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uKP8ya4VfsM1ESebwQFSfbkCuQe28Qt530QfjyBFRu/sbl9mK0K7BZV6nvwX4m222XkknjqyatpsHjPlqKpEo=
X-Received: by 2002:a05:6512:13a5:b0:47d:c1d9:dea8 with SMTP id
 p37-20020a05651213a500b0047dc1d9dea8mr13075757lfa.442.1655714834499; Mon, 20
 Jun 2022 01:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220616132725.50599-1-elic@nvidia.com>
 <20220616132725.50599-3-elic@nvidia.com>
In-Reply-To: <20220616132725.50599-3-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Jun 2022 16:47:03 +0800
Message-ID: <CACGkMEuhBApyg3mgXYWZntKfv60kGnRx5-oBnbhX7yaKaQtW6A@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] vdpa/mlx5: Support different address spaces for
 control and data
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>
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

On Thu, Jun 16, 2022 at 9:27 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Partition virtqueues to two different address spaces: oce for control

Typo, should be "one"

> virtqueue which is implemented in software, and one for data virtqueus.

And should be "virtqueues".

Other than this.

Acked-by: Jason Wang <jasowang@redhat.com>

>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  11 ++++
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 101 +++++++++++++++++++++++++----
>  2 files changed, 101 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> index 44104093163b..6af9fdbb86b7 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -70,6 +70,16 @@ struct mlx5_vdpa_wq_ent {
>         struct mlx5_vdpa_dev *mvdev;
>  };
>
> +enum {
> +       MLX5_VDPA_DATAVQ_GROUP,
> +       MLX5_VDPA_CVQ_GROUP,
> +       MLX5_VDPA_NUMVQ_GROUPS
> +};
> +
> +enum {
> +       MLX5_VDPA_NUM_AS = MLX5_VDPA_NUMVQ_GROUPS
> +};
> +
>  struct mlx5_vdpa_dev {
>         struct vdpa_device vdev;
>         struct mlx5_core_dev *mdev;
> @@ -85,6 +95,7 @@ struct mlx5_vdpa_dev {
>         struct mlx5_vdpa_mr mr;
>         struct mlx5_control_vq cvq;
>         struct workqueue_struct *wq;
> +       unsigned int group2asid[MLX5_VDPA_NUMVQ_GROUPS];
>  };
>
>  int mlx5_vdpa_alloc_pd(struct mlx5_vdpa_dev *dev, u32 *pdn, u16 uid);
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index ea4bc8a0cd25..34bd81cb697c 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2125,9 +2125,14 @@ static u32 mlx5_vdpa_get_vq_align(struct vdpa_device *vdev)
>         return PAGE_SIZE;
>  }
>
> -static u32 mlx5_vdpa_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> +static u32 mlx5_vdpa_get_vq_group(struct vdpa_device *vdev, u16 idx)
>  {
> -       return 0;
> +       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> +
> +       if (is_ctrl_vq_idx(mvdev, idx))
> +               return MLX5_VDPA_CVQ_GROUP;
> +
> +       return MLX5_VDPA_DATAVQ_GROUP;
>  }
>
>  enum { MLX5_VIRTIO_NET_F_GUEST_CSUM = 1 << 9,
> @@ -2541,6 +2546,15 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
>         up_write(&ndev->reslock);
>  }
>
> +static void init_group_to_asid_map(struct mlx5_vdpa_dev *mvdev)
> +{
> +       int i;
> +
> +       /* default mapping all groups are mapped to asid 0 */
> +       for (i = 0; i < MLX5_VDPA_NUMVQ_GROUPS; i++)
> +               mvdev->group2asid[i] = 0;
> +}
> +
>  static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>  {
>         struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> @@ -2559,7 +2573,9 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>         ndev->mvdev.cvq.completed_desc = 0;
>         memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
>         ndev->mvdev.actual_features = 0;
> +       init_group_to_asid_map(mvdev);
>         ++mvdev->generation;
> +
>         if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
>                 if (mlx5_vdpa_create_mr(mvdev, NULL))
>                         mlx5_vdpa_warn(mvdev, "create MR failed\n");
> @@ -2597,26 +2613,76 @@ static u32 mlx5_vdpa_get_generation(struct vdpa_device *vdev)
>         return mvdev->generation;
>  }
>
> -static int mlx5_vdpa_set_map(struct vdpa_device *vdev, unsigned int asid,
> -                            struct vhost_iotlb *iotlb)
> +static u32 get_group(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
> +{
> +       u32 group;
> +
> +       for (group = 0; group < MLX5_VDPA_NUMVQ_GROUPS; group++) {
> +               if (mvdev->group2asid[group] == asid)
> +                       return group;
> +       }
> +       return -EINVAL;
> +}
> +
> +static int set_map_control(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
> +{
> +       u64 start = 0ULL, last = 0ULL - 1;
> +       struct vhost_iotlb_map *map;
> +       int err = 0;
> +
> +       spin_lock(&mvdev->cvq.iommu_lock);
> +       vhost_iotlb_reset(mvdev->cvq.iotlb);
> +
> +       for (map = vhost_iotlb_itree_first(iotlb, start, last); map;
> +            map = vhost_iotlb_itree_next(map, start, last)) {
> +               err = vhost_iotlb_add_range(mvdev->cvq.iotlb, map->start,
> +                                           map->last, map->addr, map->perm);
> +               if (err)
> +                       goto out;
> +       }
> +
> +out:
> +       spin_unlock(&mvdev->cvq.iommu_lock);
> +       return err;
> +}
> +
> +static int set_map_data(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
>  {
> -       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> -       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>         bool change_map;
>         int err;
>
> -       down_write(&ndev->reslock);
> -
>         err = mlx5_vdpa_handle_set_map(mvdev, iotlb, &change_map);
>         if (err) {
>                 mlx5_vdpa_warn(mvdev, "set map failed(%d)\n", err);
> -               goto err;
> +               return err;
>         }
>
>         if (change_map)
>                 err = mlx5_vdpa_change_map(mvdev, iotlb);
>
> -err:
> +       return err;
> +}
> +
> +static int mlx5_vdpa_set_map(struct vdpa_device *vdev, unsigned int asid,
> +                            struct vhost_iotlb *iotlb)
> +{
> +       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> +       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> +       u32 group;
> +       int err;
> +
> +       down_write(&ndev->reslock);
> +       group = get_group(mvdev, asid);
> +       switch (group) {
> +       case MLX5_VDPA_DATAVQ_GROUP:
> +               err = set_map_data(mvdev, iotlb);
> +               break;
> +       case MLX5_VDPA_CVQ_GROUP:
> +               err = set_map_control(mvdev, iotlb);
> +               break;
> +       default:
> +               err = -EINVAL;
> +       }
>         up_write(&ndev->reslock);
>         return err;
>  }
> @@ -2796,6 +2862,18 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev, bool suspend)
>         return 0;
>  }
>
> +static int mlx5_set_group_asid(struct vdpa_device *vdev, u32 group,
> +                              unsigned int asid)
> +{
> +       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> +
> +       if (group >= MLX5_VDPA_NUMVQ_GROUPS)
> +               return -EINVAL;
> +
> +       mvdev->group2asid[group] = asid;
> +       return 0;
> +}
> +
>  static const struct vdpa_config_ops mlx5_vdpa_ops = {
>         .set_vq_address = mlx5_vdpa_set_vq_address,
>         .set_vq_num = mlx5_vdpa_set_vq_num,
> @@ -2825,6 +2903,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
>         .set_config = mlx5_vdpa_set_config,
>         .get_generation = mlx5_vdpa_get_generation,
>         .set_map = mlx5_vdpa_set_map,
> +       .set_group_asid = mlx5_set_group_asid,
>         .free = mlx5_vdpa_free,
>         .suspend = mlx5_vdpa_suspend,
>  };
> @@ -3047,7 +3126,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>         }
>
>         ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
> -                                1, 1, name, false);
> +                                MLX5_VDPA_NUMVQ_GROUPS, MLX5_VDPA_NUM_AS, name, false);
>         if (IS_ERR(ndev))
>                 return PTR_ERR(ndev);
>
> --
> 2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
