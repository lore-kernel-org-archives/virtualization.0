Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8C0C7619A
	for <virtualization@archiver.kernel.org>; Mon, 27 Mar 2023 12:41:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8E3B416AC;
	Mon, 27 Mar 2023 12:41:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D8E3B416AC
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZvbBkKoG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VNd4M6eTbs8C; Mon, 27 Mar 2023 12:41:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C5C5440980;
	Mon, 27 Mar 2023 12:41:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C5C5440980
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B14FC0035;
	Mon, 27 Mar 2023 12:41:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 868CFC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 12:41:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5DF206102D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 12:41:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5DF206102D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZvbBkKoG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 03qMHjyNPZu8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 12:41:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5EDC761029
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5EDC761029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 12:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679920891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XnNb/G7ybwqWhcVGEs7/goXAytcVF/QTmVVHZFaD61k=;
 b=ZvbBkKoGtUWSJFZRztkl8Fx+Vx994SQrMevkXCWH/g7Fq02fTX0HgFjicxIT/tu1jKBgxJ
 YIvgcn7n74+28JfbDzxwXCeUItJbgNIH/uphMdETDwbk5/G9avamXrt34lhLwTt6aL9hvX
 SwMX3Dowx4YwIZsWP5R1tQEpvkNK/gU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-9_qZ6MxpO6Knp6xstjo8jQ-1; Mon, 27 Mar 2023 08:41:29 -0400
X-MC-Unique: 9_qZ6MxpO6Knp6xstjo8jQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 o37-20020a05600c512500b003edd119ec9eso4670622wms.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 05:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679920888;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XnNb/G7ybwqWhcVGEs7/goXAytcVF/QTmVVHZFaD61k=;
 b=TurusBKf94cmjyq11BWZO4BlFU03ULDqB7Bx9tzPf6rvFUQZ0GH2pqNV+ZzUaqfUw7
 LCS4Kk5nl54HjhlOsI203avF3ecuq2L54OmEGCAxNrI3e3aiynHVkEVPwZ6MQAm85LwP
 BykQB7dMN9zRlbRd3qltY+01gvixg7p8UoCaIfU/5P3D7IBvSE7tBoEleBc5Sqpe5HLq
 W060OG2h+uGk9UVs+bpaB2W+6F8EAec7YbEukiRwhX+y8n9dLXxIlk863NPfBZldDsL1
 hwft4aOWY19GgV9bXRWDD1XBNL2ccZnHUfaUs2hjcS5KxXzxJHt4UtsshMFAeeamhIEl
 qxJw==
X-Gm-Message-State: AO0yUKWUig4uhrruIYpMy5bzA13xkFpyqC9hEeTQMMqSQRDQILRiE1Mr
 QswYfy4PPWJT+q5DX4MorxNfp3c7jLhQnovHFiwktuFJqY98a97aGiQ3k/VmCpA+UnFKwklbE/P
 o0pjvlVDz246vsMbsoBV9iV+WVJi0eKuN6MnWbTXVfw==
X-Received: by 2002:a05:600c:1d10:b0:3ee:f807:bcf2 with SMTP id
 l16-20020a05600c1d1000b003eef807bcf2mr8673503wms.3.1679920888147; 
 Mon, 27 Mar 2023 05:41:28 -0700 (PDT)
X-Google-Smtp-Source: AK7set8TheuTUoGWRf114NxKydwfPVjTWBZdqU/RmcMnT3g8MnJOEE2t91Q5eAT2uv4X4aE7YpCf2g==
X-Received: by 2002:a05:600c:1d10:b0:3ee:f807:bcf2 with SMTP id
 l16-20020a05600c1d1000b003eef807bcf2mr8673494wms.3.1679920887875; 
 Mon, 27 Mar 2023 05:41:27 -0700 (PDT)
Received: from redhat.com ([2.52.153.142]) by smtp.gmail.com with ESMTPSA id
 hg26-20020a05600c539a00b003ef5b285f65sm8588231wmb.46.2023.03.27.05.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Mar 2023 05:41:27 -0700 (PDT)
