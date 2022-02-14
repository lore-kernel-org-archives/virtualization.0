Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF245C433EF
	for <virtualization@archiver.kernel.org>; Mon, 14 Feb 2022 08:16:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 639BC81836;
	Mon, 14 Feb 2022 08:16:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NssVTw3n-hNs; Mon, 14 Feb 2022 08:16:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A11D18149D;
	Mon, 14 Feb 2022 08:16:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7875BC0011;
	Mon, 14 Feb 2022 08:16:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8211AC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:16:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 70F9160B28
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:16:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z5CqbBp6toYr
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:16:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4657F60AE0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644826600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7LV7iHh1JDquPU3e8XzPHyGFugKFbRb6xFrrJV5uyXY=;
 b=aoGo2LFq4CtZ1oQITU+8q2mB7tre+mJY8FFDl+A+186DHMHGAPv3c0yVIndmBAS99PVDwX
 5p6ewCFQ1xuISAmm31eQ+YczeZruME12WscxsGYL5OiH68yQyJQAUCqPYRVIhPaaLAj26g
 np4R1vtRJ3riXSFKJaL1d/u9Uir+xX8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-T1Hiigt5OtqytwfWjq6ziQ-1; Mon, 14 Feb 2022 03:16:34 -0500
X-MC-Unique: T1Hiigt5OtqytwfWjq6ziQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 j11-20020a2e3c0b000000b00244c34b83d8so712262lja.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 00:16:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7LV7iHh1JDquPU3e8XzPHyGFugKFbRb6xFrrJV5uyXY=;
 b=fr5fxk+tx2LAp3yBXBN0wX4DZizxJhbA240N9XVz98VsRwr2zYs9uyvPNEUaj8E4NV
 UCEGeambO2fxugkLZjsE7rHHs8k9VrxrbaJFcZW9p5nBLDsEuL1LEHaor018nv65ROVD
 jB2L25cHV7pWsZ3Skm9pBfWOhjQaXxGoYWi/BSP6dZzl4hwvEiqsUBVjEigYMC1To0W8
 x94JXVwtH1z+ZTbk1ooHpUskFv+7TUFh+xIO5y5qR8gILcA+yC2YdN+mE/uBSyYHEu8O
 t2WVBYdLZjRA/6q93jfcvTp59qBEEbB3QdUtGabam6Xa5LChXnHvKkDqVBww4Di2NKtq
 n0zQ==
X-Gm-Message-State: AOAM532fUcGxnWJ+8AtvF1gWcEbBcBcnmQNuAciuveneMQRT5rnJaNvb
 CLsvUDvuv0uqTvDEA/1lUAipAo89ZxWWQTZeSdO5fEqO34IBhMVnLYwkNg32q6Jwx/OE91OuwM/
 /sQm5Y3uUYb0QrOSPTXfF8xrjzawW/Q4fHb3jNz/ag4dzE+XHKQ0117uO/w==
X-Received: by 2002:a05:6512:e9c:: with SMTP id
 bi28mr10108692lfb.498.1644826592252; 
 Mon, 14 Feb 2022 00:16:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxxT4Tp28zSBnROFSoxzBluOo7ZqJxW7o17OTTY4IrCnw1SRKpED5ss55bCqLOgGSwYxnZ3dGoQXAtpZb6Y/gg=
X-Received: by 2002:a05:6512:e9c:: with SMTP id
 bi28mr10108674lfb.498.1644826591988; 
 Mon, 14 Feb 2022 00:16:31 -0800 (PST)
MIME-Version: 1.0
References: <20220203055633.3677-1-elic@nvidia.com>
 <20220203055633.3677-3-elic@nvidia.com>
In-Reply-To: <20220203055633.3677-3-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Feb 2022 16:16:21 +0800
Message-ID: <CACGkMEvO6MLkxCu9XVtFwVpyKu1z8-++GURKyKXdgwb4GqHo3Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] vdpa/mlx5: Add support for reading descriptor
 statistics
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

