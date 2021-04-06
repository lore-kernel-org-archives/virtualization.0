Return-Path: <SRS0=hGiF=JD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBD4C433B4
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C6961041
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C6961041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A111440F87;
	Tue,  6 Apr 2021 17:05:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W9g9GZOxG-_W; Tue,  6 Apr 2021 17:05:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC59940F76;
	Tue,  6 Apr 2021 17:05:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88781C000C;
	Tue,  6 Apr 2021 17:05:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F9C2C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7F12B60666
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J_--KeTny3QC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 18C5F6005E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZjpLuPyuPG3Y78MStunJ5VDXLexCjwjqh4bN3hX8gYdRcs6iVP58iwd6dxuJLPz8vypb2E3Nxldf+iHV7LwBKVhNfJEMFKh+W6UnlfqV4qwAQwnAomQRTT0g6idYjPtqAt+D1gA0nZegg8ZWhYkotnAJqXSlQkAxNdO4/Gb1J/xFoP7zLdom4XsAf0+U/aQlREHyG5lDMNB/i7q1J4MrBSx+EixCwBP/1U/OmyUXNg1moOf5lnyarLhl1Py+9m/FVFP23PRKOJ7TSCfMprTobYUjxTE2W8JvGvSh+8op34LYoDNthxY6+HukksFEYab09vbS2AljwZDu3SWVlvqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0tGXEzyVUQ0KSPCBzw0tWSgvMweVndrOVxdO6ZnEZ8=;
 b=heZEqvmwiqvr7zifQwPvhg1MLWsGP+X2Fm/Ax7xyX0xiOgn9M5jjCzrjPu8PNZ04sU64ZGnkT3Ykka8C3aWn9YjflzwSpHyRsFt91KePAytOsXX/OtY0vo2YXvq0gMNhh/cpUv2+9HUBBUajZBlLewXd/XRvA6wf5XS9xavlzAsJXMZnWkaocm2tKkd3iHnDaSrZNo7af2U4Fd7aL9vVNyOx+x7xqKVu4d2+xtP5bx9aQGkuIRAddPvIYoJEKztLbUIVJNNtvTV/QxMO6cOGoBknpTLTWLcGit4RgVFjdHNZ8U4aT1YARO7I/KqNbZkV/7HlAsdK+qmY9NIFZfU5lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0tGXEzyVUQ0KSPCBzw0tWSgvMweVndrOVxdO6ZnEZ8=;
 b=mWxt7Z9BGn2+aO1an1KcWm+jBr7zR9VfqJtdUTUzGQkc6HmKAg6gYD36CQ3CWJFA0vj0+l4TMmGyk2sBrMzzlz5eEq+6om74apkvX2lvk5juWtCh5elaxQ+I0lcgT07zXUhj1nyQr4O2vbBEFVyAiSPKQHkxVLS7Wh1nyNzDYFBv7gXgvZFuLcFTJPB+HBD/mveqSD+0z/KxNbHvsvyzaZv0liBART4hpjlJy1ndK7G0XhP7tXhHI9bCyNvvRuJ6R2E6rwT+fzUvR+cc59SYCAzw0fYysrYvaNx0w+W/gQFC5cQ6dDh7g7w3ptqe2dWj5CjMO712h/vtMrk7SxufyA==
Received: from MW4PR03CA0024.namprd03.prod.outlook.com (2603:10b6:303:8f::29)
 by BL1PR12MB5109.namprd12.prod.outlook.com (2603:10b6:208:309::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Tue, 6 Apr
 2021 17:05:14 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::ab) by MW4PR03CA0024.outlook.office365.com
 (2603:10b6:303:8f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29 via Frontend
 Transport; Tue, 6 Apr 2021 17:05:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 17:05:14 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 6 Apr 2021 17:05:13 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v2 01/14] vdpa: Follow kdoc comment style
