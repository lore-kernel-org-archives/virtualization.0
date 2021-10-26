Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9ABC433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 17:56:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF1796109D
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 17:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BF1796109D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F958814B5;
	Tue, 26 Oct 2021 17:56:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mLyjgd0_HKxb; Tue, 26 Oct 2021 17:56:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1FAB380EEB;
	Tue, 26 Oct 2021 17:56:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3910C0019;
	Tue, 26 Oct 2021 17:56:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96924C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:56:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7EE57402E1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:56:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OkhwDrDLJfec
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:56:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6DDB940231
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:56:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Se94eaf7QfWnJ5DA+BZb3/RRSwXI1TKRPzcX3JJsT2BWzZO+/I58G++888BA1yTuYWbASg2GQFCOSOSlayhdsHU5grU8XnbgObifr4ZNanKd0/YnDvl/7AMvgh4v0s04nl1giBnEVEVnA+wRTuP8v7OQquVCe5LqrzX3zn/CktCzTA1a6+dcGwBHn8pfnDR0pUhcyoFmLS0GREKIeX8PEEngaLERQd36JcqU7g4WWgLf1uArxN8AoxoEvj1qNikO4zgY9zmQfhpYeuNDOzrhrUdaRZF7lyhGCdGOpaqhSchHR7gZCdih68vhTdruS4Xfjtfu/dQVgYyBggJZSKLVHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6r2H7ofzzmLmCE/UwPQNLz8HnSMsSCl3sEoMTW0SeY=;
 b=iYFkxy/RMVrtXD3MbhWEqYyOnBQqiZQJGGYvFwVQEC24DusKcBocQkzBcjyU58ELWcUualzmI4c1TWpERbSUEuOJ2DYtS8zlVwDKjN3qNNs5u2e7z/A0kEeru3I4sKHLONRa8erixoMPyXdztttUeu/Ky6/JdTl6cWSNsrCd3V+yFq1CKsxxUgTWt/IW66rllfQ3bhZpOYC2qv3VFeklGx/tNpiSmmwhWRwq24oi7WkYtuDbVfirFiRNsDHPNmz35AkrKj3tZ6FIwQ7QLkdkJjMvfryoMUuGtEQmY8v0CCStIHY5FVsf30it8pu4Ix289nFMuq7EQ8/2+sKC+7Gopg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6r2H7ofzzmLmCE/UwPQNLz8HnSMsSCl3sEoMTW0SeY=;
 b=XLJifXkBrRWAS5TlBg/noie4Xl9OmO6lT/SwD7Vmsj3FlqR/YYNtQeabNrv1Aywlr2+92FYr8X/egcUotAEeJxpCz+k8YmnKFfDsaxDG9vZ2jqnkB92bf2daFgzcTL8F8Qdv0bSXbl/TMYWtOdooK8ANPEpbNQt7sXc4dpFTNmKAEBgzrfnVIUTbZQowX0ipwQ+1jbvoWp3lNwFU70WuE6GSrdTOiiYxV7WgSjeIJGzSo4/RkKeNBB/3+/KxMFN+tIeHDBObbavxtmCBpMfMp9o2OTY7mPS4i4JODQ5n5Xx/i9wP8lPx6nr4kZeRU9Yp8WC4+MEjwW6HUp+Rb/5/+g==
Received: from MW4PR03CA0351.namprd03.prod.outlook.com (2603:10b6:303:dc::26)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 17:56:01 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::69) by MW4PR03CA0351.outlook.office365.com
 (2603:10b6:303:dc::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Tue, 26 Oct 2021 17:56:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 17:56:00 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 26 Oct 2021 17:55:53 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v7 5/8] vdpa_sim_net: Enable user to set mac
 address and mtu
Date: Tue, 26 Oct 2021 20:55:16 +0300
Message-ID: <20211026175519.87795-6-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211026175519.87795-1-parav@nvidia.com>
References: <20211026175519.87795-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcb6a7e2-b48f-40f0-7464-08d998a9df30
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-Microsoft-Antispam-PRVS: <DM6PR12MB43554B285EFCA06CA59436C1DC849@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:226;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fVJYB5+X7lmXCwfwXRkJJLR7UtA+DxFilX7L/84+SbvgIfkpZEhBzkgo/V3lV43YC5J/hoGKuPXlCXW3GVlW+mlw9ljTd+0nmbiFFOXXO220UOokfXCbFryH63erQBlgJV3IlP7IUw8xrtoYhldLYPBKscnN1BPHGXt62lNZIlF+DXuh5D6yaHyCMnFoxef8NHbv5FNwhNw0O84YmX4ModdIej1N/fSvsvU6hXrmY9zNwDORkooajeFsLvsFf0SsIdctR9hEr/Xpu0ZzY68/2bb3FCQRUSFpH0hAztqTR/NL7m2KfAFV+GSOUwfx7BDflDBxqdlsehVaI3cHsUKumaNWZ5CFezKxRIU65dZBFwGSPDBTxFQWOdM4zAfumOqQO2qT60zi7iXyQbpwVdM1RoGLm9q3EpyIJsfAMw1YgO5t20Voi/yG7ocBkMHQMbABnxi7eM8arzXft55zEELUSZ39PRHU8EXXvsZMIkXPH8KQj6mfVnfZqH17xx7Wf2IYtsrDefymhorL4pW9kf1J1gQ87HAESFZGv151NF6Vhpc5D1OeMWhwTcxNdCkhqjG9QYozoKJckvprbGyvhanjubJ7CTDdipVBIO2yF8+IgsJw7O5mYA3YM44qE8YO4crOI4WgKCJDgN7DJTpKQ0QhpO5D7Tk4nRYBpuM9/+fHSqLGS7+Ji6O74C9LhRVukSN9HSQ40fwYz8u9puayECdH2A==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(186003)(2616005)(70206006)(16526019)(70586007)(426003)(47076005)(36860700001)(356005)(508600001)(36756003)(4326008)(1076003)(54906003)(82310400003)(336012)(26005)(83380400001)(6666004)(2906002)(5660300002)(86362001)(7636003)(8676002)(6916009)(8936002)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 17:56:00.5638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb6a7e2-b48f-40f0-7464-08d998a9df30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
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
