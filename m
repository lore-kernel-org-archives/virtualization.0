Return-Path: <SRS0=hGiF=JD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4C4C43461
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0CCB61074
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0CCB61074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F72640FAB;
	Tue,  6 Apr 2021 17:05:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HeN0oMCilS-i; Tue,  6 Apr 2021 17:05:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id F12B040FA0;
	Tue,  6 Apr 2021 17:05:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22415C0019;
	Tue,  6 Apr 2021 17:05:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E544AC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D3FDE84A48
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6E8fpgfUEy6o
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8C8FF84A0B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFDN3ACKazsPrStx1h0OKf8AKnBVI/DpRLZj/ZWxrf1x2mTr6QNWDJiSs/u+J1Fdjtootb3yKMnppAzPF4eP5g4/wpW1/jnn1+0Kjb8lVux8bwIiAv3BuJ9F5C6DVu1RtfbWkUg6zigkbwMmW2aOmQuyfkCZELXevPV0bIOHThLh7JF9rufxFdZ7cg7GdUuYQhVVWWQpRRGpRLbJ/AmyiAZodgTM815s0CRU7WbT7xh0PkzLg/Ec1Sg0YVCXi1NFp/A9LgL17IYVxYbep494RZg6Zmx3bdlf8ZRUe2qHxwjWTSOiyd6NB9oSS1GIrF4jspu13luwrZ4duwFBn4ujOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38j+yW5vWMD5IYEFV6GCSNpjdqlW9YUOpXB3tH+AzmY=;
 b=Dml5PNj0FzSz3RomMhfMrPdF22imdkiI6PDFi7yQiY3Vdx2YFGmy/SJJJAvQuBgfU9NRQbbhHvSHjEKcH47Fv07MOKeS08v+MTE+jIWVi/lZwqqo9CtZd4I0BjtMW5RLs26RBxwaH5yXgh4PpnnXrrlS0G711opy5MfnUBIPZRKR1kZ8xmjQ9vlCGVZFRqkbvUMkjuqVAaLUpAfLxu9HV+ylYvl944jcMx66Ut3zRDXjO7+0LpjPUJYs4jUvuf6kp4QARFwt1Hz1iPjRkVVBiEp+GkrDlL3t17NHC4f333LZ6kLjUP7MDLj6ziTYTYVHIxao2E+ihkXRoWsTVcz1ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38j+yW5vWMD5IYEFV6GCSNpjdqlW9YUOpXB3tH+AzmY=;
 b=FFkwL9UlhhiVmY+nmzIzOrcRV/xcDirhMnG9G43SYNJMSwi8MxPVrHaTMlfUKlCG9Lns1PFPfx8RNjc3FLjqhNmNk6ma4uEdI75Dwgs2m8Ze+kphb2AXsuf7utpgeDEjfybeMT70vfJG00OkoY5UOvjwT2jI3CCadejj982D3MpRoMfu81N+feF0s9kquWvSQPPeE3Ez+5h9kmeqGxyw474VV0r4p1LYLIdBRTCymvfIPyL5nygPXbO1tf3AKNBBgY/HZNOSPjZ5b4PdUwZXccW48yetVgRFV+AJK8KUsXuwiIQy5UWR0Vml5WWKMLZhWFFSXpdXcvKV0WX75JiwAA==
Received: from MWHPR19CA0068.namprd19.prod.outlook.com (2603:10b6:300:94::30)
 by BL1PR12MB5302.namprd12.prod.outlook.com (2603:10b6:208:31d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 17:05:15 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::80) by MWHPR19CA0068.outlook.office365.com
 (2603:10b6:300:94::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29 via Frontend
 Transport; Tue, 6 Apr 2021 17:05:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 17:05:15 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 6 Apr 2021 17:05:14 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v2 03/14] vdpa: Introduce and use vdpa device get,
 set config, features helpers
Date: Tue, 6 Apr 2021 20:04:46 +0300
Message-ID: <20210406170457.98481-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210406170457.98481-1-parav@nvidia.com>
References: <20210406170457.98481-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3443d98-8df8-42f1-bec3-08d8f91e25fa
X-MS-TrafficTypeDiagnostic: BL1PR12MB5302:
X-Microsoft-Antispam-PRVS: <BL1PR12MB530266BB81F9645266A65B1DDC769@BL1PR12MB5302.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8p19cz6GsTydZD3F28s2uHP0tIrZITB9rFd2KQqkKtdEfWlI/D+hKjn27a5sckjJHQKZW+J3ZCCh92p+g2yTnbDMYMirD6sxMQlrq8s0a1ytrQKzg3NE2186R3G/+sHQnRc8asQUEHISGp+Dnlnc7BhnJ4k9lBgYN6AJWjri3M6nshtcx358ZhQZ3KRYcXfNXCoPcWUjQ7q6kBYR/gHaWLeAHtiusi92zjXtq3+PfKgJJLi4bAioiEduecY9mXcNN+K71A7zXoqFlIFB8G/PK4HeyVO6yjksxH7nzUjeshNb6YtcsTsOL77R1xdPLKWLloFLiutSJO6lVK1U4FH0FmlSCWaWPssKVvySrsZC75NZuQ8Vu6LfTG5gccGsRFsqGNiSpydrIMbUeIApxD6zXklMRmy1qqgdhCFFQlyb8Sh6ibgfQdzPTV+WjjRjkf6ME1KzrQrCpv1KIliT4yHzm0u7RujHXHsJVvFqyB+fSvMGvl3Kk7f3FjBwzYRXf/S33rXgLq0A9YV7LtmuJhrn+p4xEkwycsb6Bg6xPD25GZ9Ofl6T14Kb3NAqyVwSow76kywELP+EfcHRVutIrR17jlmebKsvF4s3xgT1xeRphCEKNWBBMyPO5CEK7U7JttHz6roIb8KD2SVdtH4wJiLv039CYpgL+Mpn4um8Z6Fb3is=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(36840700001)(46966006)(70586007)(54906003)(26005)(82310400003)(70206006)(36906005)(82740400003)(107886003)(426003)(7636003)(2616005)(356005)(8936002)(36756003)(2906002)(5660300002)(316002)(6916009)(186003)(83380400001)(336012)(1076003)(86362001)(36860700001)(478600001)(47076005)(8676002)(6666004)(4326008)(16526019);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 17:05:15.3080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3443d98-8df8-42f1-bec3-08d8f91e25fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5302
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

