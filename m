Return-Path: <SRS0=x/cL=HV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF93C433DB
	for <virtualization@archiver.kernel.org>; Fri, 19 Feb 2021 11:55:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0F9660C3D
	for <virtualization@archiver.kernel.org>; Fri, 19 Feb 2021 11:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F9660C3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 79F8A8710D;
	Fri, 19 Feb 2021 11:55:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jt3mOEWcMiaG; Fri, 19 Feb 2021 11:55:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9A28D87108;
	Fri, 19 Feb 2021 11:55:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75466C000F;
	Fri, 19 Feb 2021 11:55:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B2B6C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 11:55:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E56D786BA4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 11:55:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ViZPq0ld4ISm
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 11:55:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5FBE186B96
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 11:55:54 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JBt3fg150949;
 Fri, 19 Feb 2021 11:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=Y7tWXDWYYFR8Goj5RqfddTZC74cyNyev2Htnfv1H/PY=;
 b=0g8IYVYtvGxxgN78prXyP73bNWJvWYX+eBmIu3AWwVTSu3PAbifwMdrNc7CyQV15tIUu
 dEVpeAFPY3Uc6Hy1cJIvZSPnbpGpCMO4mGbVVRR3nlxYZAlcUnkjqBEGiAjoilc2stsM
 /m325wYL9CPMggAEtMBHgWok/FFoQC++dGDRL4JB1oO1N4mDlErM6OsUVei3T1wG/xMa
 s6PnqOl5hGUTdHRMRzUopNtBncbRP/hPcwMv8I4MHen0LmBYwkNUm3AXAiwlOTjfPnPQ
 X4U6tYarFrsbLik0w4UdyU8pGt1akwuCXmnokCqHR5ySBbKkVAMvJRVDb+kxlKR0owOM 0g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 36p66r98vh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Feb 2021 11:55:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JBoL47016403;
 Fri, 19 Feb 2021 11:55:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 36prp2ttd4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Feb 2021 11:55:51 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11JBtndr011179;
 Fri, 19 Feb 2021 11:55:49 GMT
Received: from ban25x6uut24.us.oracle.com (/10.153.73.24)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 19 Feb 2021 03:55:49 -0800
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: mst@redhat.com, jasowang@redhat.com, elic@nvidia.com
Subject: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Date: Fri, 19 Feb 2021 06:54:58 -0500
Message-Id: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190096
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190097
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

Commit 452639a64ad8 ("vdpa: make sure set_features is invoked
for legacy") made an exception for legacy guests to reset
features to 0, when config space is accessed before features
are set. We should relieve the verify_min_features() check
and allow features reset to 0 for this case.

It's worth noting that not just legacy guests could access
config space before features are set. For instance, when
feature VIRTIO_NET_F_MTU is advertised some modern driver
will try to access and validate the MTU present in the config
space before virtio features are set. Rejecting reset to 0
prematurely causes correct MTU and link status unable to load
for the very first config space access, rendering issues like
guest showing inaccurate MTU value, or failure to reject
out-of-range MTU.

Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 7c1f789..540dd67 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1490,14 +1490,6 @@ static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
 	return mvdev->mlx_features;
 }
 
-static int verify_min_features(struct mlx5_vdpa_dev *mvdev, u64 features)
-{
-	if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
-		return -EOPNOTSUPP;
-
-	return 0;
-}
-
 static int setup_virtqueues(struct mlx5_vdpa_net *ndev)
 {
 	int err;
@@ -1558,18 +1550,13 @@ static int mlx5_vdpa_set_features(struct vdpa_device *vdev, u64 features)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
-	int err;
 
 	print_features(mvdev, features, true);
 
-	err = verify_min_features(mvdev, features);
-	if (err)
-		return err;
-
 	ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
 	ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, ndev->mtu);
 	ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
-	return err;
+	return 0;
 }
 
 static void mlx5_vdpa_set_config_cb(struct vdpa_device *vdev, struct vdpa_callback *cb)
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