Date: Tue, 6 Apr 2021 20:04:44 +0300
Message-ID: <20210406170457.98481-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210406170457.98481-1-parav@nvidia.com>
References: <20210406170457.98481-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a4520fc-5e6b-4def-6db4-08d8f91e2562
X-MS-TrafficTypeDiagnostic: BL1PR12MB5109:
X-Microsoft-Antispam-PRVS: <BL1PR12MB510990E5274A9B0D295956DEDC769@BL1PR12MB5109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Ssf613+zutyl3hECEOmNXC16/la0Gz/lOEhkjFhflueIvsX+hqebfjmnVO472cQGhI9EGPq+xbaXCOfW5zKdN6SUv8GeDcOiMOmWRR7IMWWPc9B+SxJvzBh/wIpiWVCFwo7/GPoTdvBXW0a0RokgDzwUNes5C0+2ROB4epqsinrDplQzmLR/13QfX8M7vskYaDvScxAVSuauDJLvYgzaR0xMFApBDk+74Lp3j3ZH7chmOhEr3FeVR3ln82nynG6lVC0B0f0du1zbuNMQdoeQrpBfvmZknBGGt4r+9NH/C7yCfKmR41M4waNxHElcgYIM5g/HWlJ8zsS5i2Up/ckfVOJMihP7LpVdSVpYDZ8h4NBVPUoXPW8oxwXR0+C+7pTOOhQgDhB8LMyxVA4iQaIrSO0uCpyGe1F+MhqNWLvtEsKqebko4U3YZcyZZI/DFceDe6+thKjcfVJzgeF9EZXCaF/e0SxB/m+b7f+7kuJPYZVg+EJfGZ7Eukw+r4KP82NKNXUeTsUUWNd0VK4SiyeOttjmFn5FkLzhj+/IdUZJ7YDjXIjfHTp/0kqqUpwu1P5mmDWlvnJsNgkE8EdPIKYTwJp6atXFYA5OKyn4XTi2D/tLbi9D/D3sb5HRoQZ127VLZ8qpDCjFrZBxChoA5ULn0HRlUbhgg5lDICDf2m0BiowAbHaIno2yqBcu4Knn4/0Y/koxV9vyhwT+MZ77Jl/2acsHbXMQVSNTdpDeLkhZ6g=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(46966006)(36840700001)(186003)(16526019)(4326008)(70206006)(70586007)(356005)(316002)(336012)(6666004)(47076005)(83380400001)(5660300002)(6916009)(8676002)(26005)(107886003)(36860700001)(2616005)(426003)(86362001)(36906005)(8936002)(7636003)(966005)(2906002)(478600001)(1076003)(36756003)(54906003)(82310400003)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 17:05:14.2409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4520fc-5e6b-4def-6db4-08d8f91e2562
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5109
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

Follow comment style mentioned in the Writing kernel-doc document [1].

Following warnings are fixed.
$ scripts/kernel-doc -v -none include/linux/vdpa.h
include/linux/vdpa.h:11: warning: missing initial short description on line:
 * vDPA callback definition.
include/linux/vdpa.h:11: info: Scanning doc for vDPA
include/linux/vdpa.h:15: warning: cannot understand function prototype: 'struct vdpa_callback '
include/linux/vdpa.h:21: warning: missing initial short description on line:
 * vDPA notification area
include/linux/vdpa.h:21: info: Scanning doc for vDPA
include/linux/vdpa.h:25: warning: cannot understand function prototype: 'struct vdpa_notification_area '
include/linux/vdpa.h:31: warning: missing initial short description on line:
 * vDPA vq_state definition
include/linux/vdpa.h:31: info: Scanning doc for vDPA
include/linux/vdpa.h:34: warning: cannot understand function prototype: 'struct vdpa_vq_state '
include/linux/vdpa.h:41: info: Scanning doc for vDPA device
include/linux/vdpa.h:51: warning: cannot understand function prototype: 'struct vdpa_device '
include/linux/vdpa.h:62: info: Scanning doc for vDPA IOVA range
include/linux/vdpa.h:66: warning: cannot understand function prototype: 'struct vdpa_iova_range '
include/linux/vdpa.h:72: info: Scanning doc for vDPA_config_ops
include/linux/vdpa.h:203: warning: cannot understand function prototype: 'struct vdpa_config_ops '
include/linux/vdpa.h:270: info: Scanning doc for vdpa_driver
include/linux/vdpa.h:275: warning: cannot understand function prototype: 'struct vdpa_driver '
include/linux/vdpa.h:347: info: Scanning doc for vdpa_mgmtdev_ops
include/linux/vdpa.h:360: warning: cannot understand function prototype: 'struct vdpa_mgmtdev_ops '

After this fix:

