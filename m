Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF41C761A6
	for <virtualization@archiver.kernel.org>; Mon, 27 Mar 2023 12:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 04EF840B0E;
	Mon, 27 Mar 2023 12:38:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 04EF840B0E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZM7QbGGn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QPl09V94K-Wr; Mon, 27 Mar 2023 12:38:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5CF6840AA8;
	Mon, 27 Mar 2023 12:38:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5CF6840AA8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24F89C0035;
	Mon, 27 Mar 2023 12:38:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D9F8C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 12:38:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 758C640B0E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 12:38:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 758C640B0E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eGXDELZadev7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 12:38:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 221A340AA8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 221A340AA8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 12:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679920722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UbpDTYoq/At0Odd8hud1kBCg5j4qR/OHbJf1L4Zi2CM=;
 b=ZM7QbGGnyhIZhpYGU+kWqd3Mro2RaQCBrZohHhFmWJqTre7PYm6XesH7mbRRkIJkDtvUlH
 8QWUOX+P7hV46LZfFweES0mMUYTyoxXem9tJeeAwzFa1LybHcCxh17Yne8UIJojxCrfVl/
 dMdYSNC33Xmmlp+6f0Vvn2NNyNwgQoM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-Xm5z9g85MXC2Zl1q-p3HiQ-1; Mon, 27 Mar 2023 08:38:40 -0400
X-MC-Unique: Xm5z9g85MXC2Zl1q-p3HiQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 n19-20020a05600c3b9300b003ef63ef4519so3164755wms.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 05:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679920719;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UbpDTYoq/At0Odd8hud1kBCg5j4qR/OHbJf1L4Zi2CM=;
 b=VpW7CHAHiuFwB+yRupIoGbc9DQtNXpwsYxPXUjlJhmDmgBianc9i+xI5uED5v3eRRp
 12fqFa6y3H7zKjeMBQNfaowr7+RMhP76hOErnNHnqb3GHP42gW8TW00CVnEml7dIRbua
 RuM0i3gsLF8d1eWx/HvOW8BZKlN4a8YoQ0vyPmnVmp7OyEq3Dez6n0KFnfg4MNE9JWeK
 9+RyVF06qe81E8mJ41P3RkP9s8rScvxT5jjCpaRFAPJ/1nGcn40KfIR8FO5FImNY0PwA
 rfp1A3GiDsBd7MX247uJ02gEwsy5eFpaZc2dstLQ91VMACfHeoMl2gpxEr/2puiyNXrG
 ocfw==
X-Gm-Message-State: AO0yUKV31NFJr3MiKyE9kTprKZOF8RSgGOV2ozI7Xe2LWAJUlPhrSZfB
 p4sfq+hFxHVGucR6s4uXAmB0OHPz2OETDIb6b/Y1npDu8z+Xrmneq7WsMPDzkyxXYY678CawpwL
 3wB/7I/7HRNoM13WwzJ7LirH07FNtzuzckVp8KAD5XQ==
X-Received: by 2002:a05:600c:258:b0:3ea:d611:f8 with SMTP id
 24-20020a05600c025800b003ead61100f8mr9724859wmj.38.1679920719465; 
 Mon, 27 Mar 2023 05:38:39 -0700 (PDT)
X-Google-Smtp-Source: AK7set/UOswx17qrbUv+u0cZBTGAeBQHLdmx7zBkJZuZH8ZoyS2hYQ9YIiLS1+VRCy5yxrWGcPVlrQ==
X-Received: by 2002:a05:600c:258:b0:3ea:d611:f8 with SMTP id
 24-20020a05600c025800b003ead61100f8mr9724839wmj.38.1679920719133; 
 Mon, 27 Mar 2023 05:38:39 -0700 (PDT)
Received: from redhat.com ([2.52.153.142]) by smtp.gmail.com with ESMTPSA id
 j1-20020a05600c1c0100b003ee6def283bsm8838117wms.11.2023.03.27.05.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Mar 2023 05:38:38 -0700 (PDT)
Date: Mon, 27 Mar 2023 08:38:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Avoid losing link state updates
Message-ID: <20230327083408-mutt-send-email-mst@kernel.org>
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

Hmm I don't get it.

link state changes are config updates are they not?
probe sequence is:

        err = virtio_features_ok(dev);
        if (err)
                goto err;

        err = drv->probe(dev);
        if (err)
                goto err;

        /* If probe didn't do it, mark device DRIVER_OK ourselves. */
        if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
                virtio_device_ready(dev);

        if (drv->scan)
                drv->scan(dev);

        virtio_config_enable(dev);

Looks like config changes that trigger before negotiation are queued,
not lost.

Was there an actual bug you observed or is this theoretical?

Thanks!




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
