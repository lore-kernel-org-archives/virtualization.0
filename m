Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE10C7EE2C
	for <virtualization@archiver.kernel.org>; Tue, 16 May 2023 02:56:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E8C5241452;
	Tue, 16 May 2023 02:56:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E8C5241452
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kfObty4z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K5U7xibZM1nG; Tue, 16 May 2023 02:55:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B41CA41DE3;
	Tue, 16 May 2023 02:55:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B41CA41DE3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EFDDC0095;
	Tue, 16 May 2023 02:55:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A119FC0037
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 02:55:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6D18F41C59
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 02:55:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6D18F41C59
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=kfObty4z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mPriyxwKPz6S
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 02:55:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E5EF41BDF
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::600])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0E5EF41BDF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 02:55:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgZFVyxzPmdUdbLyzRQdC9XI7SsEjXsgivO7AQXeGmEu0vyKr015+LsuLWmET9m6meJlYUPGn+lSi7ipw6aI9eF9Jkrsl0Ng2o9fshGTpxAwPiwbKfeRIr/LhZk/7GfUEw1nIF4xZqUQEnOeKOIP2aO2+U98Qr5CW2WH5qfs/Etck8BL8ikvcZgSJTXVto+EGGV0UQ1CvwjZJ7VakhLpXvZs+LVPg2w5Xp5t6wdFhE8DNNi5ZVj0HbTYwuUj4tHiuaIQWXiGMwZdJVTmuuZ5YHY6kmk8s7HnSNocEU8aYJ/Wwqkl8mL0OWckmZZvlpefoaikamWsAKcpzQJ11Db/7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7pl08gsZAq6M5LfC/8SmQl1rwIMMSjRMfx5i814uyA=;
 b=Y4YK5jnKWLePBHKccUAUwRRZpLhmtxuZg49Ulx0VtPRyOccQCx7+8G5dSNxmbv8p8YEGPONsz7BCZhi24aQN1ME1EqIu/eXbDwG57nj6U1rPFpAcJF5eS47gwowtrpVT0wv9k0Y3GC1XamZbPA7obnIlK8/YwNvtAo6OyilWV+tD7fjFmSeY2Hn9hDlEqukRdwOsSw7zovzDGJhmudXw9c4sWsfca/uEiaxZOsI+hlY/Fb3i0PPXTUWeiMFj/XS6LWLyv55O2WsgeyWYHKs4aBplr/b91kOKgk8ZGyqMO+FVqrrJw051bmK20jEkMhhD9GMjppg1DOxMjf3hfwkbsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7pl08gsZAq6M5LfC/8SmQl1rwIMMSjRMfx5i814uyA=;
 b=kfObty4zp89IRJCy693bFLwed7CTDIEXHHZbdlOA5NQx9eB8JESNtYgvE/VxBgySPINVEKxHrbhRhdyyxOTiRUFKLlDDChRotHFFshCwbepaHxhFae9nmU6jxgyADuVhg2XvppruP/K2PbbYNiIhhCvqJBDxHSfpAR6W/XSTt3A=
