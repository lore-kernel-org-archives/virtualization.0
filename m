Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE836C61DA4
	for <virtualization@archiver.kernel.org>; Sat, 11 Feb 2023 06:08:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1775D41990;
	Sat, 11 Feb 2023 06:08:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1775D41990
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=T4Ovj5C5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o0zprz3zsZA2; Sat, 11 Feb 2023 06:08:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3EDEC417A9;
	Sat, 11 Feb 2023 06:08:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3EDEC417A9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A246C0032;
	Sat, 11 Feb 2023 06:08:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BE00C002B
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Feb 2023 06:08:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 53BD7417A9
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Feb 2023 06:08:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 53BD7417A9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iVaL4zdzwxnp
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Feb 2023 06:08:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED028408DE
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ED028408DE
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Feb 2023 06:08:42 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 31B5VWHk030701; Sat, 11 Feb 2023 06:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=MOiEKHQKDJR9QHAHdY++al+Ze5H+rKY6te5kRImaaP0=;
 b=T4Ovj5C56jgml/0MPqvz+yCZIXMVzWahzMhLB9OLtMmL/KHCmbIALlc9rYXmfFICtUpH
 h/AJ1m5dk6zOVz2F0VriuzFJhKnMyfQ17cJqEikSukMpVJ8QepXoGc2eOF5WEDUA2wXA
 X3DA+9xEgUbu0/Yh8iQhNNMxU5DQ0H4+OcnRdENRa/w6V6s0bcTMWWfk+WvB+933ItXt
 WATYMW86fpImmxVWWdEyKYUDErfFCRTJL99lW4E9uKauNyUvEsEg1a5E9IHQPGAm31fy
 rLpEiT9jBhhGJkU+06q3V8BiUg1CcrQCrB6bs6KyaoyMT3V6S1eebXEIVqG93IEnBY2W 2A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1t383qr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 11 Feb 2023 06:08:41 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 31B1XGmL018005; Sat, 11 Feb 2023 06:08:40 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3np1f2mgmw-1; Sat, 11 Feb 2023 06:08:40 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: mst@redhat.com, jasowang@redhat.com, elic@nvidia.com
Subject: [PATCH] vdpa/mlx5: should not activate virtq object when suspended
Date: Fri, 10 Feb 2023 22:08:14 -0800
Message-Id: <1676095694-15563-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-11_02,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302110055
X-Proofpoint-GUID: kH9EvAek0IomS8sLw0KS02YPYNNNmEjG
X-Proofpoint-ORIG-GUID: kH9EvAek0IomS8sLw0KS02YPYNNNmEjG
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Otherwise the virtqueue object to instate could point to invalid address
that was unmapped from the MTT:

  mlx5_core 0000:41:04.2: mlx5_cmd_out_err:782:(pid 8321):
  CREATE_GENERAL_OBJECT(0xa00) op_mod(0xd) failed, status
  bad parameter(0x3), syndrome (0x5fa1c), err(-22)

While at it, add warning message to tell apart which object is
responsible for the CREATE_GENERAL_OBJECT command failure.

Fixes: cae15c2ed8e6 ("vdpa/mlx5: Implement susupend virtqueue callback")
Cc: Eli Cohen <elic@nvidia.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 3a6dbbc6..c05c7f6 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -165,6 +165,7 @@ struct mlx5_vdpa_net {
 	u32 cur_num_vqs;
 	u32 rqt_size;
 	bool nb_registered;
+	bool suspended;
 	struct notifier_block nb;
 	struct vdpa_callback config_cb;
 	struct mlx5_vdpa_wq_ent cvq_ent;
@@ -1245,12 +1246,18 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
 		goto err_connect;
 
 	err = counter_set_alloc(ndev, mvq);
-	if (err)
+	if (err) {
+		mlx5_vdpa_warn(&ndev->mvdev, "failed to alloc counter on vq idx %d(%d)\n",
+			       idx, err);
 		goto err_counter;
+	}
 
 	err = create_virtqueue(ndev, mvq);
-	if (err)
+	if (err) {
+		mlx5_vdpa_warn(&ndev->mvdev, "failed to create virtqueue idx %d(%d)\n",
+			       idx, err);
 		goto err_connect;
+	}
 
 	if (mvq->ready) {
 		err = modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
@@ -2411,7 +2418,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 	if (err)
 		goto err_mr;
 
-	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
+	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) || ndev->suspended)
 		goto err_mr;
 
 	restore_channels_info(ndev);
@@ -2580,6 +2587,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 	mlx5_vdpa_destroy_mr(&ndev->mvdev);
 	ndev->mvdev.status = 0;
 	ndev->cur_num_vqs = 0;
+	ndev->suspended = false;
 	ndev->mvdev.cvq.received_desc = 0;
 	ndev->mvdev.cvq.completed_desc = 0;
 	memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
@@ -2815,6 +2823,8 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
 	struct mlx5_vdpa_virtqueue *mvq;
 	int i;
 
+	mlx5_vdpa_info(mvdev, "suspending device\n");
+
 	down_write(&ndev->reslock);
 	ndev->nb_registered = false;
 	mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
@@ -2824,6 +2834,7 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
 		suspend_vq(ndev, mvq);
 	}
 	mlx5_vdpa_cvq_suspend(mvdev);
+	ndev->suspended = true;
 	up_write(&ndev->reslock);
 	return 0;
 }
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
