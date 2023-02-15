Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A37C61DA4
	for <virtualization@archiver.kernel.org>; Wed, 15 Feb 2023 01:31:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 822A581EA7;
	Wed, 15 Feb 2023 01:31:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 822A581EA7
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=sPlF2buO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id moUXDLRT-4Es; Wed, 15 Feb 2023 01:31:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0AF74813E9;
	Wed, 15 Feb 2023 01:31:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0AF74813E9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3BD1C0032;
	Wed, 15 Feb 2023 01:31:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E414C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 01:31:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1937D60E3A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 01:31:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1937D60E3A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=sPlF2buO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1TKfp3TA0KVV
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 01:31:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4A6AA60C23
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4A6AA60C23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 01:31:07 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 31EL3sSL016207; Wed, 15 Feb 2023 01:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=2YN4NPMiVZ/gada3XBxhbQ0i3hT/Rjk5A5hzVtCsjdg=;
 b=sPlF2buO8XvUausytVmYxSYbaBi81Zle5UZCvB00wHrbKLptZG/U6DMCynb5GRXdwuBj
 vBfBEyHqIRaiGmpy+ILUh1Kj9h62Tva5Odjlpboo0MRzlT8QPHbJfE1AsCRwoRRFkpxP
 7FMRCARGDPB1AmmwGt8zuwQZ3yTu47HyUDmVkMNpfRORYuqgkH4hEgkT8pB9b94flKIY
 AXtp4rqkQBjXPnczZVPbjH22+Nts/3PvXSP3C9AkOAvzx7ORgeQUJ1mRqFyZUKCWdzC3
 cBI4tcm5iHQJ/liSECrcubDkn+SheKU602oXJnvIAkiyX34CmGQDA2YRY5QdyIcjT1KA JQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1t3f0dk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Feb 2023 01:31:05 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 31F06NYd013576; Wed, 15 Feb 2023 01:31:05 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3np1f64m55-1; Wed, 15 Feb 2023 01:31:04 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: mst@redhat.com, jasowang@redhat.com, elic@nvidia.com
Subject: [PATCH v3] vdpa/mlx5: should not activate virtq object when suspended
Date: Tue, 14 Feb 2023 17:30:40 -0800
Message-Id: <1676424640-11673-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_17,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150012
X-Proofpoint-GUID: X8IRcncblieIcEQ_6it949XjhE64ri01
X-Proofpoint-ORIG-GUID: X8IRcncblieIcEQ_6it949XjhE64ri01
Cc: eperezma@redhat.com, linux-kernel@vger.kernel.org,
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

Fixes: cae15c2ed8e6 ("vdpa/mlx5: Implement susupend virtqueue callback")
Cc: Eli Cohen <elic@nvidia.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>

---
v3: move suspended to struct mlx5_vdpa_dev
v2: removed the change for improving warning message
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h | 1 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index 058fbe2..25fc412 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -96,6 +96,7 @@ struct mlx5_vdpa_dev {
 	struct mlx5_control_vq cvq;
 	struct workqueue_struct *wq;
 	unsigned int group2asid[MLX5_VDPA_NUMVQ_GROUPS];
+	bool suspended;
 };
 
 int mlx5_vdpa_alloc_pd(struct mlx5_vdpa_dev *dev, u32 *pdn, u16 uid);
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 3a6dbbc6..daac3ab 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2411,7 +2411,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 	if (err)
 		goto err_mr;
 
-	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
+	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) || mvdev->suspended)
 		goto err_mr;
 
 	restore_channels_info(ndev);
@@ -2579,6 +2579,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 	clear_vqs_ready(ndev);
 	mlx5_vdpa_destroy_mr(&ndev->mvdev);
 	ndev->mvdev.status = 0;
+	ndev->mvdev.suspended = false;
 	ndev->cur_num_vqs = 0;
 	ndev->mvdev.cvq.received_desc = 0;
 	ndev->mvdev.cvq.completed_desc = 0;
@@ -2815,6 +2816,8 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
 	struct mlx5_vdpa_virtqueue *mvq;
 	int i;
 
+	mlx5_vdpa_info(mvdev, "suspending device\n");
+
 	down_write(&ndev->reslock);
 	ndev->nb_registered = false;
 	mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
@@ -2824,6 +2827,7 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
 		suspend_vq(ndev, mvq);
 	}
 	mlx5_vdpa_cvq_suspend(mvdev);
+	mvdev->suspended = true;
 	up_write(&ndev->reslock);
 	return 0;
 }
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