scripts/kernel-doc -v -none include/linux/vdpa.h
include/linux/vdpa.h:11: info: Scanning doc for struct vdpa_calllback
include/linux/vdpa.h:21: info: Scanning doc for struct vdpa_notification_area
include/linux/vdpa.h:31: info: Scanning doc for struct vdpa_vq_state
include/linux/vdpa.h:41: info: Scanning doc for struct vdpa_device
include/linux/vdpa.h:62: info: Scanning doc for struct vdpa_iova_range
include/linux/vdpa.h:72: info: Scanning doc for struct vdpa_config_ops
include/linux/vdpa.h:270: info: Scanning doc for struct vdpa_driver
include/linux/vdpa.h:347: info: Scanning doc for struct vdpa_mgmtdev_ops

[1] https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
---
 include/linux/vdpa.h | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 15fa085fab05..37b65ca940cf 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -8,7 +8,7 @@
 #include <linux/vhost_iotlb.h>
 
 /**
- * vDPA callback definition.
+ * struct vdpa_calllback - vDPA callback definition.
  * @callback: interrupt callback function
  * @private: the data passed to the callback function
  */
@@ -18,7 +18,7 @@ struct vdpa_callback {
 };
 
 /**
- * vDPA notification area
+ * struct vdpa_notification_area - vDPA notification area
  * @addr: base address of the notification area
  * @size: size of the notification area
  */
@@ -28,7 +28,7 @@ struct vdpa_notification_area {
 };
 
 /**
- * vDPA vq_state definition
+ * struct vdpa_vq_state - vDPA vq_state definition
  * @avail_index: available index
  */
 struct vdpa_vq_state {
@@ -38,7 +38,7 @@ struct vdpa_vq_state {
 struct vdpa_mgmt_dev;
 
 /**
- * vDPA device - representation of a vDPA device
+ * struct vdpa_device - representation of a vDPA device
  * @dev: underlying device
  * @dma_dev: the actual device that is performing DMA
  * @config: the configuration ops for this device.
@@ -59,7 +59,7 @@ struct vdpa_device {
 };
 
 /**
- * vDPA IOVA range - the IOVA range support by the device
+ * struct vdpa_iova_range - the IOVA range support by the device
  * @first: start of the IOVA range
  * @last: end of the IOVA range
  */
@@ -69,7 +69,7 @@ struct vdpa_iova_range {
 };
 
 /**
- * vDPA_config_ops - operations for configuring a vDPA device.
+ * struct vdpa_config_ops - operations for configuring a vDPA device.
  * Note: vDPA device drivers are required to implement all of the
  * operations unless it is mentioned to be optional in the following
  * list.
@@ -267,7 +267,7 @@ int _vdpa_register_device(struct vdpa_device *vdev, int nvqs);
 void _vdpa_unregister_device(struct vdpa_device *vdev);
 
 /**
- * vdpa_driver - operations for a vDPA driver
+ * struct vdpa_driver - operations for a vDPA driver
  * @driver: underlying device driver
  * @probe: the function to call when a device is found.  Returns 0 or -errno.
  * @remove: the function to call when a device is removed.
@@ -344,18 +344,18 @@ static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
 }
 
 /**
- * vdpa_mgmtdev_ops - vdpa device ops
- * @dev_add:	Add a vdpa device using alloc and register
- *		@mdev: parent device to use for device addition
- *		@name: name of the new vdpa device
- *		Driver need to add a new device using _vdpa_register_device()
- *		after fully initializing the vdpa device. Driver must return 0
- *		on success or appropriate error code.
- * @dev_del:	Remove a vdpa device using unregister
- *		@mdev: parent device to use for device removal
- *		@dev: vdpa device to remove
- *		Driver need to remove the specified device by calling
- *		_vdpa_unregister_device().
+ * struct vdpa_mgmtdev_ops - vdpa device ops
+ * @dev_add: Add a vdpa device using alloc and register
+ *	     @mdev: parent device to use for device addition
+ *	     @name: name of the new vdpa device
+ *	     Driver need to add a new device using _vdpa_register_device()
+ *	     after fully initializing the vdpa device. Driver must return 0
+ *	     on success or appropriate error code.
+ * @dev_del: Remove a vdpa device using unregister
+ *	     @mdev: parent device to use for device removal
+ *	     @dev: vdpa device to remove
+ *	     Driver need to remove the specified device by calling
+ *	     _vdpa_unregister_device().
  */
 struct vdpa_mgmtdev_ops {
 	int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name);
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
