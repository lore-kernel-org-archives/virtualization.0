Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64E4C77B75
	for <virtualization@archiver.kernel.org>; Wed,  3 May 2023 18:13:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4F1BB40201;
	Wed,  3 May 2023 18:13:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4F1BB40201
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=trMfP3B4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eQF7VlMuTHj9; Wed,  3 May 2023 18:13:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 930E341D2D;
	Wed,  3 May 2023 18:13:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 930E341D2D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59D03C008C;
	Wed,  3 May 2023 18:13:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50F40C0037
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 18:13:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E1B6183C87
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 18:13:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E1B6183C87
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=trMfP3B4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id feansabaidaL
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 18:13:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D36AB82044
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::620])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D36AB82044
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 18:13:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCyM0gVaegX+MiX7ToI+EmBtpdZyoswtkr8ZVsn0RRpfPga+b7XaMmyOfLRPdWFryNbZsEp14f9NQVMnjidOHibQU8J0wSnjyTn+G2LNFRjgwbL4qSa3dzjzr22mcgMBl0CJ82ceRh+I6OXxP0Gor/2nEbGw7v+Cy4P5ACCrRliYkJ/gMacKgAZb7A7xjeETUQbvWQwhLiXydu/sSY4JsAPOjcrOKl/71RRtsL7WffSQuSlWmdPPzUm/u6VEUcH6h5KNRPmz027ExIjc3VFyWva2G9WzfjsQ6moQILIhAdjNeFouoj3OAnAANtsVUfhW5HcNt58ITxVgdHD5iXpDGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hO1OVx/y4DC3hfqDreSo0ry+yyEDQnOq9eb9/2WQ+PA=;
 b=ABXij3kOiXOL4fPKCTaVVjgWcNaJmvlJoIj+g1WAY2KNhhyliV+cCKZsEUAUjIZlXLqx7VJjome7Jsf8yXOK8WDQM0Ua6fYl68iycfrGFrKKtZXrZYSaLLPnEaaE5Wd+mdZMd0r/uiO8ZNiRUBWldiyRer9K7Y1WyoyXi0KZD7/3bC/UbkzmbD/XqdUq6h9lYbWWVmAJjqFRmjEIiFJa3kg+dwOXJwJM+UZZO2iCWizfjetrFeFCXDD20xaMugZIwxqnzczjlsCtmtvQ4bd79RswG/U6DhvD5LnJrZFYgCgWqwgZ3B/u8nzHrzFBefkmW+zeQ8T2/WK1jz2TmtVTdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hO1OVx/y4DC3hfqDreSo0ry+yyEDQnOq9eb9/2WQ+PA=;
 b=trMfP3B4mnp2psf1wElnO2moVwGrqhiSb8RiSUXDFit0mrUNdyAk6tXxA9NcEVbXX/1oga77HDLjQgEmBr24qQwLpjptW88RPCdSWjqJimluqlWIipVBfFFjG20WHyQpSckXUJo8b4WRcqJ4URUmR+pnODG91FR02ne7Nffh3lg=
Received: from DM6PR03CA0068.namprd03.prod.outlook.com (2603:10b6:5:100::45)
 by CY8PR12MB8194.namprd12.prod.outlook.com (2603:10b6:930:76::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 18:13:01 +0000
Received: from DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::9) by DM6PR03CA0068.outlook.office365.com
 (2603:10b6:5:100::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22 via Frontend
 Transport; Wed, 3 May 2023 18:13:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT109.mail.protection.outlook.com (10.13.173.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.22 via Frontend Transport; Wed, 3 May 2023 18:13:01 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 3 May
 2023 13:12:59 -0500
To: <jasowang@redhat.com>, <mst@redhat.com>,
 <virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
 <brett.creeley@amd.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 virtio 03/11] pds_vdpa: Add new vDPA driver for
 AMD/Pensando DSC
Date: Wed, 3 May 2023 11:12:32 -0700
Message-ID: <20230503181240.14009-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230503181240.14009-1-shannon.nelson@amd.com>
References: <20230503181240.14009-1-shannon.nelson@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT109:EE_|CY8PR12MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 35633cb6-fe7f-4be3-f58e-08db4c02080b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HUmdQnASLFwfRticZlfBuRIx+hqUZM3htTyNGNfEJ1hJGGfzqmgHQuC7T0LGnfMmjjkKPM7fzwYhH54Qeco0qUMb6BURhYHafcybFtiJcOB0zhRc0wZto2ypnMiBm71LltLV2mB7D7+gx9+4QiDKNprdlHg6YcbWDVYSUsJf7Wg4p5CMj3gxKFkHhjbuS5uLRl2Kw7NJEcEOcGYIaUuXoulrqZA2qEKEWsGzag0J/dMLO4+q6PtrewvQBGu9n7pBEbC8/L4tr5UhQRvRxfmOcCZZyB2A6Ovh/ZSQvV2k5S9GmJMVETsOftQ2WPQPqrG5t572gOtRRc7uPatxYa51Aca6hg3TnSxR4uLO0aZqa9Voo8IkDcLeqerFGzEhPLLfonKiH6zkKgAKfelWHT0g8K8S5IQvXyIQr8acGjBNILGl4uTDnHoY6ciQO4sBFEStpkJ0HbVUxwX91YGJysIZI2c/YTtHsdoVFGTYDHuyCkDGFScSinyG3IySLrd1tT7WHUegEn+M7i7Dx5p6zqk4wzx7VxKldfGrhZSq/MMWf6ocNTQdzptsNvySB+eV7z4Mligljt8Jfo2sVAqfZQgv7RvaoZIrXZ21MR12BXz7Z1LaONGA/eIZAO6XgVO5GzolQTOljqRnUK7O7uZCQ+1qNdvceZf2KanKXDMDC1r8gjIbMSDN5EXa3YR7H3XzBzI66HUPWmbh5OQsGRRkZ8sA7aDBVnVaYDB57jvyh+Y+bxE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(86362001)(8936002)(8676002)(4326008)(41300700001)(70206006)(70586007)(81166007)(316002)(82740400003)(356005)(5660300002)(44832011)(40480700001)(2906002)(16526019)(186003)(1076003)(26005)(36860700001)(6666004)(47076005)(426003)(83380400001)(336012)(36756003)(82310400005)(54906003)(110136005)(2616005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 18:13:01.0923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35633cb6-fe7f-4be3-f58e-08db4c02080b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8194
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
