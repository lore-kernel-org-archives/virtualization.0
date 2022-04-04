Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5243DC433F5
	for <virtualization@archiver.kernel.org>; Mon,  4 Apr 2022 10:34:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F252E60A7D;
	Mon,  4 Apr 2022 10:34:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KagCb5ktzKcE; Mon,  4 Apr 2022 10:34:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 44A6A60A70;
	Mon,  4 Apr 2022 10:34:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 168ACC001D;
	Mon,  4 Apr 2022 10:34:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5B80C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 945C840491
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:34:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FAhEL_mGcac5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:34:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 98A0440423
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649068483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UkMzo9SC4Lk9QRXtTS19a+ICMVFUqXkqKjt3lqG2PAs=;
 b=Nni4GKqPdgxlQuevYUUglFnrmyyayTm46dEQ+7dbgeXVvPClO+zX/5aakZ03CwN+jzwQ0j
 +Zc6Qulth6fBwakWyHpyn5BVKBj5UUXh3jLRomtapl2rl5fs++t0y+tfAGhulU1YfITeol
 g6joD0tQz9CMCy12W1cYCziIQD7yKuI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-TqPmiyYaPu-CAyuGrWpnCQ-1; Mon, 04 Apr 2022 06:34:42 -0400
X-MC-Unique: TqPmiyYaPu-CAyuGrWpnCQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 a16-20020a05600c349000b0038e6392a346so3267742wmq.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Apr 2022 03:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UkMzo9SC4Lk9QRXtTS19a+ICMVFUqXkqKjt3lqG2PAs=;
 b=WFM4vkc1HZVBaPJDlObFK2wugtjNo6b7v2+5hza+DRPcrALJbZqu2v8dvvzUHSZwD6
 4A2xH+XVQloUs2pETnL1xYT7qpxBDw/Cjrt4qJHhrrkjgwG/oFw/lVWPBqw6hCiq4C4Y
 PJtAMNo0irMiJHYussMkuGDZIQtsIoAL9cY3uC4wqA1gV7GNUGSjpbb7Uy53wdY01xM5
 O2Pr0+kRCsBKChGhEcyFJxSBqr7fqlLlrrUqi7/EdFZPTojGuXMuopboVninUZN+ynYr
 OSmyuGeqhCAAN8GdbTaCmykUmQFZVJCdqxcpHBSUVav0T2ahmkCDnhSV1WoUbbJ04uX/
 1J0A==
X-Gm-Message-State: AOAM532IoELSj5dyagezgIkIEdWheF3GbGxfPysN69koz/pwoSlW2846
 JXC1EI9iJ2fAnyRBqid5Dg6phkQh/Z3OzP6mnAJRMTdRta0yKL6/aZfIwUlVCQS8HUGSQjF4f7L
 3/xiVdRmCXZgv1mekSOpqnrzhNX5VOqiGh8f5wqtNtA==
X-Received: by 2002:adf:a45d:0:b0:206:1581:dac4 with SMTP id
 e29-20020adfa45d000000b002061581dac4mr1888201wra.265.1649068481126; 
 Mon, 04 Apr 2022 03:34:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSvw8W9KnjdJz5qRR+oDDpvMeFjAiaJymtKz8v8N8RnqnrbHizeAkpvdliMywjDvht+YKA5A==
X-Received: by 2002:adf:a45d:0:b0:206:1581:dac4 with SMTP id
 e29-20020adfa45d000000b002061581dac4mr1888179wra.265.1649068480814; 
 Mon, 04 Apr 2022 03:34:40 -0700 (PDT)
Received: from redhat.com ([2.54.40.213]) by smtp.gmail.com with ESMTPSA id
 t4-20020adfe104000000b00205b50f04f0sm8983779wrz.86.2022.04.04.03.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Apr 2022 03:34:40 -0700 (PDT)
Date: Mon, 4 Apr 2022 06:34:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RESEND V2 3/3] vdpa/mlx5: Use consistent RQT size
Message-ID: <20220404063241-mutt-send-email-mst@kernel.org>
References: <20220329042109.4029-1-jasowang@redhat.com>
 <20220329042109.4029-3-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220329042109.4029-3-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, elic@nvidia.com, hdanton@sina.com,
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

