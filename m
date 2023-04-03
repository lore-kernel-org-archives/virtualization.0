Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94E3C76196
	for <virtualization@archiver.kernel.org>; Mon,  3 Apr 2023 18:12:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6CF6A60E19;
	Mon,  3 Apr 2023 18:12:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6CF6A60E19
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IkUvVXtX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mdtR9pcPmrkl; Mon,  3 Apr 2023 18:12:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AAD5460F03;
	Mon,  3 Apr 2023 18:12:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AAD5460F03
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83E7BC0036;
	Mon,  3 Apr 2023 18:12:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48DAAC002F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 18:12:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 238FE409E5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 18:12:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 238FE409E5
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IkUvVXtX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aTesQPT3NKaN
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 18:12:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 01338409E2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 01338409E2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 18:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680545523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r3M4dnZpzEF1fjTDIk6mn6D6G4XXwwJL/IpU552QBx4=;
 b=IkUvVXtXfk6fisPxRQb5rW2iRACazqDCrMyXdvn23FoNcLA4oJQSRcnl7AoI2MCAij9rca
 hfxWxYSRWAJt9UQH9XY8Nto2YCYHz/RVIjL3AbloKbtBeVQ/NSpMOGKtuP3yhcAUwB1aS9
 6YBT/vkVQ3dlIXaZclpbYAQtYvuWar8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-WOiAR1sKMYGEi-KDRs4Tmg-1; Mon, 03 Apr 2023 14:12:01 -0400
X-MC-Unique: WOiAR1sKMYGEi-KDRs4Tmg-1
Received: by mail-ed1-f70.google.com with SMTP id
 k30-20020a50ce5e000000b00500544ebfb1so42119347edj.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Apr 2023 11:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680545520;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r3M4dnZpzEF1fjTDIk6mn6D6G4XXwwJL/IpU552QBx4=;
 b=8JInTJpjwPTx28eQ32spR4BuM+MQ1EUOlGmTLkm12j98JgR7EtIQirLsHVbR8RWgbm
 4xtur+zODON/IfcEBn99+z81eEkjp1+pSM0+Z1eEMos++0MtR3/BP0l4EhxW9EBTJPZ2
 hPkAuTvzsHTA/H3lS48r3K+PLj0VqgVBjdF4fkpnxg9PxCXyoTbQL2SROnBkrcHLLdkl
 lnZM7gfrQCRYJKBz2XA/Ath4bMxc61D2EvPBPqARJ8MIRJJQpBlMZpJb3hDuprOwguID
 1SK3A7QalvmQF1/pOxQCbLEwXeUQWwAfcWaC09mvSFWP43nOAh7dG3xj7M3/yB7M+gqY
 J1Cw==
X-Gm-Message-State: AAQBX9chgfmpIDiXi+TghKjOvcZEwb5YXvT18cszXo9QHb60Yy/2W8O0
 WABr8MLZOfp6V/j4IHEhBgrE4+Fil71+PnGjVEIc3GYA0n1VD8YF9MHrl++0srAd2sm0WqF+upY
 mLFivTxzrYowD/5YvOo2cS8OAVjnHmgNinLTS4VvkXA==
X-Received: by 2002:a17:906:16da:b0:926:7d96:9434 with SMTP id
 t26-20020a17090616da00b009267d969434mr34904461ejd.51.1680545520360; 
 Mon, 03 Apr 2023 11:12:00 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yw4JflVa4p30rz6SED52DqS4W4do2v197uYUh2bCKyY03l8lo8mHLgjmJcRH2TnvrjmmNaaQ==
X-Received: by 2002:a17:906:16da:b0:926:7d96:9434 with SMTP id
 t26-20020a17090616da00b009267d969434mr34904444ejd.51.1680545520019; 
 Mon, 03 Apr 2023 11:12:00 -0700 (PDT)
Received: from redhat.com ([213.152.162.235]) by smtp.gmail.com with ESMTPSA id
 la6-20020a170907780600b009351565d1f5sm4825614ejc.52.2023.04.03.11.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Apr 2023 11:11:59 -0700 (PDT)
Date: Mon, 3 Apr 2023 14:11:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 1/1] vdpa/mlx5: Support interrupt bypassing
Message-ID: <20230403141115-mutt-send-email-mst@kernel.org>
References: <20230403162039.18932-1-elic@nvidia.com>
 <20230403162039.18932-2-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230403162039.18932-2-elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: parav@mellanox.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, Saeed Mahameed <saeedm@nvidia.com>
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

