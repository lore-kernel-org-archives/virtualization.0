Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD551C433EF
	for <virtualization@archiver.kernel.org>; Tue, 29 Mar 2022 04:21:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 73FDA84116;
	Tue, 29 Mar 2022 04:21:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qIVYWDF_X8m1; Tue, 29 Mar 2022 04:21:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F071483ED4;
	Tue, 29 Mar 2022 04:21:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1FBEC002C;
	Tue, 29 Mar 2022 04:21:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44C09C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 04:21:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 24F4583ED4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 04:21:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jh6Vy7yzNQ6x
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 04:21:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B0AC824CE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 04:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648527683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NBrZonGtyPiYVHPrtXOiyOTwxwGC7d31Hs1pwiySqI4=;
 b=VlE58q2B0Tr3N9lOTyXWH2u0np2Ph6LKJ3EZRPffBS6bwYYWS1ZLmsLM8IurOCAM22wsVh
 qJ20d/HUvaH/Jwu1w+XOZbcuwWF60aujqPY2KXV5+vSfvPt7n495UHtfxJSg641HkTE2OJ
 wyeW2AQjGR2+QRPIgy7lBIZWdxofmTY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-rqTZFqzIPTWYwI3hFxTFfA-1; Tue, 29 Mar 2022 00:21:19 -0400
X-MC-Unique: rqTZFqzIPTWYwI3hFxTFfA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24AE38117B0;
 Tue, 29 Mar 2022 04:21:19 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-210.pek2.redhat.com
 [10.72.13.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5324C401DEA;
 Tue, 29 Mar 2022 04:21:15 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: jasowang@redhat.com,
	mst@redhat.com
Subject: [PATCH RESEND V2 2/3] vdpa: mlx5: synchronize driver status with CVQ
Date: Tue, 29 Mar 2022 12:21:08 +0800
Message-Id: <20220329042109.4029-2-jasowang@redhat.com>
In-Reply-To: <20220329042109.4029-1-jasowang@redhat.com>
References: <20220329042109.4029-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
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

Currently, CVQ doesn't have any synchronization with the driver
status. Then CVQ emulation code run in the middle of:

1) device reset
2) device status changed
3) map updating

The will lead several unexpected issue like trying to execute CVQ
command after the driver has been teared down.

Fixing this by using reslock to synchronize CVQ emulation code with
the driver status changing:

- protect the whole device reset, status changing and set_map()
  updating with reslock
- protect the CVQ handler with the reslock and check
  VIRTIO_CONFIG_S_DRIVER_OK in the CVQ handler

This will guarantee that:

1) CVQ handler won't work if VIRTIO_CONFIG_S_DRIVER_OK is not set
2) CVQ handler will see a consistent state of the driver instead of
   the partial one when it is running in the middle of the
   teardown_driver() or setup_driver().

Cc: 5262912ef3cfc ("vdpa/mlx5: Add support for control VQ and MAC setting")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes since V1:
- document the lock requirement
- protect the whole .set_map()
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 51 ++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index b2afd2b6fbca..53b8c1a68f90 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1616,11 +1616,17 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
 	mvdev = wqent->mvdev;
 	ndev = to_mlx5_vdpa_ndev(mvdev);
 	cvq = &mvdev->cvq;
+
+	mutex_lock(&ndev->reslock);
+
+	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
+		goto out;
+
 	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
-		return;
+		goto out;
 
 	if (!cvq->ready)
-		return;
+		goto out;
 
 	while (true) {
 		err = vringh_getdesc_iotlb(&cvq->vring, &cvq->riov, &cvq->wiov, &cvq->head,
@@ -1658,6 +1664,9 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
 		queue_work(mvdev->wq, &wqent->work);
 		break;
 	}
+
+out:
+	mutex_unlock(&ndev->reslock);
 }
 
 static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
@@ -2132,7 +2141,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
 		goto err_mr;
 
 	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
-		return 0;
+		goto err_mr;
 
 	restore_channels_info(ndev);
 	err = setup_driver(mvdev);
@@ -2147,12 +2156,14 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
 	return err;
 }
 
