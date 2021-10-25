Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A05C433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 12:53:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BFC60F9B
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 12:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E6BFC60F9B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C37F6403F2;
	Mon, 25 Oct 2021 12:53:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hGWeUi5nWOdb; Mon, 25 Oct 2021 12:53:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4B7E0403D3;
	Mon, 25 Oct 2021 12:53:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12CB3C0019;
	Mon, 25 Oct 2021 12:53:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05884C0021
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DEB2860875
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 08lagODE1ugd
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::62c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0A5E46080D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fnnu0IzZhpePIlcxptUsE/C5TXbw9UC/nWZS8gzyTmMeNdI4rzSN/J4y9DrCPNeKpk0JW8QmAdkinWnsqGMdiYzpLueMvz6OA07s3DkMhYk8UILtGJlP+x1/8iGjL2z3vo97XEtAR0AQe/ufrqFVfsuysmSA+HgjkknQ8gcvo5JX3pNLKS/WaTrIAQGEyG5G0vJVFtpKjhloAHKbalLPs78epB5Witxhl8ie5yalLXVtV8+PBa//3xPZxSbQ9+s2pc4ZkPZrNjgbnLAymUpL4TStDiI1N4ju2NHDCFAzDTDIzwh5cp8+zqwViN1PZash0h+062K8aQF9Uo6AWL7nAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5C4Rzs8QuXIpma2D1/Nqt5CsLbQmE31ZnD5yjvLx4k=;
 b=PwrxtmyLuBIqvNXd7wb8EXspLVP/IisNvoQOOeGYEaTjMPnroqBsiSiuqXlOpi8U3HL0mmyqFTiNccCJX8LdD7y/xZiFUc3nbM5CNtvg2UFD7yNaUXR7BmtIN7hYM3P4TUtw5uLB79+SppP4PAJNLsLKRThl42vpGSxuQvKJVkmY9iAJKbtnR82QB6iNCb4OIDTwKZcn+fnVxm3LAephVPXcxiLwRc5AH0ziHuFcSycGMGiNCAVUj51EL0YMOXmBxl6+gQxqFhvS0dL/fotkSmbrPkOdhR2sY5PRnvXO3fSJWnzbuDfQZCNyIcps0T3HecKaXNdkmMQcd5VTJUj8Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5C4Rzs8QuXIpma2D1/Nqt5CsLbQmE31ZnD5yjvLx4k=;
 b=D0ot4D/VM5kWzJ+9qE7oq8GwljpTO9n0q+yoB27mX/z4OW3Zqc4Imm5BHkpPUc7mn70Kj1k8KugcKjYi6HPId/t3FlbmzOU885GJ0aNOSolQ207uGQMfctOhwVJ95MlYFeLvDwn8OCw5WWC7RWe7Ce6+GB31/gkiGWoQc942Io9mkpG4tQ8V/VPK4OUhHfwAeDgu8yVzcq1g6vbLm7ZEIYmoC3ktW/vYGyucPToEpN3jWnJSLkC3tR8WEDMYhbcVV1Ou7oT+xzjNiFaRxFU3Lgg/3RsBTXvAQ1RMKD1LmGyLuhUSbNN/WuylnH/ee+xkaOUxu0f0AqPOMBZAFjhQbA==
Received: from MWHPR1701CA0021.namprd17.prod.outlook.com
 (2603:10b6:301:14::31) by CY4PR12MB1894.namprd12.prod.outlook.com
 (2603:10b6:903:128::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Mon, 25 Oct
 2021 12:53:41 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::c5) by MWHPR1701CA0021.outlook.office365.com
 (2603:10b6:301:14::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Mon, 25 Oct 2021 12:53:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 12:53:41 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Mon, 25 Oct 2021 12:53:34 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v5 7/8] vdpa/mlx5: Support configuration of MAC
