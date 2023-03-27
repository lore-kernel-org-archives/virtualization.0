Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD012C761AF
	for <virtualization@archiver.kernel.org>; Mon, 27 Mar 2023 13:28:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8819F60FA1;
	Mon, 27 Mar 2023 13:28:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8819F60FA1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NFTzcxIg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GSXqRtYMRX2a; Mon, 27 Mar 2023 13:28:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D2A7860881;
	Mon, 27 Mar 2023 13:28:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D2A7860881
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7D44C0035;
	Mon, 27 Mar 2023 13:28:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16F0CC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 13:28:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D913B60BD1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 13:28:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D913B60BD1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8reSc59SRY_0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 13:28:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CF5AD60881
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CF5AD60881
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 13:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679923733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=raxgClWNaZ0slt9+Xnf3pZs1In5gM4uG1eWN1jpU+vw=;
 b=NFTzcxIg53lRbUA7mEtU19fZTpHK9vaewXYvFlk+R3ql9ca3Veq4UVnC3l0511E7IapQiP
 ocNHriku1oRvl87wyL4rnSmzUbG+JPvNPzNFaQrcGxfdXMQ8pSV54Df7Y6u5VG+tv65P3s
 HaTtBUzw8LvzpS3kvscm7IsyAZ+ER84=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-SZ8TayevMTiSslKdt03lug-1; Mon, 27 Mar 2023 09:28:50 -0400
X-MC-Unique: SZ8TayevMTiSslKdt03lug-1
Received: by mail-wm1-f70.google.com with SMTP id
 v7-20020a05600c470700b003ef6ebfa99fso1718498wmo.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 06:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679923729;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=raxgClWNaZ0slt9+Xnf3pZs1In5gM4uG1eWN1jpU+vw=;
 b=yK4uc1HURMlh/nB32n3qaZIV3thKRRLv9z4LzRZE14drKkjKnUsmocHREF3ry2s8lp
 lA6iLQC9KvYnh49eUPpNQblBC/daLTURIgypnn9xf9xYGN1W1FmHwRO59wmfoI3A0aKe
 HaOknZBA8Y5Ok6Cw0DADg2bi687Y6N32tf+oB+mHoyqae2S27avVyS40emh5/2hKDoHw
 /zPS+yeocoFSqCvLrnpxo6kqbg0uTPzuhoUBFYDWP0gLRGKYuw8sqzXeY67oL5HvURW4
 VUHY8bZsqPKaOZy/21PSxfGe0T7EfRs8T/Lx1KatqUhPF7QEfycvd4dkueObE/p/hrfG
 DmIQ==
X-Gm-Message-State: AAQBX9cVJ9axtPSoRVg8lF2ROrbB6QFgSvwPwQHilJa98TEgKOpd3/AT
 Pe2/iPWg9L9qP/AqBvv24pje+go4yyy8/RA4xKMC9HQhCNUyX0HPzIfREU7QQUoDcvLGHjCPad4
 vTea4sjdRPQdPCHM+MC1SZEJqGA9CRS8dxlERZH5LdA==
X-Received: by 2002:adf:f1cb:0:b0:2cf:e8b2:4f76 with SMTP id
 z11-20020adff1cb000000b002cfe8b24f76mr10159890wro.66.1679923729570; 
 Mon, 27 Mar 2023 06:28:49 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y6V1NXWgz2ql9bKw0FgUMSb763tTMOmz7zcdvUsn4CL5ct5t0T0sEVc9RyAzKkeKpCPrutBA==
X-Received: by 2002:adf:f1cb:0:b0:2cf:e8b2:4f76 with SMTP id
 z11-20020adff1cb000000b002cfe8b24f76mr10159865wro.66.1679923729023; 
 Mon, 27 Mar 2023 06:28:49 -0700 (PDT)
Received: from redhat.com ([2.52.153.142]) by smtp.gmail.com with ESMTPSA id
 b13-20020adff90d000000b002c54c92e125sm25140224wrr.46.2023.03.27.06.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Mar 2023 06:28:48 -0700 (PDT)
