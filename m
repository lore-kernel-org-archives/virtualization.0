Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E42C433FE
	for <virtualization@archiver.kernel.org>; Tue, 29 Mar 2022 04:21:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C7D28824CE;
	Tue, 29 Mar 2022 04:21:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pzeTNVzj4QOu; Tue, 29 Mar 2022 04:21:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6359584113;
	Tue, 29 Mar 2022 04:21:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FDA3C002C;
	Tue, 29 Mar 2022 04:21:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9727DC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 04:21:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 842F360B58
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 04:21:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CZSiejSunA4e
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 04:21:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BD01060899
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 04:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648527685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/Fki2qhrqzIn3lkIi3YIPXgrFjahMDx8WQomnumvye4=;
 b=fW9wf1d692zHtWTg8BVcfbVzIVG1dBuVhZnUj3gumOK/ExQOKYImmLTLbhWxOps+jaRc3K
 LibVuZIpK5/StEHioulD0s0HnD4UEcMb88Sze1UoEitPYaMoXcAn5fH2dd71yPZckGhJE6
 Xcmx/64GTjY5TGkjYOuw8Cd8WGB56uo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-_GFlxY4ZMDycqaqXkHLD-w-1; Tue, 29 Mar 2022 00:21:16 -0400
X-MC-Unique: _GFlxY4ZMDycqaqXkHLD-w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 98654811E80;
 Tue, 29 Mar 2022 04:21:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-210.pek2.redhat.com
 [10.72.13.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68A94401DEA;
 Tue, 29 Mar 2022 04:21:12 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: jasowang@redhat.com,
	mst@redhat.com
Subject: [PATCH RESEND V2 1/3] vdpa: mlx5: prevent cvq work from hogging CPU
Date: Tue, 29 Mar 2022 12:21:07 +0800
Message-Id: <20220329042109.4029-1-jasowang@redhat.com>
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

A userspace triggerable infinite loop could happen in
mlx5_cvq_kick_handler() if userspace keeps sending a huge amount of
cvq requests.

Fixing this by introducing a quota and re-queue the work if we're out
of the budget (currently the implicit budget is one) . While at it,
using a per device work struct to avoid on demand memory allocation
for cvq.

Fixes: 5262912ef3cfc ("vdpa/mlx5: Add support for control VQ and MAC setting")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes since V1:
- Using 1 as the budget
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index d0f91078600e..b2afd2b6fbca 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -163,6 +163,7 @@ struct mlx5_vdpa_net {
 	u32 cur_num_vqs;
 	struct notifier_block nb;
 	struct vdpa_callback config_cb;
+	struct mlx5_vdpa_wq_ent cvq_ent;
 };
 
 static void free_resources(struct mlx5_vdpa_net *ndev);
@@ -1616,10 +1617,10 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
 	ndev = to_mlx5_vdpa_ndev(mvdev);
 	cvq = &mvdev->cvq;
 	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
-		goto out;
+		return;
 
 	if (!cvq->ready)
-		goto out;
+		return;
 
 	while (true) {
 		err = vringh_getdesc_iotlb(&cvq->vring, &cvq->riov, &cvq->wiov, &cvq->head,
@@ -1653,9 +1654,10 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
 
 		if (vringh_need_notify_iotlb(&cvq->vring))
 			vringh_notify(&cvq->vring);
+
+		queue_work(mvdev->wq, &wqent->work);
+		break;
 	}
-out:
-	kfree(wqent);
 }
 
 static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
@@ -1663,7 +1665,6 @@ static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	struct mlx5_vdpa_virtqueue *mvq;
-	struct mlx5_vdpa_wq_ent *wqent;
 
 	if (!is_index_valid(mvdev, idx))
 		return;
@@ -1672,13 +1673,7 @@ static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
 		if (!mvdev->cvq.ready)
 			return;
 
-		wqent = kzalloc(sizeof(*wqent), GFP_ATOMIC);
-		if (!wqent)
-			return;
-
-		wqent->mvdev = mvdev;
-		INIT_WORK(&wqent->work, mlx5_cvq_kick_handler);
-		queue_work(mvdev->wq, &wqent->work);
+		queue_work(mvdev->wq, &ndev->cvq_ent.work);
 		return;
 	}
 
@@ -2668,6 +2663,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	if (err)
 		goto err_mr;
 
+	ndev->cvq_ent.mvdev = mvdev;
+	INIT_WORK(&ndev->cvq_ent.work, mlx5_cvq_kick_handler);
 	mvdev->wq = create_singlethread_workqueue("mlx5_vdpa_wq");
 	if (!mvdev->wq) {
 		err = -ENOMEM;
-- 
2.18.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
