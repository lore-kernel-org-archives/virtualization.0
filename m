Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA627C77B72
	for <virtualization@archiver.kernel.org>; Mon, 17 Apr 2023 11:27:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52097821DE;
	Mon, 17 Apr 2023 11:27:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 52097821DE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ycq7eY+p
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9azFlI9TC-IS; Mon, 17 Apr 2023 11:27:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E18B5821C8;
	Mon, 17 Apr 2023 11:27:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E18B5821C8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCC40C0036;
	Mon, 17 Apr 2023 11:27:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0524AC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 11:27:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D543C41C9C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 11:27:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D543C41C9C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ycq7eY+p
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f5PUY2ZN3Enj
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 11:27:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CE5B34059E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CE5B34059E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 11:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681730866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=woEoe/ky/ifPFd2nOkW6u9KXRL4g1n/b16ZE7mnnnfw=;
 b=Ycq7eY+pzqI4BHjpb/rm6S0tjkxpZz46Ah0RnQkeqgWM/nbkNBR8cmxTIcc2q3F6pGBFix
 oNdmRfp0ZkKFQAp1QJB6K+JzwxTLFJR6T6eOjvTJ2FtMq+eH3nP/pgJbv5xtqOYQw3IAoV
 RTemk1yRZGcrxbx/ywwDETAMkaSi4z0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-Z4nO1eM8MXSQrryvF4ygrg-1; Mon, 17 Apr 2023 07:27:45 -0400
X-MC-Unique: Z4nO1eM8MXSQrryvF4ygrg-1
Received: by mail-ej1-f70.google.com with SMTP id
 hh16-20020a170906a95000b00948f41a40d3so10458579ejb.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 04:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681730864; x=1684322864;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=woEoe/ky/ifPFd2nOkW6u9KXRL4g1n/b16ZE7mnnnfw=;
 b=e2pXtC+Y0r85gGufM5yQ/xoWf9Z+GIOnyOEXzqxdgbzNWqVaQZlKfzR99ItwnbaR9M
 bU7IQDMh2nt8iK4eIWmCK0V7zXIiICUIt05o8qpBZjhDE7zm2+ifQo0ayRwzARh0VNsj
 v94sgL9YujmOQRHTDMyeqnXeJKcw2rC/4bKwG85Cq/NbHnTiiaFyuHmZzryJuQKPV8+t
 NEXpjN9cYVrk8UVIA1EqBw/HruoPPr2EO+waqIWjFf3hfCKwFEB5QyH8ieILAP/F19Tt
 YWE4OqJ6+IYkhEFe2S8Fh2aOBhfVJx3PcsWBDlOP90mDMxBQmIkpeMXOITneexeUX3Bi
 3JHw==
X-Gm-Message-State: AAQBX9cQzHbOM/Rct4awCLqw9MTxhLxxnf+QDljAMUJpK/qNj/OK5HhQ
 Mb/LnewcRacV+L79DqNphlrXF8DZe+zjrX9wHQviCk9g+TOKW2eLSJwUUSNw7UtnvoWvNRMAkrz
 Qh40tHHOYuXp+4iATAeLG0/ZybV7EfPnyylDcBefwmckaLhLAoBcX
X-Received: by 2002:a17:906:4708:b0:94f:764e:e311 with SMTP id
 y8-20020a170906470800b0094f764ee311mr2617446ejq.16.1681730863821; 
 Mon, 17 Apr 2023 04:27:43 -0700 (PDT)
X-Google-Smtp-Source: AKy350bBHEvHsHtOzn3UoScLbvY5NOPRLGLimoDvhFKE8ZblaVCkikRe5l8cPMrRGIOSzi5RMNTr3A==
X-Received: by 2002:a17:906:4708:b0:94f:764e:e311 with SMTP id
 y8-20020a170906470800b0094f764ee311mr2617425ejq.16.1681730863462; 
 Mon, 17 Apr 2023 04:27:43 -0700 (PDT)