Date: Mon, 27 Mar 2023 09:28:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Avoid losing link state updates
Message-ID: <20230327092109-mutt-send-email-mst@kernel.org>
References: <20230320080105.2867-1-elic@nvidia.com>
 <20230327084043-mutt-send-email-mst@kernel.org>
 <6b775366-d727-6f2b-e002-4fbfb47d5e9a@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <6b775366-d727-6f2b-e002-4fbfb47d5e9a@nvidia.com>
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

On Mon, Mar 27, 2023 at 03:54:34PM +0300, Eli Cohen wrote:
> 
> On 27/03/2023 15:41, Michael S. Tsirkin wrote:
> > On Mon, Mar 20, 2023 at 10:01:05AM +0200, Eli Cohen wrote:
> > > Current code ignores link state updates if VIRTIO_NET_F_STATUS was not
> > > negotiated. However, link state updates could be received before feature
> > > negotiation was completed , therefore causing link state events to be
> > > lost, possibly leaving the link state down.
> > > 
> > > Add code to detect if VIRTIO_NET_F_STATUS was set and update the link
> > > state. We add a spinlock to serialize updated to config.status to
> > > maintain its integrity.
> > > 
> > > Fixes: 033779a708f0 ("vdpa/mlx5: make MTU/STATUS presence conditional on feature bits")
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > ---
> > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 91 ++++++++++++++++++++-----------
> > >   drivers/vdpa/mlx5/net/mlx5_vnet.h |  2 +
> > >   2 files changed, 60 insertions(+), 33 deletions(-)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 520646ae7fa0..20d415e25aeb 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -2298,10 +2298,62 @@ static void update_cvq_info(struct mlx5_vdpa_dev *mvdev)
> > >   	}
> > >   }
> > > +static bool f_status_was_set(u64 old, u64 new)
> > the name is exact reverse of what it does is it not?
> > it is true if status was not set and is being set.
> 
> I am tracking feature negotiation to check if VIRTIO_NET_F_STATUS *just
> became set* and unconditionally update link state.
> If you still think the name choice is not good, I can change it.

this is where you use the function currently.
yes the "new" value is currently the value that
was already saved before the call to the function.
but the function itself does not care.
but it says nothing about what it does itself.
it gets old and new and tells you whether VIRTIO_NET_F_STATUS
flipped from 0 in old to 1 in new.

I am not sure why you need helper, you can write
it in a single statement as:

(~old & new & BIT_ULL(VIRTIO_NET_F_STATUS))

or here practically:

    if (~cur_features & ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_STATUS))

(maybe use a shorter name for cur_features to fit in 80 columns).
so I would just open-code, but if you do write a helper then it
should make sense by itself and be reusable.


