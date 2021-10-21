Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBC5C433FE
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 16:35:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BEFF61501
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 16:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2BEFF61501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E19AE606ED;
	Thu, 21 Oct 2021 16:35:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W0DfzSfK33Z9; Thu, 21 Oct 2021 16:35:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 778DE6067C;
	Thu, 21 Oct 2021 16:35:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE8A0C0011;
	Thu, 21 Oct 2021 16:35:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1173AC0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F331B606A0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zPlAMMZBI43J
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3226760661
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFyYiCEbdIFmJoSIyNYOzfxcV1LBRNVi29WtjjDYMN3MoVCwr27Kc9EWGwfEEvrxASXTZ/jj4KIdQxHy5h9pQO2NraIPxvdTxnJ5xmByPZ9oLKZU0NsStzRBtNlY0n8VaJgoZusZBKelOkmyXXfwkZwixHacqvkgQX8d3Fty3v2hOLg3bgmJaxb373jXK/Ym1hiCa9Al2jcuudU2YmTkyc1AKJSdn/OUT1d6JRs7Ro5pwwLC6IGZCqNPQZhds58+DgogVZ5UgGfcnpcXBRfRj/mvqRSXsBli6zCXQrMY4T5ZqsX3aIw5q08Wf6hYpLjRp1UASobbE3kNxfWJvb7KOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjjYPQnXY0EtyZ3oy5L14XjwvWLGNaLkQXRO1RBCFiM=;
 b=jhgvSqpRPThYHrWff+aF8VlApi6+rpEC2S9znes34n9FmLCq8v7RJrjnrx0BV616K7EmISegvh0NdyLrPk8d51fTSKXwgnGHed5FR7eCWe3Y5eNFogCfSK39MrOvOHr9V9hxEwJCyeB+Vb/dxZt903kUkORIhWj6IQk0wwcK+1mik3pqH/85rR/97lLnjIBmX30nVO24Aez3LwfYxVBTDqoOwYj1J+3IqFkRbhjhyE4DXAYXrScbkrP6+mIpbgSR9jPsQ+TKpUBLS5N1MJc9fObqDsmofdkhCzIKBIalXLr2j8abymwQLwqogdpArsEaaoBi7mPCbHcT/2rxdR0ndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjjYPQnXY0EtyZ3oy5L14XjwvWLGNaLkQXRO1RBCFiM=;
 b=O7mn6ZAjt8WnBiLA8V4HApkAb15YcRrjUhRgOMTWWGoo4ZXLKCKkPQQF/lOf9YhyxSz6n0DeT5hqcov/I9qfpk1dwYUdIcppY/FrTqqHGb0Et+CTEW7s/QkBT128Ffag+R/qaGrCPxIGFcmNp9BxIWlVA9XE/nFpbM7OwYvXgc+UNUsvo66FdVMTDFNIaIJ5cNyleIIiLrs/3y3k7ZrXkuBGnfDKTqlmBl1WCynqs1kTHmACOsI73c9+lLoSW9VeBaFl1gAc4LGqH1NOoMZJDSubiFMH4SYS0II/WpOJXDn8OJB3ZhRttPF8sXdFztlaLCaesAjAJpTdjJVG7Q68/A==
Received: from CO2PR06CA0058.namprd06.prod.outlook.com (2603:10b6:104:3::16)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 16:35:29 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::ee) by CO2PR06CA0058.outlook.office365.com
 (2603:10b6:104:3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Thu, 21 Oct 2021 16:35:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 16:35:28 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Thu, 21 Oct 2021 16:35:22 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v4 1/8] vdpa: Introduce and use vdpa device get,
 set config helpers
Date: Thu, 21 Oct 2021 19:35:02 +0300
Message-ID: <20211021163509.6978-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211021163509.6978-1-parav@nvidia.com>
References: <20211021163509.6978-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4cbabfe-ddae-4a54-8e7a-08d994b0cb02
X-MS-TrafficTypeDiagnostic: MN2PR12MB4357:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4357911910A0A42295C5AF2FDCBF9@MN2PR12MB4357.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rpev/optBZ+AXfdc4vgEEO93jiYR71n4I3U0R9YfH6xygJcQktbEc0f1L26hNngqPl2fkFW3NjaY2jq7B8kuU1AcQ9GVKPON2V2c6rkJhcIq+x5Qisk+qz8x0fkjP1AHytFPbvtyZtAw1/Maw7y9bJ1HVzmK0q6tgSJLcT5B2TIH8sBEMd21qwIiF8xWjdv23KPG4+rlOIDX6b/qUJP3i2caaj7bZhE0zPHW3LqJyXUyKmwRUkm7zxb/Cm5xbcq6skNIdGo1t8iqJK4jcOAqwOmYCnFg4ZwUn5OSMtqNc8JqmyHYSaM158Uc4qEmhuBIDQyC9902rwj9AFlyF2MmU+VU6seRZBK69IJcQpTKQcslTBEYREcmwG6sV7AmObyRrqBTLFla5wUVi7tG53aXSSqs/9DE1R5aJ/8UCH69R814Jk86MtA7bsZqbCM68PDLd1xaP2Cl8hR0p0vhvghpcQJaNaJtopFES/MxzdHx/OIJOUjyX9tBTmul+aDOYr7MSXNh2cwTQzP1LdPh/Cwwub7l4b2Kcemc42006vVvb7XuU4JDi37tV7QRnE3xtSCzIuwGVBPEhYGjjuIYHBFr/IFb6V4y3jg4EbLb+hKjnkLTdw2F36Kf0o57CAiTTnFedPerxH2kls27epMLJ9k/qvyaxc6Ws1cU1FLcrKM1FU43H40zTMNN0MbPk0WbK4V4zQQ92Avi1dgShKkZcSYs6w==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36860700001)(508600001)(36756003)(8676002)(1076003)(16526019)(186003)(70206006)(70586007)(4326008)(47076005)(426003)(8936002)(2906002)(107886003)(36906005)(6666004)(316002)(54906003)(5660300002)(6916009)(82310400003)(83380400001)(2616005)(86362001)(356005)(7636003)(336012)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 16:35:28.5306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4cbabfe-ddae-4a54-8e7a-08d994b0cb02
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357
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
 drivers/vdpa/vdpa.c  | 36 ++++++++++++++++++++++++++++++++++++
 drivers/vhost/vdpa.c |  3 +--
 include/linux/vdpa.h | 19 ++++---------------
 3 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 1dc121a07a93..6fdfc11ecb13 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -289,6 +289,42 @@ void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev)
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
+		     void *buf, unsigned int length)
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
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 3972ab765de1..78395331a166 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -382,21 +382,10 @@ static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
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
+		     void *buf, unsigned int length);
 /**
  * struct vdpa_mgmtdev_ops - vdpa device ops
  * @dev_add: Add a vdpa device using alloc and register
-- 
2.25.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
