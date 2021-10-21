Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687C9C433F5
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 16:35:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15C9A61501
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 16:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 15C9A61501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E155160661;
	Thu, 21 Oct 2021 16:35:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SS0F-own9QDa; Thu, 21 Oct 2021 16:35:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8149360F30;
	Thu, 21 Oct 2021 16:35:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15FB3C0037;
	Thu, 21 Oct 2021 16:35:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 561F6C0036
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 271F340868
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o6tfknNaOlih
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5CD6A4085D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0w8EoWJ5ErUHtFdRc1muaTTSwd2XHDnJmOo8y6xeKxDFICIy/zmMp2dokQ14EwwEVeS1L+8NBZEQ5utvYgxaRb8Yf/WR49vr7THWMkHWoJt8Q2ZjzWhK6rytXbqu/v7pv5Tm6Zcv7mQnoNI0RLYKNkUgwObHminxY5QXPvl+c/ctr8LTDeTV67PLOxygcvccWc3XkqAZAGoYJ4opJa+tJCHfGUPBHepaguPIXC5fx6vxlg+2OMgM0Zfojki8tch8t52i/Ja0M9WG3nW/513u0+rOpH3bnh1ojlYs7pMNruYcLwcnLkdqTJ88w6EWQUX8sVXo8/Zbb93X3u0NOJQWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWwwvury1RYyzPSAQ09SqO5dXTX1NjWtKsbAIf/9TIw=;
 b=AqM9CNjZCarAHb8J51rC/JOZxURvYKSq2u7Rs4x0FogOzSKLrTzB/LMDK8+Z8338dZ9kVcz99bejeTDE1aw3uA2/6olVaS29WNrv+jK5aYcQ5ij7DeTGKYwxwGhIcwA4uDIKClcgXzSjJBG5dUF7RguG/HTzxhVNI0AYR5xF1xCA+I8EYko4zAo1BDFWwGLUl4Bv0nFsNe2onsqW2XZ3rlA+xvWPzGTQfUAGNLdh42tNp0vzBpc0W3km6omuAfZvkQPeEOpHAi+JULjlWzP87nh1bqpuKIKLo78W37Zu/aRDw/XHCeTG1UqgKIVO2acmUcYNrnkv0G2ZTpMCLAYnIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWwwvury1RYyzPSAQ09SqO5dXTX1NjWtKsbAIf/9TIw=;
 b=cTbHUlcv9qrSf/+Zr7pJOQAr1y7TokZM4QfDsIOpZ9dzs/lpkmQqwrSbSO2LMcVWB2bzPxsdnVlWi3sjTzTnmFw/H2cNNoac0R2d4s+gvuebSOmuWMsqqC9yrSmFEnFFH1fV2zHkKgFLsExb06EO+34D4bQY9JNn3/tPmAt4xZHWYPZZtb2Bns/whN2cIY1q7WvdPFuJXu+5RJqWIL7Lo/sX3B6pOoS5vdqteSE19BYYduN+2P+foDHUKsWExxXxbvpaW5CuP8BwvPv1zHDTYX2nzovdx9uJsFxtOuZW8iOuHSM7+oW+Hd+ln35Skvc1BnxCdDwaeLMm7UzzCHhy8Q==
Received: from CO2PR06CA0057.namprd06.prod.outlook.com (2603:10b6:104:3::15)
 by DM6PR12MB3531.namprd12.prod.outlook.com (2603:10b6:5:18b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 16:35:34 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::7b) by CO2PR06CA0057.outlook.office365.com
 (2603:10b6:104:3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Thu, 21 Oct 2021 16:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 16:35:33 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Thu, 21 Oct 2021 16:35:24 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v4 5/8] vdpa_sim_net: Enable user to set mac
 address and mtu
Date: Thu, 21 Oct 2021 19:35:06 +0300
Message-ID: <20211021163509.6978-6-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211021163509.6978-1-parav@nvidia.com>
References: <20211021163509.6978-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66d68468-e74a-44df-f4ae-08d994b0ce1a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3531:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3531428861547681488998ACDCBF9@DM6PR12MB3531.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zKb5XAJSUCmOGlwSKI45BAGSdZxWp2VrG2ZSXCr6eVeb9n95s7g5oTWzY+wcVQlX0E3/xo/czzJrkpVnuPbGfBgVescEv7+jVRJ7e8AJq+Ix9zyAhDQ1vouLEaa9cNWNDu0J1PgkWSbWsoSnJV4qS2hJwOSYjeGj+ko8m6yWXhiL+uCrlwiNws+QM9UPCKJTvCNPZ/q8DSmGEPvMK3HJvVxzPLx4wUB3XM6d99UQaR55kfdEy2h+AQ9I/LeKLN7+sobYHS04MJjSgEk9dxWfIiKurNXQTWcJjpB9eFeTYnVXxapLfsM4GclOqH9gbSyQk3Z/TYSjUnDLfdbNeJcKeuduWj6o066zIFj+RKKWnhHzkiarIV49kS600xQUwC68e9kXUjN4GuoemUu+o36tMHbI3uBoKWSBjEV06EverSl+KxfgD8i0Sl07Esm3gkSR5+CUHmrt+TDaxw5hhXLM+EFlgStK7QaOphAzFIzinL/3/KusITj1APMm+LgwWKLqKsuUA9NEKuWIdILXaVsA9+KV/mngHnfY7yMgZUgsZiqOoiiEUYVGuKu/omDi5x/NqKKlnIjiUcJqNkCYjYog2Qjzgkll9edQK2vBFOl4foeYp90yw9NFm4VLFpHTy5m5Bu4NPrDSYhzanbOLXlTH4CjW4GeXJ/0NFau8Qk/nUji3CjupSgXrCMFWXJhzaBghu8YUnx77nEOSzpu3yxBe+g==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36906005)(1076003)(316002)(4326008)(16526019)(336012)(5660300002)(2906002)(54906003)(2616005)(36756003)(426003)(107886003)(356005)(86362001)(186003)(70206006)(6666004)(83380400001)(82310400003)(8936002)(6916009)(36860700001)(26005)(8676002)(7636003)(70586007)(508600001)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 16:35:33.6567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d68468-e74a-44df-f4ae-08d994b0ce1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3531
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
This is done by implementing the management device's configuration
layout fields setting callback routine.

Now that user is enabled to set the mac address, remove the module
parameter for same.

And example of setting mac addr and mtu:
$ vdpa mgmtdev show

$ vdpa dev add name bar mgmtdev vdpasim_net
$ vdpa dev config set bar mac 00:11:22:33:44:55 mtu 9000

View the config after setting:
$ vdpa dev config show
bar: mac 00:11:22:33:44:55 link up link_announce false mtu 9000

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
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