On Thu, Feb 3, 2022 at 1:56 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Implement the get_vq_stats calback of vdpa_config_ops to return the
> statistics for a virtqueue.
>
> The statistics are provided as vendor specific statistics where the
> driver provides a pair of attribute name and attribute value.
>
> Currently supported are received descriptors and completed descriptors.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |   2 +
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 154 +++++++++++++++++++++++++++++
>  include/linux/mlx5/mlx5_ifc.h      |   1 +
>  include/linux/mlx5/mlx5_ifc_vdpa.h |  39 ++++++++
>  4 files changed, 196 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> index daaf7b503677..44104093163b 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -61,6 +61,8 @@ struct mlx5_control_vq {
>         struct vringh_kiov riov;
>         struct vringh_kiov wiov;
>         unsigned short head;
> +       unsigned int received_desc;
> +       unsigned int completed_desc;
>  };
>
>  struct mlx5_vdpa_wq_ent {
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index b53603d94082..b3fbe229cd74 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -119,6 +119,7 @@ struct mlx5_vdpa_virtqueue {
>         struct mlx5_vdpa_umem umem2;
>         struct mlx5_vdpa_umem umem3;
>
> +       u32 counter_set_id;
>         bool initialized;
>         int index;
>         u32 virtq_id;
> @@ -163,6 +164,8 @@ struct mlx5_vdpa_net {
>         u32 cur_num_vqs;
>         struct notifier_block nb;
>         struct vdpa_callback config_cb;
> +       /* sync access to virtqueues statistics */
> +       struct mutex numq_lock;

Patch 1 already held vdpa_dev_mutex, any reason for another mutex here?

>  };
>
>  static void free_resources(struct mlx5_vdpa_net *ndev);
> @@ -821,6 +824,12 @@ static u16 get_features_12_3(u64 features)
>                (!!(features & BIT_ULL(VIRTIO_NET_F_GUEST_CSUM)) << 6);
>  }
>
> +static bool counters_supported(const struct mlx5_vdpa_dev *mvdev)
> +{
> +       return MLX5_CAP_GEN_64(mvdev->mdev, general_obj_types) &
> +              BIT_ULL(MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
> +}
> +
>  static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
>  {
>         int inlen = MLX5_ST_SZ_BYTES(create_virtio_net_q_in);
> @@ -875,6 +884,8 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
>         MLX5_SET(virtio_q, vq_ctx, umem_3_id, mvq->umem3.id);
>         MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem3.size);
>         MLX5_SET(virtio_q, vq_ctx, pd, ndev->mvdev.res.pdn);
> +       if (counters_supported(&ndev->mvdev))
> +               MLX5_SET(virtio_q, vq_ctx, counter_set_id, mvq->counter_set_id);
>
>         err = mlx5_cmd_exec(ndev->mvdev.mdev, in, inlen, out, sizeof(out));
>         if (err)
> @@ -1138,6 +1149,47 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
>         return err;
>  }
>
> +static int counter_set_alloc(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
> +{
> +       u32 in[MLX5_ST_SZ_DW(create_virtio_q_counters_in)] = {};
> +       u32 out[MLX5_ST_SZ_DW(create_virtio_q_counters_out)] = {};
> +       void *cmd_hdr;
> +       int err;
> +
> +       if (!counters_supported(&ndev->mvdev))
> +               return 0;
> +
> +       cmd_hdr = MLX5_ADDR_OF(create_virtio_q_counters_in, in, hdr);
> +
> +       MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, opcode, MLX5_CMD_OP_CREATE_GENERAL_OBJECT);
> +       MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, obj_type, MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
> +       MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, uid, ndev->mvdev.res.uid);
> +
> +       err = mlx5_cmd_exec(ndev->mvdev.mdev, in, sizeof(in), out, sizeof(out));
> +       if (err)
> +               return err;
> +
> +       mvq->counter_set_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
> +
> +       return 0;
> +}
> +
> +static void counter_set_dealloc(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
> +{
> +       u32 in[MLX5_ST_SZ_DW(destroy_virtio_q_counters_in)] = {};
> +       u32 out[MLX5_ST_SZ_DW(destroy_virtio_q_counters_out)] = {};
> +
> +       if (!counters_supported(&ndev->mvdev))
> +               return;
> +
> +       MLX5_SET(destroy_virtio_q_counters_in, in, hdr.opcode, MLX5_CMD_OP_DESTROY_GENERAL_OBJECT);
> +       MLX5_SET(destroy_virtio_q_counters_in, in, hdr.obj_id, mvq->counter_set_id);
> +       MLX5_SET(destroy_virtio_q_counters_in, in, hdr.uid, ndev->mvdev.res.uid);
> +       MLX5_SET(destroy_virtio_q_counters_in, in, hdr.obj_type, MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
> +       if (mlx5_cmd_exec(ndev->mvdev.mdev, in, sizeof(in), out, sizeof(out)))
> +               mlx5_vdpa_warn(&ndev->mvdev, "dealloc counter set 0x%x\n", mvq->counter_set_id);
> +}
> +
>  static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
>  {
>         u16 idx = mvq->index;
> @@ -1165,6 +1217,10 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
>         if (err)
>                 goto err_connect;
>
> +       err = counter_set_alloc(ndev, mvq);
> +       if (err)
> +               goto err_counter;
> +
>         err = create_virtqueue(ndev, mvq);
>         if (err)
>                 goto err_connect;
> @@ -1182,6 +1238,8 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
>         return 0;
>
>  err_connect:
> +       counter_set_dealloc(ndev, mvq);
> +err_counter:
>         qp_destroy(ndev, &mvq->vqqp);
>  err_vqqp:
>         qp_destroy(ndev, &mvq->fwqp);
> @@ -1226,6 +1284,7 @@ static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *
>
>         suspend_vq(ndev, mvq);
>         destroy_virtqueue(ndev, mvq);
> +       counter_set_dealloc(ndev, mvq);
>         qp_destroy(ndev, &mvq->vqqp);
>         qp_destroy(ndev, &mvq->fwqp);
>         cq_destroy(ndev, mvq->index);
> @@ -1573,8 +1632,10 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct mlx5_vdpa_dev *mvdev, u8 cmd)
>                         break;
>                 }
>
> +               mutex_lock(&ndev->numq_lock);
>                 if (!change_num_qps(mvdev, newqps))
>                         status = VIRTIO_NET_OK;
> +               mutex_unlock(&ndev->numq_lock);
>
>                 break;
>         default:
> @@ -1615,6 +1676,7 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
>                 if (read != sizeof(ctrl))
>                         break;
>
> +               cvq->received_desc++;
>                 switch (ctrl.class) {
>                 case VIRTIO_NET_CTRL_MAC:
>                         status = handle_ctrl_mac(mvdev, ctrl.cmd);
> @@ -1637,6 +1699,7 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
>
>                 if (vringh_need_notify_iotlb(&cvq->vring))
>                         vringh_notify(&cvq->vring);
> +               cvq->completed_desc++;
>         }
>  out:
>         kfree(wqent);
> @@ -2310,6 +2373,7 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
>                 mlx5_mpfs_del_mac(pfmdev, ndev->config.mac);
>         }
>         mlx5_vdpa_free_resources(&ndev->mvdev);
> +       mutex_destroy(&ndev->numq_lock);
>         mutex_destroy(&ndev->reslock);
>         kfree(ndev->event_cbs);
>         kfree(ndev->vqs);
> @@ -2351,6 +2415,93 @@ static u64 mlx5_vdpa_get_driver_features(struct vdpa_device *vdev)
>         return mvdev->actual_features;
>  }
>
> +static int counter_set_query(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq,
> +                            u64 *received_desc, u64 *completed_desc)
> +{
> +       u32 in[MLX5_ST_SZ_DW(query_virtio_q_counters_in)] = {};
> +       u32 out[MLX5_ST_SZ_DW(query_virtio_q_counters_out)] = {};
> +       void *cmd_hdr;
> +       void *ctx;
> +       int err;
> +
> +       if (!counters_supported(&ndev->mvdev))
> +               return -EOPNOTSUPP;
> +
> +       if (mvq->fw_state != MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY)
> +               return -EAGAIN;

Not related to this patch, but I found this is interesting. It looks
to me the Q_OBJECT_STATE_RDY bring some troubles, I wonder if we can
delay the register of vdpa device until fw is ready then we don't even
need this check?

> +
> +       cmd_hdr = MLX5_ADDR_OF(query_virtio_q_counters_in, in, hdr);
> +
> +       MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, opcode, MLX5_CMD_OP_QUERY_GENERAL_OBJECT);
> +       MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, obj_type, MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
> +       MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, uid, ndev->mvdev.res.uid);
> +       MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, obj_id, mvq->counter_set_id);
> +
> +       err = mlx5_cmd_exec(ndev->mvdev.mdev, in, sizeof(in), out, sizeof(out));
> +       if (err)
> +               return err;
> +
> +       ctx = MLX5_ADDR_OF(query_virtio_q_counters_out, out, counters);
> +       *received_desc = MLX5_GET64(virtio_q_counters, ctx, received_desc);
> +       *completed_desc = MLX5_GET64(virtio_q_counters, ctx, completed_desc);
> +       return 0;
> +}
> +
> +static int mlx5_vdpa_get_vq_stats(struct vdpa_device *vdev, u16 idx,
> +                                 struct sk_buff *msg,
> +                                 struct netlink_ext_ack *extack)
> +{
> +       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> +       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> +       struct mlx5_vdpa_virtqueue *mvq;
> +       struct mlx5_control_vq *cvq;
> +       u64 received_desc;
> +       u64 completed_desc;
> +       int err = 0;
> +
> +       mutex_lock(&ndev->numq_lock);
> +       if (!is_index_valid(mvdev, idx)) {
> +               NL_SET_ERR_MSG_MOD(extack, "virtqueue index is not valid");
> +               err = -EINVAL;
> +               goto out_err;
> +       }
> +
> +       if (idx == ctrl_vq_idx(mvdev)) {
> +               cvq = &mvdev->cvq;
> +               received_desc = cvq->received_desc;
> +               completed_desc = cvq->completed_desc;
> +               goto out;
> +       }
> +
> +       mvq = &ndev->vqs[idx];
> +       err = counter_set_query(ndev, mvq, &received_desc, &completed_desc);
> +       if (err) {
> +               NL_SET_ERR_MSG_MOD(extack, "failed to query hardware");
> +               goto out_err;
> +       }
> +
> +out:
> +       err = -EMSGSIZE;
> +       if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME, "received_desc"))
> +               goto out_err;
> +
> +       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE, received_desc,
> +                             VDPA_ATTR_PAD))
> +               goto out_err;
> +
> +       if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME, "completed_desc"))
> +               goto out_err;
> +
> +       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE, completed_desc,
> +                             VDPA_ATTR_PAD))
> +               goto out_err;
> +
> +       err = 0;
> +out_err:
> +       mutex_unlock(&ndev->numq_lock);
> +       return err;
> +}
> +
>  static const struct vdpa_config_ops mlx5_vdpa_ops = {
>         .set_vq_address = mlx5_vdpa_set_vq_address,
>         .set_vq_num = mlx5_vdpa_set_vq_num,
> @@ -2360,6 +2511,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
>         .get_vq_ready = mlx5_vdpa_get_vq_ready,
>         .set_vq_state = mlx5_vdpa_set_vq_state,
>         .get_vq_state = mlx5_vdpa_get_vq_state,
> +       .get_vq_stats = mlx5_vdpa_get_vq_stats,
>         .get_vq_notification = mlx5_get_vq_notification,
>         .get_vq_irq = mlx5_get_vq_irq,
>         .get_vq_align = mlx5_vdpa_get_vq_align,
> @@ -2593,6 +2745,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>
>         init_mvqs(ndev);
>         mutex_init(&ndev->reslock);
> +       mutex_init(&ndev->numq_lock);
>         config = &ndev->config;
>         err = query_mtu(mdev, &mtu);
>         if (err)
> @@ -2666,6 +2819,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>         if (!is_zero_ether_addr(config->mac))
>                 mlx5_mpfs_del_mac(pfmdev, config->mac);
>  err_mtu:
> +       mutex_destroy(&ndev->numq_lock);
>         mutex_destroy(&ndev->reslock);
>  err_alloc:
>         put_device(&mvdev->vdev.dev);
> diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
> index fbaab440a484..15f50becfcfb 100644
> --- a/include/linux/mlx5/mlx5_ifc.h
> +++ b/include/linux/mlx5/mlx5_ifc.h
> @@ -94,6 +94,7 @@ enum {
>  enum {
>         MLX5_OBJ_TYPE_GENEVE_TLV_OPT = 0x000b,
>         MLX5_OBJ_TYPE_VIRTIO_NET_Q = 0x000d,
> +       MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS = 0x001c,
>         MLX5_OBJ_TYPE_MATCH_DEFINER = 0x0018,
>         MLX5_OBJ_TYPE_MKEY = 0xff01,
>         MLX5_OBJ_TYPE_QP = 0xff02,
> diff --git a/include/linux/mlx5/mlx5_ifc_vdpa.h b/include/linux/mlx5/mlx5_ifc_vdpa.h
> index 1a9c9d94cb59..4414ed5b6ed2 100644
> --- a/include/linux/mlx5/mlx5_ifc_vdpa.h
> +++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
> @@ -165,4 +165,43 @@ struct mlx5_ifc_modify_virtio_net_q_out_bits {
>         struct mlx5_ifc_general_obj_out_cmd_hdr_bits general_obj_out_cmd_hdr;
>  };
>
> +struct mlx5_ifc_virtio_q_counters_bits {
> +       u8    modify_field_select[0x40];
> +       u8    reserved_at_40[0x40];
> +       u8    received_desc[0x40];
> +       u8    completed_desc[0x40];
> +       u8    error_cqes[0x20];
> +       u8    bad_desc_errors[0x20];
> +       u8    exceed_max_chain[0x20];
> +       u8    invalid_buffer[0x20];
> +       u8    reserved_at_180[0x280];
> +};

I wonder if it's better to support all of those counters from the beginning?

Thanks

> +
> +struct mlx5_ifc_create_virtio_q_counters_in_bits {
> +       struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
> +       struct mlx5_ifc_virtio_q_counters_bits virtio_q_counters;
> +};
> +
> +struct mlx5_ifc_create_virtio_q_counters_out_bits {
> +       struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
> +       struct mlx5_ifc_virtio_q_counters_bits virtio_q_counters;
> +};
> +
> +struct mlx5_ifc_destroy_virtio_q_counters_in_bits {
> +       struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
> +};
> +
> +struct mlx5_ifc_destroy_virtio_q_counters_out_bits {
> +       struct mlx5_ifc_general_obj_out_cmd_hdr_bits hdr;
> +};
> +
> +struct mlx5_ifc_query_virtio_q_counters_in_bits {
> +       struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
> +};
> +
> +struct mlx5_ifc_query_virtio_q_counters_out_bits {
> +       struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
> +       struct mlx5_ifc_virtio_q_counters_bits counters;
> +};
> +
>  #endif /* __MLX5_IFC_VDPA_H_ */
> --
> 2.34.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