Date: Mon, 25 Oct 2021 15:53:15 +0300
Message-ID: <20211025125316.67664-8-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211025125316.67664-1-parav@nvidia.com>
References: <20211025125316.67664-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb5beb91-6cbf-41cc-0cbf-08d997b678c2
X-MS-TrafficTypeDiagnostic: CY4PR12MB1894:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1894DB4EAABAD21AB1A17EABDC839@CY4PR12MB1894.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0fJMpJDJlopTUZZ7+h57qDTSsaMit87mtRf+JYRZd2w2w+Zts6UBeqIn0JYlNtTWteDu1XwlIhjcttm+ddQTuFrFSfTFwPBG1WoFw3bfmeIQ+DFSnfgZa7UhrRsQ3eviJtb4mBKhoaSLvCcIXaP0CNXK3j1rud1ySoSG+ntNBW5eHw7lMLqfwCyhjekEKWjZEG3B1R1AeachCYBlHA3g46WnQgprGLrrnfgsv5/tv5Zn2Y8zSJNG2uXhmZizormQLmnMD2/H6lioXalqy19akooXCLzgP8DazOCG3x+LEGS0M0iS2dyWlpg6IG+HyjflOr6pSrUIJ6K7Vh7bTAmf9Gu2rLpesni0F4RN9u9XTBq2dZdF1+TpN90gxulBxdwfyZ+tNPEHSbT5hUdMICeCVLXBPXw4gZ9R2GiuewbglerviZVlQ/MFbMkDKZnrsXvet/+JOTD0JmaVuqJTqCb6tgqSbXOmnv1bFmf0pxlTJc8y6hQ3cbqa/6EV/ODJFHq4th99w9Iexrsmc2bAmHr/EpKIXUvvh6B4nYYOk+AybA7sLok++TAdMDZXde7xu0oiecvDqMwx9SwQmUdg9get+az4bjp+S4yxnasp2UDmGnbUPriytyxu6kI0OAV5av76NB/b4D2tl6KqNxFS9G5+59lp+RnVe4kdrKVelvk2g+IHqToFDGtzN1U9JILxZooKVgegqiA6PxZHUwaPI52W8w==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(186003)(6916009)(70206006)(316002)(356005)(508600001)(70586007)(83380400001)(54906003)(36756003)(36906005)(1076003)(5660300002)(8676002)(82310400003)(86362001)(336012)(426003)(26005)(2616005)(7636003)(2906002)(16526019)(36860700001)(8936002)(6666004)(107886003)(47076005)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 12:53:41.2702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5beb91-6cbf-41cc-0cbf-08d997b678c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1894
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

From: Eli Cohen <elic@nvidia.com>

Add code to accept MAC configuration through vdpa tool. The MAC is
written into the config struct and later can be retrieved through
get_config().

Examples:
1. Configure MAC while adding a device:
$ vdpa dev add mgmtdev pci/0000:06:00.2 name vdpa0 mac 00:11:22:33:44:55

2. Show configured params:
$ vdpa dev config show
vdpa0: mac 00:11:22:33:44:55 link down link_announce false max_vq_pairs 8 mtu 1500

Signed-off-by: Eli Cohen <elic@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 8d1539728a59..860d80efa5d1 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -6,6 +6,7 @@
 #include <linux/vringh.h>
 #include <uapi/linux/virtio_net.h>
 #include <uapi/linux/virtio_ids.h>
+#include <uapi/linux/vdpa.h>
 #include <linux/virtio_config.h>
 #include <linux/auxiliary_bus.h>
 #include <linux/mlx5/cq.h>
@@ -2523,18 +2524,19 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	if (err)
 		goto err_mtu;
 
-	ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
-	ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
-
-	err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
-	if (err)
-		goto err_mtu;
-
 	if (get_link_state(mvdev))
 		ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
 	else
 		ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
 
+	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
+		memcpy(ndev->config.mac, add_config->net.mac, ETH_ALEN);
+	} else {
+		err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
+		if (err)
+			goto err_mtu;
+	}
+
 	if (!is_zero_ether_addr(config->mac)) {
 		pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
 		err = mlx5_mpfs_add_mac(pfmdev, config->mac);
@@ -2632,6 +2634,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
 	mgtdev->mgtdev.ops = &mdev_ops;
 	mgtdev->mgtdev.device = mdev->device;
 	mgtdev->mgtdev.id_table = id_table;
+	mgtdev->mgtdev.config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR);
 	mgtdev->madev = madev;
 
 	err = vdpa_mgmtdev_register(&mgtdev->mgtdev);
-- 
2.25.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
