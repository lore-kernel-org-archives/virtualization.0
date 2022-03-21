Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06448C433F5
	for <virtualization@archiver.kernel.org>; Mon, 21 Mar 2022 07:24:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9400C400E4;
	Mon, 21 Mar 2022 07:24:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O5JMxxng9Plv; Mon, 21 Mar 2022 07:24:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BF0BA40133;
	Mon, 21 Mar 2022 07:24:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91F1AC001A;
	Mon, 21 Mar 2022 07:24:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28E39C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 07:24:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1124D409FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 07:24:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0lpGk7CChjDc
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 07:24:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2BAEA409F6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 07:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647847443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gm1sVEe7dfvUdSkynXTsnwrA/DTKgGNcg7xjF4IEAm0=;
 b=dAbapOMnMWYJqE5mDQUWeoF81heTUhlWGV+6bxYw76SpLeVnYDtEDiIEbBfF/DQFNtR58O
 pYXRKrwo6jcjvySRcSqtfOkBtWsS5aXcEQ0k1AZKN0Kt90nGvjuov0OkyROiS4uNk2IKC1
 8X0Yc+UvDkUUC/mulYaNN95xV0nFFyw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-IRax1ycdM2yK_ctVrUBvpA-1; Mon, 21 Mar 2022 03:24:01 -0400
X-MC-Unique: IRax1ycdM2yK_ctVrUBvpA-1
Received: by mail-wm1-f72.google.com with SMTP id
 r9-20020a1c4409000000b0038c15a1ed8cso7886498wma.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 00:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gm1sVEe7dfvUdSkynXTsnwrA/DTKgGNcg7xjF4IEAm0=;
 b=SX89y7YZF5vmhWy8qAUMDMxq9mqBG+51xk4Y5yo45Icr6I3bhqmyqTHp01WVAqrNMG
 k6KKFLUhCPQWgxXoviOLBDTtn/91Z3A0Yd44KukUoYxmhMdeP90t7ZfWe3MbfsMGFgeS
 MsA+0vbGQZlQnWOPly56j2ne2tAj2EdlkKQpgko0IjJtqLXtjE7dariZjqdzsL5kRUR8
 yJgyup/nkfoGwc0rZb6+vELCUEIPR/BbTq5yS+/0zvrs1SgmhDgoGBFmEPFapavQs4HS
 iOODb1KCmkEIQstQDeLpaEXxQ4gLdQ5MmlJJO/6o3GYSzOcaeBlfyjeFCvoUpMbD86Xw
 ndWA==
X-Gm-Message-State: AOAM533XJmIWmJpsam+oUhisQwLMS6/VKL/QRg4Jf5GEMxuVjGRodne/
 kK6htW7ElfDoZRzn0ussU5GMsA5wZeP8fAE0I10302wjzAXVwI79VDDTnp8FtXdYAGl4+/Fh9Rt
 aI1pobt/m5UMOurHoDtMMTMC/Bi8xTG03tk9at0kzDg==
X-Received: by 2002:a5d:64ce:0:b0:204:1175:690c with SMTP id
 f14-20020a5d64ce000000b002041175690cmr2961296wri.602.1647847440338; 
 Mon, 21 Mar 2022 00:24:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwl3os8XroyBJYveWuikCF+kPUTeHbT5+F3Baho+OM7HQh1WENiU61jeHtVPPieVClAnGIOWg==
X-Received: by 2002:a5d:64ce:0:b0:204:1175:690c with SMTP id
 f14-20020a5d64ce000000b002041175690cmr2961288wri.602.1647847440056; 
 Mon, 21 Mar 2022 00:24:00 -0700 (PDT)
Received: from redhat.com ([2.55.132.0]) by smtp.gmail.com with ESMTPSA id
 w5-20020a5d5445000000b00203f8c96bcesm7223459wrv.49.2022.03.21.00.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Mar 2022 00:23:59 -0700 (PDT)
Date: Mon, 21 Mar 2022 03:23:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/2] vdpa: mlx5: synchronize driver status with CVQ
Message-ID: <20220321032130-mutt-send-email-mst@kernel.org>
References: <20220321060429.10457-1-jasowang@redhat.com>
 <20220321060429.10457-2-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220321060429.10457-2-jasowang@redhat.com>
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

