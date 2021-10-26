Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3696C433FE
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 17:56:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC866108D
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 17:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9BC866108D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7AD60608CE;
	Tue, 26 Oct 2021 17:56:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qrrsnl42N0zp; Tue, 26 Oct 2021 17:56:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1E47F608C6;
	Tue, 26 Oct 2021 17:56:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5575C0019;
	Tue, 26 Oct 2021 17:56:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4EB7C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:56:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C531B4051E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:56:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MKxUxP7xF1Ge
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:56:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::628])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0302640513
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:56:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjZyYewBbzLYl/K3O/PyC2zdB7JPaRcBkk8SIWNFyiczU+Ot7PaX4ZG51EWhb93KAne42pYrZeb3OCshP2Rj3ReWPdlY8ykR98vutSX4ldrKnB4QuMvt1kKcZTX1Sq/83z/oYBWlPA8mhHana89ProWCEws04dBy5TK60LXpm127EOy26TzEEt/D7TWIgknjVH7LC+I8IJY9V9WlAwPnHnJj4yaQnVnfIzIig6mzjpPUOVcJF99WSFFpIcKjYD+uhIFnW+ziId28wmO2jrhhNe7ST4HOwifL+QQPdHbY1Alq01IHcQkXaz3Lj2fejtoW56xwS8SQCbwv6QD4x+1Vkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhwFQ16wb8xSoSahjmGs8AXN/pngtZLaoAu3304QFI0=;
 b=YEy5EQpF2WywU8WndbDXHTkDQf5qChXZUc1cDKF8t3+iJSOH/wg0yzgeDumSOV5JVlyQEDaovX7dsNTvpWIgLpQPbxDHJr6dtqZMNIKFsaBhxYYpfeUDy4d3Ily06L7Jsu/BknfJdaFNFJkVF2wBoUkSHeIFLV6nEloyjlcWLRt/b2MAr3pyEkf4wrvxcwhcPusnP261ltGDotcQx9xg3bRz+2wVV3UnckgER0joxYVg1i20KqJxcS9lwGeoz8WksRqKSRCFp3g6Vk8Rwl7P0xvT1ooJvouj4ar329i2Jp21vs6N6qCsKq6Yxf+7ybMI5eQV+6mEyxJWoLU2baGZtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhwFQ16wb8xSoSahjmGs8AXN/pngtZLaoAu3304QFI0=;
 b=fjAMyUacH6OzSIyjAbvLvCqIA6rtPiyf/QFUeHZ/8MqzhMgDm91ScsbU1clQ2+NEd5k0pgRVzeCWY5hGvvxKGec+HzgEBaVotRxOWTin+aNbN0G2KRGfYH0+J40Muec7IReRNLydxRAmNfBTIVIFjaGDIz/ZwKTekFi5rSypwNh/OADfSUDreLjoXmIbMNHfa9p8bCk+3XyoWZ9c9+9drnv+x1lBSEbC7gSHJoysRGiFo2N6BWlzAqCLY640E0aT8riySUjNjvaL8qLhCdnAPKbMiFzLSPpk+4dkAZ6Y/XYqLTJO6edb1VD42FkCu/7+mQgl6IEYd/kRic3+VuTowA==
Received: from MW4PR03CA0354.namprd03.prod.outlook.com (2603:10b6:303:dc::29)
 by DM6PR12MB5551.namprd12.prod.outlook.com (2603:10b6:5:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Tue, 26 Oct
 2021 17:56:09 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::4e) by MW4PR03CA0354.outlook.office365.com
 (2603:10b6:303:dc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Tue, 26 Oct 2021 17:56:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 17:56:08 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 26 Oct 2021 17:55:58 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v7 7/8] vdpa/mlx5: Support configuration of MAC
Date: Tue, 26 Oct 2021 20:55:18 +0300
Message-ID: <20211026175519.87795-8-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211026175519.87795-1-parav@nvidia.com>
References: <20211026175519.87795-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24c20a24-3789-4ac1-1c44-08d998a9e41e
X-MS-TrafficTypeDiagnostic: DM6PR12MB5551:
X-Microsoft-Antispam-PRVS: <DM6PR12MB555148F54019B87E29975504DC849@DM6PR12MB5551.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kmN+tAf+tV87IdmUj7nAERgcewl4XdVg+Tvd0weXQbIsgJ9HBfUlAyCYE+8Bz5Pbw7//xK5IAK66qOJLslhi28gat4QMJc6a43QkrvdjnG1odoQbSMkWG/7B+JkVCfoWFXls8mTQLDI4bbBNzLQfZHpK492ix6b0MQTMpBSKpUsaBtloi8x9DZK2by3pyj7AV0fdpsVWOdA+tGfhsbBdm/HKCyIvNfcFIb6jt5IQRprBLgHcZ0SvBx61tbPxTyIw54RglCQGJV63M9h5U+iDsI7buFfloj9ptOr4u1YsGGRfL/wIiy6aCO1M7aZaRz/FlsHqbffOUyRee/WrVTtTzP3ymYbVQVJGW+6nE91AQtT7pzDdqecwuRdYkhLZ7enjqoUh6KOA/yg6Z0B+xpSzQK0QTv/XtQulzwTQpYeDLDQdH9rdbK6WphmB43SoZifogtrzARPXCFs9rSkXJJiCLWXWextfsbaanmAOR/YkNJT1roO1DstY/r7EqlS7BGZq2HLPccvr9tpph1TujBiGUPUiaouuJuzthJpb6cGeFhsNmDaQP/6FjTVmG3NB9pRXPE5gvqtWFItwdu3Y0iql+qIjkuxmuUY1spU5xTbFJOcgkai62KIkb9DucYISiJZntNDAT4aJ3RppaY3JkapurdwebGIwZvDB5NwFJhEVDjACB2hNgNp6uFgH/pC/MFAzbnc1GHAbe04CaqXIbguM5g==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(83380400001)(107886003)(26005)(8676002)(47076005)(70586007)(1076003)(82310400003)(70206006)(6666004)(54906003)(356005)(36756003)(508600001)(6916009)(36860700001)(2616005)(186003)(316002)(4326008)(5660300002)(2906002)(16526019)(336012)(7636003)(86362001)(8936002)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 17:56:08.7962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c20a24-3789-4ac1-1c44-08d998a9e41e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5551
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
