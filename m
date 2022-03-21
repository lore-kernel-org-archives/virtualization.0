Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEF5C433FE
	for <virtualization@archiver.kernel.org>; Mon, 21 Mar 2022 07:20:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B728C60E17;
	Mon, 21 Mar 2022 07:20:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xScXn5EyRllF; Mon, 21 Mar 2022 07:20:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3A6ED60C09;
	Mon, 21 Mar 2022 07:20:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D111C001A;
	Mon, 21 Mar 2022 07:20:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A526C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 07:20:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4B72182446
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 07:20:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nXNLpCgUTMYx
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 07:20:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E57B82416
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 07:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647847252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SIJ1lFudMiKPRPgtx9GaQG4dP6LxXEZqctYzO9j/NOg=;
 b=ZSWW0leRe6ilGk3Kv29P1GodpIVkOZnWrEqPdx6kanwPxx2ymQb4lm47xgdyp2mWJ7jE0O
 Ln6IhDs/s4Ey+PXfnKL4j1f0wCqfg1ZE5xmlZeUkjSByivEA5AUZcQ6E9j+Y4VbsdfaI/f
 TEham6NA7hhZsOUWthAykHHug71LRHM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-zddLLBp2OKugjRtL3dfiPQ-1; Mon, 21 Mar 2022 03:20:50 -0400
X-MC-Unique: zddLLBp2OKugjRtL3dfiPQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 m123-20020a1c2681000000b0038c9e1197f6so1222422wmm.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 00:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SIJ1lFudMiKPRPgtx9GaQG4dP6LxXEZqctYzO9j/NOg=;
 b=vzfDwmwcJxVvYc/HcB8hcDxd0DZQ49dO0T+ghwryQOlaouf4nZ3fwOe/GCpGp3jcgJ
 kLRT0hivc7BP5cOf+B/b1iOrJSHEYKsE80zvI/yUBT62dra14JI0nUgzbNvKZCH02VrU
 GgsYLnaTeMHDVv4cZ58Enr+XFztGSExFqx7F4zSnSX+IVgl/x2sOrfN6rI/tdv/8ngU4
 Um7WarHUMjvoURv2LnGSMbxIvdUcuj9BFBeThHZ0lCP6E255CwyqRdi1Fwue+Ko1fvF0
 2a0QT8x5j0ShuwBUndj7saWXnk/LkuwlajaJTtS5fhONLfRjLspOml6By4zf+lx4Bms9
 I3ug==
X-Gm-Message-State: AOAM531rneofrU7xor9iG3dd4pZkbde82W7ZiEB5nSR51Kzu+2csEdkj
 aQ5nixi9EFCjOssHP16qc6qBhCGOIZNsLVs04FmdVwRCc2Awlokv7mQETB1bAmKyw+IEDvd4lpd
 xNGVvTlc+UbxayWBH2siusji8817BrMnfPmnJNhVB5w==
X-Received: by 2002:a7b:cbc5:0:b0:38c:a756:a8c4 with SMTP id
 n5-20020a7bcbc5000000b0038ca756a8c4mr2584120wmi.83.1647847249100; 
 Mon, 21 Mar 2022 00:20:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMFI7roHJtjURXiWeuCi+lFKn4bmYP0BmmvCPxzn9UBqWfoqLkvs3gZIW+8PuD1gQkJBXSYQ==
X-Received: by 2002:a7b:cbc5:0:b0:38c:a756:a8c4 with SMTP id
 n5-20020a7bcbc5000000b0038ca756a8c4mr2584099wmi.83.1647847248803; 
 Mon, 21 Mar 2022 00:20:48 -0700 (PDT)
Received: from redhat.com ([2.55.132.0]) by smtp.gmail.com with ESMTPSA id
 az26-20020adfe19a000000b00204154a1d1fsm1467442wrb.88.2022.03.21.00.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Mar 2022 00:20:48 -0700 (PDT)
