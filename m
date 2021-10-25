Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA99C433FE
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 12:53:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A35660F02
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 12:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4A35660F02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 197674037F;
	Mon, 25 Oct 2021 12:53:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jtMwxcOAEgBz; Mon, 25 Oct 2021 12:53:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3F5CC402A2;
	Mon, 25 Oct 2021 12:53:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4D8CC0019;
	Mon, 25 Oct 2021 12:53:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 002A0C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E2DFA60780
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LuS8nN9RB_W9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::61f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 09C5360766
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWrfGbSpq6aTdb+se8XZ8nY63WiX9DKo69aj/9Otyqake8e2aHtI3lVnQtnJqYed9HNv7roSWJupKeKP3t5yTdQEICtx2aieEPCe0Ah93R/X6mMlNnfhzZ1Ag8KvlgboG2lAOZYkCG/xFFBhBDPzETVBYNJjHu0NPwqIeUc9bETvnBL8YnNyhOejRPiNZssNGlKQqrrunI5JmZtMJVCLNugRmBLV0juEYlxvG5PkoOjz5gF84TFh8LW2jZtPQ0aq49ViVho8ma1vQFtlS5O3SIFi6xM+msbSSDkk9BIHLjyK4WpixiTrcg2q010QgxthDFC/Amf0GEbZ24woBfIBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IJrf2OOjwc3wbG62Ljq/M34aHCijWH2VusBGnPtE8c=;
 b=I1auXUBFVxCQMnaWIPPcxJbHT1qY8bvfHWN/xJF00dfUIETVlrSaVsGETKYsvpQ3P1ZWHqxsvgVxlZoEJvF3w7SItnITVzoWVhEGhWT4Z6jFE/inVCn5M15nKI7883Uol/Z8302DZDuprVh/OoiXrrTfAE499G3W9iBU/Ew+1VGK/LZWoCGELeS9t1AvlrnLX6sAjHt22MYjlZVXex8PX5+iLwrl5cSFadeM4A0dU9XB1CsJCjRTKFstF/XAQPXsGyxWQN7/i27u1q8I1oBd0CS8+d1j1YR5IDGTFgH3LpAllVVeNl/iIWPIV37+iCfP5UYjWm+C5Q+vVtWqSXSf9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IJrf2OOjwc3wbG62Ljq/M34aHCijWH2VusBGnPtE8c=;
 b=TAXr0PThTP+OQV68T/A+H9VuramamnSmdXmdKnvFjBXSGqGOXOgfeO42x7SZ2uaSlJjIXs7BVxOQgu8/fqojKQumrDtqihTHz6PyL5H/6LCL2Kk39pwaCJnk3JkofiwjOT77BFqhPJc6HUFqKwZx9At/pqL9DN/VaQBExzKIFy9pU4c9Hf80Of3WjdYtEiN4qruhiwINjllNy5zBY4rkDelhHMwl1l9hjzW+YPmbrPKk7l9thQ4ROpz8/lk6bIYAwXLhDNFlkn4y8einO7IKhNACnuxmpzIWjXV6VIezYkeMLucY62/sGmjQu+5AWUJAvtKkd6N4ljFPbDMpFuEoSg==
Received: from MWHPR1701CA0012.namprd17.prod.outlook.com
 (2603:10b6:301:14::22) by DM6PR12MB3979.namprd12.prod.outlook.com
 (2603:10b6:5:1cd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 12:53:32 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::49) by MWHPR1701CA0012.outlook.office365.com
 (2603:10b6:301:14::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Mon, 25 Oct 2021 12:53:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 12:53:32 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Mon, 25 Oct 2021 12:53:30 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v5 1/8] vdpa: Introduce and use vdpa device get,
 set config helpers
Date: Mon, 25 Oct 2021 15:53:09 +0300
Message-ID: <20211025125316.67664-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211025125316.67664-1-parav@nvidia.com>
References: <20211025125316.67664-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67554a31-6fef-4992-fee1-08d997b67338
X-MS-TrafficTypeDiagnostic: DM6PR12MB3979:
X-Microsoft-Antispam-PRVS: <DM6PR12MB39798F5DE725D87A8EB3E6C8DC839@DM6PR12MB3979.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iLbgytyJWLO24bkArXuPKzmTxEDO8oHhpepFegev2j9vXryYcm3k0T72h21HJ6n16By41ZqATfrTR0iHYFhhJZkfxcCAoiXo02GMlscB79PaCd6KMs+DokjfHaTb5fsF8So+/LXBbqsfxqtiq63N0CKisKT155mhyyssNOyzUFCooclGRZbZr6Z36GY4UNXJgul9jLTnV+cjYQODKPtE8tSmqGH0FRXEMAIU02PrnwRHtv05r7uBm7mE5LMGAgJzUh0R68vdRWP3kyhoWU9R+m4/R1R3NxsUMixCeP2Kb1bx3I8XixfCRPoP2xaFnRvf0jKphaaryPyySL55xqkRfEG1uxmRASIilmxu+FkZ95nbmmx2Kyjclw9PwRe14DY6Wm+OFIS3B7FKhhEjYMcdruO/Syb4w/I4VoVxS++D2eWA6uGEdUiZmJ2jVB5BoGTPO5HX1qKLSXSMk16QLmS6bGbSEV17ymV4ad14w2xngMvmo03pobn6cskf3ZSfYJ6fboOq8kLcZF/KeDaqw0TlRLcAL01aSrdrc1x11x6ooaURWfo9vQIpFQu5rMWSGtRuffnmSul9JUBuHhCa4E6KKQWiX3V5r0E0kNfC10P8HGCuocjjY/a1gZmQUWAHoW7y8UZLlPEwAkOSphfJMMluGRlVE69E/gcJqF6lIiSS94DBMEXFwstFSzmaz2OUKYRVweVMvkyXYfs7dLKe7XWjyQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2616005)(426003)(4326008)(70586007)(26005)(8936002)(86362001)(70206006)(16526019)(36860700001)(8676002)(6666004)(5660300002)(336012)(6916009)(356005)(47076005)(107886003)(316002)(36756003)(1076003)(83380400001)(508600001)(2906002)(82310400003)(54906003)(7636003)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 12:53:32.1243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67554a31-6fef-4992-fee1-08d997b67338
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3979
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