Received: from SJ0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:a03:33a::13)
 by MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 02:55:49 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33a:cafe::4e) by SJ0PR03CA0008.outlook.office365.com
 (2603:10b6:a03:33a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 02:55:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 02:55:49 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 15 May
 2023 21:55:47 -0500
To: <jasowang@redhat.com>, <mst@redhat.com>,
 <virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
 <brett.creeley@amd.com>, <netdev@vger.kernel.org>
Subject: [PATCH v6 virtio 06/11] pds_vdpa: get vdpa management info
Date: Mon, 15 May 2023 19:55:16 -0700
Message-ID: <20230516025521.43352-7-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230516025521.43352-1-shannon.nelson@amd.com>
References: <20230516025521.43352-1-shannon.nelson@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT096:EE_|MW4PR12MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: ae8b918b-c13a-4d77-b856-08db55b90df5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IoCzjQEH4gov4tP1DkTidjJwmM1UZsGtYliOZmB7zk+SuogSYtFK7kVHtQGILoEii3AHM/YrHU8iupUzbj4F80a1LxKLklaZ9vfHLbJ6WNemxwyyY+AH73LJ6kqJVIegwZ4BBImQvd45uvQynScqaCRPBMIKyMetb4gL7KrwA7t4Zb2IGMTO44Ch645fotSruHSpjOIH3xBDrNFVJkylb7AtPejVTrFhhhjSb7GJXQL4Ea6LwxQBei5XSiiSXRWt8EcIkVW9WJ9GFclscckM+5cE0D5nPKcnhQ7S0WQPOqu6yFHuoud/sO6hH0LRSFjCPriQPWbgix4vnC6+u+RJoaM1OM2cQtNmPoZK+0vgdzO2YOFAqHTOLLU2DBJmhBNfZYIK11GbxOt4FrIFD2REC751ltaogtA/u4C7n7c9LS04e4oPT0Q/R0kZ/9ZJ1MsjSAUWUGkDNgIrCBzkQT6JOjzy4OB/zNOCyZQyc+HhRarpCz4yeiyX8i7rn8fLXLfslfWNb1pLAtrJGCDLg7vDOs3msrtT/RIHjpp44q1EGmjgvcPdCLnC8Ad96ug4y2XbzlvXbKEWRSss+Yc46uj5NKGfZ6PZ9P7q23/qVlzfwhEDLHUeDwqaYn+7H7vsQCE7GcBoozf5X/SezGQVFxy1gB6CpCtZ5PmzUwXaOyD4Iq+EpVfuGOcIkZBRABEq5vrOZGvhClIAQpNItQODMwuB2T2x4Y3FomlgyenlvtW4e9xM7DV/cu2X6IWJCwa1mPk93gIai9BDgq3kfKhhXqH2bw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(36840700001)(40470700004)(46966006)(478600001)(110136005)(70586007)(70206006)(6666004)(36756003)(54906003)(316002)(4326008)(86362001)(40460700003)(82310400005)(36860700001)(426003)(1076003)(82740400003)(186003)(47076005)(336012)(81166007)(356005)(26005)(2616005)(5660300002)(41300700001)(2906002)(44832011)(8936002)(8676002)(16526019)(83380400001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 02:55:49.3793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8b918b-c13a-4d77-b856-08db55b90df5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144
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

Find the vDPA management information from the DSC in order to
advertise it to the vdpa subsystem.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/pds/Makefile   |   3 +-
 drivers/vdpa/pds/aux_drv.c  |  17 ++++++
 drivers/vdpa/pds/aux_drv.h  |   7 +++
 drivers/vdpa/pds/debugfs.c  |   1 +
 drivers/vdpa/pds/vdpa_dev.c | 108 ++++++++++++++++++++++++++++++++++++
 drivers/vdpa/pds/vdpa_dev.h |  15 +++++
 6 files changed, 150 insertions(+), 1 deletion(-)
 create mode 100644 drivers/vdpa/pds/vdpa_dev.c
 create mode 100644 drivers/vdpa/pds/vdpa_dev.h

diff --git a/drivers/vdpa/pds/Makefile b/drivers/vdpa/pds/Makefile
index a9cd2f450ae1..13b50394ec64 100644
--- a/drivers/vdpa/pds/Makefile
+++ b/drivers/vdpa/pds/Makefile
@@ -3,6 +3,7 @@
 
 obj-$(CONFIG_PDS_VDPA) := pds_vdpa.o
 
-pds_vdpa-y := aux_drv.o
+pds_vdpa-y := aux_drv.o \
+	      vdpa_dev.o
 
 pds_vdpa-$(CONFIG_DEBUG_FS) += debugfs.o
diff --git a/drivers/vdpa/pds/aux_drv.c b/drivers/vdpa/pds/aux_drv.c
index e4a0ad61ea22..aa748cf55d2b 100644
--- a/drivers/vdpa/pds/aux_drv.c
+++ b/drivers/vdpa/pds/aux_drv.c
@@ -3,6 +3,7 @@
 
 #include <linux/auxiliary_bus.h>
 #include <linux/pci.h>
+#include <linux/vdpa.h>
 
 #include <linux/pds/pds_common.h>
 #include <linux/pds/pds_core_if.h>
@@ -11,6 +12,7 @@
 
 #include "aux_drv.h"
 #include "debugfs.h"
+#include "vdpa_dev.h"
 
 static const struct auxiliary_device_id pds_vdpa_id_table[] = {
 	{ .name = PDS_VDPA_DEV_NAME, },
@@ -24,15 +26,28 @@ static int pds_vdpa_probe(struct auxiliary_device *aux_dev,
 	struct pds_auxiliary_dev *padev =
 		container_of(aux_dev, struct pds_auxiliary_dev, aux_dev);
 	struct pds_vdpa_aux *vdpa_aux;
+	int err;
 
 	vdpa_aux = kzalloc(sizeof(*vdpa_aux), GFP_KERNEL);
 	if (!vdpa_aux)
 		return -ENOMEM;
 
 	vdpa_aux->padev = padev;
+	vdpa_aux->vf_id = pci_iov_vf_id(padev->vf_pdev);
 	auxiliary_set_drvdata(aux_dev, vdpa_aux);
 
+	/* Get device ident info and set up the vdpa_mgmt_dev */
+	err = pds_vdpa_get_mgmt_info(vdpa_aux);
+	if (err)
+		goto err_free_mem;
+
 	return 0;
+
+err_free_mem:
+	kfree(vdpa_aux);
+	auxiliary_set_drvdata(aux_dev, NULL);
+
+	return err;
 }
 
 static void pds_vdpa_remove(struct auxiliary_device *aux_dev)
@@ -40,6 +55,8 @@ static void pds_vdpa_remove(struct auxiliary_device *aux_dev)
 	struct pds_vdpa_aux *vdpa_aux = auxiliary_get_drvdata(aux_dev);
 	struct device *dev = &aux_dev->dev;
 
+	pci_free_irq_vectors(vdpa_aux->padev->vf_pdev);
+
 	kfree(vdpa_aux);
 	auxiliary_set_drvdata(aux_dev, NULL);
 
diff --git a/drivers/vdpa/pds/aux_drv.h b/drivers/vdpa/pds/aux_drv.h
index f1e99359424e..dcec782e79eb 100644
--- a/drivers/vdpa/pds/aux_drv.h
+++ b/drivers/vdpa/pds/aux_drv.h
@@ -10,6 +10,13 @@
 struct pds_vdpa_aux {
 	struct pds_auxiliary_dev *padev;
 
+	struct vdpa_mgmt_dev vdpa_mdev;
+
+	struct pds_vdpa_ident ident;
+
+	int vf_id;
 	struct dentry *dentry;
+
+	int nintrs;
 };
 #endif /* _AUX_DRV_H_ */
diff --git a/drivers/vdpa/pds/debugfs.c b/drivers/vdpa/pds/debugfs.c
index 5be22fb7a76a..d91dceb07380 100644
--- a/drivers/vdpa/pds/debugfs.c
+++ b/drivers/vdpa/pds/debugfs.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2023 Advanced Micro Devices, Inc */
 
 #include <linux/pci.h>
+#include <linux/vdpa.h>
 
 #include <linux/pds/pds_common.h>
 #include <linux/pds/pds_core_if.h>
diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
new file mode 100644
index 000000000000..0f0f0ab8b811
--- /dev/null
+++ b/drivers/vdpa/pds/vdpa_dev.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Advanced Micro Devices, Inc */
+
+#include <linux/pci.h>
+#include <linux/vdpa.h>
+#include <uapi/linux/vdpa.h>
+
+#include <linux/pds/pds_common.h>
+#include <linux/pds/pds_core_if.h>
+#include <linux/pds/pds_adminq.h>
+#include <linux/pds/pds_auxbus.h>
+
+#include "vdpa_dev.h"
+#include "aux_drv.h"
+
+static struct virtio_device_id pds_vdpa_id_table[] = {
+	{VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID},
+	{0},
+};
+
+static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
+			    const struct vdpa_dev_set_config *add_config)
+{
+	return -EOPNOTSUPP;
+}
+
+static void pds_vdpa_dev_del(struct vdpa_mgmt_dev *mdev,
+			     struct vdpa_device *vdpa_dev)
+{
+}
+
+static const struct vdpa_mgmtdev_ops pds_vdpa_mgmt_dev_ops = {
+	.dev_add = pds_vdpa_dev_add,
+	.dev_del = pds_vdpa_dev_del
+};
+
+int pds_vdpa_get_mgmt_info(struct pds_vdpa_aux *vdpa_aux)
+{
+	union pds_core_adminq_cmd cmd = {
+		.vdpa_ident.opcode = PDS_VDPA_CMD_IDENT,
+		.vdpa_ident.vf_id = cpu_to_le16(vdpa_aux->vf_id),
+	};
+	union pds_core_adminq_comp comp = {};
+	struct vdpa_mgmt_dev *mgmt;
+	struct pci_dev *pf_pdev;
+	struct device *pf_dev;
+	struct pci_dev *pdev;
+	dma_addr_t ident_pa;
+	struct device *dev;
+	u16 dev_intrs;
+	u16 max_vqs;
+	int err;
+
+	dev = &vdpa_aux->padev->aux_dev.dev;
+	pdev = vdpa_aux->padev->vf_pdev;
+	mgmt = &vdpa_aux->vdpa_mdev;
+
+	/* Get resource info through the PF's adminq.  It is a block of info,
+	 * so we need to map some memory for PF to make available to the
+	 * firmware for writing the data.
+	 */
+	pf_pdev = pci_physfn(vdpa_aux->padev->vf_pdev);
+	pf_dev = &pf_pdev->dev;
+	ident_pa = dma_map_single(pf_dev, &vdpa_aux->ident,
+				  sizeof(vdpa_aux->ident), DMA_FROM_DEVICE);
+	if (dma_mapping_error(pf_dev, ident_pa)) {
+		dev_err(dev, "Failed to map ident space\n");
+		return -ENOMEM;
+	}
+
+	cmd.vdpa_ident.ident_pa = cpu_to_le64(ident_pa);
+	cmd.vdpa_ident.len = cpu_to_le32(sizeof(vdpa_aux->ident));
+	err = pds_client_adminq_cmd(vdpa_aux->padev, &cmd,
+				    sizeof(cmd.vdpa_ident), &comp, 0);
+	dma_unmap_single(pf_dev, ident_pa,
+			 sizeof(vdpa_aux->ident), DMA_FROM_DEVICE);
+	if (err) {
+		dev_err(dev, "Failed to ident hw, status %d: %pe\n",
+			comp.status, ERR_PTR(err));
+		return err;
+	}
+
+	max_vqs = le16_to_cpu(vdpa_aux->ident.max_vqs);
+	dev_intrs = pci_msix_vec_count(pdev);
+	dev_dbg(dev, "ident.max_vqs %d dev_intrs %d\n", max_vqs, dev_intrs);
+
+	max_vqs = min_t(u16, dev_intrs, max_vqs);
+	mgmt->max_supported_vqs = min_t(u16, PDS_VDPA_MAX_QUEUES, max_vqs);
+	vdpa_aux->nintrs = mgmt->max_supported_vqs;
+
+	mgmt->ops = &pds_vdpa_mgmt_dev_ops;
+	mgmt->id_table = pds_vdpa_id_table;
+	mgmt->device = dev;
+	mgmt->supported_features = le64_to_cpu(vdpa_aux->ident.hw_features);
+	mgmt->config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
+	mgmt->config_attr_mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
+
+	err = pci_alloc_irq_vectors(pdev, vdpa_aux->nintrs, vdpa_aux->nintrs,
+				    PCI_IRQ_MSIX);
+	if (err < 0) {
+		dev_err(dev, "Couldn't get %d msix vectors: %pe\n",
+			vdpa_aux->nintrs, ERR_PTR(err));
+		return err;
+	}
+	vdpa_aux->nintrs = err;
+
+	return 0;
+}
diff --git a/drivers/vdpa/pds/vdpa_dev.h b/drivers/vdpa/pds/vdpa_dev.h
new file mode 100644
index 000000000000..97fab833a0aa
--- /dev/null
+++ b/drivers/vdpa/pds/vdpa_dev.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2023 Advanced Micro Devices, Inc */
+
+#ifndef _VDPA_DEV_H_
+#define _VDPA_DEV_H_
+
+#define PDS_VDPA_MAX_QUEUES	65
+
+struct pds_vdpa_device {
+	struct vdpa_device vdpa_dev;
+	struct pds_vdpa_aux *vdpa_aux;
+};
+
+int pds_vdpa_get_mgmt_info(struct pds_vdpa_aux *vdpa_aux);
+#endif /* _VDPA_DEV_H_ */
-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
