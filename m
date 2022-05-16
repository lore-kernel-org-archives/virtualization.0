Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F9AC433F5
	for <virtualization@archiver.kernel.org>; Mon, 16 May 2022 08:22:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 36DC940396;
	Mon, 16 May 2022 08:22:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q0V8ItPwQdrV; Mon, 16 May 2022 08:22:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8D1BE408D5;
	Mon, 16 May 2022 08:22:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C7D2C0032;
	Mon, 16 May 2022 08:22:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E391C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 08:22:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 57CD941702
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 08:22:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TQzNzgqRHM16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 08:22:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C76E0416FA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 08:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652689371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WNvDsFdKXXxNUzS9xa6p0OG+HdvP+Qe9tir/WG8T4Zw=;
 b=Oh/u5M5vN5kGgaYCPpoS+IlXPSzZUNZBuZtQCiqcnmlKQwoBcqPTlY4rn1+dVt8AnKOcMG
 siXp9LUHmVGch4KiBonO8BIY8JMlflhqsFWU0DdI3VDq2cMZvGLHv0Zac85Ex+G820Ds5W
 NJP9WawR6oFxTR6EAadD20MUPErFHWc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-7OWfFwclN1S9Gl8Ofmb5Jw-1; Mon, 16 May 2022 04:22:48 -0400
X-MC-Unique: 7OWfFwclN1S9Gl8Ofmb5Jw-1
Received: by mail-wr1-f71.google.com with SMTP id
 o13-20020adfa10d000000b0020c6fa5a77cso3659956wro.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 01:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WNvDsFdKXXxNUzS9xa6p0OG+HdvP+Qe9tir/WG8T4Zw=;
 b=LSStBibNDQUHuL3Km7UgxdcoH8Ei6lY0brdYzLbqjtcUaIJmtyJR6djlxyRcq8EJ18
 1lPCxocLFiNxY40IIabKNZ3g1UcAvNmqx7gw+6eukSNYHKJ6FUJJG0/+7WN2tYka/iMt
 YTYrEPchhgzVCx6PT/WfkQ4M4ohT93ajCZnMQF3yLKgSavIS94+7xXipU2kyIwV3UniB
 WwtfrkTZ56k307yMLEgjFnEvPHmCm4ptnrKl1kQGdUVCTgGGaHt1vnDwP0q/5c9EDLRf
 +xhERVyxquknvqhSPn/XR6+/5OZ0QYbKRv9w6bx8uT3OLpHRlmSwW9zYJy4Wux5aOdVP
 d3Rg==
X-Gm-Message-State: AOAM530KFx0vpKH2zq3uOrBGtcqVbaPUeCoQY3NW4/HUAeW3E5i0arvZ
 b1qsGGRBTIzrdvUHxT9jGdo8WH5xWFDJFGhIf6KPxctgyqPWe990m4wIPYsIDbVqqjeL35jMhMx
 iiorlS7tCeTIkyDG9hdi9YxltPBLHqdaJNwYK6at0aQ==
X-Received: by 2002:a1c:4456:0:b0:395:b9bf:57 with SMTP id
 r83-20020a1c4456000000b00395b9bf0057mr23439427wma.21.1652689367024; 
 Mon, 16 May 2022 01:22:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxejjGYUhnUK8sEqz50naB0K9MbMknqjB3nHtA62/D77/KpoFScxr6uUPVS4u9zWeA/TaNNSA==
X-Received: by 2002:a1c:4456:0:b0:395:b9bf:57 with SMTP id
 r83-20020a1c4456000000b00395b9bf0057mr23439416wma.21.1652689366805; 
 Mon, 16 May 2022 01:22:46 -0700 (PDT)
Received: from redhat.com ([2.55.141.66]) by smtp.gmail.com with ESMTPSA id
 o20-20020a1c4d14000000b0039453fe55a7sm12550284wmh.35.2022.05.16.01.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 May 2022 01:22:46 -0700 (PDT)
Date: Mon, 16 May 2022 04:22:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH RESEND V3 3/3] vdpa/mlx5: Use consistent RQT size
Message-ID: <20220516041917-mutt-send-email-mst@kernel.org>
References: <20220406085325.87644-1-elic@nvidia.com>
 <DM8PR12MB5400507B1DA407DEC2E72195ABCF9@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB5400507B1DA407DEC2E72195ABCF9@DM8PR12MB5400.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hdanton@sina.com" <hdanton@sina.com>, Cindy Lu <lulu@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Mon, May 16, 2022 at 08:17:18AM +0000, Eli Cohen wrote:
> Hi Michael,
> 
> When are you going to pull this fix?
> It fixes a real problem and was reviewed and acked.

Do I understand it correctly that this is a stand-alone patch?
Sorry, my process have been thrown off by it being labeled 3/3 but not
being part of a thread. Do not do this for single patches please.
And I suspect 0-day machinery didn't process it either.
Can you repost as a stand-along patch please?
I will then process ASAP.

