Return-Path: <SRS0=hGiF=JD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E160C433ED
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D9F61205
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D9F61205
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C65E340FA0;
	Tue,  6 Apr 2021 17:05:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id liQ4EmBMNJGK; Tue,  6 Apr 2021 17:05:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9722D40FAE;
	Tue,  6 Apr 2021 17:05:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 791F5C000C;
	Tue,  6 Apr 2021 17:05:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F4186C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D6FF184A4A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s2eGBMUyepgP
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ACFF284A0B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRboBUNWpnihElwDnSRM2+Tn9ZSGz4Fods+iTykInaqn5f8b86r+aaadTZCKS0VOls0VO9sCUHDF4Mi0/DT3HzfApmwNZRJ4SkOazbYJrOwPUvOTPWo0508MgpysojAs2hmAPSf95Ge2Yoy3+QP6X4glX9kX7Wj06Q4A0LJukSRxiWfQytvQ6aZaBm7Rq6UtZrTtQbkdm0DLPLf0D7/23s6jrB/tcNaLrcLtvLZ+yGNRI3SBZHn/pBwQni8cV7oa48Xwzmam4acFSmrejuYixzewIE2BKR6mgHVbahM29heEeHSTTYPQXzEK48P/eKnAmL4DFdZSIpUzpWg8eyVVCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fb9dBBZfLphKszOVRVgdc5bQy+5XowbMq1xrLGutCyg=;
 b=euAkQJkaLWiWU0dFqUJC3xn2Y6w6Z/A19BqofIZPqTepU9vmWhzaUCJr54VFHxE11R+Wz4miQ7UrtJbAvb7xzrI7JbNAKbJeZvzxEUkMMuQK+SUMs4Xwq0hLPOXy9dvHHHubuW5dOeKLaLAUe72/b+cpud/dJyUC8wefcUa6roAwBsV5eyTkO0xj6rbRdlGvDcZbtv250r0QpKSco9zXYpuQjCRlUdw9PlgUmwYLkODNf8tQGEVCtTdWWu/8u2gY40VC3Eq4e3HSKd7ZaXhOaHIssvASfiEXPKysBV665nZioocjHsuhGoHa7ViOAHAcpx7rlt/fw69xA+68YSBwcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fb9dBBZfLphKszOVRVgdc5bQy+5XowbMq1xrLGutCyg=;
 b=fW+QiYn8AOWSEezqggQhUFklqWiwuzKIcdQ/FHmA8Smsyid43Yn0rWKkGQEiqaDtwSxvKNkCD4HEY1gjDPkrOt42f2Wa/S6EbBBAMgKzomQLr6jPHYzACWhN8vMaICDZeTSlYxJSGXenyQZiYC0U45gpSI1x8skJQx16YjbNLuaQhGymmhBz5M6Rl4b+p2tizhQ36kCHj7BQFFjmJF6P6aj8JiO1oTALAEaQrqe7v6z+M2GUeKYaJnr50pzVTARrBJkvhPRwnY1+8cz3f9MJE1VEeCd7V9Rc1T4jwVgtMNAncK5tLiSutoa+2/ul7YdDiTeF71c02TksJ4/5DeSDbg==
Received: from MWHPR19CA0057.namprd19.prod.outlook.com (2603:10b6:300:94::19)
 by MWHPR1201MB0240.namprd12.prod.outlook.com (2603:10b6:301:58::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Tue, 6 Apr
 2021 17:05:16 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::b1) by MWHPR19CA0057.outlook.office365.com
 (2603:10b6:300:94::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29 via Frontend
 Transport; Tue, 6 Apr 2021 17:05:16 +0000
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
 Tue, 6 Apr 2021 17:05:13 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v2 02/14] vdpa: Follow kdoc comment style
Date: Tue, 6 Apr 2021 20:04:45 +0300
Message-ID: <20210406170457.98481-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210406170457.98481-1-parav@nvidia.com>
References: <20210406170457.98481-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14b94ac9-30a0-4ae1-0b17-08d8f91e2653
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0240:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0240248A615B59BE308B6C47DC769@MWHPR1201MB0240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3IsKeEZKew6iudIwmOUwQ06blAWgRGo2nn/iZm4oAweyYXHDrJKI8t/QPWm5pS71WzFEhekLah+Dq3SIieD3hgOkXzZxjMOO5Nna0sKZEgmISuORvwSYB8TwWz6TDjuLEbBnRYgmu0XNugU6oeylPppBI9HLZ/h5MdGbEBngwtBvv9bTKX1UNSCyHVJoz5FbX/gSiWQrSnVzryQghL+4nmnQ3v0vpc+LDv4KyFb2jWPFQ7pMcPJNc+cKBIHkGzRcsVBR6MdKnOpcW7uE36me6nzykCddEGKBt1k8C7W3iuH0QcJAFUQBaM6Eyv1VgPdpUvEEpiWsU799335ZQu9pXVxAgMBDL3VyeU6bwqUZ8bM2nMV0fRVuyN5Xjt/KQmg42aW0S1liCX0R8C3PxQF8p1krupZ7LyE+KrsEAzM7hB7q6JX4pgiwpytV6P8XicfBsBDrXdOctt5ciwLWGBRtYJmMoYgyPR4KG+g+iqXaz5E3HT58GD+m7e7F3n+6P5fV5gy2Ra2wXca3kg/xreMB4pE9wQQf8zfR+PRtUGTKnup3PpV97ZvlLgUAtUKf2b4Asq5LG6hIUIaMnvbzdtB26H1QodMAjGK8xuOgpieAoabdvVq0Z+HTaiYJUFfhzBbJkyADBRQKKW5lREXDUUUzCY4i5FJCeXfefcpasGyQxi198ymOwAs1gxoxKzc/kRajEXJGpWqLM0Q4VRb+28X6aC3mdxRfWFBhLPvLChGz2Ww=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(46966006)(36840700001)(4326008)(2906002)(86362001)(8676002)(1076003)(26005)(107886003)(8936002)(54906003)(966005)(316002)(36906005)(47076005)(16526019)(5660300002)(426003)(83380400001)(82740400003)(70586007)(336012)(36860700001)(2616005)(356005)(6666004)(6916009)(186003)(7636003)(36756003)(70206006)(82310400003)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 17:05:15.9167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b94ac9-30a0-4ae1-0b17-08d8f91e2653
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0240
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

