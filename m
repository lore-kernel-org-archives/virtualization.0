Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91E6C433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:03:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AFBA60EFE
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8AFBA60EFE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E9AA608C9;
	Tue, 26 Oct 2021 04:03:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5dw4rqYtkR6U; Tue, 26 Oct 2021 04:03:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 08BA2608C5;
	Tue, 26 Oct 2021 04:03:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDC5BC0012;
	Tue, 26 Oct 2021 04:03:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AF39C0023
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E4C23401D9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cc8buZ4KGC5q
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D0BDA401BA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIMbAdquKhtwVil2FrnMNDCwQaMbVT9DqAbzI8IU4SEBMMm3CLkqzU3wSGAWFeOsHxFCKOPTSi4rBonobgTWzxcSRdI1r3VZex2ifiIl167KltcTN/VYgkujm3A3QVUcN79j1e4Nv7fjbgzAokdmDR7SDmgYF+CcUGEpM0Ov7E0cVC2DM54+koWPgj5nTJzF+njoMuADfd3xM6vUsIS9dYuv5YDHxrHS4D+KFF1vNiGPzJmOTAijr02pBB1jRd8RB2L0YCQfh9a5qz8Zgm+yQkJbK9G63VxeD373fU5bmoSDudtBmnIxXiZg4FcVusvsbdoWx78ZFv0GTw2KM/gnsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAUqrOs790mbswkKmQ0W6tzkzz+eBjYHO7yL7xgsAeg=;
 b=Qbq5kx7CjkIzrobcELA+A6SW/BL/QRFtIpsTShVcyDjGOvbfyWNggB4uCW60QVrzsjZKftV2EPNwsfFAB6l9ETydrv3i8B9m6HYTdP5+0VWsoV0FDHh0LjJmfurYY59OyrZLrv3ZTZvUvS1bqyDDBic0rpB7YmP4osVn5DjRV5jSfdB74lKqIyQJOKYmfKXiePiJVpduEhE26Er3VhRRO6EYQ/UsynCnWwgoS+E5Z01w60RPuLJS43Q0rA6EkCN5eXnkaOHog+3hkpKDl5KZbLiEpF/YmaJEVTo0Xf37Yj4gcJ+1GMhzI8vrRo+HUEGC37eE/2Xc5QjkN5KnxC5TAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAUqrOs790mbswkKmQ0W6tzkzz+eBjYHO7yL7xgsAeg=;
 b=V9ZINvcbAwA9d6KkXmzTv8wVMTyxjZNuQOHHWagGe3/PF+JsvvWjK26783fd6Fwl/82G/RBR+jh1/EdQOKqPFr3yn1w+xZ6L84OSgVOYj4PLnuGLOU+drGZaZTj+yjhevBUZS7jYnXvGhbK7PtdESuG+Rw0XUttttGjhvQ0BSLnwfnA1fen2ZJO7694oWpuN+Lp+CIqZO4ErVRf8+vwOhISRJbo5NEg9UqNy/Wqt/VAinY7Cs/Ip+gSmJ0sKwdDBw4dJ5ZF0narGqSgruyy5p5UcyA8SEgMgaOyBylNJaG+YGNS7mtq0IYezxU9io6SQDzDXuvAqdWi+sF07YQP4vQ==
Received: from MWHPR2201CA0040.namprd22.prod.outlook.com
 (2603:10b6:301:16::14) by DM5PR12MB1564.namprd12.prod.outlook.com
 (2603:10b6:4:f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Tue, 26 Oct
 2021 04:03:04 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::7b) by MWHPR2201CA0040.outlook.office365.com
 (2603:10b6:301:16::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Tue, 26 Oct 2021 04:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 04:03:03 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 26 Oct 2021 04:02:59 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v6 5/8] vdpa_sim_net: Enable user to set mac
 address and mtu
