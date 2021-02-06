Return-Path: <SRS0=dwtO=HI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5845FC433E0
	for <virtualization@archiver.kernel.org>; Sat,  6 Feb 2021 13:18:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E425B64EBE
	for <virtualization@archiver.kernel.org>; Sat,  6 Feb 2021 13:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E425B64EBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9B5A9863F2;
	Sat,  6 Feb 2021 13:18:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BMOX27bIeTso; Sat,  6 Feb 2021 13:17:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4171886371;
	Sat,  6 Feb 2021 13:17:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BE69C0174;
	Sat,  6 Feb 2021 13:17:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7085CC013A
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Feb 2021 13:17:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 344C787160
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Feb 2021 13:17:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kKq3WeVgz+9L
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Feb 2021 13:17:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2C4F087132
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Feb 2021 13:17:14 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 116DDS6H182707;
 Sat, 6 Feb 2021 13:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=o3THMT3JVYvgXz8IFwi9kLOWhVsX51RrtTOYVjA1hGI=;
 b=Y3cO8rQc2Es13Tu/DiAALKGY53sNXRia1fo5o/ETv6lsuKDbeTwdtU8WK3Xb7c+wvqDU
 LYLPxZg7dYs6hvtHG9yN6LZntxwZOZVuLTuIIt8yavtpFbfQDCIIpDCkIzqrneJTOTvd
 sQYOjYHAc6sWHEhqUW0TgK0CMMJUVHoGKztiKqPYnOfwsSDoLf0gDA7JWJMfEZ0i+M4H
 HZVq7x1W00O+pThjRUHyF9sTakz6V/aSleYCnBbf4I7I5SD6CDQ85oeyi+oGLH7vnN4s
 MZW7FhiXJST2OMXekNnCNSfCqkbwfW/2vIhogzfiXNUNwv3S2pAqpSpqx7d8MPZmEmI4 0g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 36hk2k8mbu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 06 Feb 2021 13:17:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 116DAmSQ054100;
 Sat, 6 Feb 2021 13:17:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 36hg7rfas6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 06 Feb 2021 13:17:09 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 116DH8FU027788;
 Sat, 6 Feb 2021 13:17:08 GMT
Received: from ban25x6uut24.us.oracle.com (/10.153.73.24) by default (Oracle
 Beehive Gateway v4.0) with ESMTP ; Sat, 06 Feb 2021 05:16:16 -0800
MIME-Version: 1.0
Message-ID: <1612614564-4220-1-git-send-email-si-wei.liu@oracle.com>
Date: Sat, 6 Feb 2021 04:29:22 -0800 (PST)
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: mst@redhat.com, jasowang@redhat.com, elic@nvidia.com
Subject: [PATCH 1/3] mlx5_vdpa: should exclude header length and fcs from mtu
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9886
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102060093
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9886
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102060093
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

When feature VIRTIO_NET_F_MTU is negotiated on mlx5_vdpa,
22 extra bytes worth of MTU length is shown in guest.
This is because the mlx5_query_port_max_mtu API returns
the "hardware" MTU value, which does not just contain the
Ethernet payload, but includes extra lengths starting
from the Ethernet header up to the FCS altogether.

Fix the MTU so packets won't get dropped silently.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  4 ++++
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 15 ++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index 08f742f..b6cc53b 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -4,9 +4,13 @@
 #ifndef __MLX5_VDPA_H__
 #define __MLX5_VDPA_H__
 
+#include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
 #include <linux/vdpa.h>
 #include <linux/mlx5/driver.h>
 
+#define MLX5V_ETH_HARD_MTU (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN)
+
 struct mlx5_vdpa_direct_mr {
 	u64 start;
 	u64 end;
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index dc88559..b8416c4 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1907,6 +1907,19 @@ static int mlx5_get_vq_irq(struct vdpa_device *vdv, u16 idx)
 	.free = mlx5_vdpa_free,
 };
 
+static int query_mtu(struct mlx5_core_dev *mdev, u16 *mtu)
+{
+	u16 hw_mtu;
+	int err;
+
+	err = mlx5_query_nic_vport_mtu(mdev, &hw_mtu);
+	if (err)
+		return err;
+
+	*mtu = hw_mtu - MLX5V_ETH_HARD_MTU;
+	return 0;
+}
+
 static int alloc_resources(struct mlx5_vdpa_net *ndev)
 {
 	struct mlx5_vdpa_net_resources *res = &ndev->res;
@@ -1992,7 +2005,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
 	init_mvqs(ndev);
 	mutex_init(&ndev->reslock);
 	config = &ndev->config;
-	err = mlx5_query_nic_vport_mtu(mdev, &ndev->mtu);
+	err = query_mtu(mdev, &ndev->mtu);
 	if (err)
 		goto err_mtu;
 
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