On Mon, Apr 03, 2023 at 07:20:39PM +0300, Eli Cohen wrote:
> Add support for generation of interrupts from the device directly to the
> VM to the VCPU thus avoiding the overhead on the host CPU.
> 
> When supported, the driver will attempt to allocate vectors for each
> data virtqueue. If a vector for a virtqueue cannot be provided it will
> use the QP mode where notifications go through the driver.
> 
> In addition, we add a shutdown callback to make sure allocated
> interrupts are released in case of shutdown to allow clean shutdown.
> 
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 139 ++++++++++++++++++++++++++++--
>  drivers/vdpa/mlx5/net/mlx5_vnet.h |  14 +++
>  2 files changed, 144 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 520646ae7fa0..215a46cf8a98 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -83,6 +83,7 @@ struct mlx5_vq_restore_info {
>  	u64 driver_addr;
>  	u16 avail_index;
>  	u16 used_index;
> +	struct msi_map map;
>  	bool ready;
>  	bool restore;
>  };
> @@ -118,6 +119,7 @@ struct mlx5_vdpa_virtqueue {
>  	u16 avail_idx;
>  	u16 used_idx;
>  	int fw_state;
> +	struct msi_map map;
>  
>  	/* keep last in the struct */
>  	struct mlx5_vq_restore_info ri;
> @@ -792,6 +794,13 @@ static bool counters_supported(const struct mlx5_vdpa_dev *mvdev)
>  	       BIT_ULL(MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
>  }
>  
> +static bool msix_mode_supported(struct mlx5_vdpa_dev *mvdev)
> +{
> +	return (MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, event_mode) &
> +		(1 << MLX5_VIRTIO_Q_EVENT_MODE_MSIX_MODE) &&
> +		pci_msix_can_alloc_dyn(mvdev->mdev->pdev));

Don't add () around return value. too many () just obscures the logic.


> +}
> +
>  static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
>  {
>  	int inlen = MLX5_ST_SZ_BYTES(create_virtio_net_q_in);
> @@ -829,9 +838,15 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
>  	if (vq_is_tx(mvq->index))
>  		MLX5_SET(virtio_net_q_object, obj_context, tisn_or_qpn, ndev->res.tisn);
>  
> -	MLX5_SET(virtio_q, vq_ctx, event_mode, MLX5_VIRTIO_Q_EVENT_MODE_QP_MODE);
> +	if (mvq->map.virq) {
> +		MLX5_SET(virtio_q, vq_ctx, event_mode, MLX5_VIRTIO_Q_EVENT_MODE_MSIX_MODE);
> +		MLX5_SET(virtio_q, vq_ctx, event_qpn_or_msix, mvq->map.index);
> +	} else {
> +		MLX5_SET(virtio_q, vq_ctx, event_mode, MLX5_VIRTIO_Q_EVENT_MODE_QP_MODE);
> +		MLX5_SET(virtio_q, vq_ctx, event_qpn_or_msix, mvq->fwqp.mqp.qpn);
> +	}
> +
>  	MLX5_SET(virtio_q, vq_ctx, queue_index, mvq->index);
> -	MLX5_SET(virtio_q, vq_ctx, event_qpn_or_msix, mvq->fwqp.mqp.qpn);
>  	MLX5_SET(virtio_q, vq_ctx, queue_size, mvq->num_ent);
>  	MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0,
>  		 !!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_F_VERSION_1)));
> @@ -1174,6 +1189,32 @@ static void counter_set_dealloc(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_vir
>  		mlx5_vdpa_warn(&ndev->mvdev, "dealloc counter set 0x%x\n", mvq->counter_set_id);
>  }
>  
> +static void alloc_vector(struct mlx5_vdpa_net *ndev,
> +			 struct mlx5_vdpa_virtqueue *mvq)
> +{
> +	struct mlx5_vdpa_irq_pool *irqp = &ndev->irqp;
> +	int i;
> +
> +	for (i = 0; i < irqp->num_ent; i++) {
> +		if (!irqp->entries[i].usecount) {
> +			irqp->entries[i].usecount++;
> +			mvq->map = irqp->entries[i].map;
> +			return;
> +		}
> +	}
> +}
> +
> +static void dealloc_vector(struct mlx5_vdpa_net *ndev,
> +			   struct mlx5_vdpa_virtqueue *mvq)
> +{
> +	struct mlx5_vdpa_irq_pool *irqp = &ndev->irqp;
> +	int i;
> +
> +	for (i = 0; i < irqp->num_ent; i++)
> +		if (mvq->map.virq == irqp->entries[i].map.virq)
> +			irqp->entries[i].usecount--;
> +}
> +
>  static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
>  {
>  	u16 idx = mvq->index;
> @@ -1203,27 +1244,31 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
>  
>  	err = counter_set_alloc(ndev, mvq);
>  	if (err)
> -		goto err_counter;
> +		goto err_connect;
>  
> +	alloc_vector(ndev, mvq);
>  	err = create_virtqueue(ndev, mvq);
>  	if (err)
> -		goto err_connect;
> +		goto err_vq;
>  
>  	if (mvq->ready) {
>  		err = modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
>  		if (err) {
>  			mlx5_vdpa_warn(&ndev->mvdev, "failed to modify to ready vq idx %d(%d)\n",
>  				       idx, err);
> -			goto err_connect;
> +			goto err_modify;
>  		}
>  	}
>  
>  	mvq->initialized = true;
>  	return 0;
>  
> -err_connect:
> +err_modify:
> +	destroy_virtqueue(ndev, mvq);
> +err_vq:
> +	dealloc_vector(ndev, mvq);
>  	counter_set_dealloc(ndev, mvq);
> -err_counter:
> +err_connect:
>  	qp_destroy(ndev, &mvq->vqqp);
>  err_vqqp:
>  	qp_destroy(ndev, &mvq->fwqp);
> @@ -1267,6 +1312,7 @@ static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *
>  		return;
>  
>  	suspend_vq(ndev, mvq);
> +	dealloc_vector(ndev, mvq);
>  	destroy_virtqueue(ndev, mvq);
>  	counter_set_dealloc(ndev, mvq);
>  	qp_destroy(ndev, &mvq->vqqp);
> @@ -2374,6 +2420,7 @@ static int save_channel_info(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqu
>  	ri->desc_addr = mvq->desc_addr;
>  	ri->device_addr = mvq->device_addr;
>  	ri->driver_addr = mvq->driver_addr;
> +	ri->map = mvq->map;
>  	ri->restore = true;
>  	return 0;
>  }
> @@ -2418,6 +2465,7 @@ static void restore_channels_info(struct mlx5_vdpa_net *ndev)
>  		mvq->desc_addr = ri->desc_addr;
>  		mvq->device_addr = ri->device_addr;
>  		mvq->driver_addr = ri->driver_addr;
> +		mvq->map = ri->map;
>  	}
>  }
>  
> @@ -2693,6 +2741,22 @@ static struct device *mlx5_get_vq_dma_dev(struct vdpa_device *vdev, u16 idx)
>  	return mvdev->vdev.dma_dev;
>  }
>  
> +static void free_irqs(struct mlx5_vdpa_net *ndev)
> +{
> +	struct mlx5_vdpa_irq_pool_entry *ent;
> +	int i;
> +
> +	if (!msix_mode_supported(&ndev->mvdev))
> +		return;
> +
> +	for (i = ndev->irqp.num_ent - 1; i >= 0; i--) {
> +		ent = ndev->irqp.entries + i;
> +		mlx5_msix_free(ndev->mvdev.mdev, ent->map);
> +		ndev->irqp.num_ent--;
> +	}
> +	kfree(ndev->irqp.entries);
> +}
> +
>  static void mlx5_vdpa_free(struct vdpa_device *vdev)
>  {
>  	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> @@ -2708,6 +2772,7 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
>  		mlx5_mpfs_del_mac(pfmdev, ndev->config.mac);
>  	}
>  	mlx5_vdpa_free_resources(&ndev->mvdev);
> +	free_irqs(ndev);
>  	kfree(ndev->event_cbs);
>  	kfree(ndev->vqs);
>  }
> @@ -2736,9 +2801,23 @@ static struct vdpa_notification_area mlx5_get_vq_notification(struct vdpa_device
>  	return ret;
>  }
>  
> -static int mlx5_get_vq_irq(struct vdpa_device *vdv, u16 idx)
> +static int mlx5_get_vq_irq(struct vdpa_device *vdev, u16 idx)
>  {
> -	return -EOPNOTSUPP;
> +	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> +	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> +	struct mlx5_vdpa_virtqueue *mvq;
> +
> +	if (!is_index_valid(mvdev, idx))
> +		return -EINVAL;
> +
> +	if (is_ctrl_vq_idx(mvdev, idx))
> +		return -EOPNOTSUPP;
> +
> +	mvq = &ndev->vqs[idx];
> +	if (!mvq->map.virq)
> +		return -EOPNOTSUPP;
> +
> +	return mvq->map.virq;
>  }
>  
>  static u64 mlx5_vdpa_get_driver_features(struct vdpa_device *vdev)
> @@ -3095,6 +3174,35 @@ static int config_func_mtu(struct mlx5_core_dev *mdev, u16 mtu)
>  	return err;
>  }
>  
> +static irqreturn_t int_handler(int irq, void *nh)
> +{
> +	return IRQ_HANDLED;
> +}
> +
> +static void allocate_irqs(struct mlx5_vdpa_net *ndev)
> +{
> +	struct mlx5_vdpa_irq_pool_entry *ent;
> +	int i;
> +
> +	if (!msix_mode_supported(&ndev->mvdev))
> +		return;
> +
> +	ndev->irqp.entries = kcalloc(ndev->mvdev.max_vqs, sizeof(*ndev->irqp.entries), GFP_KERNEL);
> +	if (!ndev->irqp.entries)
> +		return;
> +
> +	for (i = 0; i < ndev->mvdev.max_vqs; i++) {
> +		ent = ndev->irqp.entries + i;
> +		snprintf(ent->name, MLX5_VDPA_IRQ_NAME_LEN, "%s-vq-%d",
> +			 dev_name(&ndev->mvdev.vdev.dev), i);
> +		ent->map = mlx5_msix_alloc(ndev->mvdev.mdev, int_handler, NULL, ent->name);
> +		if (!ent->map.virq)
> +			return;
> +
> +		ndev->irqp.num_ent++;
> +	}
> +}
> +
>  static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  			     const struct vdpa_dev_set_config *add_config)
>  {
> @@ -3171,6 +3279,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  	}
>  
>  	init_mvqs(ndev);
> +	allocate_irqs(ndev);
>  	init_rwsem(&ndev->reslock);
>  	config = &ndev->config;
>  
> @@ -3358,6 +3467,17 @@ static void mlx5v_remove(struct auxiliary_device *adev)
>  	kfree(mgtdev);
>  }
>  
> +static void mlx5v_shutdown(struct auxiliary_device *auxdev)
> +{
> +	struct mlx5_vdpa_mgmtdev *mgtdev;
> +	struct mlx5_vdpa_net *ndev;
> +
> +	mgtdev = auxiliary_get_drvdata(auxdev);
> +	ndev = mgtdev->ndev;
> +
> +	free_irqs(ndev);
> +}
> +
>  static const struct auxiliary_device_id mlx5v_id_table[] = {
>  	{ .name = MLX5_ADEV_NAME ".vnet", },
>  	{},
> @@ -3369,6 +3489,7 @@ static struct auxiliary_driver mlx5v_driver = {
>  	.name = "vnet",
>  	.probe = mlx5v_probe,
>  	.remove = mlx5v_remove,
> +	.shutdown = mlx5v_shutdown,
>  	.id_table = mlx5v_id_table,
>  };
>  
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> index c90a89e1de4d..e5063b310d3c 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> @@ -26,6 +26,19 @@ static inline u16 key2vid(u64 key)
>  	return (u16)(key >> 48) & 0xfff;
>  }
>  
> +#define MLX5_VDPA_IRQ_NAME_LEN 32
> +
> +struct mlx5_vdpa_irq_pool_entry {
> +	struct msi_map map;
> +	int usecount;
> +	char name[MLX5_VDPA_IRQ_NAME_LEN];
> +};
> +
> +struct mlx5_vdpa_irq_pool {
> +	int num_ent;
> +	struct mlx5_vdpa_irq_pool_entry *entries;
> +};
> +
>  struct mlx5_vdpa_net {
>  	struct mlx5_vdpa_dev mvdev;
>  	struct mlx5_vdpa_net_resources res;
> @@ -49,6 +62,7 @@ struct mlx5_vdpa_net {
>  	struct vdpa_callback config_cb;
>  	struct mlx5_vdpa_wq_ent cvq_ent;
>  	struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
> +	struct mlx5_vdpa_irq_pool irqp;
>  	struct dentry *debugfs;
>  };
>  
> -- 
> 2.39.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
