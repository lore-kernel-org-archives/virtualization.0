Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050F1C43334
	for <virtualization@archiver.kernel.org>; Sun, 12 Jun 2022 18:02:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85E5541797;
	Sun, 12 Jun 2022 18:02:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2rTn0t4SB_FV; Sun, 12 Jun 2022 18:02:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D68E2417A7;
	Sun, 12 Jun 2022 18:02:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7D19C0039;
	Sun, 12 Jun 2022 18:02:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 319A9C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Jun 2022 18:02:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 18A0B83E03
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Jun 2022 18:02:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bJMXcI5ZV0d5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Jun 2022 18:02:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::619])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A93F28329D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Jun 2022 18:02:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCJ9a+GwWxEMqh+rTSfStom4KNI9viVW4+Zym2QZLlJ6hstgjeidUw4cScqWVW8HBRFP4uXBNjPnbpwugjKaVrQycMFOUEdviOP4MQCT0Fmy1DHTPS9IDFc1tSDwIX/nrmOe/+gW9FSFRJI4lbLK/CtX9PLc7ukaSBH5z78Cx/LPfdOY0jnOoJN5WqP10IKd41AymCfrygForFb43lAWJvONWZY8kNxvgah0shj+318MgvK5/0ElPXka/Rvni1Nv+AgiwXyJTX1bQNvcFvT3mRUfbMp+2y6h29kUs8WZN/UY35f0ksVWz868qoYvRUC94Q6HQ22Wjf7v8pkk/AqA8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grqvNznNv+2WGJmi4q2wCXJRN77Iez7ewfUaf6YfrPI=;
 b=JXZbG5QzNt6lo1CDWeJLNDtC8Vp8GzOdnqarh6aye/ljM/qfqNcwuQ2Xf8jSWrkbzFJSvYRTymQtwUvZ6vVNkTYiFEY83iPfo5C01ji5XGp6v3kJdXbb+KQhBdvuoV8cUsh/HwY8eAYM61yIf/ZNWdioE7pv1Re+KDLg39UfZTT827pon288jlY0PvuGTr8CGUX8C1KlsZLW2mtTRICmUV9nLXD5hLKTQE1i5r0yE6UjZ3OWIYocH7JbryZ8CXPM9r56bCEOjizuIk3BI3pFP+nuiB7ss5XMfTmngVvT2wGMWZLCTH85dxmTcujcDDCptkscYzWRu61A45rufvZCQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=bytedance.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grqvNznNv+2WGJmi4q2wCXJRN77Iez7ewfUaf6YfrPI=;
 b=rXBM+QI7JUdwahBSAJLS0JdicqFycicr/QhtOLZMdbmdthhqPnVAhFI4QSM8Gjn9aLGbtuYjS6rni4XzaKPBkflQ6U0Ue0+6zLmxU2kEdSGWVjxsWCckq6pTFobUHXXXp2Sgk70aW0kXDrnxJf33k+ksVhVLq2rX554jCFvs8n2a857RIGh8ANa84UsudEuuv9MGrDLBu45mEGUAC8Sh8gyk/5Ef8yXABQQszcsnERVg9FA3X4I3U3pwKjivKTqG4CLf/k+IzaurJMjJ5Cyg6f//jy+Q/JeheLkg+H7ZHHs3DYdBFjjV6Yod2zhx/rJ0OBwYsZ0HG84N2Fm6sLJfGg==