Date: Mon, 21 Mar 2022 03:20:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
Message-ID: <20220321032019-mutt-send-email-mst@kernel.org>
References: <20220321060429.10457-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220321060429.10457-1-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: elic@nvidia.com, linux-kernel@vger.kernel.org,
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

On Mon, Mar 21, 2022 at 02:04:28PM +0800, Jason Wang wrote:
> A userspace triggerable infinite loop could happen in
> mlx5_cvq_kick_handler() if userspace keeps sending a huge amount of
> cvq requests.
> 
> Fixing this by introducing a quota and re-queue the work if we're out
> of the budget. While at it, using a per device workqueue to avoid on
> demand memory allocation for cvq.
> 
> Fixes: 5262912ef3cfc ("vdpa/mlx5: Add support for control VQ and MAC setting")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index d0f91078600e..d5a6fb3f9c41 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -163,6 +163,7 @@ struct mlx5_vdpa_net {
>  	u32 cur_num_vqs;
>  	struct notifier_block nb;
>  	struct vdpa_callback config_cb;
> +	struct mlx5_vdpa_wq_ent cvq_ent;
>  };
>  
>  static void free_resources(struct mlx5_vdpa_net *ndev);
> @@ -1600,6 +1601,8 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct mlx5_vdpa_dev *mvdev, u8 cmd)
>  	return status;
>  }
>  
> +#define MLX5_CVQ_BUDGET 16
> +
>  static void mlx5_cvq_kick_handler(struct work_struct *work)
>  {
>  	virtio_net_ctrl_ack status = VIRTIO_NET_ERR;
> @@ -1609,17 +1612,17 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
>  	struct mlx5_control_vq *cvq;
>  	struct mlx5_vdpa_net *ndev;
>  	size_t read, write;
> -	int err;
> +	int err, n = 0;
>  
>  	wqent = container_of(work, struct mlx5_vdpa_wq_ent, work);
>  	mvdev = wqent->mvdev;
>  	ndev = to_mlx5_vdpa_ndev(mvdev);
>  	cvq = &mvdev->cvq;
>  	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> -		goto out;
> +		return;
>  
>  	if (!cvq->ready)
> -		goto out;
> +		return;
>  
>  	while (true) {
>  		err = vringh_getdesc_iotlb(&cvq->vring, &cvq->riov, &cvq->wiov, &cvq->head,
> @@ -1653,9 +1656,13 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
>  
>  		if (vringh_need_notify_iotlb(&cvq->vring))
>  			vringh_notify(&cvq->vring);
> +
> +		n++;
> +		if (n > MLX5_CVQ_BUDGET) {
> +			queue_work(mvdev->wq, &wqent->work);
> +			break;
> +		}
>  	}
> -out:
> -	kfree(wqent);
>  }
>  
>  static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
> @@ -1663,7 +1670,6 @@ static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
>  	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>  	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>  	struct mlx5_vdpa_virtqueue *mvq;
> -	struct mlx5_vdpa_wq_ent *wqent;
>  
>  	if (!is_index_valid(mvdev, idx))
>  		return;
> @@ -1672,13 +1678,7 @@ static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
>  		if (!mvdev->cvq.ready)
>  			return;
>  
> -		wqent = kzalloc(sizeof(*wqent), GFP_ATOMIC);
> -		if (!wqent)
> -			return;
> -
> -		wqent->mvdev = mvdev;
> -		INIT_WORK(&wqent->work, mlx5_cvq_kick_handler);
> -		queue_work(mvdev->wq, &wqent->work);
> +		queue_work(mvdev->wq, &ndev->cvq_ent.work);
>  		return;
>  	}
>  
> @@ -2668,6 +2668,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  	if (err)
>  		goto err_mr;
>  
> +	ndev->cvq_ent.mvdev = mvdev;
> +	INIT_WORK(&ndev->cvq_ent.work, mlx5_cvq_kick_handler);
>  	mvdev->wq = create_singlethread_workqueue("mlx5_vdpa_wq");
>  	if (!mvdev->wq) {
>  		err = -ENOMEM;

Shouldn't there be a flush during cleanup somewhere?

> -- 
> 2.18.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
