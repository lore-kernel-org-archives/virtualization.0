Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAA5C433EF
	for <virtualization@archiver.kernel.org>; Mon, 13 Jun 2022 19:52:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5AC4282BEB;
	Mon, 13 Jun 2022 19:52:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lNIHl64YY89b; Mon, 13 Jun 2022 19:52:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E53E182AED;
	Mon, 13 Jun 2022 19:52:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B56C3C0039;
	Mon, 13 Jun 2022 19:52:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8521BC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 19:52:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 60DA482BEB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 19:52:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m9VbggD-Msl5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 19:52:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::611])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E35E382AED
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 19:52:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRaX+GeEz5062Vnv3eMEN3dYhVg/f8ruubQ38bAXv4erZOoeDMF0S+XLCSw291kr7/oySSXfMNGMx3rnc1rAOPxufXaq9VE5ceg/eHAL1km69g66XR0enm84pNQ7Wi0+dG2yt+HttoC0+IX4EBIDY9vUBRJLtY2LFQQfuRejXPdiPs5+rxRiKllV5qEIsIN6DDLYMdVNWTLyGyfcc8CJiQ+TpzaDIW9u3N76m2K8z/O9pwPQPd3nJodPazDYpoPBN8YJ/UeTelgPE0CCBgTFaf4w5QQw7AG5qn5a9vTc4bj8etXOpadbY6biCFgJVyO6udIx3F0wn6Eekp7b+Dzy4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8VrmywJJzEuuppiHTGYksN5Fg2mQ10Rmcn9ZUNYn5g=;
 b=Z+MibA3iOIKx4S6NKCG1HurHNAwU7lkl/dcLtvrAybxty228RksUn4AO33+XZeP6PAR3vWvZEp4PDls/AXbTxXZmcUEIwRmbdRSuXA6v3z6WaHEGmORD+OiwDYlrwcDBFqW1WxGltTouni0Uqp6zsrbmijzbrWc7aJh/brF4EKi3YuXeNty8+NKe+FXJkrNnqp9+LjLtbbYURlUU0ZjkYiwcBreP28vLexg4/HV3zoyDEdr0fUFg4MlieP87buiFL8lZZ/OWtLBxTOzJsDtT2Gbw7WuBncFQeZPDIho0zrxWkFx5SlQBC/eKtE1dFNWGYNWcJSJwdv1B4TpUKzOmsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=bytedance.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8VrmywJJzEuuppiHTGYksN5Fg2mQ10Rmcn9ZUNYn5g=;
 b=ApZEhLzsGSw8NZBPo8Jy0yephKMkm/bGNOblPNdCltHW5t/GK9yyOnZNg0xP0q/jYQGOCrJmE6Nnkej3qNxKyTiko27OyH5QTc1K+rCLA9RxR1YHB103FcWkBF3oyijAul4QvSyQM3+qTegsX3vGNTDvLn293krVOlADr4IgkiM3ZBY4IlxZB03I7QZkZ3j4B9iuoW68vyLDoAUlwxOnhHP15hXfy1lw8lSWWfPRL0xGXfVX5BscBZAAwcyu8FkqA2bsr5bfXn+GM3Wm1tw28XImA7tMNp2sjfEulynC0NR4X5Kv3WW+mvbdeaZijx8k9FUqojFzQp1LB4dyjh3J5g==
Received: from MW4PR03CA0277.namprd03.prod.outlook.com (2603:10b6:303:b5::12)
 by DM5PR12MB1898.namprd12.prod.outlook.com (2603:10b6:3:10d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Mon, 13 Jun
 2022 19:52:37 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::34) by MW4PR03CA0277.outlook.office365.com
 (2603:10b6:303:b5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Mon, 13 Jun 2022 19:52:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 19:52:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Mon, 13 Jun 2022 19:52:36 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 13 Jun 2022 12:52:35 -0700
To: <virtualization@lists.linux-foundation.org>, <mst@redhat.com>,
 <jasowang@redhat.com>
Subject: [PATCH v1] vduse: Tie vduse mgmtdev and its device
Date: Mon, 13 Jun 2022 22:52:23 +0300
Message-ID: <20220613195223.473966-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0ef30d9-a373-4ba2-c61e-08da4d764408
X-MS-TrafficTypeDiagnostic: DM5PR12MB1898:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB18980320F0B1A3D3412DF9DADCAB9@DM5PR12MB1898.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Co4ldSrFKHrHv8a1Irjn6cWEuum7LBcQ2AEwIurh/Q+H5BYrNWkVxe00om0Onr3xeNejL24AW3wKUL6jIcekJ3hUG9bDMuNgXphr7xtFUPDredVyhSLwmjUHB8lXQjdko7l4vmuJyxOpZq/uwZFWSnIG7GTPKlClg8a0TN5hngrvoPfJ455+dOCNU7mW+VamPg1mb2FtCi7aoYjpOf5fjOJmmgCRuzWL5RjpEK1NmzUZZxMcUgG59YUTdVRuQB6sboReSFlv70TfnOta1Nd+2bEro4TLGl4ysEPyzFD1liCBPxWcN2LmWRIAU5f7rd1TM7GscjCnh4sIWFKvKNWAMOrb73L/OcAMyruEK8hG+Q0ihN4CkePQIKN6uEfc89juvlOFMwFodK2kzv+LUFGDBLvoTcU6yZ33oEVzdP8MqMs8XEhBKMzvfRr769A1Lx8bEbqKL0u4Tx5iPdq5Zib6mMYgWHXGZTxUfzw8cIYqX5AGaLd/V5uQJ0jIWr3OE/HK13YWPyGSZXRaCPVX2rmmAWd2/k6FWzkbxX5I3+MmH5xDmgcIqjcT5lFfvx93djnwmK1IUUrPXSyv99MBjW2rlezYEU+D6YoM7szphtAHHzT2MpKs02xXTnHxHsd0RSrRX6jkXhW+aJwiO296WG/pUVnA15cIn614A1gvc94BNGQcJnRfVw39jXp0D+RuhNdglYSh8BN1GE2BIpBiAEHb/BS5PXvMdwKtghubADaFm5TkrJNWQ9+t9pq+n1knxbJnYaFaVZSggoRwQN6aKOOYrsK3NUXS1DhXMl6PwTwLMys=
X-Forefront-Antispam-Report: CIP:12.22.5.234; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(54906003)(36756003)(356005)(110136005)(186003)(83380400001)(336012)(426003)(6666004)(107886003)(47076005)(82310400005)(81166007)(70586007)(36860700001)(8676002)(316002)(4326008)(70206006)(966005)(508600001)(8936002)(5660300002)(40460700003)(1076003)(2616005)(86362001)(2906002)(16526019)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 19:52:36.8314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ef30d9-a373-4ba2-c61e-08da4d764408
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.234];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1898
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
changelog:
v0->v1:
- removed typo in device name of "-la"
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 60 ++++++++++++++++++------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 776ad7496f53..3bc27de58f46 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1476,16 +1476,12 @@ static char *vduse_devnode(struct device *dev, umode_t *mode)
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
@@ -1510,7 +1506,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
 	}
 	set_dma_ops(&vdev->vdpa.dev, &vduse_dev_dma_ops);
 	vdev->vdpa.dma_dev = &vdev->vdpa.dev;
-	vdev->vdpa.mdev = &mgmt_dev;
+	vdev->vdpa.mdev = &vduse_mgmt->mgmt_dev;
 
 	return 0;
 }
@@ -1556,34 +1552,52 @@ static struct virtio_device_id id_table[] = {
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
+	ret = dev_set_name(&vduse_mgmt->dev, "vduse");
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