+/* reslock must be held for this function */
 static int setup_driver(struct mlx5_vdpa_dev *mvdev)
 {
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	int err;
 
-	mutex_lock(&ndev->reslock);
+	WARN_ON(!mutex_is_locked(&ndev->reslock));
+
 	if (ndev->setup) {
 		mlx5_vdpa_warn(mvdev, "setup driver called for already setup driver\n");
 		err = 0;
@@ -2182,7 +2193,6 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
 		goto err_fwd;
 	}
 	ndev->setup = true;
-	mutex_unlock(&ndev->reslock);
 
 	return 0;
 
@@ -2193,23 +2203,23 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
 err_rqt:
 	teardown_virtqueues(ndev);
 out:
-	mutex_unlock(&ndev->reslock);
 	return err;
 }
 
+/* reslock must be held for this function */
 static void teardown_driver(struct mlx5_vdpa_net *ndev)
 {
-	mutex_lock(&ndev->reslock);
+
+	WARN_ON(!mutex_is_locked(&ndev->reslock));
+
 	if (!ndev->setup)
-		goto out;
+		return;
 
 	remove_fwd_to_tir(ndev);
 	destroy_tir(ndev);
 	destroy_rqt(ndev);
 	teardown_virtqueues(ndev);
 	ndev->setup = false;
-out:
-	mutex_unlock(&ndev->reslock);
 }
 
 static void clear_vqs_ready(struct mlx5_vdpa_net *ndev)
@@ -2230,6 +2240,8 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 
 	print_status(mvdev, status, true);
 
+	mutex_lock(&ndev->reslock);
+
 	if ((status ^ ndev->mvdev.status) & VIRTIO_CONFIG_S_DRIVER_OK) {
 		if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
 			err = setup_driver(mvdev);
@@ -2239,16 +2251,19 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 			}
 		} else {
 			mlx5_vdpa_warn(mvdev, "did not expect DRIVER_OK to be cleared\n");
-			return;
+			goto err_clear;
 		}
 	}
 
 	ndev->mvdev.status = status;
+	mutex_unlock(&ndev->reslock);
 	return;
 
 err_setup:
 	mlx5_vdpa_destroy_mr(&ndev->mvdev);
 	ndev->mvdev.status |= VIRTIO_CONFIG_S_FAILED;
+err_clear:
+	mutex_unlock(&ndev->reslock);
 }
 
 static int mlx5_vdpa_reset(struct vdpa_device *vdev)
@@ -2258,6 +2273,8 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 
 	print_status(mvdev, 0, true);
 	mlx5_vdpa_info(mvdev, "performing device reset\n");
+
+	mutex_lock(&ndev->reslock);
 	teardown_driver(ndev);
 	clear_vqs_ready(ndev);
 	mlx5_vdpa_destroy_mr(&ndev->mvdev);
@@ -2270,6 +2287,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 		if (mlx5_vdpa_create_mr(mvdev, NULL))
 			mlx5_vdpa_warn(mvdev, "create MR failed\n");
 	}
+	mutex_unlock(&ndev->reslock);
 
 	return 0;
 }
@@ -2305,19 +2323,24 @@ static u32 mlx5_vdpa_get_generation(struct vdpa_device *vdev)
 static int mlx5_vdpa_set_map(struct vdpa_device *vdev, struct vhost_iotlb *iotlb)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
+	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	bool change_map;
 	int err;
 
+	mutex_lock(&ndev->reslock);
+
 	err = mlx5_vdpa_handle_set_map(mvdev, iotlb, &change_map);
 	if (err) {
 		mlx5_vdpa_warn(mvdev, "set map failed(%d)\n", err);
-		return err;
+		goto err;
 	}
 
 	if (change_map)
-		return mlx5_vdpa_change_map(mvdev, iotlb);
+		err = mlx5_vdpa_change_map(mvdev, iotlb);
 
-	return 0;
+err:
+	mutex_unlock(&ndev->reslock);
+	return err;
 }
 
 static void mlx5_vdpa_free(struct vdpa_device *vdev)
-- 
2.18.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
