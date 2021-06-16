Return-Path: <SRS0=d+i8=LK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E6AC48BE5
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 19:12:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B8C461245
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 19:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8C461245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A45183C65;
	Wed, 16 Jun 2021 19:12:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RQN_rJpuLodb; Wed, 16 Jun 2021 19:12:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A8EC983C25;
	Wed, 16 Jun 2021 19:12:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F6B4C000E;
	Wed, 16 Jun 2021 19:12:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76084C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 642DC405E6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yvzfIr4jUkyf
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1816B40642
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjBJIGqDBP00qbghwVIbvbYZ1E8050L6qeFWZ3HbQoqV3lIeBb8pTF+Vv2vQpf2NIq+kmCvOmfzKpUWz+g4r1qd4m/2GzAlVLAlKRw0VDQGjzqnq3zuG0jVvGBfuE76OURBp6JVs/jFeCzUsx8DxlnjICOkY70Mt16jdA+ESTPbyVRlHM9apfmbr8yi2RmCNkbsp/ecoey/gE0nOW6O5AHQKrwU6/y8T2WSfSw4Jt2tNLl0k/RfW1giMlJAZpFTw5G4KNlSVNoU71wEFyx4jNVq+mQsZOXiPLx/HyZPh/86Ke0B83GwclaJ0tC9bEZW9YTNwCBTdztQUnDZ0W1+CWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xb0/DENP5R2n8JBbS8EdtaSLnnBvoq+zS3Q3oYgekcg=;
 b=RCyDbyIenQvyrXr8zaddSKfqG/A1xF7DeYJazwzqhlsVCN+GxaPWd6sM+r2HiNh0pO6eckgK6AB4JDriKgXLY5aL/YZNoXgjAZ7dwJej6Ea7ny4WEX8Nu8SJaLhqAikV1iAB6lWu3vgunEMB6KbeFo8sohDoBbhvp4LKRO0hy+318amNOGSVXVphjYT6FNeMQDZdoUinvX5nL9gl0DaiIbbC+UA3TeIZ8o2kKdw+3BvAIrx7mIQ+zbY8ZJVViEJds29wC8xBhKhcsC8xWFlyXhTYiIBln+YdtQRgnJikIfI4YR76p8/PAaAg9GCvVHyPLc4/tcx8Is4G8ULGc8gVyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xb0/DENP5R2n8JBbS8EdtaSLnnBvoq+zS3Q3oYgekcg=;
 b=gn3cef7NNhjC4hYO8AUvf4GLqoEPRzNiJ/WZ0lqh6EaaJPGRKhiszPxf2FCpD97JVN1tYrN+YCFDB1NjwJk6Vv9FE8A4JwrjiHAbVzmPFSK3mW6bfL/H9VBx6HaxHv0VPwWF6njvBybNk8qLSAzYhpFWQC27H6naWQTI/gxU+oPu0IW/aRAp0DOVZNCROL7w5zJa6jKCUjzH6lM+h8pWr2+L4bUl10kTJ1auQqUtsZGnZml9zRZWhHbQw7vZ1lwARIMenUC5b7lITk0CiydQz0j7jF9Mkm7HZK9pjZAcSkYKXaBGpfNo72Uwyn7907kJrG9yA4CSWkvU+tMW3lXEJQ==
Received: from MWHPR22CA0061.namprd22.prod.outlook.com (2603:10b6:300:12a::23)
 by DM6PR12MB2668.namprd12.prod.outlook.com (2603:10b6:5:4a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.25; Wed, 16 Jun
 2021 19:12:14 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::a3) by MWHPR22CA0061.outlook.office365.com
 (2603:10b6:300:12a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Wed, 16 Jun 2021 19:12:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 19:12:14 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 16 Jun 2021 19:12:13 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v3 1/6] vdpa: Introduce and use vdpa device get,
 set config helpers
Date: Wed, 16 Jun 2021 22:11:50 +0300
Message-ID: <20210616191155.102303-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210616191155.102303-1-parav@nvidia.com>
References: <20210616191155.102303-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f238b29-e7b8-4a09-0de7-08d930faa66f
X-MS-TrafficTypeDiagnostic: DM6PR12MB2668:
X-Microsoft-Antispam-PRVS: <DM6PR12MB26680C41392C1E7BBCC88007DC0F9@DM6PR12MB2668.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jftTXtO6ZffoQiRNeDsj864T3lY1y5+6nxjbflFkKkMoJi9iD/RoGo+NHo04Ktn5Wp3+ODrfKestzfPb8WgICBb3OurAD4oDqE3kzosr/b8SG2FPf2wfn+yfwT+6OHFQixmLoAvjFIoo+R1S9kY8+rTy21BjUel9SylNV2obb7zz4sjE222bfRqZ4ehpUFlHNadTZUwjzl2uq8vgnpGIb/QnNPokFdk8mVaoT4qoUskCZdSz7zk9uGVSyq/R7/uwUFzoOvqHK99MvOrsc9m+vaUT1qIWf0wB9rDpY2KVvJe0csCAKuG23nRDt4l2RmqtMKN29xkpVEUbntiHGU2+bQgHuL17Yk9WbzhSuMcnnJnzL7fIRUg7wQKJc6r9iOdih5BuzjMyLHPsFZ+CIzyLEfBEhUc3WS9auM95Cu3G+wBjlPqN21FUL+gzTKzC2eC158tlHi9YJpJqAdhzM3nJr2o5FBYTvHQoCFBDEFUQQ3KSOPcRtGm8TTldOJ4yBdy3710xz6lBAVin1E8of90Z7/bXrhbztUD8YHQPxI2a6aTS94f1yh1ReV8U06U3KqPeNRZHpTZvwN2m+Pyj7MXNwHSX0W5viDv/KmxRbQqifQC0hg3kD8vn39kCF0V/Yl+VFWf+iz8/10ktQLgAMzwVOqcmemcoN5WvSAyWREcQhVs=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(36840700001)(8936002)(356005)(36860700001)(478600001)(2616005)(336012)(86362001)(5660300002)(36906005)(47076005)(8676002)(426003)(70586007)(36756003)(82310400003)(83380400001)(82740400003)(7636003)(1076003)(6666004)(316002)(107886003)(70206006)(2906002)(16526019)(6916009)(26005)(186003)(54906003)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 19:12:14.0799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f238b29-e7b8-4a09-0de7-08d930faa66f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2668
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
 drivers/vdpa/vdpa.c  | 36 ++++++++++++++++++++++++++++++++++++
 drivers/vhost/vdpa.c |  3 +--
 include/linux/vdpa.h | 18 ++++--------------
 3 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index bb3f1d1f0422..bc44cdc34114 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -284,6 +284,42 @@ void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev)
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
index fb41db3da611..908b4fb251b3 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -231,7 +231,6 @@ static long vhost_vdpa_set_config(struct vhost_vdpa *v,
 				  struct vhost_vdpa_config __user *c)
 {
 	struct vdpa_device *vdpa = v->vdpa;
-	const struct vdpa_config_ops *ops = vdpa->config;
 	struct vhost_vdpa_config config;
 	unsigned long size = offsetof(struct vhost_vdpa_config, buf);
 	u8 *buf;
@@ -245,7 +244,7 @@ static long vhost_vdpa_set_config(struct vhost_vdpa *v,
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
-	ops->set_config(vdpa, config.off, buf, config.len);
+	vdpa_set_config(vdpa, config.off, buf, config.len);
 
 	kvfree(buf);
 	return 0;
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index f311d227aa1b..993d99519452 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -332,20 +332,10 @@ static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
         return ops->set_features(vdev, features);
 }
 
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
