Return-Path: <SRS0=+DIW=J2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683ACC433B4
	for <virtualization@archiver.kernel.org>; Thu, 29 Apr 2021 01:50:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 063D161451
	for <virtualization@archiver.kernel.org>; Thu, 29 Apr 2021 01:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 063D161451
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A41D38465F;
	Thu, 29 Apr 2021 01:50:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z0xYlJrnAJOi; Thu, 29 Apr 2021 01:50:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45FAA8465D;
	Thu, 29 Apr 2021 01:50:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 225E4C000F;
	Thu, 29 Apr 2021 01:50:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D7BAC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 01:50:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DC94D4011F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 01:50:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZK2FcWNjt8Bb
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 01:50:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BE6A940111
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 01:50:30 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13T1o3Y6048008;
 Thu, 29 Apr 2021 01:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=7527Ky9YLhXmwVbJhatdnIN6ck4lz56JZBmCdtNblZE=;
 b=h1/f51B4WofEloeAbwqIWhpnc8u7TkGfXcDKDpXHJYPPlFVPodzrpqe8wqFZRmgk+EAi
 7JSy+mx5Uf45T+uNamvx2UhpjzIq2RQ86DOtEo+MB62sMKnWu1o8CZ0P/nllcwr3ZQ1k
 Rc38ssrtAlz1xmeAkWcFQntAipkufxmQ/h10Pv2pcJcGLMG4o1kUEwdwTmVc+fvW65Qx
 +vD/uTvBU8CokBLZqrzKw6vSSse+KweVFEvgxWfChlQPFhrMJOxy74s1T1/zuRTlN3E9
 jfP+hnvoTIn65A1esDucEbAAelYa5ZQ2RijrTrOwNi0NNvPvzFCLoCWmKvusmGfHWMKn tA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 385aft2rh0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Apr 2021 01:50:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13T1nq8t012550;
 Thu, 29 Apr 2021 01:50:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by aserp3020.oracle.com with ESMTP id 384b59gcde-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Apr 2021 01:50:28 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13T1oRcD014363;
 Thu, 29 Apr 2021 01:50:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 384b59gcd6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Apr 2021 01:50:27 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13T1oRME001590;
 Thu, 29 Apr 2021 01:50:27 GMT
Received: from ban25x6uut24.us.oracle.com (/10.153.73.24)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 28 Apr 2021 18:50:27 -0700
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: mst@redhat.com, jasowang@redhat.com, elic@nvidia.com
Subject: [PATCH v3 1/1] vdpa/mlx5: fix feature negotiation across device reset
Date: Wed, 28 Apr 2021 21:48:54 -0400
Message-Id: <1619660934-30910-2-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1619660934-30910-1-git-send-email-si-wei.liu@oracle.com>
References: <1619660934-30910-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-GUID: oh378PwpZ4wZKgXEqgz_qEwXApDWQqJY
X-Proofpoint-ORIG-GUID: oh378PwpZ4wZKgXEqgz_qEwXApDWQqJY
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1011 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104290011
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The mlx_features denotes the capability for which
set of virtio features is supported by device. In
principle, this field needs not be cleared during
virtio device reset, as this capability is static
and does not change across reset.

In fact, the current code seems to wrongly assume
that mlx_features can be reloaded or updated on
device reset thru the .get_features op. However,
the userspace VMM may save a copy of previously
advertised backend feature capability and won't
need to get it again on reset. In that event, all
virtio features reset to zero thus getting disabled
upon device reset. This ends up with guest holding
a mismatched view of available features with the
VMM/host's. For instance, the guest may assume
the presence of tx checksum offload feature across
reboot, however, since the feature is left disabled
on reset, frames with bogus partial checksum are
transmitted on the wire.

The fix is to retain the features capability on
reset, and get it only once from firmware on the
vdpa_dev_add path.

Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Eli Cohen <elic@nvidia.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 25533db..624f521 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1492,16 +1492,8 @@ static u64 mlx_to_vritio_features(u16 dev_features)
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
@@ -1783,7 +1775,6 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 		teardown_driver(ndev);
 		mlx5_vdpa_destroy_mr(&ndev->mvdev);
 		ndev->mvdev.status = 0;
-		ndev->mvdev.mlx_features = 0;
 		++mvdev->generation;
 		return;
 	}
@@ -1902,6 +1893,19 @@ static int mlx5_get_vq_irq(struct vdpa_device *vdv, u16 idx)
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
@@ -2009,6 +2013,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
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