Received: from redhat.com ([2.52.136.129]) by smtp.gmail.com with ESMTPSA id
 og4-20020a1709071dc400b0094f158ebfc8sm3641388ejc.166.2023.04.17.04.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Apr 2023 04:27:42 -0700 (PDT)
Date: Mon, 17 Apr 2023 07:27:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v5] vdpa/mlx5: Avoid losing link state updates
Message-ID: <20230417072729-mutt-send-email-mst@kernel.org>
References: <20230417110343.138319-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230417110343.138319-1-elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: parav@mellanox.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com
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

On Mon, Apr 17, 2023 at 02:03:43PM +0300, Eli Cohen wrote:
> Current code ignores link state updates if VIRTIO_NET_F_STATUS was not
> negotiated. However, link state updates could be received before feature
> negotiation was completed , therefore causing link state events to be
> lost, possibly leaving the link state down.
> 
> Modify the code so link state notifier is registered after DRIVER_OK was
> negotiated and carry the registration only if
> VIRTIO_NET_F_STATUS was negotiated.  Unregister the notifier when the
> device is reset.
> 
> Fixes: 033779a708f0 ("vdpa/mlx5: make MTU/STATUS presence conditional on feature bits")
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> Message-Id: <20230404073347.40847-1-elic@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

this should not be there either.

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 203 +++++++++++++++++-------------
>  1 file changed, 114 insertions(+), 89 deletions(-)
> v4 -> v5:
> Rebase over latest linux tree.
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 195963b82b63..97a16f7eb894 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2298,6 +2298,113 @@ static void update_cvq_info(struct mlx5_vdpa_dev *mvdev)
>  	}
>  }
>  
> +static u8 query_vport_state(struct mlx5_core_dev *mdev, u8 opmod, u16 vport)
> +{
> +	u32 out[MLX5_ST_SZ_DW(query_vport_state_out)] = {};
> +	u32 in[MLX5_ST_SZ_DW(query_vport_state_in)] = {};
> +	int err;
> +
> +	MLX5_SET(query_vport_state_in, in, opcode, MLX5_CMD_OP_QUERY_VPORT_STATE);
> +	MLX5_SET(query_vport_state_in, in, op_mod, opmod);
> +	MLX5_SET(query_vport_state_in, in, vport_number, vport);
> +	if (vport)
> +		MLX5_SET(query_vport_state_in, in, other_vport, 1);
> +
> +	err = mlx5_cmd_exec_inout(mdev, query_vport_state, in, out);
> +	if (err)
> +		return 0;
> +
> +	return MLX5_GET(query_vport_state_out, out, state);
> +}
> +
> +static bool get_link_state(struct mlx5_vdpa_dev *mvdev)
> +{
> +	if (query_vport_state(mvdev->mdev, MLX5_VPORT_STATE_OP_MOD_VNIC_VPORT, 0) ==
> +	    VPORT_STATE_UP)
> +		return true;
> +
> +	return false;
> +}
> +
> +static void update_carrier(struct work_struct *work)
> +{
> +	struct mlx5_vdpa_wq_ent *wqent;
> +	struct mlx5_vdpa_dev *mvdev;
> +	struct mlx5_vdpa_net *ndev;
> +
> +	wqent = container_of(work, struct mlx5_vdpa_wq_ent, work);
> +	mvdev = wqent->mvdev;
> +	ndev = to_mlx5_vdpa_ndev(mvdev);
> +	if (get_link_state(mvdev))
> +		ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
> +	else
> +		ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
> +
> +	if (ndev->config_cb.callback)
> +		ndev->config_cb.callback(ndev->config_cb.private);
> +
> +	kfree(wqent);
> +}
> +
> +static int queue_link_work(struct mlx5_vdpa_net *ndev)
> +{
> +	struct mlx5_vdpa_wq_ent *wqent;
> +
> +	wqent = kzalloc(sizeof(*wqent), GFP_ATOMIC);
> +	if (!wqent)
> +		return -ENOMEM;
> +
> +	wqent->mvdev = &ndev->mvdev;
> +	INIT_WORK(&wqent->work, update_carrier);
> +	queue_work(ndev->mvdev.wq, &wqent->work);
> +	return 0;
> +}
> +
> +static int event_handler(struct notifier_block *nb, unsigned long event, void *param)
> +{
> +	struct mlx5_vdpa_net *ndev = container_of(nb, struct mlx5_vdpa_net, nb);
> +	struct mlx5_eqe *eqe = param;
> +	int ret = NOTIFY_DONE;
> +
> +	if (event == MLX5_EVENT_TYPE_PORT_CHANGE) {
> +		switch (eqe->sub_type) {
> +		case MLX5_PORT_CHANGE_SUBTYPE_DOWN:
> +		case MLX5_PORT_CHANGE_SUBTYPE_ACTIVE:
> +			if (queue_link_work(ndev))
> +				return NOTIFY_DONE;
> +
> +			ret = NOTIFY_OK;
> +			break;
> +		default:
> +			return NOTIFY_DONE;
> +		}
> +		return ret;
> +	}
> +	return ret;
> +}
> +
> +static void register_link_notifier(struct mlx5_vdpa_net *ndev)
> +{
> +	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_STATUS)))
> +		return;
> +
> +	ndev->nb.notifier_call = event_handler;
> +	mlx5_notifier_register(ndev->mvdev.mdev, &ndev->nb);
> +	ndev->nb_registered = true;
> +	queue_link_work(ndev);
> +}
> +
> +static void unregister_link_notifier(struct mlx5_vdpa_net *ndev)
> +{
> +	if (!ndev->nb_registered)
> +		return;
> +
> +	ndev->nb_registered = false;
> +	mlx5_notifier_unregister(ndev->mvdev.mdev, &ndev->nb);
> +	if (ndev->mvdev.wq)
> +		flush_workqueue(ndev->mvdev.wq);
> +}
> +
>  static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
>  {
>  	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> @@ -2567,10 +2674,11 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
>  				mlx5_vdpa_warn(mvdev, "failed to setup control VQ vring\n");
>  				goto err_setup;
>  			}
> +			register_link_notifier(ndev);
>  			err = setup_driver(mvdev);
>  			if (err) {
>  				mlx5_vdpa_warn(mvdev, "failed to setup driver\n");
> -				goto err_setup;
> +				goto err_driver;
>  			}
>  		} else {
>  			mlx5_vdpa_warn(mvdev, "did not expect DRIVER_OK to be cleared\n");
> @@ -2582,6 +2690,8 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
>  	up_write(&ndev->reslock);
>  	return;
>  
> +err_driver:
> +	unregister_link_notifier(ndev);
>  err_setup:
>  	mlx5_vdpa_destroy_mr(&ndev->mvdev);
>  	ndev->mvdev.status |= VIRTIO_CONFIG_S_FAILED;
> @@ -2607,6 +2717,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>  	mlx5_vdpa_info(mvdev, "performing device reset\n");
>  
>  	down_write(&ndev->reslock);
> +	unregister_link_notifier(ndev);
>  	teardown_driver(ndev);
>  	clear_vqs_ready(ndev);
>  	mlx5_vdpa_destroy_mr(&ndev->mvdev);
> @@ -2861,9 +2972,7 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
>  	mlx5_vdpa_info(mvdev, "suspending device\n");
>  
>  	down_write(&ndev->reslock);
> -	ndev->nb_registered = false;
> -	mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
> -	flush_workqueue(ndev->mvdev.wq);
> +	unregister_link_notifier(ndev);
>  	for (i = 0; i < ndev->cur_num_vqs; i++) {
>  		mvq = &ndev->vqs[i];
>  		suspend_vq(ndev, mvq);
> @@ -3000,84 +3109,6 @@ struct mlx5_vdpa_mgmtdev {
>  	struct mlx5_vdpa_net *ndev;
>  };
>  
> -static u8 query_vport_state(struct mlx5_core_dev *mdev, u8 opmod, u16 vport)
> -{
> -	u32 out[MLX5_ST_SZ_DW(query_vport_state_out)] = {};
> -	u32 in[MLX5_ST_SZ_DW(query_vport_state_in)] = {};
> -	int err;
> -
> -	MLX5_SET(query_vport_state_in, in, opcode, MLX5_CMD_OP_QUERY_VPORT_STATE);
> -	MLX5_SET(query_vport_state_in, in, op_mod, opmod);
> -	MLX5_SET(query_vport_state_in, in, vport_number, vport);
> -	if (vport)
> -		MLX5_SET(query_vport_state_in, in, other_vport, 1);
> -
> -	err = mlx5_cmd_exec_inout(mdev, query_vport_state, in, out);
> -	if (err)
> -		return 0;
> -
> -	return MLX5_GET(query_vport_state_out, out, state);
> -}
> -
> -static bool get_link_state(struct mlx5_vdpa_dev *mvdev)
> -{
> -	if (query_vport_state(mvdev->mdev, MLX5_VPORT_STATE_OP_MOD_VNIC_VPORT, 0) ==
> -	    VPORT_STATE_UP)
> -		return true;
> -
> -	return false;
> -}
> -
> -static void update_carrier(struct work_struct *work)
> -{
> -	struct mlx5_vdpa_wq_ent *wqent;
> -	struct mlx5_vdpa_dev *mvdev;
> -	struct mlx5_vdpa_net *ndev;
> -
> -	wqent = container_of(work, struct mlx5_vdpa_wq_ent, work);
> -	mvdev = wqent->mvdev;
> -	ndev = to_mlx5_vdpa_ndev(mvdev);
> -	if (get_link_state(mvdev))
> -		ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
> -	else
> -		ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
> -
> -	if (ndev->nb_registered && ndev->config_cb.callback)
> -		ndev->config_cb.callback(ndev->config_cb.private);
> -
> -	kfree(wqent);
> -}
> -
> -static int event_handler(struct notifier_block *nb, unsigned long event, void *param)
> -{
> -	struct mlx5_vdpa_net *ndev = container_of(nb, struct mlx5_vdpa_net, nb);
> -	struct mlx5_eqe *eqe = param;
> -	int ret = NOTIFY_DONE;
> -	struct mlx5_vdpa_wq_ent *wqent;
> -
> -	if (event == MLX5_EVENT_TYPE_PORT_CHANGE) {
> -		if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_STATUS)))
> -			return NOTIFY_DONE;
> -		switch (eqe->sub_type) {
> -		case MLX5_PORT_CHANGE_SUBTYPE_DOWN:
> -		case MLX5_PORT_CHANGE_SUBTYPE_ACTIVE:
> -			wqent = kzalloc(sizeof(*wqent), GFP_ATOMIC);
> -			if (!wqent)
> -				return NOTIFY_DONE;
> -
> -			wqent->mvdev = &ndev->mvdev;
> -			INIT_WORK(&wqent->work, update_carrier);
> -			queue_work(ndev->mvdev.wq, &wqent->work);
> -			ret = NOTIFY_OK;
> -			break;
> -		default:
> -			return NOTIFY_DONE;
> -		}
> -		return ret;
> -	}
> -	return ret;
> -}
> -
>  static int config_func_mtu(struct mlx5_core_dev *mdev, u16 mtu)
>  {
>  	int inlen = MLX5_ST_SZ_BYTES(modify_nic_vport_context_in);
> @@ -3258,9 +3289,6 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  		goto err_res2;
>  	}
>  
> -	ndev->nb.notifier_call = event_handler;
> -	mlx5_notifier_register(mdev, &ndev->nb);
> -	ndev->nb_registered = true;
>  	mvdev->vdev.mdev = &mgtdev->mgtdev;
>  	err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1);
>  	if (err)
> @@ -3294,10 +3322,7 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
>  
>  	mlx5_vdpa_remove_debugfs(ndev->debugfs);
>  	ndev->debugfs = NULL;
> -	if (ndev->nb_registered) {
> -		ndev->nb_registered = false;
> -		mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
> -	}
> +	unregister_link_notifier(ndev);
>  	wq = mvdev->wq;
>  	mvdev->wq = NULL;
>  	destroy_workqueue(wq);
> -- 
> 2.39.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
