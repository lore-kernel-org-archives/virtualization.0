Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB020C433E0
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 21:49:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E63E64DE1
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 21:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E63E64DE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 376E66F5BA
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 21:49:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FWBHTk42f4N1 for <virtualization@archiver.kernel.org>;
	Wed, 10 Feb 2021 21:49:57 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id A7D426F586; Wed, 10 Feb 2021 21:49:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC9E26F54B;
	Wed, 10 Feb 2021 21:49:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 785F0C1DA9;
	Wed, 10 Feb 2021 21:49:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B3E6C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 21:49:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EE2856F516
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 21:49:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jX2ux8CuB9_D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 21:49:50 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id B3E7D6F52E; Wed, 10 Feb 2021 21:49:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 394C66F516
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 21:49:49 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11ALhnDX097103;
 Wed, 10 Feb 2021 21:49:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=83WqnSnikDCkcTpxqBjjWCmEupWNL0G22UOpLZMlrRI=;
 b=X0leY4Eg+izsFYsdVwLJOWNl2hCPK/O3i7IqjTcOY7IS72D2FSYMsTn2YsOZr2JpONL4
 dCfbi0xJNEGV4ttXbdcoDBoUfCZrZCqxoc5wSbjPQW45jNeQF2aytw75kwqauPToo7T5
 EOG2IcbodOyQB8j8lr/eZfEhI+RvBSxBkk9mBzopJnjPSlgNXLzCfFccGb2MkKJWClKO
 MhijraipMG2TNip+fIqRGx9aLFst5TTh0ZmHnv1g8R39QBdV0nMiGqcsPNmN5la3sQVq
 elW2hmYQDrM7kFNhTcs9VUePHVyW2U4+8fv7wJYw1Qs7++d5maaUqbyd3SQelncdGzXh ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 36hkrn56bm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Feb 2021 21:49:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11ALij9Z159426;
 Wed, 10 Feb 2021 21:49:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 36j4vtcj18-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Feb 2021 21:49:46 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11ALnjvp002822;
 Wed, 10 Feb 2021 21:49:45 GMT
Received: from ban25x6uut24.us.oracle.com (/10.153.73.24) by default (Oracle
 Beehive Gateway v4.0) with ESMTP ; Wed, 10 Feb 2021 13:48:43 -0800
MIME-Version: 1.0
Message-ID: <1612993680-29454-3-git-send-email-si-wei.liu@oracle.com>
Date: Wed, 10 Feb 2021 13:47:59 -0800 (PST)
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: mst@redhat.com, jasowang@redhat.com, elic@nvidia.com
Subject: [PATCH v2 2/3] vdpa/mlx5: fix feature negotiation across device reset
References: <1612993680-29454-1-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1612993680-29454-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100189
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100189
Cc: si-wei.liu@oracle.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

The mlx_features denotes the capability for which
set of virtio features is supported by device. In
principle, this field needs not be cleared during
virtio device reset, as this capability is static
and does not change across reset.

In fact, the current code may have the assumption
that mlx_features can be reloaded from firmware
via the .get_features ops after device is reset
(via the .set_status ops), which is unfortunately
not true. The userspace VMM might save a copy
of backend capable features and won't call into
kernel again to get it on reset. This causes all
virtio features getting disabled on newly created
virtqs after device reset, while guest would hold
mismatched view of available features. For e.g.,
the guest may still assume tx checksum offload
is available after reset and feature negotiation,
causing frames with bogus (incomplete) checksum
transmitted on the wire.

Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index b8416c4..7c1f789 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1486,16 +1486,8 @@ static u64 mlx_to_vritio_features(u16 dev_features)
 static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
-	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
-	u16 dev_features;
 
-	dev_features = MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, device_features_bits_mask);
-	ndev->mvdev.mlx_features = mlx_to_vritio_features(dev_features);
-	if (MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, virtio_version_1_0))
-		ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_F_VERSION_1);
-	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_F_ACCESS_PLATFORM);
-	print_features(mvdev, ndev->mvdev.mlx_features, false);
-	return ndev->mvdev.mlx_features;
+	return mvdev->mlx_features;
 }
 
 static int verify_min_features(struct mlx5_vdpa_dev *mvdev, u64 features)
@@ -1788,7 +1780,6 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 		clear_virtqueues(ndev);
 		mlx5_vdpa_destroy_mr(&ndev->mvdev);
 		ndev->mvdev.status = 0;
-		ndev->mvdev.mlx_features = 0;
 		++mvdev->generation;
 		return;
 	}
@@ -1907,6 +1898,19 @@ static int mlx5_get_vq_irq(struct vdpa_device *vdv, u16 idx)
 	.free = mlx5_vdpa_free,
 };
 
+static void query_virtio_features(struct mlx5_vdpa_net *ndev)
+{
+	struct mlx5_vdpa_dev *mvdev = &ndev->mvdev;
+	u16 dev_features;
+
+	dev_features = MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, device_features_bits_mask);
+	mvdev->mlx_features = mlx_to_vritio_features(dev_features);
+	if (MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, virtio_version_1_0))
+		mvdev->mlx_features |= BIT_ULL(VIRTIO_F_VERSION_1);
+	mvdev->mlx_features |= BIT_ULL(VIRTIO_F_ACCESS_PLATFORM);
+	print_features(mvdev, mvdev->mlx_features, false);
+}
+
 static int query_mtu(struct mlx5_core_dev *mdev, u16 *mtu)
 {
 	u16 hw_mtu;
@@ -2005,6 +2009,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
 	init_mvqs(ndev);
 	mutex_init(&ndev->reslock);
 	config = &ndev->config;
+	query_virtio_features(ndev);
 	err = query_mtu(mdev, &ndev->mtu);
 	if (err)
 		goto err_mtu;
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