Received: from BN8PR04CA0032.namprd04.prod.outlook.com (2603:10b6:408:70::45)
 by BY5PR12MB5016.namprd12.prod.outlook.com (2603:10b6:a03:1c5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Sun, 12 Jun
 2022 18:02:23 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::cc) by BN8PR04CA0032.outlook.office365.com
 (2603:10b6:408:70::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15 via Frontend
 Transport; Sun, 12 Jun 2022 18:02:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5332.12 via Frontend Transport; Sun, 12 Jun 2022 18:02:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Sun, 12 Jun 2022 18:02:22 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 12 Jun 2022 11:02:21 -0700
To: <virtualization@lists.linux-foundation.org>, <mst@redhat.com>,
 <jasowang@redhat.com>
Subject: [PATCH] vduse: Tie vduse mgmtdev and its device
Date: Sun, 12 Jun 2022 21:01:58 +0300
Message-ID: <20220612180158.462192-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0bf5c07-2ca7-49e8-83e4-08da4c9db39b
X-MS-TrafficTypeDiagnostic: BY5PR12MB5016:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB501618011B61C41AE7177AB9DCA89@BY5PR12MB5016.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 36tDYMv7J7StkhYk/n+G4GIidxnJayby+R31hCg8jZ/+Q0qf45QE+b36znTfYv4VV64UThhoBgtLDNhHKmkH2nteFGuZxPpr3w0o//fNt5DINhgXnLsq7OGFzEMIbT0QEfBH6ems9otQ/MY/U65mV/o2zFulpLAhpVGCI7FuI5cu//7viM52t7Bjx722Fs5fCcJwr2FQFkUTDw9VnUyo6dLYDRmmlugUMrTzkULJ3kwf1jha9SDnaRwIkYYvPMx+EhXOe/8Uh7zGvWXj/eU0q2T7L4tynF2dCDnSZZwFAFgfpjEpTkIpwq/brkIC0L7sq/5SZm6fXSKi/0IUU/1PfgEIpYT9X/h7jjpJeQKLxxX2PsgVx4WGPFgmzgKpE5WMB77tbxmR+OV7SjF1VVeEWngKjc+yjpIyYwgHk0wHsKyvbsSc6JKm5WDSB0Uz1fKRTjVViEL31ubcH/1/DbYgH3l/nFHgJR7C3FmzuhznKlaSasValbCZDM2gQfmuZzSYj/TPbRT8iUhKtp386Ty1zpatsmqtkqnMm4rXZKD5wda20cMI+KZ6WS0xdcjP8dAiHwkCbwN376cWGJsbI7JdsE2YDtSbZPlOlhS1CnayEDXMY65Kz7FbYgvCowdn3/WnM6s8wlYA+mfLxMKccJMX0i5xMXERyRaDi2FSgOQ02ADdAfs610uYw75v1sitS5Nllpnajn4wYMuFufoj9DKUq5DtWfQlZ4sWAdx2awHPQ0/XYxgJE2IdJ7ViuOqvFLi1tEahbQrMvK9ROt3ev3UldILHLTGtJNpUUvBtknfhxkM=
X-Forefront-Antispam-Report: CIP:12.22.5.234; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(1076003)(426003)(47076005)(336012)(40460700003)(16526019)(186003)(81166007)(83380400001)(82310400005)(356005)(36860700001)(6666004)(86362001)(8676002)(26005)(110136005)(54906003)(316002)(70586007)(966005)(508600001)(70206006)(2616005)(2906002)(107886003)(4326008)(5660300002)(8936002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2022 18:02:23.1361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0bf5c07-2ca7-49e8-83e4-08da4c9db39b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.234];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5016
Cc: xieyongji@bytedance.com, lingshan.zhu@intel.com
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

vduse devices are not backed by any real devices such as PCI. Hence it
doesn't have any parent device linked to it.

Kernel driver model in [1] suggests to avoid an empty device
release callback.

Hence tie the mgmtdevice object's life cycle to an allocate dummy struct
device instead of static one.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/core-api/kobject.rst?h=v5.18-rc7#n284

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 60 ++++++++++++++++++------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index f85d1a08ed87..ebe272575fb8 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1475,16 +1475,12 @@ static char *vduse_devnode(struct device *dev, umode_t *mode)
 	return kasprintf(GFP_KERNEL, "vduse/%s", dev_name(dev));
 }
 
-static void vduse_mgmtdev_release(struct device *dev)
-{
-}
-
-static struct device vduse_mgmtdev = {
-	.init_name = "vduse",
-	.release = vduse_mgmtdev_release,
+struct vduse_mgmt_dev {
+	struct vdpa_mgmt_dev mgmt_dev;
+	struct device dev;
 };
 
-static struct vdpa_mgmt_dev mgmt_dev;
+static struct vduse_mgmt_dev *vduse_mgmt;
 
 static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
 {
@@ -1509,7 +1505,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
 	}
 	set_dma_ops(&vdev->vdpa.dev, &vduse_dev_dma_ops);
 	vdev->vdpa.dma_dev = &vdev->vdpa.dev;
-	vdev->vdpa.mdev = &mgmt_dev;
+	vdev->vdpa.mdev = &vduse_mgmt->mgmt_dev;
 
 	return 0;
 }
@@ -1555,34 +1551,52 @@ static struct virtio_device_id id_table[] = {
 	{ 0 },
 };
 
-static struct vdpa_mgmt_dev mgmt_dev = {
-	.device = &vduse_mgmtdev,
-	.id_table = id_table,
-	.ops = &vdpa_dev_mgmtdev_ops,
-};
+static void vduse_mgmtdev_release(struct device *dev)
+{
+	struct vduse_mgmt_dev *mgmt_dev;
+
+	mgmt_dev = container_of(dev, struct vduse_mgmt_dev, dev);
+	kfree(mgmt_dev);
+}
 
 static int vduse_mgmtdev_init(void)
 {
 	int ret;
 
-	ret = device_register(&vduse_mgmtdev);
-	if (ret)
+	vduse_mgmt = kzalloc(sizeof(*vduse_mgmt), GFP_KERNEL);
+	if (!vduse_mgmt)
+		return -ENOMEM;
+
+	ret = dev_set_name(&vduse_mgmt->dev, "vduse-la");
+	if (ret) {
+		kfree(vduse_mgmt);
 		return ret;
+	}
 
-	ret = vdpa_mgmtdev_register(&mgmt_dev);
+	vduse_mgmt->dev.release = vduse_mgmtdev_release;
+
+	ret = device_register(&vduse_mgmt->dev);
 	if (ret)
-		goto err;
+		goto dev_reg_err;
 
-	return 0;
-err:
-	device_unregister(&vduse_mgmtdev);
+	vduse_mgmt->mgmt_dev.id_table = id_table;
+	vduse_mgmt->mgmt_dev.ops = &vdpa_dev_mgmtdev_ops;
+	vduse_mgmt->mgmt_dev.device = &vduse_mgmt->dev;
+	ret = vdpa_mgmtdev_register(&vduse_mgmt->mgmt_dev);
+	if (ret)
+		device_unregister(&vduse_mgmt->dev);
+
+	return ret;
+
+dev_reg_err:
+	put_device(&vduse_mgmt->dev);
 	return ret;
 }
 
 static void vduse_mgmtdev_exit(void)
 {
-	vdpa_mgmtdev_unregister(&mgmt_dev);
-	device_unregister(&vduse_mgmtdev);
+	vdpa_mgmtdev_unregister(&vduse_mgmt->mgmt_dev);
+	device_unregister(&vduse_mgmt->dev);
 }
 
 static int vduse_init(void)
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
