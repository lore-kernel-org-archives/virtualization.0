Return-Path: <SRS0=d+i8=LK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2416C48BE8
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 19:12:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98BDD613BD
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 19:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BDD613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72F1A60B6F;
	Wed, 16 Jun 2021 19:12:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LPd_Xbeu05WZ; Wed, 16 Jun 2021 19:12:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 24F6060BC0;
	Wed, 16 Jun 2021 19:12:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F1E1C0025;
	Wed, 16 Jun 2021 19:12:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FDDFC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7E18260BD6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FuM83NV2_2T3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6714760A54
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EML4uogtXBj8sEjb4mTPm/F+YnZyjcQXSWe1C/jrWBK61ROM/NxcK7OeQ8TJ0pItS3zctSh1+gRq4aOZd088g8SIulpBM+Q7WdKSj/pjnf9XHb9pYm+kGx4WucRSY/Sjmxf/KtX9NzQGJsGOT922hN9D1cB2+wxluCiXUu3OQDljj8TOz7bvUdyH1RbDZkbOaQLARzmJqJvb1YXmBvgjW/oObu5eM00DK8TABA/rOb8Y1vyU8o+9Hj/7cufO9fjc1djQ46tEpFgF4V21ugh7rHb+YpQTXtF7ozQ/RDS1jWnIUOtoNCD3LslBS0xcVRh2yi3SlxmKZat+CSFevpbuIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2M7kTVNlQegLoek0+yy0GD9t3WsbYZ/e7r5BUILGtM=;
 b=E4ycFkuS/qYoaAShO10AVcpMRuUbbVWeGivXGnzJJ5I7WQ0kywWi9oFCL1ukBfr/J9QaSxh4srG9fhE92P0s9MEV4BSnGnwI+A0nu0m6gBwoGb8Cte2cnMZO7+fq9Rg8oCFYnZ9618VHZujvInmfx+HD5CguWitHTnasO1h3QRCQZiQp9zSS5M/BgtOQm5mdLCWdtnJ42FWAQuZmlmtQ4+Toman5yrjvSDsR3Gpw0wLRQyX56r0hJaa2Lt6tX8gqZdYGXQE8XxAA9PcWa+o3JE/bcx+uZD+cQ7mfiKVhpBr9jJbjuedljdrF7DpNLD17Z1+wqOerQGlcaGHMUHeWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2M7kTVNlQegLoek0+yy0GD9t3WsbYZ/e7r5BUILGtM=;
 b=MjL9tizKEwMMocomcmc9i8AtGbHAM80shyV3fzoXF8Crcw8ffleG6O6//xndCxJo13j9olzN7QFe81XnkZnCtjjOJDoDWJyhT5hB3rk9hkGlcO0ChVH0Z/0WLNhJpLxSDmTULz8vAx1q7ix5ZzfooTo7ZtLKC3pEe1XnShgv2R6T4n3tEDMiMnSAurjWhaOlKHW65HwwR8X9cLQ5v4T48V998y2RM5NPuxPLD2Jezh5ae095wLGpW5NclklssQQoRS2tR7idAWr41exQlgHpsVLFey71VqTbFRDJ1sthRl1rY8lMAFoG3+NrMxLJL1ko82b6Q6Mo0lzzURXGwyWiHw==
Received: from MWHPR22CA0057.namprd22.prod.outlook.com (2603:10b6:300:12a::19)
 by CY4PR1201MB0055.namprd12.prod.outlook.com (2603:10b6:910:1b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Wed, 16 Jun
 2021 19:12:19 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::80) by MWHPR22CA0057.outlook.office365.com
 (2603:10b6:300:12a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Wed, 16 Jun 2021 19:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 19:12:19 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 16 Jun 2021 19:12:15 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v3 5/6] vdpa/mlx5: Support configuration of MAC
