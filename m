Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E999EC77B7A
	for <virtualization@archiver.kernel.org>; Fri, 19 May 2023 21:57:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 765D1426E2;
	Fri, 19 May 2023 21:57:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 765D1426E2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gJo84eE2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0mcsF6rrG-Rq; Fri, 19 May 2023 21:57:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 33ECA426D2;
	Fri, 19 May 2023 21:57:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 33ECA426D2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 009F2C0036;
	Fri, 19 May 2023 21:57:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF932C0036
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 21:56:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A86C64012B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 21:56:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A86C64012B
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=gJo84eE2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ICXNsN7yeLCU
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 21:56:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B5E0D40222
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::617])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B5E0D40222
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 21:56:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/JogwNJixKdYscxBZ+wt6zKkV3QZW00pEDouhl2RxlOg0UMoOpY7V/et7xdmH6cIZhRAL2JKjCnnfaMnelItWIpQV1/0SeWHTALzh5j+s/8uXr9IMet1f2OaonuczbQBoe6qnvSpZcomxPG0Kg6e8rqpDjOYf4uRDPzlZ2zs5eCRd75wvuA0+1PP+u7JICbnhDNPy0RTNn1nsjDiAIo1KmH5vZ5ZYOpnPvcg6ZXlipktlUSyD9w7CBgTzVAFvsjxA0+DKb/ZXCd68Ekr4ZZdDZNJsGmWkk6La89cnFC8QNy3ZcP5S9NMQ4KKc9BytrUwqcgnc4XzJNnGSfx5VPLHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hO1OVx/y4DC3hfqDreSo0ry+yyEDQnOq9eb9/2WQ+PA=;
 b=L4a/Su/p2o5Jja9KuEUnUHinosyCpS2hSdL2HZjbWIAN5eIAqrs0zLogdj0uQWYiT7UxnkPKl7NcsjX7Yo/k16zO03roF53oJXaVUxl2lpve08JASAnOiAynNLIll91gBehf/ERIfUl0UF32D24tBh1QcyPG6bRmoO9nP0blVamwy9OIeK+hup2VPRRESiTxnP95tDq/dWe1gF4gRfQDLYD93x0bEsFsL4zTnf/Jo+BbGK/J224kK0LF1u+bxqrYcIR6Fp+s32Y9hVR65nqV2ZBWEGyrVsdEC/69RQ1Qx8TIMkyvZzfYTvl0POaNc/EhnjJiHxu8jAT69a032DQIkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hO1OVx/y4DC3hfqDreSo0ry+yyEDQnOq9eb9/2WQ+PA=;
 b=gJo84eE2sdEh6RBklmBA5cAKe+/Wpepy2pTEUiK5RWjEfWUxh7xtkQDdQebkQFj1vMOeLg7dpZEo1sRoFjnErlJI7KhbU3e1JleS290/5rRZbph4nb/zIUUsyKcdHhDvAkUpQU9MGMnUxCvwFzVdG+zAUE5lkxy4qBsWidK3W/g=
Received: from BN8PR03CA0008.namprd03.prod.outlook.com (2603:10b6:408:94::21)
 by DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.19; Fri, 19 May 2023 21:56:53 +0000