Thanks!

> > -----Original Message-----
> > From: Eli Cohen <elic@nvidia.com>
> > Sent: Wednesday, April 6, 2022 11:53 AM
> > To: mst@redhat.com; jasowang@redhat.com
> > Cc: hdanton@sina.com; virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org; Eli Cohen <elic@nvidia.com>
> > Subject: [PATCH RESEND V3 3/3] vdpa/mlx5: Use consistent RQT size
> > 
> > The current code evaluates RQT size based on the configured number of
> > virtqueues. This can raise an issue in the following scenario:
> > 
> > Assume MQ was negotiated.
> > 1. mlx5_vdpa_set_map() gets called.
> > 2. handle_ctrl_mq() is called setting cur_num_vqs to some value, lower
> >    than the configured max VQs.
> > 3. A second set_map gets called, but now a smaller number of VQs is used
> >    to evaluate the size of the RQT.
> > 4. handle_ctrl_mq() is called with a value larger than what the RQT can
> >    hold. This will emit errors and the driver state is compromised.
> > 
> > To fix this, we use a new field in struct mlx5_vdpa_net to hold the
> > required number of entries in the RQT. This value is evaluated in
> > mlx5_vdpa_set_driver_features() where we have the negotiated features
> > all set up.
> > 
> > In addition to that, we take into consideration the max capability of RQT
> > entries early when the device is added so we don't need to take consider
> > it when creating the RQT.
> > 
> > Last, we remove the use of mlx5_vdpa_max_qps() which just returns the
> > max_vas / 2 and make the code clearer.
> > 
> > Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > ---
> > V2 -> V3:
> > Fix typo in change log
> > Add acked-by Jason
> > 
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 61 +++++++++++--------------------
> >  1 file changed, 21 insertions(+), 40 deletions(-)
> > 
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 79001301b383..e0de44000d92 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -161,6 +161,7 @@ struct mlx5_vdpa_net {
> >  	struct mlx5_flow_handle *rx_rule_mcast;
> >  	bool setup;
> >  	u32 cur_num_vqs;
> > +	u32 rqt_size;
> >  	struct notifier_block nb;
> >  	struct vdpa_callback config_cb;
> >  	struct mlx5_vdpa_wq_ent cvq_ent;
> > @@ -204,17 +205,12 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
> >  	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
> >  }
> > 
> > -static inline u32 mlx5_vdpa_max_qps(int max_vqs)
> > -{
> > -	return max_vqs / 2;
> > -}
> > -
> >  static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
> >  {
> >  	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> >  		return 2;
> > 
> > -	return 2 * mlx5_vdpa_max_qps(mvdev->max_vqs);
> > +	return mvdev->max_vqs;
> >  }
> > 
> >  static bool is_ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev, u16 idx)
> > @@ -1236,25 +1232,13 @@ static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *
> >  static int create_rqt(struct mlx5_vdpa_net *ndev)
> >  {
> >  	__be32 *list;
> > -	int max_rqt;
> >  	void *rqtc;
> >  	int inlen;
> >  	void *in;
> >  	int i, j;
> >  	int err;
> > -	int num;
> > -
> > -	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> > -		num = 1;
> > -	else
> > -		num = ndev->cur_num_vqs / 2;
> > 
> > -	max_rqt = min_t(int, roundup_pow_of_two(num),
> > -			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
> > -	if (max_rqt < 1)
> > -		return -EOPNOTSUPP;
> > -
> > -	inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + max_rqt * MLX5_ST_SZ_BYTES(rq_num);
> > +	inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + ndev->rqt_size * MLX5_ST_SZ_BYTES(rq_num);
> >  	in = kzalloc(inlen, GFP_KERNEL);
> >  	if (!in)
> >  		return -ENOMEM;
> > @@ -1263,12 +1247,12 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
> >  	rqtc = MLX5_ADDR_OF(create_rqt_in, in, rqt_context);
> > 
> >  	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
> > -	MLX5_SET(rqtc, rqtc, rqt_max_size, max_rqt);
> > +	MLX5_SET(rqtc, rqtc, rqt_max_size, ndev->rqt_size);
> >  	list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> > -	for (i = 0, j = 0; i < max_rqt; i++, j += 2)
> > -		list[i] = cpu_to_be32(ndev->vqs[j % (2 * num)].virtq_id);
> > +	for (i = 0, j = 0; i < ndev->rqt_size; i++, j += 2)
> > +		list[i] = cpu_to_be32(ndev->vqs[j % ndev->cur_num_vqs].virtq_id);
> > 
> > -	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
> > +	MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
> >  	err = mlx5_vdpa_create_rqt(&ndev->mvdev, in, inlen, &ndev->res.rqtn);
> >  	kfree(in);
> >  	if (err)
> > @@ -1282,19 +1266,13 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
> >  static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
> >  {
> >  	__be32 *list;
> > -	int max_rqt;
> >  	void *rqtc;
> >  	int inlen;
> >  	void *in;
> >  	int i, j;
> >  	int err;
> > 
> > -	max_rqt = min_t(int, roundup_pow_of_two(ndev->cur_num_vqs / 2),
> > -			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
> > -	if (max_rqt < 1)
> > -		return -EOPNOTSUPP;
> > -
> > -	inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) + max_rqt * MLX5_ST_SZ_BYTES(rq_num);
> > +	inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) + ndev->rqt_size * MLX5_ST_SZ_BYTES(rq_num);
> >  	in = kzalloc(inlen, GFP_KERNEL);
> >  	if (!in)
> >  		return -ENOMEM;
> > @@ -1305,10 +1283,10 @@ static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
> >  	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
> > 
> >  	list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> > -	for (i = 0, j = 0; i < max_rqt; i++, j += 2)
> > +	for (i = 0, j = 0; i < ndev->rqt_size; i++, j += 2)
> >  		list[i] = cpu_to_be32(ndev->vqs[j % num].virtq_id);
> > 
> > -	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
> > +	MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
> >  	err = mlx5_vdpa_modify_rqt(&ndev->mvdev, in, inlen, ndev->res.rqtn);
> >  	kfree(in);
> >  	if (err)
> > @@ -1625,7 +1603,7 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct mlx5_vdpa_dev *mvdev, u8 cmd)
> > 
> >  		newqps = mlx5vdpa16_to_cpu(mvdev, mq.virtqueue_pairs);
> >  		if (newqps < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
> > -		    newqps > mlx5_vdpa_max_qps(mvdev->max_vqs))
> > +		    newqps > ndev->rqt_size)
> >  			break;
> > 
> >  		if (ndev->cur_num_vqs == 2 * newqps) {
> > @@ -1989,7 +1967,7 @@ static int setup_virtqueues(struct mlx5_vdpa_dev *mvdev)
> >  	int err;
> >  	int i;
> > 
> > -	for (i = 0; i < 2 * mlx5_vdpa_max_qps(mvdev->max_vqs); i++) {
> > +	for (i = 0; i < mvdev->max_vqs; i++) {
> >  		err = setup_vq(ndev, &ndev->vqs[i]);
> >  		if (err)
> >  			goto err_vq;
> > @@ -2060,9 +2038,11 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
> > 
> >  	ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
> >  	if (ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ))
> > -		ndev->cur_num_vqs = 2 * mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
> > +		ndev->rqt_size = mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
> >  	else
> > -		ndev->cur_num_vqs = 2;
> > +		ndev->rqt_size = 1;
> > +
> > +	ndev->cur_num_vqs = 2 * ndev->rqt_size;
> > 
> >  	update_cvq_info(mvdev);
> >  	return err;
> > @@ -2529,7 +2509,7 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
> >  	struct mlx5_vdpa_virtqueue *mvq;
> >  	int i;
> > 
> > -	for (i = 0; i < 2 * mlx5_vdpa_max_qps(ndev->mvdev.max_vqs); ++i) {
> > +	for (i = 0; i < ndev->mvdev.max_vqs; ++i) {
> >  		mvq = &ndev->vqs[i];
> >  		memset(mvq, 0, offsetof(struct mlx5_vdpa_virtqueue, ri));
> >  		mvq->index = i;
> > @@ -2671,7 +2651,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> >  		return -EOPNOTSUPP;
> >  	}
> > 
> > -	max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
> > +	max_vqs = min_t(int, MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues),
> > +			1 << MLX5_CAP_GEN(mdev, log_max_rqt_size));
> >  	if (max_vqs < 2) {
> >  		dev_warn(mdev->device,
> >  			 "%d virtqueues are supported. At least 2 are required\n",
> > @@ -2742,7 +2723,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> >  		ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MAC);
> >  	}
> > 
> > -	config->max_virtqueue_pairs = cpu_to_mlx5vdpa16(mvdev, mlx5_vdpa_max_qps(max_vqs));
> > +	config->max_virtqueue_pairs = cpu_to_mlx5vdpa16(mvdev, max_vqs / 2);
> >  	mvdev->vdev.dma_dev = &mdev->pdev->dev;
> >  	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
> >  	if (err)
> > @@ -2769,7 +2750,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> >  	ndev->nb.notifier_call = event_handler;
> >  	mlx5_notifier_register(mdev, &ndev->nb);
> >  	mvdev->vdev.mdev = &mgtdev->mgtdev;
> > -	err = _vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_vqs) + 1);
> > +	err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1);
> >  	if (err)
> >  		goto err_reg;
> > 
> > --
> > 2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
