Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA90C636CC
	for <virtualization@archiver.kernel.org>; Tue, 31 Jan 2023 23:22:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C8E244056E;
	Tue, 31 Jan 2023 23:22:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C8E244056E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=1l3K44/s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G2gwUxU_OxcI; Tue, 31 Jan 2023 23:22:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 575064052E;
	Tue, 31 Jan 2023 23:22:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 575064052E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06627C0078;
	Tue, 31 Jan 2023 23:22:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AD0BC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 23:22:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1262940534
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 23:22:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1262940534
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7V60vl5fFtuI
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 23:22:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 71DCC4052E
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 71DCC4052E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 23:22:48 +0000 (UTC)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 30VIi8KY006403; Tue, 31 Jan 2023 23:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=jBMajAB9G57vQkrNzc3zhBcJ+CNOgFjKuu+oW+pIhbI=;
 b=1l3K44/sOyMyiBBFNyxXwi/L9zrW/Vc7H2hXKgLfkHwop6uuh/c8aT5QwgSvRESP3Fs7
 FXsjisfomvLATZdIHFXwkugBslTP8/8pXuOwKL67Q3ymionPRm+5Sl0pFLpAa0WTR22G
 w+h8vRZi/SF392on1gdn2iMzThPEX7nHwjXd8vkt1ML3ICnCeQNztLK7IuT5dEeJve8M
 95ZrhZWGuiudL+5uXzMuv34fWsczkXaT3DvQzRoJwJIeP+yinQJLJFTxps/0l/WpW8Ue
 miRmaOMTgaUhxJHaMkz5AGWpV4Gt1oUAEYyHWysfd9z/nXbkV1/un5a1AWWqeB9dbY+F xA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvp171fr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Jan 2023 23:22:47 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 30VN9OVp033826; Tue, 31 Jan 2023 23:22:47 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3nct56fb9w-7; Tue, 31 Jan 2023 23:22:47 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, elic@nvidia.com
Subject: [PATCH v2 6/7] vdpa/mlx5: conditionally show MTU and STATUS in config
 space
Date: Tue, 31 Jan 2023 15:22:24 -0800
Message-Id: <1675207345-22328-7-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675207345-22328-1-git-send-email-si-wei.liu@oracle.com>
References: <1675207345-22328-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310201
X-Proofpoint-GUID: O-lnltgzBHJSzogCVGl15IVauHYM3XrS
X-Proofpoint-ORIG-GUID: O-lnltgzBHJSzogCVGl15IVauHYM3XrS
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

The spec says:
    mtu only exists if VIRTIO_NET_F_MTU is set
    status only exists if VIRTIO_NET_F_STATUS is set

We should only show MTU and STATUS conditionally depending on
the feature bits.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 3a6dbbc6..3d49eae 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3009,6 +3009,8 @@ static int event_handler(struct notifier_block *nb, unsigned long event, void *p
 	struct mlx5_vdpa_wq_ent *wqent;
 
 	if (event == MLX5_EVENT_TYPE_PORT_CHANGE) {
+		if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_STATUS)))
+			return NOTIFY_DONE;
 		switch (eqe->sub_type) {
 		case MLX5_PORT_CHANGE_SUBTYPE_DOWN:
 		case MLX5_PORT_CHANGE_SUBTYPE_ACTIVE:
@@ -3118,16 +3120,20 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 			goto err_alloc;
 	}
 
-	err = query_mtu(mdev, &mtu);
-	if (err)
-		goto err_alloc;
+	if (device_features & BIT_ULL(VIRTIO_NET_F_MTU)) {
+		err = query_mtu(mdev, &mtu);
+		if (err)
+			goto err_alloc;
 
-	ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
+		ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
+	}
 
-	if (get_link_state(mvdev))
-		ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
-	else
-		ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
+	if (device_features & BIT_ULL(VIRTIO_NET_F_STATUS)) {
+		if (get_link_state(mvdev))
+			ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
+		else
+			ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
+	}
 
 	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
 		memcpy(ndev->config.mac, add_config->net.mac, ETH_ALEN);
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
