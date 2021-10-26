Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980A4C433F5
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:03:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2791660EFE
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2791660EFE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE53540275;
	Tue, 26 Oct 2021 04:03:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BYCIH5ezzKel; Tue, 26 Oct 2021 04:03:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0374640268;
	Tue, 26 Oct 2021 04:03:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B359AC0012;
	Tue, 26 Oct 2021 04:03:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E66DAC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E17974015C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 50LTjSIkLWYb
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C05CB400E1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0hD4r7gjNKmKsTsLm6857ia82/ANGfCOqrUhlSdwKRL1QzwyuMN+NRDw/1aCXUHUbDNo1I0AfuPK3m5AZ0bfYdn1EVWPHNmCzXsf8VDU0pkEppnqt7s3TvYUGKDuOnJQAYij6dCleJMZ77/qFltyLe6+k+0Knc8s8nZTrfhnVzAn6TQ7uT8YZC+Rd3rQ5O4tPvEsBkVvhYEDW70L9luLHB4q7JyqbhbqLZqTkumbP6TYf9gOrHp2WlGOmAETxhOhMz3ZzYaR1uwGSlt6D1KPpX300DbYtHHWDcomXSe0PaZIbsbyQ1/7nY6T02z1zF9ApyItZsa0sb5UMbmQo8LYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IJrf2OOjwc3wbG62Ljq/M34aHCijWH2VusBGnPtE8c=;
 b=febZKCDuudy1+grawgpj4vx0hVvr7Mm1IXPJAGbgSDvtbr4+gIZOEwaiM6wvUM4Itfz7RtAakzUoUbH/YGv2cF2kyM6ZQl/beHDaXGG8zTOeimp/dC8+QPqQFhkhxHTqrtEKOUpEGBbSQfOUHCu3TquAzMwWzMmLmqHExgvdOqdtQl+XKqWOgZU9b4w0cfOpi1XYsiNa3Tbs4kXUplQitYLfGR+0hbZEghJQfmMbT1FagtzYOfElRVmS1w5yFYOIVFrr9gSCmU87y6W+FCjMLNL/6hs646iqjrRjZTTMbuuy5zEo0/zGXbNMH6Noj67nEEVQwEVEokJ5D9e2/EcR1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IJrf2OOjwc3wbG62Ljq/M34aHCijWH2VusBGnPtE8c=;
 b=oIxczxVsJ5RHbzFy46wymw3Vw4m5yFIkod6NZJgYD67hsQVx9+4aaTUTeiNWdNoRk0Cacs+fEU+5z7+uN/a8vLwfI1aYMpHVAJeqM8mVvCLcq5ihGRWnf3NHovSf8hCp6aoAZP/HWkd5D/O2hQ1mdTUZor7TfFRqgbAnlVq0Rh5Z4xntSP/W/B+q01XFhK8VZrkJ8ZGrW52p1Whp2x46luePS4o1Sll/2KPgjtSLi1JoGSfcSRMInMJS4LoyMzaPTS/rSsQR7ssdX9dykQ7asGFgp6Bxgu2Xti4WJ0t9jqMIViFjPEnvq1i1wazj2maQwiTC8BzH5J0voC9AABMoMA==
Received: from MW4P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::15)
 by MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 04:02:58 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::3b) by MW4P223CA0010.outlook.office365.com
 (2603:10b6:303:80::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13 via Frontend
 Transport; Tue, 26 Oct 2021 04:02:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 04:02:57 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 26 Oct 2021 04:02:56 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v6 1/8] vdpa: Introduce and use vdpa device get,
 set config helpers
Date: Tue, 26 Oct 2021 07:02:36 +0300
Message-ID: <20211026040243.79005-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211026040243.79005-1-parav@nvidia.com>
References: <20211026040243.79005-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1780e4f5-86a3-47a0-51d4-08d998357ecc
X-MS-TrafficTypeDiagnostic: MW3PR12MB4410:
X-Microsoft-Antispam-PRVS: <MW3PR12MB441034D54443C81E08B64A67DC849@MW3PR12MB4410.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jDWgCI9+Cq/FXbaFmk0044WfQngUcazF0r8U8n54wRmnSB42TfrPkS/6AvBh9ktqk4HWdFA3kfqBaAZP6DUWf584S97STirbFSegscaioreMAhRJtmCLsWVga1Z6vrBAZv6JNU2Nu5ygpw3kk8GRQ2xcvWwh4hwLzFyd1RnkqR8nF4IJX/wfR5GVKS/YFcWMS6FLOUQG3NFa8Nn/Ekww/OA5dQ2jH6HyKCrUh7/GxnXc408KtO/HqWgQN3dT2MXiaboeIJsdPdpvloBXB1UqmSzUbv8RL45PsTrqH4+DXDnM0Rg6mqApnB92sZvUkKF30TKGfhEluIpaqT8TK6fUWKYStOK7jNFcU1fBmpwKTf6rukWHW8PfgOCh0ZpJ96Lc+TMH4WqQPxfKnmA5E1tjJMFFET6cc0nLCM2HVGIT0muIqQAoUj9pif8NyUsQp5KlTuvGKzhMdo5hi9HI/xzIwuako52T7IBxPn8qT1PpMp6gkCg69+YBBBSXLG8WgIWeOGtksxfLzBPvj2JlYU3BHK1DLvfbzkY+Cq9hcVVsmMHccL/unYLoyK6lvEErIwVYGe5p42r/u47Fu2ombu1B4PIrfrFeFuiB7PMxLC9N2i4bsq9fu/2wQm01v+kLme+nZ9FwGx/7pNOOcV3uz7E8siy89CZt7KHNK5CtiNM0jDL4NU915+V9zOisV1s50wVrhV7siTrGv6ko9Tgu0KMaQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6666004)(336012)(26005)(83380400001)(2906002)(54906003)(508600001)(86362001)(36906005)(5660300002)(6916009)(426003)(7636003)(8676002)(70586007)(2616005)(1076003)(36860700001)(16526019)(70206006)(107886003)(36756003)(82310400003)(47076005)(4326008)(8936002)(186003)(316002)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 04:02:57.6624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1780e4f5-86a3-47a0-51d4-08d998357ecc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
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