On Mon, Mar 21, 2022 at 02:04:29PM +0800, Jason Wang wrote:
> Currently, CVQ doesn't have any synchronization with the driver
> status. Then CVQ emulation code run in the middle of:
> 
> 1) device reset
> 2) device status changed
> 3) map updating
> 
> The will lead several unexpected issue like trying to execute CVQ
> command after the driver has been teared down.
> 
> Fixing this by using reslock to synchronize CVQ emulation code with
> the driver status changing:
> 
> - protect the whole device reset, status changing and map updating
>   with reslock
> - protect the CVQ handler with the reslock and check
>   VIRTIO_CONFIG_S_DRIVER_OK in the CVQ handler
> 
> This will guarantee that:
> 
> 1) CVQ handler won't work if VIRTIO_CONFIG_S_DRIVER_OK is not set
> 2) CVQ handler will see a consistent state of the driver instead of
>    the partial one when it is running in the middle of the
>    teardown_driver() or setup_driver().
> 
> Cc: 5262912ef3cfc ("vdpa/mlx5: Add support for control VQ and MAC setting")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 42 +++++++++++++++++++++++--------
>  1 file changed, 31 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index d5a6fb3f9c41..524240f55c1c 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1618,11 +1618,17 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
>  	mvdev = wqent->mvdev;
>  	ndev = to_mlx5_vdpa_ndev(mvdev);
>  	cvq = &mvdev->cvq;
> +
> +	mutex_lock(&ndev->reslock);
> +
> +	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> +		goto done;
> +
>  	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> -		return;
> +		goto done;
>  
>  	if (!cvq->ready)
> -		return;
> +		goto done;
>  
>  	while (true) {
>  		err = vringh_getdesc_iotlb(&cvq->vring, &cvq->riov, &cvq->wiov, &cvq->head,
> @@ -1663,6 +1669,9 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
>  			break;
>  		}
>  	}
> +
> +done:
> +	mutex_unlock(&ndev->reslock);
>  }
>  
>  static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
> @@ -2125,6 +2134,8 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
>  	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>  	int err;
>  
> +	mutex_lock(&ndev->reslock);
> +
>  	suspend_vqs(ndev);
>  	err = save_channels_info(ndev);
>  	if (err)
> @@ -2137,18 +2148,20 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
>  		goto err_mr;
>  
>  	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> -		return 0;
> +		goto err_mr;
>  
>  	restore_channels_info(ndev);
>  	err = setup_driver(mvdev);
>  	if (err)
>  		goto err_setup;
>  
> +	mutex_unlock(&ndev->reslock);
>  	return 0;
>  
>  err_setup:
>  	mlx5_vdpa_destroy_mr(mvdev);
>  err_mr:
> +	mutex_unlock(&ndev->reslock);
>  	return err;
>  }
>  
> @@ -2157,7 +2170,8 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
>  	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>  	int err;
>  
> -	mutex_lock(&ndev->reslock);
> +	WARN_ON(!mutex_is_locked(&ndev->reslock));
> +
>  	if (ndev->setup) {
>  		mlx5_vdpa_warn(mvdev, "setup driver called for already setup driver\n");
>  		err = 0;


Maybe also add a comment near function header explaining this must be
called with lock held.

> @@ -2187,7 +2201,6 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
>  		goto err_fwd;
>  	}
>  	ndev->setup = true;
> -	mutex_unlock(&ndev->reslock);
>  
>  	return 0;
>  
> @@ -2198,23 +2211,22 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
>  err_rqt:
>  	teardown_virtqueues(ndev);
>  out:
> -	mutex_unlock(&ndev->reslock);
>  	return err;
>  }
>  
>  static void teardown_driver(struct mlx5_vdpa_net *ndev)
>  {
> -	mutex_lock(&ndev->reslock);
> +
> +	WARN_ON(!mutex_is_locked(&ndev->reslock));
> +
>  	if (!ndev->setup)
> -		goto out;
> +		return;
>  
>  	remove_fwd_to_tir(ndev);
>  	destroy_tir(ndev);
>  	destroy_rqt(ndev);
>  	teardown_virtqueues(ndev);
>  	ndev->setup = false;
> -out:
> -	mutex_unlock(&ndev->reslock);
>  }
>  
>  static void clear_vqs_ready(struct mlx5_vdpa_net *ndev)
> @@ -2235,6 +2247,8 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
>  
>  	print_status(mvdev, status, true);
>  
> +	mutex_lock(&ndev->reslock);
> +
>  	if ((status ^ ndev->mvdev.status) & VIRTIO_CONFIG_S_DRIVER_OK) {
>  		if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
>  			err = setup_driver(mvdev);
> @@ -2244,16 +2258,19 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
>  			}
>  		} else {
>  			mlx5_vdpa_warn(mvdev, "did not expect DRIVER_OK to be cleared\n");
> -			return;
> +			goto err_clear;
>  		}
>  	}
>  
>  	ndev->mvdev.status = status;
> +	mutex_unlock(&ndev->reslock);
>  	return;
>  
>  err_setup:
>  	mlx5_vdpa_destroy_mr(&ndev->mvdev);
>  	ndev->mvdev.status |= VIRTIO_CONFIG_S_FAILED;
> +err_clear:
> +	mutex_unlock(&ndev->reslock);
>  }
>  
>  static int mlx5_vdpa_reset(struct vdpa_device *vdev)
> @@ -2263,6 +2280,8 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>  
>  	print_status(mvdev, 0, true);
>  	mlx5_vdpa_info(mvdev, "performing device reset\n");
> +
> +	mutex_lock(&ndev->reslock);
>  	teardown_driver(ndev);
>  	clear_vqs_ready(ndev);
>  	mlx5_vdpa_destroy_mr(&ndev->mvdev);
> @@ -2275,6 +2294,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>  		if (mlx5_vdpa_create_mr(mvdev, NULL))
>  			mlx5_vdpa_warn(mvdev, "create MR failed\n");
>  	}
> +	mutex_unlock(&ndev->reslock);
>  
>  	return 0;
>  }
> -- 
> 2.18.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