Subsequent patches enable get and set configuration either
via management device or via vdpa device' config ops.

This requires synchronization between multiple callers to get and set
config callbacks. Features setting also influence the layout of the
configuration fields endianness.

To avoid exposing synchronization primitives to callers, introduce
helper for setting the configuration and use it.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
---
changelog:
v1->v2
 - new patch to have synchronized access to features and config space
---
 drivers/vdpa/vdpa.c  | 57 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/vhost/vdpa.c |  6 ++---
 include/linux/vdpa.h | 28 +++++-----------------
 3 files changed, 65 insertions(+), 26 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index bb3f1d1f0422..116e076c72fd 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -261,6 +261,63 @@ int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev)
 }
 EXPORT_SYMBOL_GPL(vdpa_mgmtdev_register);
 
+/**
+ * vdpa_get_features - Read vDPA device features
+ * @vdev: vdpa device whose features to read
+ *
+ * Return: Returns device features.
+ */
+u64 vdpa_get_features(struct vdpa_device *vdev)
+{
+	return vdev->config->get_features(vdev);
+}
+EXPORT_SYMBOL_GPL(vdpa_get_features);
+
+/**
+ * vdpa_set_features - Set vDPA device features
+ * @vdev: vdpa device whose features to set
+ * @features: features of the vdpa device to enable/disable
+ *
+ * Return: Returns 0 on success or error code.
+ */
+int vdpa_set_features(struct vdpa_device *vdev, u64 features)
+{
+	const struct vdpa_config_ops *ops = vdev->config;
+
+	vdev->features_valid = true;
+	return ops->set_features(vdev, features);
+}
+EXPORT_SYMBOL_GPL(vdpa_set_features);
+
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
+ * @dev: vdpa device to operate on
+ * @offset: starting byte offset of the field
+ * @buf: buffer pointer to read from
+ * @length: length of the configuration fields in bytes
+ */
+void vdpa_set_config(struct vdpa_device *dev, unsigned int offset,
+		     void *buf, unsigned int length)
+{
+	dev->config->set_config(dev, offset, buf, length);
+}
+EXPORT_SYMBOL_GPL(vdpa_set_config);
+
 static int vdpa_match_remove(struct device *dev, void *data)
 {
 	struct vdpa_device *vdev = container_of(dev, struct vdpa_device, dev);
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index e0a27e336293..383f5be8ffa6 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -236,7 +236,6 @@ static long vhost_vdpa_set_config(struct vhost_vdpa *v,
 				  struct vhost_vdpa_config __user *c)
 {
 	struct vdpa_device *vdpa = v->vdpa;
-	const struct vdpa_config_ops *ops = vdpa->config;
 	struct vhost_vdpa_config config;
 	unsigned long size = offsetof(struct vhost_vdpa_config, buf);
 	u8 *buf;
@@ -250,7 +249,7 @@ static long vhost_vdpa_set_config(struct vhost_vdpa *v,
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
-	ops->set_config(vdpa, config.off, buf, config.len);
+	vdpa_set_config(vdpa, config.off, buf, config.len);
 
 	kvfree(buf);
 	return 0;
@@ -259,10 +258,9 @@ static long vhost_vdpa_set_config(struct vhost_vdpa *v,
 static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *featurep)
 {
 	struct vdpa_device *vdpa = v->vdpa;
-	const struct vdpa_config_ops *ops = vdpa->config;
 	u64 features;
 
-	features = ops->get_features(vdpa);
+	features = vdpa_get_features(vdpa);
 
 	if (copy_to_user(featurep, &features, sizeof(features)))
 		return -EFAULT;
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 37b65ca940cf..62e68ccc4c96 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -320,28 +320,12 @@ static inline void vdpa_reset(struct vdpa_device *vdev)
         ops->set_status(vdev, 0);
 }
 
-static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
-{
-        const struct vdpa_config_ops *ops = vdev->config;
-
-	vdev->features_valid = true;
-        return ops->set_features(vdev, features);
-}
-
-
-static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
-				   void *buf, unsigned int len)
-{
-        const struct vdpa_config_ops *ops = vdev->config;
-
-	/*
-	 * Config accesses aren't supposed to trigger before features are set.
-	 * If it does happen we assume a legacy guest.
-	 */
-	if (!vdev->features_valid)
-		vdpa_set_features(vdev, 0);
-	ops->get_config(vdev, offset, buf, len);
-}
+u64 vdpa_get_features(struct vdpa_device *vdev);
+int vdpa_set_features(struct vdpa_device *vdev, u64 features);
+void vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
+		     void *buf, unsigned int len);
+void vdpa_set_config(struct vdpa_device *dev, unsigned int offset,
+		     void *buf, unsigned int length);
 
 /**
  * struct vdpa_mgmtdev_ops - vdpa device ops
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
