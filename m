Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96836C433FE
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 16:35:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A2261502
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 16:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 55A2261502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3330340891;
	Thu, 21 Oct 2021 16:35:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5mMtwmZUh53m; Thu, 21 Oct 2021 16:35:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B434540856;
	Thu, 21 Oct 2021 16:35:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91ED1C003C;
	Thu, 21 Oct 2021 16:35:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A43DC0038
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C3A660F30
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FVT5fuNOhjCd
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::600])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D8E1260F26
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cgp8fB9/D1cbQnRKasB6s6+o65r962WRQWDrOrbaGfR9Ze5XaSV458r+EZPSfGcr73icfsi+DTj1s1z8QPgp8aIn1dcFyCcasMzRKxO0WwFpAtd8TB7W88rLJX7IkvCzveAPIv423vi6i8LaoVQVMfVWG+vLWS6tW8J68Z0E/gUP0apVf/2f6/A+SaOhbEZ47sIurDFeLhPRlVTu5ABN5TSKak55PNND/mI7GzawJ2Bew/7QfFt5N+xDc1CPnTzBtYmQN7zm57fAqtkPpYkWTlzmKw1TZl0/zwMJ6MaAncymfhHVmwnb10WVyhDZSsnP4Sp5EhMosJ3Y5p+KjTZdng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fue65fTjLzVOSPmAhfP/hi0E0hKOx/K/ZzwrErUEa28=;
 b=MNzHcZQqbPBesHyJ5RQXz12QfJ0o0qxv9q5RfHVKed9z24eqcPHzvvRdCLkEQ2dQZX1tCZ4Oddzu/A/kXctDE6ztDzkd6kb6Msj5jOnX3+Cgm6EW9NGB0eYvVOqE9pSSUP03mDfCnL9kj2YOxrLB1gAr/xviE43dZQQA/x6WROH2ld9DIwloi2e1ZUIz8eMIxt9GIlZb3G13o1D9Zmf9+T6mJdQ5j0fwndhOCucnORYlbHIFx6ZkHUB9lMmkgL82n8Ny+Jol9cvm8VL2/uXaxqs3f3FsiqfFXixLQi7avSug2lVffhNj26FmVC0WnVm8fgaCu3Z+xJXPpqaZiuLm5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fue65fTjLzVOSPmAhfP/hi0E0hKOx/K/ZzwrErUEa28=;
 b=g5wJO7/GX4w5vypuP0TvVzZfjg6FZ3P1dc8zdNYPZUfiNQLAgy59w5vq/stphLVFlzl5caHNCNHnA8Wi3OPw/jBSKCVPsIL8cPAVAfyotakrz6w82a1bRw7DY1GnHT1Zon02HURDuCDksZnzv6XI9cI2vv5x/37RzIcomujJ/uGFenxv8IAbU51N05qE1sdkk7QPP6oN8YZRtDoXyoZ3dIB8ljJOuZT2wh9qAx91AZ55iM7u7vqJwB1KtJvg3Uemp4T44j/gZTPd+bFCg4gKzFfa8W603rK3XIHSExXknQgEn2LBjwEPT2hSSytM7Qrxc0GXzjzD6cArQxyLTy3GGA==
Received: from CO2PR06CA0061.namprd06.prod.outlook.com (2603:10b6:104:3::19)
 by DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 16:35:38 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::cc) by CO2PR06CA0061.outlook.office365.com
 (2603:10b6:104:3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Thu, 21 Oct 2021 16:35:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 16:35:37 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Thu, 21 Oct 2021 16:35:26 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v4 7/8] vdpa/mlx5: Support configuration of MAC
Date: Thu, 21 Oct 2021 19:35:08 +0300
Message-ID: <20211021163509.6978-8-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211021163509.6978-1-parav@nvidia.com>
References: <20211021163509.6978-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5a62a30-fed2-47b8-627e-08d994b0d044
X-MS-TrafficTypeDiagnostic: DM6PR12MB4300:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4300D2A89A4B3C0D7FFCF6A8DCBF9@DM6PR12MB4300.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5WuIhgXnVIV5FDXFkX5D4Xtpz9CutVHGTJ1GCnbYWxuCiMaBgM9/Gila1DFkHGOeJWgwzkkSn5a0aq6m5ue2QhwmKcTwjIvR1fW0ygIJSPAtPG9TY+r67wsM6xRT2wdbRL+kvd3MNp99LD8w6tEfRkAgo1rWzt6GPXwbIjW++cdKibIvwlr4G/THxMRQyT2qvDabK1gLIajnqt0qVZfQxR9m67NiCvx48zYHADhFZTvsMdK2X3D2dZxN1/xWkmAy7cB6l7LK8vg8br/1Yk0K1EwB8W8ek0t0s6nYJ2rI0vgdVBk7TWwSbU8wcXLj8vfRpF4AUDOl8OVqwVuE8P/2sGNvqiWqaJPNZv9E4mAaMU13VJOCK0vEr+nIz8/NB6QwJpVTk9TFwFm7fGVgy+Rt/lwswHZIwqiIRW1qjn8KWsHqufFWIwXaFwrBpP2jk1nCInqakLrb3dtRahSmEf5Enyoi4cUAv8x34a0Qtmx1t2SGpQOST1GpMKjlRKldVZFnoyfeiri+tGiC4h9zXgKnl8teRN/XVQDD+7LHMte3UphMzAyHoi79YYXpLgvams+y4Kp7ve9+NloERDNJGyjVrBgrI8gtxXT2/v9bzTKDewbXWJ64nYVXfE2WDFetopt2Knexb9WJX/9U4g46ZBp/KsL76JQ4nl1r6rc3qKr5m4vVCXKIAYzsDLNlgVRLVbSwU0eCW7JpjkP8HI52qCyYtg==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36906005)(47076005)(4326008)(6916009)(336012)(107886003)(7636003)(426003)(186003)(2906002)(16526019)(316002)(508600001)(5660300002)(54906003)(1076003)(86362001)(26005)(8936002)(83380400001)(70206006)(36860700001)(70586007)(8676002)(6666004)(36756003)(2616005)(82310400003)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 16:35:37.3406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a62a30-fed2-47b8-627e-08d994b0d044
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4300
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
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 0a2b79887085..61f17ce0892e 100644
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
@@ -2444,9 +2445,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	if (err)
 		goto err_mtu;
 
-	err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
-	if (err)
-		goto err_mtu;
+	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
+		memcpy(ndev->config.mac, add_config->net.mac, ETH_ALEN);
+	} else {
+		err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
+		if (err)
+			goto err_mtu;
+	}
 
 	if (!is_zero_ether_addr(config->mac)) {
 		pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
@@ -2541,6 +2546,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
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