Subsequent patches enable get and set configuration either
via management device or via vdpa device' config ops.

This requires synchronization between multiple callers to get and set
config callbacks. Features setting also influence the layout of the
configuration fields endianness.

To avoid exposing synchronization primitives to callers, introduce
helper for setting the configuration and use it.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
changelog:
v4->v5:
 - use vdpa_set_config() API in virtio_vdpa driver
---
 drivers/vdpa/vdpa.c          | 36 ++++++++++++++++++++++++++++++++++++
 drivers/vhost/vdpa.c         |  3 +--
 drivers/virtio/virtio_vdpa.c |  3 +--
 include/linux/vdpa.h         | 19 ++++---------------
 4 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 4aeb1458b924..d42697699366 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -297,6 +297,42 @@ void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev)
 }
 EXPORT_SYMBOL_GPL(vdpa_mgmtdev_unregister);
 
+/**
+ * vdpa_get_config - Get one or more device configuration fields.
+ * @vdev: vdpa device to operate on
+ * @offset: starting byte offset of the field
+ * @buf: buffer pointer to read to
+ * @len: length of the configuration fields in bytes
+ */
+void vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
+		     void *buf, unsigned int len)
+{
+	const struct vdpa_config_ops *ops = vdev->config;
+
+	/*
+	 * Config accesses aren't supposed to trigger before features are set.
+	 * If it does happen we assume a legacy guest.
+	 */
+	if (!vdev->features_valid)
+		vdpa_set_features(vdev, 0);
+	ops->get_config(vdev, offset, buf, len);
+}
+EXPORT_SYMBOL_GPL(vdpa_get_config);
+
+/**
+ * vdpa_set_config - Set one or more device configuration fields.
+ * @vdev: vdpa device to operate on
+ * @offset: starting byte offset of the field
+ * @buf: buffer pointer to read from
+ * @length: length of the configuration fields in bytes
+ */
+void vdpa_set_config(struct vdpa_device *vdev, unsigned int offset,
+		     const void *buf, unsigned int length)
+{
+	vdev->config->set_config(vdev, offset, buf, length);
+}
+EXPORT_SYMBOL_GPL(vdpa_set_config);
+
 static bool mgmtdev_handle_match(const struct vdpa_mgmt_dev *mdev,
 				 const char *busname, const char *devname)
 {
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 39039e046117..01c59ce7e250 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -237,7 +237,6 @@ static long vhost_vdpa_set_config(struct vhost_vdpa *v,
 				  struct vhost_vdpa_config __user *c)
 {
 	struct vdpa_device *vdpa = v->vdpa;
-	const struct vdpa_config_ops *ops = vdpa->config;
 	struct vhost_vdpa_config config;
 	unsigned long size = offsetof(struct vhost_vdpa_config, buf);
 	u8 *buf;
@@ -251,7 +250,7 @@ static long vhost_vdpa_set_config(struct vhost_vdpa *v,
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
-	ops->set_config(vdpa, config.off, buf, config.len);
+	vdpa_set_config(vdpa, config.off, buf, config.len);
 
 	kvfree(buf);
 	return 0;
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index e42ace29daa1..4bb148d4b4e8 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -65,9 +65,8 @@ static void virtio_vdpa_set(struct virtio_device *vdev, unsigned offset,
 			    const void *buf, unsigned len)
 {
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
-	const struct vdpa_config_ops *ops = vdpa->config;
 
-	ops->set_config(vdpa, offset, buf, len);
+	vdpa_set_config(vdpa, offset, buf, len);
 }
 
 static u32 virtio_vdpa_generation(struct virtio_device *vdev)
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 30864848950b..267236aab34c 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -386,21 +386,10 @@ static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
 	return ops->set_features(vdev, features);
 }
 
-static inline void vdpa_get_config(struct vdpa_device *vdev,
-				   unsigned int offset, void *buf,
-				   unsigned int len)
-{
-	const struct vdpa_config_ops *ops = vdev->config;
-
-	/*
-	 * Config accesses aren't supposed to trigger before features are set.
-	 * If it does happen we assume a legacy guest.
-	 */
-	if (!vdev->features_valid)
-		vdpa_set_features(vdev, 0);
-	ops->get_config(vdev, offset, buf, len);
-}
-
+void vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
+		     void *buf, unsigned int len);
+void vdpa_set_config(struct vdpa_device *dev, unsigned int offset,
+		     const void *buf, unsigned int length);
 /**
  * struct vdpa_mgmtdev_ops - vdpa device ops
  * @dev_add: Add a vdpa device using alloc and register
-- 
2.25.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
