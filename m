Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CC7C433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:03:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4F760EBC
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7E4F760EBC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49D01404B7;
	Tue, 26 Oct 2021 04:03:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XgugGK1TGqLy; Tue, 26 Oct 2021 04:03:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C563D404B2;
	Tue, 26 Oct 2021 04:03:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E92DC0012;
	Tue, 26 Oct 2021 04:03:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B9DAC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2DFBA401CD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0asb4OIP3l4f
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1E488401BA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ij/n5L7df44Fv+0ZGkVKtaFfyReoC09NS68ka+Sfrl4/OsKhTqRH3l4mysYapUPe3XxaXk+TqaSbbfoQhvVi2Gex2E7V3z7k7lbB+a1VAl6EZdnwzN6sExxnJXlZEvjiUwnBAHr1q3tkMaVeqR7o2x8/uYCzvMlr3/nEmGiDe+FP6gZ1t0jSGf6tVW/c9V80T+SlOA61/euy9ptDLkrk4rDs0QJ4yBJUdfN0A01ROK+OVTVih0MoeSjOMLOieWo9qFDN0GacxJ3JqAGjRsAwjoAYKkMBLfbY1Uu+Gciz83D5IOuH560EPuopgYWN3AH5+YSRACWoiGt9DqdexDOntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhwFQ16wb8xSoSahjmGs8AXN/pngtZLaoAu3304QFI0=;
 b=fOXdgFZBcQPXjYXdyK8SMBemaf8156dm3w2TrY4ESK+kNpN2oYc3wbfZkKM6ZrnvfPMCuDOxfs9yzchH7so0A0L1qbNOFP+LNhHM7ZUGtLesDz8a6G+KnKLSrZmODekhXkMrcC/NSS1DlfcVi6AMYz7tCe8wvyM9Ih4Cz5EP8sJgBKzlyaN9f8HZqTuMlhGwcnm06tjT+yIfe6ynKUZ2ZKp8yBV2SaTvUpRDbvpEJTMbw+NIshG4TDcIVADC83s83RKB3WVO6kvp9ogUTLvH/AkuGg7sepUET31I8FlpeaWqOgITY7dhzLhNsIxY3Q+JTdWLIbcmCImjhsm+jEiOFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhwFQ16wb8xSoSahjmGs8AXN/pngtZLaoAu3304QFI0=;
 b=VLH8yPbgd8wWwUbiboJJZxPZrMK/sBdS8Wg/YnJsgcjUoUno0sfnUknD5ZB9h6raG/yfNoqK7jIMwC8juraWg3w+sA2XBOAAidMFi9yHL5LJKDvjUP7uawDco8ouS+XZhZb3bgZclsB0o0kpalorscUfRZyii61VoqZeZqG55pS1TizCwMkhxf/D+giosmgsEpClxB2yljI4fQ6a80QfRe/PXQTu6Z0z3jzX73xAfn0n31meuT8oP+/8pqX4WIvljtWYxm16Mc2d9bmQTluYrzeagM50+keXINCzNLtdJI8A1+2pNYyx1+SpqP1GyTtKwXbiqdQ0RpO8hPWpMU06xw==
Received: from MWHPR2201CA0037.namprd22.prod.outlook.com
 (2603:10b6:301:16::11) by MN2PR12MB3903.namprd12.prod.outlook.com
 (2603:10b6:208:15a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 04:03:07 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::58) by MWHPR2201CA0037.outlook.office365.com
 (2603:10b6:301:16::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Tue, 26 Oct 2021 04:03:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 04:03:06 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 26 Oct 2021 04:03:00 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v6 7/8] vdpa/mlx5: Support configuration of MAC
Date: Tue, 26 Oct 2021 07:02:42 +0300
Message-ID: <20211026040243.79005-8-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211026040243.79005-1-parav@nvidia.com>
References: <20211026040243.79005-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72d797f4-1ce5-4907-16fd-08d9983583fe
X-MS-TrafficTypeDiagnostic: MN2PR12MB3903:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3903BAE47A6439EC39790348DC849@MN2PR12MB3903.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fCYnCzJNvMwUheF8YKVRfeB4XW+8ooNraXEJgp9o1WY1KomE3QHWD6SV5J62WtDyfpyVgk6gNQgjzmJQoeEYoVZC18k9ooOVC5gAYHSda5eVjLlj1x7M6zuuWMVVD0jPxoBXJgLVEazwBy0nts6R6jkEyzvElyaR8kmgs5CktxbL4/6tPmz3jUMpb5VD3dGBK6r5XPnsWpMsSuoNqNcSeHc4xb4XaFzyArJtEXcO5odTzTh9ANP78rZhwy2Wf3svWth+b5AVFUg2AgvWWj/uTzTAJEzpdYJ2LlvV9VUTh7nUd0PH4GArmJwMEXdaq91/F/7PR5iDfQ4SrNfHArkMMs10O9jRJixFinXDaXFfl0t59U4joIigA5upUz8aBv/IIjk5cpreNo1+t7zS3PcwNBPgLy684POmS9BAghb0vkQ18SNBI+MW/4nZqjOR98wUCHo1H7c7YlulQDaO0WE5xBGw6TBFxKi9SvdRdY1haYZUZown662KoVekdrBz3uKLVxELm8lfq+UaETn/SYdCI2OhYvQYFb6qWOOEmB8bbwb0BT4kzOUryRPYNRTFbFBx1VdWB/4bNbdt+KF8hHLGJlfqZIZ8SBeMhx+5jeVuixHSRMU7f5lY9uSzCAiVQ1gi7Iz6PNw2IEqoNY1GPAVT1d1+YLAy5vIuKFl/ZoB3fpOu/d599IPs+2vS1JMfXKB/Z97cJL7k3Q8T5qVhtYMQew==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(1076003)(316002)(8936002)(426003)(54906003)(4326008)(70206006)(7636003)(36860700001)(336012)(356005)(5660300002)(16526019)(36756003)(86362001)(47076005)(2906002)(6916009)(186003)(2616005)(6666004)(107886003)(8676002)(83380400001)(70586007)(26005)(82310400003)(508600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 04:03:06.3652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d797f4-1ce5-4907-16fd-08d9983583fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3903
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
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 8d1539728a59..cc027499c4d3 100644
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
@@ -2524,17 +2525,20 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 		goto err_mtu;
 
 	ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
-	ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
-
-	err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
-	if (err)
-		goto err_mtu;
 
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
@@ -2632,6 +2636,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
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
