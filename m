Return-Path: <SRS0=hGiF=JD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7153AC433B4
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330D561074
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330D561074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F8AB84A76;
	Tue,  6 Apr 2021 17:05:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4IEPJUFPK2nq; Tue,  6 Apr 2021 17:05:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7716F84A85;
	Tue,  6 Apr 2021 17:05:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E479C000C;
	Tue,  6 Apr 2021 17:05:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1087C000F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C36BF60B96
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iwEge5Gf9Bui
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::631])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D978B6005E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHjb3BdWBB81U/KCuw3WH1S2Oj49cnXrqJxxiRN82hMRctQPEto2PJSpNeLVZBzWW8PcQdKkr5kJkXf5Aezon+qGMQKGgdF7a21+qsOlg2BT+CipWN/cQUuis4sx+xLxOMsQMkA4VDbvUtY2er4rneu/JGhqaqeBiwlPWs5IQTh+At0EdNXGcb2CZi41Tguh47xEHf9JQ0a/WMewjxS33mexyK6HvTUMHX6QFaLHoTcMIHM8rSCsgcjS3YkdDti56HzCQQdmIapMEdxfY6CWDMNyQPKXiNErD4uDI9NmDyZcza4N9fiED/P4iQC68GVwQOOYSJJS3nUPUNGBd3i+9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpJbCdu76hTxTF3aCGWg7iw7qf1wlaQjrgz0bjHjRSY=;
 b=V9xVtJ8ETUN29xG1dvlfQLLxIeXImcl5sWGYDeEB+bfQQBNWi2IAgqeCK8mMzG+SrelSBpWxC+vq4nWP7Eb1PY0wgGoOqO3EguxC6y8NRLbYd0jILvY1oNZECAiYSZE3K8gRyWFwG2GYi7LJggI9DM+OfJUHiITpL8ZoBVPBAKo4MfOJvFsglf58zopFA4/7kyHeTSRuG7iedzsS8WSGoK8jUhys4n6GLgA08tPVCyA3IUICFabfNT4WXgMg0u0t//1EC+fgeb5MEgw74hTaATQ3iP4I+JVCA2eVvhdU1Bi8voVHsMjqKlDu2ymchb2X8ftgPjoablmcl6ax8GteOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpJbCdu76hTxTF3aCGWg7iw7qf1wlaQjrgz0bjHjRSY=;
 b=bryxB8pRSW9YkiT95t0CIyW4fHeUpmgLx2izKCFgvWMAp62iZx5uJUxWUpbgp0/6d4VL+DIdzu+fpe38am3L28RQjsdgQLTSCL8WAzVpz6j1LXDT6ZFApcRSY4XDKpTKOU5gJVm8tuYu2lcjDPeghaa9NqkTDGl4BDqkOZjjFDdo58dKqkoi144moy1bYqvafDuz73wqWHxVU/cxeR9g5LwW5PFMW2CzcrvsgJ7kgjHnv2Z0eQdqbBzHLkR7Y/QUu7Dym7GoSyMYQDEpQ2Hv+9M2o3dzn4AEDKmbb4p2nvQjXGsMrSVeX392jQ3iwXjVIDOyCOhMcqeWbyV4wuw9Ow==
Received: from MWHPR19CA0067.namprd19.prod.outlook.com (2603:10b6:300:94::29)
 by DM5PR1201MB0154.namprd12.prod.outlook.com (2603:10b6:4:58::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 17:05:21 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::92) by MWHPR19CA0067.outlook.office365.com
 (2603:10b6:300:94::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Tue, 6 Apr 2021 17:05:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 17:05:21 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 6 Apr 2021 17:05:19 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v2 10/14] vdpa/mlx5: Support configuration of MAC
