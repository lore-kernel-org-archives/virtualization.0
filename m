Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AEFC4332F
	for <virtualization@archiver.kernel.org>; Mon, 21 Mar 2022 06:04:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08733409C3;
	Mon, 21 Mar 2022 06:04:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qRKfTbiWUuzh; Mon, 21 Mar 2022 06:04:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6D38C409C1;
	Mon, 21 Mar 2022 06:04:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F45CC001A;
	Mon, 21 Mar 2022 06:04:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BBC1C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 06:04:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2B55A409BE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 06:04:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bPzmPHI9If6E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 06:04:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 61D80409B2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 06:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647842685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3QGzl2Y6fwZNaUGV3ooqk8roHKG0eglLUaLpVPAugo4=;
 b=UkdaM0GV1hoMAYPEF2GcEq+RjqInT84dClEVJTh/Gk9nM0BxG1DyVVStiBvKsm7xDlMOoA
 kynq8fYMGj2cSb3C4remS3WeAYggicF0rwYJsGyTGHYmHfJmdSe6hSTgUX+g1z1vL5D2NR
 /hz+kk79V9bpTbnHk8+HrZb+tfdsp9k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-318-eU5-CX3_OkCXm5O0y3jazQ-1; Mon, 21 Mar 2022 02:04:41 -0400
X-MC-Unique: eU5-CX3_OkCXm5O0y3jazQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5D953811A21;
 Mon, 21 Mar 2022 06:04:40 +0000 (UTC)
Received: from localhost.localdomain (ovpn-14-31.pek2.redhat.com [10.72.14.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9DF462166B2D;
 Mon, 21 Mar 2022 06:04:38 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 2/2] vdpa: mlx5: synchronize driver status with CVQ
Date: Mon, 21 Mar 2022 14:04:29 +0800
Message-Id: <20220321060429.10457-2-jasowang@redhat.com>
In-Reply-To: <20220321060429.10457-1-jasowang@redhat.com>
References: <20220321060429.10457-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
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

Currently, CVQ doesn't have any synchronization with the driver
status. Then CVQ emulation code run in the middle of:

1) device reset
2) device status changed
3) map updating

The will lead several unexpected issue like trying to execute CVQ
command after the driver has been teared down.

Fixing this by using reslock to synchronize CVQ emulation code with
the driver status changing:

- protect the whole device reset, status changing and map updating
  with reslock
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
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 42 +++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index d5a6fb3f9c41..524240f55c1c 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1618,11 +1618,17 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
 	mvdev = wqent->mvdev;
 	ndev = to_mlx5_vdpa_ndev(mvdev);
 	cvq = &mvdev->cvq;
+
+	mutex_lock(&ndev->reslock);
+
+	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
+		goto done;
+
 	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
-		return;
+		goto done;
 
 	if (!cvq->ready)
-		return;
+		goto done;
 
 	while (true) {
 		err = vringh_getdesc_iotlb(&cvq->vring, &cvq->riov, &cvq->wiov, &cvq->head,
@@ -1663,6 +1669,9 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
 			break;
 		}
 	}
+
+done:
+	mutex_unlock(&ndev->reslock);
 }
 
 static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
@@ -2125,6 +2134,8 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	int err;
 
+	mutex_lock(&ndev->reslock);
+
 	suspend_vqs(ndev);
 	err = save_channels_info(ndev);
 	if (err)
@@ -2137,18 +2148,20 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
 		goto err_mr;
 
 	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
-		return 0;
+		goto err_mr;
 
 	restore_channels_info(ndev);
 	err = setup_driver(mvdev);
 	if (err)
 		goto err_setup;
 
+	mutex_unlock(&ndev->reslock);
 	return 0;
 
 err_setup:
 	mlx5_vdpa_destroy_mr(mvdev);
 err_mr:
+	mutex_unlock(&ndev->reslock);
 	return err;
 }
 
@@ -2157,7 +2170,8 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	int err;
 
-	mutex_lock(&ndev->reslock);
+	WARN_ON(!mutex_is_locked(&ndev->reslock));
+
 	if (ndev->setup) {
 		mlx5_vdpa_warn(mvdev, "setup driver called for already setup driver\n");
 		err = 0;
@@ -2187,7 +2201,6 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
 		goto err_fwd;
 	}
 	ndev->setup = true;
-	mutex_unlock(&ndev->reslock);
 
 	return 0;
 
@@ -2198,23 +2211,22 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
 err_rqt:
 	teardown_virtqueues(ndev);
 out:
-	mutex_unlock(&ndev->reslock);
 	return err;
 }
 
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
@@ -2235,6 +2247,8 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 
 	print_status(mvdev, status, true);
 
+	mutex_lock(&ndev->reslock);
+
 	if ((status ^ ndev->mvdev.status) & VIRTIO_CONFIG_S_DRIVER_OK) {
 		if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
 			err = setup_driver(mvdev);
@@ -2244,16 +2258,19 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
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
@@ -2263,6 +2280,8 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 
 	print_status(mvdev, 0, true);
 	mlx5_vdpa_info(mvdev, "performing device reset\n");
+
+	mutex_lock(&ndev->reslock);
 	teardown_driver(ndev);
 	clear_vqs_ready(ndev);
 	mlx5_vdpa_destroy_mr(&ndev->mvdev);
@@ -2275,6 +2294,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 		if (mlx5_vdpa_create_mr(mvdev, NULL))
 			mlx5_vdpa_warn(mvdev, "create MR failed\n");
 	}
+	mutex_unlock(&ndev->reslock);
 
 	return 0;
 }
-- 
2.18.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