Date: Wed, 16 Jun 2021 22:11:54 +0300
Message-ID: <20210616191155.102303-6-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210616191155.102303-1-parav@nvidia.com>
References: <20210616191155.102303-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eefd6e77-72d5-44ce-aabc-08d930faa9ac
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0055:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0055D0E1CF65256C7C97FABDDC0F9@CY4PR1201MB0055.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zFyrkUXCik2cjCkg6+faL1norvVDxlyh6jZpBNobhA+vLygpBPyfs9LSUiwhBaykmyeFm4p5Hy8DCLx8dNVXNs73SGbCo9zRA+y4cyRwXv54i5txd9bUfV1nr0NhkHLkA80DCRFT0p8LoGBAaISnE4iM5OXuMAUHTNK7E2hyIfgm01LgZLqMKiGCw2qtRDwgvKdY+RCslbRgf1eh5G/632E/poSCa9uv6qIvUrC8BvHZQ9ooGVljvC353p6PwY4HOLFh2oFdCefgPtQEzAwYfalMwCBUnKXGsjS51J6a+Je9TfrVPfFqhC2ym4qpzmNZWmcyF4jzU/Aktkw2ARTKzZ33T11/yjQCgPafvFTbHrgPWspD9Vm4Kqs7oKoFZ+NKB0GRhytQhfBxOyag0/bhSokAR+66yR+HAXIZ47F1c6w5MM0T4EvLNGo+yK2Tjd6TBzd4mdQlRzDiawxmC2xTcsm8o88BLvf8cm1vXygLyGP9LLljmrUDn7+kM7AT3Riv39DBmiOZE7g72i0jWGYCWdu8TIg4Ril6haY9NP7T3TQb3zXa9gr3tVl2A22NziJ/xZU1Lqm1wK4bNCD18XfJ1nAMOYxxVFRIE6FZa/ftdgU1+FtaoDO81R5J2Aw2TjDIVf9xiMQOr8Slp7V0ICOlUHJKOiFWDSALMGH6McaVN40=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(36840700001)(46966006)(1076003)(54906003)(107886003)(26005)(8676002)(336012)(16526019)(82740400003)(2616005)(47076005)(356005)(5660300002)(4326008)(316002)(36906005)(70206006)(36860700001)(186003)(478600001)(70586007)(6916009)(7636003)(2906002)(8936002)(426003)(82310400003)(6666004)(86362001)(83380400001)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 19:12:19.5189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eefd6e77-72d5-44ce-aabc-08d930faa9ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0055
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Eli Cohen <elic@nvidia.com>

Add code to accept MAC configuration through vdpa tool. The MAC is
written into the config struct and later can be retrieved through
get_config().

Examples:
1. Configure MAC:
$ vdpa dev config set vdpa0 mac 00:11:22:33:44:55

2. Show configured params:
$ vdpa dev config show
vdpa0: mac 00:11:22:33:44:55 link down link_announce false mtu 0 speed 0 duplex 0

Signed-off-by: Eli Cohen <elic@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v2->v3:
 - following new api for config space setup for mgmt tool
v1->v2:
 - following new api for config get/set for mgmt tool
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index dda5dc6f7737..7f3d09f201fc 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1831,6 +1831,30 @@ static void mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned int offset,
 	/* not supported */
 }
 
+static int mlx5_vdpa_setup_config(struct vdpa_device *vdev,
+				  const struct vdpa_dev_set_config *config)
+{
+	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
+	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
+	int err = 0;
+
+	mutex_lock(&ndev->reslock);
+	if (ndev->setup)
+		err = -EBUSY;
+	mutex_unlock(&ndev->reslock);
+
+	if (err)
+		return err;
+
+	if (config->net_mask.mtu_valid)
+		return -EOPNOTSUPP;
+
+	if (config->net_mask.mac_valid)
+		memcpy(ndev->config.mac, config->net.mac, ETH_ALEN);
+
+	return 0;
+}
+
 static u32 mlx5_vdpa_get_generation(struct vdpa_device *vdev)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
@@ -1909,6 +1933,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.get_config_size = mlx5_vdpa_get_config_size,
 	.get_config = mlx5_vdpa_get_config,
 	.set_config = mlx5_vdpa_set_config,
+	.setup_config = mlx5_vdpa_setup_config,
 	.get_generation = mlx5_vdpa_get_generation,
 	.set_map = mlx5_vdpa_set_map,
 	.free = mlx5_vdpa_free,
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
