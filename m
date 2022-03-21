Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA501C433F5
	for <virtualization@archiver.kernel.org>; Mon, 21 Mar 2022 08:59:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1CD1E400E4;
	Mon, 21 Mar 2022 08:59:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m7LjE18SSTXz; Mon, 21 Mar 2022 08:58:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4B2F340138;
	Mon, 21 Mar 2022 08:58:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16DA3C0012;
	Mon, 21 Mar 2022 08:58:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3DE8C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 08:58:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C2A1E81308
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 08:58:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P4rDsDUxXzXU
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 08:58:54 +0000 (UTC)
X-Greylist: delayed 00:05:24 by SQLgrey-1.8.0
Received: from mail3-162.sinamail.sina.com.cn (mail3-162.sinamail.sina.com.cn
 [202.108.3.162])
 by smtp1.osuosl.org (Postfix) with SMTP id E48A9812DC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 08:58:53 +0000 (UTC)
Received: from unknown (HELO localhost.localdomain)([114.249.57.134])
 by sina.com (172.16.97.27) with ESMTP
 id 62383D0500019AD3; Mon, 21 Mar 2022 16:53:27 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
X-SMAIL-MID: 2727049283290
From: Hillf Danton <hdanton@sina.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
Date: Mon, 21 Mar 2022 16:53:17 +0800
Message-Id: <20220321085317.3148-1-hdanton@sina.com>
In-Reply-To: <20220321060429.10457-1-jasowang@redhat.com>
References: 
MIME-Version: 1.0
Cc: elic@nvidia.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com
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

On Mon, 21 Mar 2022 14:04:28 +0800 Jason Wang wrote:
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

This is not needed as given a single thread workqueue, a cond_resched()
can do the job in the worker context instead of requeue of work.

Hillf

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
> -- 
> 2.18.1
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