$ scripts/kernel-doc -v -none drivers/vdpa/vdpa.c
drivers/vdpa/vdpa.c:67: info: Scanning doc for __vdpa_alloc_device
drivers/vdpa/vdpa.c:84: warning: No description found for return value of '__vdpa_alloc_device'
drivers/vdpa/vdpa.c:153: info: Scanning doc for _vdpa_register_device
drivers/vdpa/vdpa.c:163: warning: No description found for return value of '_vdpa_register_device'
drivers/vdpa/vdpa.c:172: info: Scanning doc for vdpa_register_device
drivers/vdpa/vdpa.c:180: warning: No description found for return value of 'vdpa_register_device'
drivers/vdpa/vdpa.c:191: info: Scanning doc for _vdpa_unregister_device
drivers/vdpa/vdpa.c:205: info: Scanning doc for vdpa_unregister_device
drivers/vdpa/vdpa.c:217: info: Scanning doc for __vdpa_register_driver
drivers/vdpa/vdpa.c:224: warning: No description found for return value of '__vdpa_register_driver'
drivers/vdpa/vdpa.c:233: info: Scanning doc for vdpa_unregister_driver
drivers/vdpa/vdpa.c:243: info: Scanning doc for vdpa_mgmtdev_register
drivers/vdpa/vdpa.c:250: warning: No description found for return value of 'vdpa_mgmtdev_register'

After the fix:

scripts/kernel-doc -v -none drivers/vdpa/vdpa.c
drivers/vdpa/vdpa.c:67: info: Scanning doc for __vdpa_alloc_device
drivers/vdpa/vdpa.c:153: info: Scanning doc for _vdpa_register_device
drivers/vdpa/vdpa.c:172: info: Scanning doc for vdpa_register_device
drivers/vdpa/vdpa.c:191: info: Scanning doc for _vdpa_unregister_device
drivers/vdpa/vdpa.c:205: info: Scanning doc for vdpa_unregister_device
drivers/vdpa/vdpa.c:217: info: Scanning doc for __vdpa_register_driver
drivers/vdpa/vdpa.c:233: info: Scanning doc for vdpa_unregister_driver
drivers/vdpa/vdpa.c:243: info: Scanning doc for vdpa_mgmtdev_register

[1] https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/vdpa.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 5cffce67cab0..bb3f1d1f0422 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -75,8 +75,8 @@ static void vdpa_release_dev(struct device *d)
  * Driver should use vdpa_alloc_device() wrapper macro instead of
  * using this directly.
  *
- * Returns an error when parent/config/dma_dev is not set or fail to get
- * ida.
+ * Return: Returns an error when parent/config/dma_dev is not set or fail to get
+ *	   ida.
  */
 struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 					const struct vdpa_config_ops *config,
@@ -157,7 +157,7 @@ static int __vdpa_register_device(struct vdpa_device *vdev, int nvqs)
  * @vdev: the vdpa device to be registered to vDPA bus
  * @nvqs: number of virtqueues supported by this device
  *
- * Returns an error when fail to add device to vDPA bus
+ * Return: Returns an error when fail to add device to vDPA bus
  */
 int _vdpa_register_device(struct vdpa_device *vdev, int nvqs)
 {
@@ -174,7 +174,7 @@ EXPORT_SYMBOL_GPL(_vdpa_register_device);
  * @vdev: the vdpa device to be registered to vDPA bus
  * @nvqs: number of virtqueues supported by this device
  *
- * Returns an error when fail to add to vDPA bus
+ * Return: Returns an error when fail to add to vDPA bus
  */
 int vdpa_register_device(struct vdpa_device *vdev, int nvqs)
 {
@@ -218,7 +218,7 @@ EXPORT_SYMBOL_GPL(vdpa_unregister_device);
  * @drv: the vdpa device driver to be registered
  * @owner: module owner of the driver
  *
- * Returns an err when fail to do the registration
+ * Return: Returns an err when fail to do the registration
  */
 int __vdpa_register_driver(struct vdpa_driver *drv, struct module *owner)
 {
@@ -245,6 +245,8 @@ EXPORT_SYMBOL_GPL(vdpa_unregister_driver);
  * @mdev: Pointer to vdpa management device
  * vdpa_mgmtdev_register() register a vdpa management device which supports
  * vdpa device management.
+ * Return: Returns 0 on success or failure when required callback ops are not
+ *         initialized.
  */
 int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev)
 {
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