Date: Tue, 26 Oct 2021 07:02:40 +0300
Message-ID: <20211026040243.79005-6-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211026040243.79005-1-parav@nvidia.com>
References: <20211026040243.79005-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9fe8f67-39e9-4ea8-acdf-08d998358255
X-MS-TrafficTypeDiagnostic: DM5PR12MB1564:
X-Microsoft-Antispam-PRVS: <DM5PR12MB156457EF6BB58F4340A01962DC849@DM5PR12MB1564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:226;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nX+ZKFVbw5aKIun4yxM/id8pJDkyTryE0aQYwf8LIhz6MqtoK6f8qLXDoVNXmInbJ1p9Cy0Y3lZiDr9XFXCxujC1ycYpGa7qGIw4OpzmJv0UOF7qkLYneeUnFWRsFgG8zmYWa+GB8gbRmStTGAEBcVV5N2eKOFWgzoHr+7y2G/KOuobHsik3BRH6769JaHoi4Dz0hMchB98Hr4qiyleLbfp+m3iDjjYobj02PzaWfbVjkzR7JDe8+iKXbZICElEarEf60ZpEZSyKjeTr6vfYIl05+Slf5ID9IFIK89EUfkMLiD9gVKlYuUmzHgEpbPU60cgJzRSqIvYaLPuxhQG9NQ+M1Y+tjGh/fJ7OTOmplziUNxa0GL2HyL5DNUtzBQt4l6aHMspro1pwtgfi4sirIBw3mOfYyyMYVZbGhhqDYEdKVjH6ebEgEWk14BL1vGlyJ0Ii3WRHEWSFX4UHGd9SzhG/Q/ca9/IPsjmDfW/2ZBeYjtt/fZJp6L32RiY0ELsRnDeDvo6aD4r8yS30sP/YyKVndHQDyWDOTQf9c6A3RhC01voLuxCjwECDbVZuANHLw3ahFHYoJxCjhP7MfIuQ/cOuyfTca/yQJN0CY6YFE6UzGci+DjXIK/flL5xkxUwHGDrWT+J/d2pYQXnxijxzpOhJcWL52X3TQTI59nwdrpmmUh0UEftYR//4gwBXweURiCPNVOk5IAmWVTuQVMrnjw==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36860700001)(1076003)(7636003)(70586007)(107886003)(83380400001)(356005)(82310400003)(6666004)(70206006)(426003)(8936002)(36756003)(8676002)(86362001)(336012)(26005)(16526019)(186003)(316002)(6916009)(54906003)(2616005)(508600001)(4326008)(2906002)(47076005)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 04:03:03.5478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fe8f67-39e9-4ea8-acdf-08d998358255
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1564
Cc: elic@nvidia.com, mst@redhat.com
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Enable user to set the mac address and mtu so that each vdpa device
can have its own user specified mac address and mtu.

Now that user is enabled to set the mac address, remove the module
parameter for same.

And example of setting mac addr and mtu and view the configuration:
$ vdpa mgmtdev show
vdpasim_net:
  supported_classes net

$ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:55 mtu 9000

$ vdpa dev config show
bar: mac 00:11:22:33:44:55 link up link_announce false mtu 9000

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
---
changelog:
v4->v5:
 - updated commit log example for add command
---
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 35 +++++++++++++++-------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index d681e423e64f..76dd24abc791 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -16,6 +16,7 @@
 #include <linux/vringh.h>
 #include <linux/vdpa.h>
 #include <uapi/linux/virtio_net.h>
+#include <uapi/linux/vdpa.h>
 
 #include "vdpa_sim.h"
 
@@ -29,12 +30,6 @@
 
 #define VDPASIM_NET_VQ_NUM	2
 
-static char *macaddr;
-module_param(macaddr, charp, 0);
-MODULE_PARM_DESC(macaddr, "Ethernet MAC address");
-
-static u8 macaddr_buf[ETH_ALEN];
-
 static void vdpasim_net_work(struct work_struct *work)
 {
 	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
@@ -112,9 +107,21 @@ static void vdpasim_net_get_config(struct vdpasim *vdpasim, void *config)
 {
 	struct virtio_net_config *net_config = config;
 
-	net_config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
 	net_config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
-	memcpy(net_config->mac, macaddr_buf, ETH_ALEN);
+}
+
+static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
+				     const struct vdpa_dev_set_config *config)
+{
+	struct virtio_net_config *vio_config = vdpasim->config;
+
+	if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR))
+		memcpy(vio_config->mac, config->net.mac, ETH_ALEN);
+	if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MTU))
+		vio_config->mtu = cpu_to_vdpasim16(vdpasim, config->net.mtu);
+	else
+		/* Setup default MTU to be 1500 */
+		vio_config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
 }
 
 static void vdpasim_net_mgmtdev_release(struct device *dev)
@@ -147,6 +154,8 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	if (IS_ERR(simdev))
 		return PTR_ERR(simdev);
 
+	vdpasim_net_setup_config(simdev, config);
+
 	ret = _vdpa_register_device(&simdev->vdpa, VDPASIM_NET_VQ_NUM);
 	if (ret)
 		goto reg_err;
@@ -180,20 +189,14 @@ static struct vdpa_mgmt_dev mgmt_dev = {
 	.device = &vdpasim_net_mgmtdev,
 	.id_table = id_table,
 	.ops = &vdpasim_net_mgmtdev_ops,
+	.config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
+			     1 << VDPA_ATTR_DEV_NET_CFG_MTU),
 };
 
 static int __init vdpasim_net_init(void)
 {
 	int ret;
 
-	if (macaddr) {
-		mac_pton(macaddr, macaddr_buf);
-		if (!is_valid_ether_addr(macaddr_buf))
-			return -EADDRNOTAVAIL;
-	} else {
-		eth_random_addr(macaddr_buf);
-	}
-
 	ret = device_register(&vdpasim_net_mgmtdev);
 	if (ret)
 		return ret;
-- 
2.25.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