Date: Tue, 6 Apr 2021 20:04:53 +0300
Message-ID: <20210406170457.98481-11-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210406170457.98481-1-parav@nvidia.com>
References: <20210406170457.98481-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 076aeeea-9d40-479d-32d3-08d8f91e29b2
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0154:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0154AED4354CA0BB42AC4FF2DC769@DM5PR1201MB0154.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qpe9AqVisvF1xjx4HQiwjnBn9O9XzutPMP1KnHs90JHf52s66iuNvftmjo/ztnpJXYX16YPYV9PzcfJW0pvubRdU1fN9UBzMujOSnytXkYZlOfpIP/CeE8zyGiJeR8dHmgBPoqfvVdZFUZG1kn6Lg80OnhnjFsWO3kvk+7Ad5LBRIFzRep/Be9j/9j48YXcl6TQrMj0ErA0UGfOpLxQH2X1EfIpXqlEtCLUvawkHa9VV8plOZamxIGFWUXeeIQEjhoRxoue5pNMzkjIhuBREmS/dXw32BVCYf6lwUSX5ZCLULvkJldFA02EjKnPSWNgbOSPT7KRneNHzyayBGIn3zxOal7DTIBEbi+Y5PsWGHPPBuudRPeSSaxQp9gfBhoIWuB2OXteBgWHrLetaXnOTIxf9tSDmm9GMZdJjnHJPQSsy5KlTWorXdAsvRm1Pzyxp+UGi1Dq3Fkt8EGr95d9KskWRgOny5D8DiJE5scW1r7B8bBJBYET3qdNax9jsDj2eVsk4nrcbBtUhShdzX2zuz8noQjxtzQDUiK9E8tguV5ll8S7jjgP6/DAD11yhAC0YrgSypo5jUtbPJKManwTGknYdm5eUWJJebSJPvCNHqHCi1wNNBgRXoU6rYErSfxbiJMr1cnMoSq0AagZqXYvIv3ht9Lv3Ktc99BuQNxheZ0w=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(36840700001)(46966006)(82740400003)(2616005)(7636003)(70586007)(1076003)(70206006)(83380400001)(6666004)(82310400003)(356005)(8936002)(8676002)(36756003)(5660300002)(2906002)(86362001)(36860700001)(426003)(16526019)(186003)(26005)(4326008)(36906005)(316002)(478600001)(107886003)(54906003)(47076005)(6916009)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 17:05:21.5645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 076aeeea-9d40-479d-32d3-08d8f91e29b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0154
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
v1->v2:
 - following new api for config get/set for mgmt tool
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 45 ++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index aaf7f9394af0..949084aac102 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1493,7 +1493,8 @@ static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
 	ndev->mvdev.mlx_features = mlx_to_vritio_features(dev_features);
 	if (MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, virtio_version_1_0))
 		ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_F_VERSION_1);
-	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_F_ACCESS_PLATFORM);
+	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_F_ACCESS_PLATFORM) |
+				     BIT_ULL(VIRTIO_NET_F_MAC);
 	print_features(mvdev, ndev->mvdev.mlx_features, false);
 	return ndev->mvdev.mlx_features;
 }
@@ -1562,6 +1563,11 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
 	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
 }
 
+static inline u16 mlx5vdpa16_to_cpu(struct mlx5_vdpa_dev *mvdev, __virtio16 val)
+{
+	return __virtio16_to_cpu(mlx5_vdpa_is_little_endian(mvdev), val);
+}
+
 static int mlx5_vdpa_set_features(struct vdpa_device *vdev, u64 features)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
@@ -1880,6 +1886,41 @@ static int mlx5_get_vq_irq(struct vdpa_device *vdv, u16 idx)
 	return -EOPNOTSUPP;
 }
 
+static int mlx5_vdpa_set_ce_config(struct vdpa_device *vdev,
+				   const struct vdpa_dev_set_config *config)
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
+static void mlx5_vdpa_get_ce_config(struct vdpa_device *vdev,
+				    struct vdpa_dev_config *config)
+{
+	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
+	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
+
+	memcpy(config->net.mac, ndev->config.mac, ETH_ALEN);
+	config->net.mtu = mlx5vdpa16_to_cpu(mvdev, ndev->config.mtu);
+	config->net.status = VIRTIO_NET_S_LINK_UP;
+}
+
 static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.set_vq_address = mlx5_vdpa_set_vq_address,
 	.set_vq_num = mlx5_vdpa_set_vq_num,
@@ -1902,6 +1943,8 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.set_status = mlx5_vdpa_set_status,
 	.get_config = mlx5_vdpa_get_config,
 	.set_config = mlx5_vdpa_set_config,
+	.get_ce_config = mlx5_vdpa_get_ce_config,
+	.set_ce_config = mlx5_vdpa_set_ce_config,
 	.get_generation = mlx5_vdpa_get_generation,
 	.set_map = mlx5_vdpa_set_map,
 	.free = mlx5_vdpa_free,
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