> 
> > 
> > > +{
> > > +	if (!(old & BIT_ULL(VIRTIO_NET_F_STATUS)) &&
> > > +	    (new & BIT_ULL(VIRTIO_NET_F_STATUS)))
> > > +		return true;
> > > +
> > > +	return false;
> > > +}
> > > +
> > > +static u8 query_vport_state(struct mlx5_core_dev *mdev, u8 opmod, u16 vport)
> > > +{
> > > +	u32 out[MLX5_ST_SZ_DW(query_vport_state_out)] = {};
> > > +	u32 in[MLX5_ST_SZ_DW(query_vport_state_in)] = {};
> > > +	int err;
> > > +
> > > +	MLX5_SET(query_vport_state_in, in, opcode, MLX5_CMD_OP_QUERY_VPORT_STATE);
> > > +	MLX5_SET(query_vport_state_in, in, op_mod, opmod);
> > > +	MLX5_SET(query_vport_state_in, in, vport_number, vport);
> > > +	if (vport)
> > > +		MLX5_SET(query_vport_state_in, in, other_vport, 1);
> > > +
> > > +	err = mlx5_cmd_exec_inout(mdev, query_vport_state, in, out);
> > > +	if (err)
> > > +		return 0;
> > > +
> > > +	return MLX5_GET(query_vport_state_out, out, state);
> > > +}
> > > +
> > > +static bool get_link_state(struct mlx5_vdpa_dev *mvdev)
> > > +{
> > > +	if (query_vport_state(mvdev->mdev, MLX5_VPORT_STATE_OP_MOD_VNIC_VPORT, 0) ==
> > > +	    VPORT_STATE_UP)
> > > +		return true;
> > > +
> > > +	return false;
> > > +}
> > > +
> > > +static void update_link_state(struct mlx5_vdpa_dev *mvdev)
> > > +{
> > > +	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > +	bool up;
> > > +
> > > +	up = get_link_state(mvdev);
> > > +	spin_lock(&ndev->status_lock);
> > > +	if (up)
> > > +		ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
> > > +	else
> > > +		ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
> > > +	spin_unlock(&ndev->status_lock);
> > > +}
> > > +
> > >   static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
> > >   {
> > >   	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > >   	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > +	u64 cur_features;
> > >   	int err;
> > >   	print_features(mvdev, features, true);
> > > @@ -2310,7 +2362,11 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
> > >   	if (err)
> > >   		return err;
> > > +	cur_features = ndev->mvdev.actual_features;
> > >   	ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
> > > +	if (f_status_was_set(cur_features, ndev->mvdev.actual_features))
> > > +		update_link_state(mvdev);
> > > +
> > >   	if (ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ))
> > >   		ndev->rqt_size = mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
> > >   	else
> > > @@ -2995,34 +3051,6 @@ struct mlx5_vdpa_mgmtdev {
> > >   	struct mlx5_vdpa_net *ndev;
> > >   };
> > > -static u8 query_vport_state(struct mlx5_core_dev *mdev, u8 opmod, u16 vport)
> > > -{
> > > -	u32 out[MLX5_ST_SZ_DW(query_vport_state_out)] = {};
> > > -	u32 in[MLX5_ST_SZ_DW(query_vport_state_in)] = {};
> > > -	int err;
> > > -
> > > -	MLX5_SET(query_vport_state_in, in, opcode, MLX5_CMD_OP_QUERY_VPORT_STATE);
> > > -	MLX5_SET(query_vport_state_in, in, op_mod, opmod);
> > > -	MLX5_SET(query_vport_state_in, in, vport_number, vport);
> > > -	if (vport)
> > > -		MLX5_SET(query_vport_state_in, in, other_vport, 1);
> > > -
> > > -	err = mlx5_cmd_exec_inout(mdev, query_vport_state, in, out);
> > > -	if (err)
> > > -		return 0;
> > > -
> > > -	return MLX5_GET(query_vport_state_out, out, state);
> > > -}
> > > -
> > > -static bool get_link_state(struct mlx5_vdpa_dev *mvdev)
> > > -{
> > > -	if (query_vport_state(mvdev->mdev, MLX5_VPORT_STATE_OP_MOD_VNIC_VPORT, 0) ==
> > > -	    VPORT_STATE_UP)
> > > -		return true;
> > > -
> > > -	return false;
> > > -}
> > > -
> > >   static void update_carrier(struct work_struct *work)
> > >   {
> > >   	struct mlx5_vdpa_wq_ent *wqent;
> > > @@ -3032,11 +3060,7 @@ static void update_carrier(struct work_struct *work)
> > >   	wqent = container_of(work, struct mlx5_vdpa_wq_ent, work);
> > >   	mvdev = wqent->mvdev;
> > >   	ndev = to_mlx5_vdpa_ndev(mvdev);
> > > -	if (get_link_state(mvdev))
> > > -		ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
> > > -	else
> > > -		ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
> > > -
> > > +	update_link_state(mvdev);
> > >   	if (ndev->nb_registered && ndev->config_cb.callback)
> > >   		ndev->config_cb.callback(ndev->config_cb.private);
> > > @@ -3172,6 +3196,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> > >   	init_mvqs(ndev);
> > >   	init_rwsem(&ndev->reslock);
> > > +	spin_lock_init(&ndev->status_lock);
> > >   	config = &ndev->config;
> > >   	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> > > index c90a89e1de4d..3666bbaa8822 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> > > @@ -50,6 +50,8 @@ struct mlx5_vdpa_net {
> > >   	struct mlx5_vdpa_wq_ent cvq_ent;
> > >   	struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
> > >   	struct dentry *debugfs;
> > > +	/* serialize link status updates */
> > > +	spinlock_t status_lock;
> > >   };
> > >   struct mlx5_vdpa_counter {
> > > -- 
> > > 2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