Received: from BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::c) by BN8PR03CA0008.outlook.office365.com
 (2603:10b6:408:94::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 21:56:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT071.mail.protection.outlook.com (10.13.177.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 21:56:52 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 16:56:51 -0500
To: <jasowang@redhat.com>, <mst@redhat.com>,
 <virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
 <brett.creeley@amd.com>, <netdev@vger.kernel.org>
Subject: [PATCH v7 virtio 03/11] pds_vdpa: Add new vDPA driver for
 AMD/Pensando DSC
Date: Fri, 19 May 2023 14:56:24 -0700
Message-ID: <20230519215632.12343-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230519215632.12343-1-shannon.nelson@amd.com>
References: <20230519215632.12343-1-shannon.nelson@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT071:EE_|DS7PR12MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 223e5ca6-b7da-4d03-ba69-08db58b3f478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jFRnFjsjfmr8qsWFdgrP/1FpYVTsqF0g0AywWtCBMd+3SG6UHGGYJXygfoPGXXi4CymlqfrOQHQmzb5NngB1w9udK+fNXHGcRolo+7ODs2UdYvl6kCKD7qt0WIWnSLFgL2KAvYRrAPal+FlnC542dL11d9yxAwTIE/6LSryc6HtONXV2/tGJW4OsK4jqw/7aw25l8CQDOHxxZ55kF/p30UXr3IKtgo8FKWQljhMnyXzfnMxA35D/xL8MKNLAsPkskrLzxZIjicccFOmpwCFls+HRUBifLr0FXsWaRKyQLCpRtLJV7+TixlR4D0N3ivWCmeyNoR+NYBzCpIlN08X85lLdHcyuDpbtNzE4iyPjZnBpp9UEH2hh74Nl3BfRh2LEsQFaPG0+f4joxNEny6FceML/WJMcqJ/dGv7a5yu2aXJNg80Ql3C20AauL9ds4jd85GK+Ej0D1BGIQHRpJkvPASe1preeSJLOLipxbJuow+k7emJzs374ri6tKlakgeFFUgKV7PquHbfKOMhEQhgPjFAWLQEqSYnveuR5SpztjLqjwp6aFuHbtml0+sxmjq5dKYuRpfLuHn2gBfccq0KsUjm/MlRm6ws+Ad6LWSm2vRt1IjesBRh7ELhq2zOTADlOMZofBzUH/mFolPSWFXbX1Bm/dkBA/qqHa1QQxtU0OiTiwJ6VUQfIbw6OwnZK0YFt/YZ++WAPu3nk6ITj29QYwCNjsm9B46PTnzEP/iBah7gfA4Xxu1DOQqjr/c8Djs+BdK+cGHoEpaKYfHyrarUCpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(40470700004)(36840700001)(46966006)(86362001)(8936002)(41300700001)(8676002)(82740400003)(70206006)(4326008)(82310400005)(336012)(54906003)(356005)(81166007)(70586007)(316002)(44832011)(2906002)(36756003)(110136005)(478600001)(83380400001)(47076005)(426003)(2616005)(36860700001)(40480700001)(6666004)(5660300002)(26005)(16526019)(40460700003)(1076003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 21:56:52.6531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 223e5ca6-b7da-4d03-ba69-08db58b3f478
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8252
Cc: simon.horman@corigine.com, drivers@pensando.io
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
From: Shannon Nelson via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Shannon Nelson <shannon.nelson@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is the initial auxiliary driver framework for a new vDPA
device driver, an auxiliary_bus client of the pds_core driver.
The pds_core driver supplies the PCI services for the VF device
and for accessing the adminq in the PF device.

This patch adds the very basics of registering for the auxiliary
device and setting up debugfs entries.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/Makefile          |  1 +
 drivers/vdpa/pds/Makefile      |  8 ++++
 drivers/vdpa/pds/aux_drv.c     | 83 ++++++++++++++++++++++++++++++++++
 drivers/vdpa/pds/aux_drv.h     | 15 ++++++
 drivers/vdpa/pds/debugfs.c     | 25 ++++++++++
 drivers/vdpa/pds/debugfs.h     | 12 +++++
 include/linux/pds/pds_common.h |  2 +
 7 files changed, 146 insertions(+)
 create mode 100644 drivers/vdpa/pds/Makefile
 create mode 100644 drivers/vdpa/pds/aux_drv.c
 create mode 100644 drivers/vdpa/pds/aux_drv.h
 create mode 100644 drivers/vdpa/pds/debugfs.c
 create mode 100644 drivers/vdpa/pds/debugfs.h

diff --git a/drivers/vdpa/Makefile b/drivers/vdpa/Makefile
index 59396ff2a318..8f53c6f3cca7 100644
--- a/drivers/vdpa/Makefile
+++ b/drivers/vdpa/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_MLX5_VDPA) += mlx5/
 obj-$(CONFIG_VP_VDPA)    += virtio_pci/
 obj-$(CONFIG_ALIBABA_ENI_VDPA) += alibaba/
 obj-$(CONFIG_SNET_VDPA) += solidrun/
+obj-$(CONFIG_PDS_VDPA) += pds/
diff --git a/drivers/vdpa/pds/Makefile b/drivers/vdpa/pds/Makefile
new file mode 100644
index 000000000000..a9cd2f450ae1
--- /dev/null
+++ b/drivers/vdpa/pds/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright(c) 2023 Advanced Micro Devices, Inc
+
+obj-$(CONFIG_PDS_VDPA) := pds_vdpa.o
+
+pds_vdpa-y := aux_drv.o
+
+pds_vdpa-$(CONFIG_DEBUG_FS) += debugfs.o
diff --git a/drivers/vdpa/pds/aux_drv.c b/drivers/vdpa/pds/aux_drv.c
new file mode 100644
index 000000000000..e4a0ad61ea22
--- /dev/null
+++ b/drivers/vdpa/pds/aux_drv.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Advanced Micro Devices, Inc */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/pci.h>
+
+#include <linux/pds/pds_common.h>
+#include <linux/pds/pds_core_if.h>
+#include <linux/pds/pds_adminq.h>
+#include <linux/pds/pds_auxbus.h>
+
+#include "aux_drv.h"
+#include "debugfs.h"
+
+static const struct auxiliary_device_id pds_vdpa_id_table[] = {
+	{ .name = PDS_VDPA_DEV_NAME, },
+	{},
+};
+
+static int pds_vdpa_probe(struct auxiliary_device *aux_dev,
+			  const struct auxiliary_device_id *id)
+
+{
+	struct pds_auxiliary_dev *padev =
+		container_of(aux_dev, struct pds_auxiliary_dev, aux_dev);
+	struct pds_vdpa_aux *vdpa_aux;
+
+	vdpa_aux = kzalloc(sizeof(*vdpa_aux), GFP_KERNEL);
+	if (!vdpa_aux)
+		return -ENOMEM;
+
+	vdpa_aux->padev = padev;
+	auxiliary_set_drvdata(aux_dev, vdpa_aux);
+
+	return 0;
+}
+
+static void pds_vdpa_remove(struct auxiliary_device *aux_dev)
+{
+	struct pds_vdpa_aux *vdpa_aux = auxiliary_get_drvdata(aux_dev);
+	struct device *dev = &aux_dev->dev;
+
+	kfree(vdpa_aux);
+	auxiliary_set_drvdata(aux_dev, NULL);
+
+	dev_info(dev, "Removed\n");
+}
+
+static struct auxiliary_driver pds_vdpa_driver = {
+	.name = PDS_DEV_TYPE_VDPA_STR,
+	.probe = pds_vdpa_probe,
+	.remove = pds_vdpa_remove,
+	.id_table = pds_vdpa_id_table,
+};
+
+static void __exit pds_vdpa_cleanup(void)
+{
+	auxiliary_driver_unregister(&pds_vdpa_driver);
+
+	pds_vdpa_debugfs_destroy();
+}
+module_exit(pds_vdpa_cleanup);
+
+static int __init pds_vdpa_init(void)
+{
+	int err;
+
+	pds_vdpa_debugfs_create();
+
+	err = auxiliary_driver_register(&pds_vdpa_driver);
+	if (err) {
+		pr_err("%s: aux driver register failed: %pe\n",
+		       PDS_VDPA_DRV_NAME, ERR_PTR(err));
+		pds_vdpa_debugfs_destroy();
+	}
+
+	return err;
+}
+module_init(pds_vdpa_init);
+
+MODULE_DESCRIPTION(PDS_VDPA_DRV_DESCRIPTION);
+MODULE_AUTHOR("Advanced Micro Devices, Inc");
+MODULE_LICENSE("GPL");
diff --git a/drivers/vdpa/pds/aux_drv.h b/drivers/vdpa/pds/aux_drv.h
new file mode 100644
index 000000000000..f1e99359424e
--- /dev/null
+++ b/drivers/vdpa/pds/aux_drv.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2023 Advanced Micro Devices, Inc */
+
+#ifndef _AUX_DRV_H_
+#define _AUX_DRV_H_
+
+#define PDS_VDPA_DRV_DESCRIPTION    "AMD/Pensando vDPA VF Device Driver"
+#define PDS_VDPA_DRV_NAME           KBUILD_MODNAME
+
+struct pds_vdpa_aux {
+	struct pds_auxiliary_dev *padev;
+
+	struct dentry *dentry;
+};
+#endif /* _AUX_DRV_H_ */
diff --git a/drivers/vdpa/pds/debugfs.c b/drivers/vdpa/pds/debugfs.c
new file mode 100644
index 000000000000..5be22fb7a76a
--- /dev/null
+++ b/drivers/vdpa/pds/debugfs.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Advanced Micro Devices, Inc */
+
+#include <linux/pci.h>
+
+#include <linux/pds/pds_common.h>
+#include <linux/pds/pds_core_if.h>
+#include <linux/pds/pds_adminq.h>
+#include <linux/pds/pds_auxbus.h>
+
+#include "aux_drv.h"
+#include "debugfs.h"
+
+static struct dentry *dbfs_dir;
+
+void pds_vdpa_debugfs_create(void)
+{
+	dbfs_dir = debugfs_create_dir(PDS_VDPA_DRV_NAME, NULL);
+}
+
+void pds_vdpa_debugfs_destroy(void)
+{
+	debugfs_remove_recursive(dbfs_dir);
+	dbfs_dir = NULL;
+}
diff --git a/drivers/vdpa/pds/debugfs.h b/drivers/vdpa/pds/debugfs.h
new file mode 100644
index 000000000000..658849591a99
--- /dev/null
+++ b/drivers/vdpa/pds/debugfs.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2023 Advanced Micro Devices, Inc */
+
+#ifndef _PDS_VDPA_DEBUGFS_H_
+#define _PDS_VDPA_DEBUGFS_H_
+
+#include <linux/debugfs.h>
+
+void pds_vdpa_debugfs_create(void);
+void pds_vdpa_debugfs_destroy(void);
+
+#endif /* _PDS_VDPA_DEBUGFS_H_ */
diff --git a/include/linux/pds/pds_common.h b/include/linux/pds/pds_common.h
index 060331486d50..2a0d1669cfd0 100644
--- a/include/linux/pds/pds_common.h
+++ b/include/linux/pds/pds_common.h
@@ -39,6 +39,8 @@ enum pds_core_vif_types {
 #define PDS_DEV_TYPE_RDMA_STR	"RDMA"
 #define PDS_DEV_TYPE_LM_STR	"LM"
 
+#define PDS_VDPA_DEV_NAME	PDS_CORE_DRV_NAME "." PDS_DEV_TYPE_VDPA_STR
+
 #define PDS_CORE_IFNAMSIZ		16
 
 /**
-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