Date: Mon, 27 Mar 2023 08:41:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Avoid losing link state updates
Message-ID: <20230327084043-mutt-send-email-mst@kernel.org>
References: <20230320080105.2867-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230320080105.2867-1-elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, parav@mellanox.com,
 virtualization@lists.linux-foundation.org
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

On Mon, Mar 20, 2023 at 10:01:05AM +0200, Eli Cohen wrote:
> Current code ignores link state updates if VIRTIO_NET_F_STATUS was not
> negotiated. However, link state updates could be received before feature
> negotiation was completed , therefore causing link state events to be
> lost, possibly leaving the link state down.
> 
> Add code to detect if VIRTIO_NET_F_STATUS was set and update the link
> state. We add a spinlock to serialize updated to config.status to
> maintain its integrity.
> 
> Fixes: 033779a708f0 ("vdpa/mlx5: make MTU/STATUS presence conditional on feature bits")
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 91 ++++++++++++++++++++-----------
>  drivers/vdpa/mlx5/net/mlx5_vnet.h |  2 +
>  2 files changed, 60 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 520646ae7fa0..20d415e25aeb 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2298,10 +2298,62 @@ static void update_cvq_info(struct mlx5_vdpa_dev *mvdev)
>  	}
>  }
>  
> +static bool f_status_was_set(u64 old, u64 new)

the name is exact reverse of what it does is it not?
it is true if status was not set and is being set.

> +{
> +	if (!(old & BIT_ULL(VIRTIO_NET_F_STATUS)) &&
> +	    (new & BIT_ULL(VIRTIO_NET_F_STATUS)))
> +		return true;
> +
> +	return false;
> +}
> +
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
> +static void update_link_state(struct mlx5_vdpa_dev *mvdev)
> +{
> +	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> +	bool up;
> +
> +	up = get_link_state(mvdev);
> +	spin_lock(&ndev->status_lock);
> +	if (up)
> +		ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
> +	else
> +		ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
> +	spin_unlock(&ndev->status_lock);
> +}
> +
>  static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
>  {
>  	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>  	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> +	u64 cur_features;
>  	int err;
>  
>  	print_features(mvdev, features, true);
> @@ -2310,7 +2362,11 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
>  	if (err)
>  		return err;
>  
> +	cur_features = ndev->mvdev.actual_features;
>  	ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
> +	if (f_status_was_set(cur_features, ndev->mvdev.actual_features))
> +		update_link_state(mvdev);
> +
>  	if (ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ))
>  		ndev->rqt_size = mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
>  	else
> @@ -2995,34 +3051,6 @@ struct mlx5_vdpa_mgmtdev {
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
>  static void update_carrier(struct work_struct *work)
>  {
>  	struct mlx5_vdpa_wq_ent *wqent;
> @@ -3032,11 +3060,7 @@ static void update_carrier(struct work_struct *work)
>  	wqent = container_of(work, struct mlx5_vdpa_wq_ent, work);
>  	mvdev = wqent->mvdev;
>  	ndev = to_mlx5_vdpa_ndev(mvdev);
> -	if (get_link_state(mvdev))
> -		ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
> -	else
> -		ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
> -
> +	update_link_state(mvdev);
>  	if (ndev->nb_registered && ndev->config_cb.callback)
>  		ndev->config_cb.callback(ndev->config_cb.private);
>  
> @@ -3172,6 +3196,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  
>  	init_mvqs(ndev);
>  	init_rwsem(&ndev->reslock);
> +	spin_lock_init(&ndev->status_lock);
>  	config = &ndev->config;
>  
>  	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> index c90a89e1de4d..3666bbaa8822 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> @@ -50,6 +50,8 @@ struct mlx5_vdpa_net {
>  	struct mlx5_vdpa_wq_ent cvq_ent;
>  	struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
>  	struct dentry *debugfs;
> +	/* serialize link status updates */
> +	spinlock_t status_lock;
>  };
>  
>  struct mlx5_vdpa_counter {
> -- 
> 2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