On Tue, Mar 29, 2022 at 12:21:09PM +0800, Jason Wang wrote:
> From: Eli Cohen <elic@nvidia.com>
> 
> The current code evaluates RQT size based on the configured number of
> virtqueues. This can raise an issue in the following scenario:
> 
> Assume MQ was negotiated.
> 1. mlx5_vdpa_set_map() gets called.
> 2. handle_ctrl_mq() is called setting cur_num_vqs to some value, lower
>    than the configured max VQs.
> 3. A second set_map gets called, but now a smaller number of VQs is used
>    to evaluate the size of the RQT.
> 4. handle_ctrl_mq() is called with a value larger than what the RQT can
>    hold. This will emit errors and the driver state is compromised.
> 
> To fix this, we use a new field in struct mlx5_vdpa_net to hold the
> required number of entries in the RQT. This value is evaluated in
> mlx5_vdpa_set_driver_features() where we have the negotiated features
> all set up.
> 
> In addtion

addition?

> to that, we take into consideration the max capability of RQT
> entries early when the device is added so we don't need to take consider
> it when creating the RQT.
> 
> Last, we remove the use of mlx5_vdpa_max_qps() which just returns the
> max_vas / 2 and make the code clearer.
> 
> Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Jason I don't have your ack or S.O.B on this one.


> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 61 +++++++++++--------------------
>  1 file changed, 21 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 53b8c1a68f90..61bec1ed0bc9 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -161,6 +161,7 @@ struct mlx5_vdpa_net {
>  	struct mlx5_flow_handle *rx_rule_mcast;
>  	bool setup;
>  	u32 cur_num_vqs;
> +	u32 rqt_size;
>  	struct notifier_block nb;
>  	struct vdpa_callback config_cb;
>  	struct mlx5_vdpa_wq_ent cvq_ent;
> @@ -204,17 +205,12 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
>  	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
>  }
>  
> -static inline u32 mlx5_vdpa_max_qps(int max_vqs)
> -{
> -	return max_vqs / 2;
> -}
> -
>  static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
>  {
>  	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
>  		return 2;
>  
> -	return 2 * mlx5_vdpa_max_qps(mvdev->max_vqs);
> +	return mvdev->max_vqs;
>  }
>  
>  static bool is_ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev, u16 idx)
> @@ -1236,25 +1232,13 @@ static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *
>  static int create_rqt(struct mlx5_vdpa_net *ndev)
>  {
>  	__be32 *list;
> -	int max_rqt;
>  	void *rqtc;
>  	int inlen;
>  	void *in;
>  	int i, j;
>  	int err;
> -	int num;
> -
> -	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> -		num = 1;
> -	else
> -		num = ndev->cur_num_vqs / 2;
>  
> -	max_rqt = min_t(int, roundup_pow_of_two(num),
> -			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
> -	if (max_rqt < 1)
> -		return -EOPNOTSUPP;
> -
> -	inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + max_rqt * MLX5_ST_SZ_BYTES(rq_num);
> +	inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + ndev->rqt_size * MLX5_ST_SZ_BYTES(rq_num);
>  	in = kzalloc(inlen, GFP_KERNEL);
>  	if (!in)
>  		return -ENOMEM;
> @@ -1263,12 +1247,12 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>  	rqtc = MLX5_ADDR_OF(create_rqt_in, in, rqt_context);
>  
>  	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
> -	MLX5_SET(rqtc, rqtc, rqt_max_size, max_rqt);
> +	MLX5_SET(rqtc, rqtc, rqt_max_size, ndev->rqt_size);
>  	list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> -	for (i = 0, j = 0; i < max_rqt; i++, j += 2)
> -		list[i] = cpu_to_be32(ndev->vqs[j % (2 * num)].virtq_id);
> +	for (i = 0, j = 0; i < ndev->rqt_size; i++, j += 2)
> +		list[i] = cpu_to_be32(ndev->vqs[j % ndev->cur_num_vqs].virtq_id);
>  
> -	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
> +	MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
>  	err = mlx5_vdpa_create_rqt(&ndev->mvdev, in, inlen, &ndev->res.rqtn);
>  	kfree(in);
>  	if (err)
> @@ -1282,19 +1266,13 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>  static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
>  {
>  	__be32 *list;
> -	int max_rqt;
>  	void *rqtc;
>  	int inlen;
>  	void *in;
>  	int i, j;
>  	int err;
>  
> -	max_rqt = min_t(int, roundup_pow_of_two(ndev->cur_num_vqs / 2),
> -			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
> -	if (max_rqt < 1)
> -		return -EOPNOTSUPP;
> -
> -	inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) + max_rqt * MLX5_ST_SZ_BYTES(rq_num);
> +	inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) + ndev->rqt_size * MLX5_ST_SZ_BYTES(rq_num);
>  	in = kzalloc(inlen, GFP_KERNEL);
>  	if (!in)
>  		return -ENOMEM;
> @@ -1305,10 +1283,10 @@ static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
>  	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
>  
>  	list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> -	for (i = 0, j = 0; i < max_rqt; i++, j += 2)
> +	for (i = 0, j = 0; i < ndev->rqt_size; i++, j += 2)
>  		list[i] = cpu_to_be32(ndev->vqs[j % num].virtq_id);
>  
> -	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
> +	MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
>  	err = mlx5_vdpa_modify_rqt(&ndev->mvdev, in, inlen, ndev->res.rqtn);
>  	kfree(in);
>  	if (err)
> @@ -1582,7 +1560,7 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct mlx5_vdpa_dev *mvdev, u8 cmd)
>  
>  		newqps = mlx5vdpa16_to_cpu(mvdev, mq.virtqueue_pairs);
>  		if (newqps < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
> -		    newqps > mlx5_vdpa_max_qps(mvdev->max_vqs))
> +		    newqps > ndev->rqt_size)
>  			break;
>  
>  		if (ndev->cur_num_vqs == 2 * newqps) {
> @@ -1946,7 +1924,7 @@ static int setup_virtqueues(struct mlx5_vdpa_dev *mvdev)
>  	int err;
>  	int i;
>  
> -	for (i = 0; i < 2 * mlx5_vdpa_max_qps(mvdev->max_vqs); i++) {
> +	for (i = 0; i < mvdev->max_vqs; i++) {
>  		err = setup_vq(ndev, &ndev->vqs[i]);
>  		if (err)
>  			goto err_vq;
> @@ -2017,9 +1995,11 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
>  
>  	ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
>  	if (ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ))
> -		ndev->cur_num_vqs = 2 * mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
> +		ndev->rqt_size = mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
>  	else
> -		ndev->cur_num_vqs = 2;
> +		ndev->rqt_size = 1;
> +
> +	ndev->cur_num_vqs = 2 * ndev->rqt_size;
>  
>  	update_cvq_info(mvdev);
>  	return err;
> @@ -2486,7 +2466,7 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
>  	struct mlx5_vdpa_virtqueue *mvq;
>  	int i;
>  
> -	for (i = 0; i < 2 * mlx5_vdpa_max_qps(ndev->mvdev.max_vqs); ++i) {
> +	for (i = 0; i < ndev->mvdev.max_vqs; ++i) {
>  		mvq = &ndev->vqs[i];
>  		memset(mvq, 0, offsetof(struct mlx5_vdpa_virtqueue, ri));
>  		mvq->index = i;
> @@ -2606,7 +2586,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  		return -EOPNOTSUPP;
>  	}
>  
> -	max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
> +	max_vqs = min_t(int, MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues),
> +			1 << MLX5_CAP_GEN(mdev, log_max_rqt_size));
>  	if (max_vqs < 2) {
>  		dev_warn(mdev->device,
>  			 "%d virtqueues are supported. At least 2 are required\n",
> @@ -2670,7 +2651,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  		ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MAC);
>  	}
>  
> -	config->max_virtqueue_pairs = cpu_to_mlx5vdpa16(mvdev, mlx5_vdpa_max_qps(max_vqs));
> +	config->max_virtqueue_pairs = cpu_to_mlx5vdpa16(mvdev, max_vqs / 2);
>  	mvdev->vdev.dma_dev = &mdev->pdev->dev;
>  	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
>  	if (err)
> @@ -2697,7 +2678,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  	ndev->nb.notifier_call = event_handler;
>  	mlx5_notifier_register(mdev, &ndev->nb);
>  	mvdev->vdev.mdev = &mgtdev->mgtdev;
> -	err = _vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_vqs) + 1);
> +	err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1);
>  	if (err)
>  		goto err_reg;
>  
> -- 
> 2.18.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
