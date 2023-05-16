Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A3EC77B7D
	for <virtualization@archiver.kernel.org>; Tue, 16 May 2023 02:56:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0674084064;
	Tue, 16 May 2023 02:56:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0674084064
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5qjKNvA+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wsbfmi3JXF1x; Tue, 16 May 2023 02:56:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2DAA784167;
	Tue, 16 May 2023 02:55:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2DAA784167
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3546C007E;
	Tue, 16 May 2023 02:55:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65175C0096
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 02:55:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2CF09615DC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 02:55:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2CF09615DC
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=5qjKNvA+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 09t65kbmYIDw
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 02:55:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA015615E2
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::617])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EA015615E2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 02:55:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSuyv+xf4p5xEaqc4ndaotqabGCrgd9DLfe27hcNWaI7wraJwsDhD1jXjbuayC2ybNc/KirsUOaRT7X30UJAofz0nEymCSJu58dxQAoDNmkCv8JvIiOZHjmD55kCkjiIyVcwzw7GHPUfQ6pE5u+ld4UygQXJK/VwkSb8dkBHyozz001Qb5IUBTt5kezxreOmJeeRobnoxgcsOsOJC8MfsKf92UoSyHXQs2CUjHqek2By0oF0SaZBTWFBaSyKnmLx6w9ITdSHXEaXKI0oLCrl33Rdn6e+cJgI/mZKjNpB/qtWG/Emy2VvqNbJuFmxwgMRVXuymkSN5MTm1eBIdZ7i4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cMQJdmdzsxJ2kM66vHCHLSEYBcgp+6lYO1eq3z2SsU=;
 b=gKtDsJMNBd/4oANw2rVRU+r583J+hCHsw6QOhWLhb+M0CCj44ZEZJpvJ1gljSXXkMmxsYmUScaMIXQwAa+kHrjftJnd/cS3rYZpPSj2vW4QtJnvvP9TA3xd2+DzOzXrZjWw8BnSiLsI/7gYPlxntvqdQSpWhEcwQcOfzlHRjj4mIIwSLRSDj2M5PadkIOo2HWm53Ox3xZ2EAj/vKavC4uypsRtkLMaqJtz69I4ecADH89GjZGD8CrMtC+ylybAJHS7Sc3OOAWq/N8eAUJVsW/xusysrJS5+i6IjF4weKb9gb+73mv2cUI4ETQJiyA085NXlup1t/j+n2KryvKEYpjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cMQJdmdzsxJ2kM66vHCHLSEYBcgp+6lYO1eq3z2SsU=;
 b=5qjKNvA+6jbleAfsWo/cb+roCBAfML+gFLStfik32vfxnqhlIco0jj7RSsh9YNu9UrzLNDQ0YguDyZB8jM8AQw0n54nf+2BRVYs0xdCWNniCeTJvNvR1mbuyxJS7SBa/FH68XR3MuLKx/d3cdm1FP9szSTkCKx+v2JHTmlyNDto=
Received: from SJ0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:33a::32)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 02:55:51 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33a:cafe::48) by SJ0PR03CA0027.outlook.office365.com
 (2603:10b6:a03:33a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Tue, 16 May 2023 02:55:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 02:55:50 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 15 May
 2023 21:55:49 -0500
To: <jasowang@redhat.com>, <mst@redhat.com>,
 <virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
 <brett.creeley@amd.com>, <netdev@vger.kernel.org>
Subject: [PATCH v6 virtio 08/11] pds_vdpa: add vdpa config client commands
Date: Mon, 15 May 2023 19:55:18 -0700
Message-ID: <20230516025521.43352-9-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230516025521.43352-1-shannon.nelson@amd.com>
References: <20230516025521.43352-1-shannon.nelson@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT096:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 919d2657-e996-4b2e-f85b-08db55b90edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GX8hvOeqI2Gg9Z028BYbA8hpUBhjISI2CF7/lFV8JBT1c+bpllicoYK7O+X8kdzq7FeUU4tBWub3mUH2cidm3Pog8g5kaPCivHeBij1wb+AY34SGg42rEAh5q98hHddEklhWn996/KOAyYCMaR9FIUyWPaArn2xFBeTDcaWt8LZKMX7+jYWSd8IMIVB9Sm+WeyRqEy6Kpela5noY/pFn8WANpM60rUsy/utLr81CoBCZ38dkUSBQCtOAuFz10KWnl0a8ZX1PyWY9KfBByw9OsXFhoSrnUkwNqKv/hCjEdKGD/ZimUdlSCwaoBluMlqLQl8tdbjIv7AriKa8RTmSdA4b3GgArGybgn6q7BhLtByz+Re2pzqsDpwSfOs5iiOVbC9wPu/Et8MGqqgBAdzcSkjt4nCEe9ktygCxmOEXPG6V6kl3PNiujbSSeNt4MqTydDtOVvtrbmo2QTyZm++B2bAV4hpflBD+A0jDB2ZM6e7IIfC48y2RGCUoeZSGoneL7TZ70wF5K81umEBOgk2KZQljF/sHoL1EFVVcznHzNBxN1MREceCMKKaRenP8tzl52+nFhuER3k0wddQ9Lqzcr4mmlCrQC6JVo9C0Oy/uaFJLlyEtjv6/iYnbksTjKWO64wro9KU3je0UJ5/mG4WVfto+iC0BGycHOVUFxtoHImHzE9NttZGFjZYc1gR6QdPWM0QgL9nR6QW4isH+R4CoSwq0LyA4dCRkbGar5Mn7oBOctRtOrBOmYtIbcA9lodWkCGOzMblqm9MtmFa8e1llGoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(6666004)(36756003)(4326008)(47076005)(478600001)(54906003)(110136005)(316002)(70206006)(70586007)(81166007)(356005)(5660300002)(2616005)(41300700001)(426003)(83380400001)(336012)(36860700001)(82740400003)(16526019)(8676002)(1076003)(26005)(8936002)(44832011)(186003)(40460700003)(2906002)(86362001)(40480700001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 02:55:50.8949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 919d2657-e996-4b2e-f85b-08db55b90edc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458
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

These are the adminq commands that will be needed for
setting up and using the vDPA device.  There are a number
of commands defined in the FW's API, but by making use of
the FW's virtio BAR we only need a few of these commands
for vDPA support.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/pds/Makefile   |   1 +
 drivers/vdpa/pds/cmds.c     | 185 ++++++++++++++++++++++++++++++++++++
 drivers/vdpa/pds/cmds.h     |  18 ++++
 drivers/vdpa/pds/vdpa_dev.h |  33 ++++++-
 4 files changed, 236 insertions(+), 1 deletion(-)
 create mode 100644 drivers/vdpa/pds/cmds.c
 create mode 100644 drivers/vdpa/pds/cmds.h

diff --git a/drivers/vdpa/pds/Makefile b/drivers/vdpa/pds/Makefile
index 13b50394ec64..2e22418e3ab3 100644
--- a/drivers/vdpa/pds/Makefile
+++ b/drivers/vdpa/pds/Makefile
@@ -4,6 +4,7 @@
 obj-$(CONFIG_PDS_VDPA) := pds_vdpa.o
 
 pds_vdpa-y := aux_drv.o \
+	      cmds.o \
 	      vdpa_dev.o
 
 pds_vdpa-$(CONFIG_DEBUG_FS) += debugfs.o
diff --git a/drivers/vdpa/pds/cmds.c b/drivers/vdpa/pds/cmds.c
new file mode 100644
index 000000000000..80863a41c3cd
--- /dev/null
+++ b/drivers/vdpa/pds/cmds.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Advanced Micro Devices, Inc */
+
+#include <linux/vdpa.h>
+#include <linux/virtio_pci_modern.h>
+
+#include <linux/pds/pds_common.h>
+#include <linux/pds/pds_core_if.h>
+#include <linux/pds/pds_adminq.h>
+#include <linux/pds/pds_auxbus.h>
+
+#include "vdpa_dev.h"
+#include "aux_drv.h"
+#include "cmds.h"
+
+int pds_vdpa_init_hw(struct pds_vdpa_device *pdsv)
+{
+	struct pds_auxiliary_dev *padev = pdsv->vdpa_aux->padev;
+	struct device *dev = &padev->aux_dev.dev;
+	union pds_core_adminq_cmd cmd = {
+		.vdpa_init.opcode = PDS_VDPA_CMD_INIT,
+		.vdpa_init.vdpa_index = pdsv->vdpa_index,
+		.vdpa_init.vf_id = cpu_to_le16(pdsv->vdpa_aux->vf_id),
+	};
+	union pds_core_adminq_comp comp = {};
+	int err;
+
+	/* Initialize the vdpa/virtio device */
+	err = pds_client_adminq_cmd(padev, &cmd, sizeof(cmd.vdpa_init),
+				    &comp, 0);
+	if (err)
+		dev_dbg(dev, "Failed to init hw, status %d: %pe\n",
+			comp.status, ERR_PTR(err));
+
+	return err;
+}
+
+int pds_vdpa_cmd_reset(struct pds_vdpa_device *pdsv)
+{
+	struct pds_auxiliary_dev *padev = pdsv->vdpa_aux->padev;
+	struct device *dev = &padev->aux_dev.dev;
+	union pds_core_adminq_cmd cmd = {
+		.vdpa.opcode = PDS_VDPA_CMD_RESET,
+		.vdpa.vdpa_index = pdsv->vdpa_index,
+		.vdpa.vf_id = cpu_to_le16(pdsv->vdpa_aux->vf_id),
+	};
+	union pds_core_adminq_comp comp = {};
+	int err;
+
+	err = pds_client_adminq_cmd(padev, &cmd, sizeof(cmd.vdpa), &comp, 0);
+	if (err)
+		dev_dbg(dev, "Failed to reset hw, status %d: %pe\n",
+			comp.status, ERR_PTR(err));
+
+	return err;
+}
+
+int pds_vdpa_cmd_set_status(struct pds_vdpa_device *pdsv, u8 status)
+{
+	struct pds_auxiliary_dev *padev = pdsv->vdpa_aux->padev;
+	struct device *dev = &padev->aux_dev.dev;
+	union pds_core_adminq_cmd cmd = {
+		.vdpa_status.opcode = PDS_VDPA_CMD_STATUS_UPDATE,
+		.vdpa_status.vdpa_index = pdsv->vdpa_index,
+		.vdpa_status.vf_id = cpu_to_le16(pdsv->vdpa_aux->vf_id),
+		.vdpa_status.status = status,
+	};
+	union pds_core_adminq_comp comp = {};
+	int err;
+
+	err = pds_client_adminq_cmd(padev, &cmd, sizeof(cmd.vdpa_status), &comp, 0);
+	if (err)
+		dev_dbg(dev, "Failed to set status to %#x, error status %d: %pe\n",
+			status, comp.status, ERR_PTR(err));
+
+	return err;
+}
+
+int pds_vdpa_cmd_set_mac(struct pds_vdpa_device *pdsv, u8 *mac)
+{
+	struct pds_auxiliary_dev *padev = pdsv->vdpa_aux->padev;
+	struct device *dev = &padev->aux_dev.dev;
+	union pds_core_adminq_cmd cmd = {
+		.vdpa_setattr.opcode = PDS_VDPA_CMD_SET_ATTR,
+		.vdpa_setattr.vdpa_index = pdsv->vdpa_index,
+		.vdpa_setattr.vf_id = cpu_to_le16(pdsv->vdpa_aux->vf_id),
+		.vdpa_setattr.attr = PDS_VDPA_ATTR_MAC,
+	};
+	union pds_core_adminq_comp comp = {};
+	int err;
+
+	ether_addr_copy(cmd.vdpa_setattr.mac, mac);
+	err = pds_client_adminq_cmd(padev, &cmd, sizeof(cmd.vdpa_setattr),
+				    &comp, 0);
+	if (err)
+		dev_dbg(dev, "Failed to set mac address %pM, status %d: %pe\n",
+			mac, comp.status, ERR_PTR(err));
+
+	return err;
+}
+
+int pds_vdpa_cmd_set_max_vq_pairs(struct pds_vdpa_device *pdsv, u16 max_vqp)
+{
+	struct pds_auxiliary_dev *padev = pdsv->vdpa_aux->padev;
+	struct device *dev = &padev->aux_dev.dev;
+	union pds_core_adminq_cmd cmd = {
+		.vdpa_setattr.opcode = PDS_VDPA_CMD_SET_ATTR,
+		.vdpa_setattr.vdpa_index = pdsv->vdpa_index,
+		.vdpa_setattr.vf_id = cpu_to_le16(pdsv->vdpa_aux->vf_id),
+		.vdpa_setattr.attr = PDS_VDPA_ATTR_MAX_VQ_PAIRS,
+		.vdpa_setattr.max_vq_pairs = cpu_to_le16(max_vqp),
+	};
+	union pds_core_adminq_comp comp = {};
+	int err;
+
+	err = pds_client_adminq_cmd(padev, &cmd, sizeof(cmd.vdpa_setattr),
+				    &comp, 0);
+	if (err)
+		dev_dbg(dev, "Failed to set max vq pairs %u, status %d: %pe\n",
+			max_vqp, comp.status, ERR_PTR(err));
+
+	return err;
+}
+
+int pds_vdpa_cmd_init_vq(struct pds_vdpa_device *pdsv, u16 qid, u16 invert_idx,
+			 struct pds_vdpa_vq_info *vq_info)
+{
+	struct pds_auxiliary_dev *padev = pdsv->vdpa_aux->padev;
+	struct device *dev = &padev->aux_dev.dev;
+	union pds_core_adminq_cmd cmd = {
+		.vdpa_vq_init.opcode = PDS_VDPA_CMD_VQ_INIT,
+		.vdpa_vq_init.vdpa_index = pdsv->vdpa_index,
+		.vdpa_vq_init.vf_id = cpu_to_le16(pdsv->vdpa_aux->vf_id),
+		.vdpa_vq_init.qid = cpu_to_le16(qid),
+		.vdpa_vq_init.len = cpu_to_le16(ilog2(vq_info->q_len)),
+		.vdpa_vq_init.desc_addr = cpu_to_le64(vq_info->desc_addr),
+		.vdpa_vq_init.avail_addr = cpu_to_le64(vq_info->avail_addr),
+		.vdpa_vq_init.used_addr = cpu_to_le64(vq_info->used_addr),
+		.vdpa_vq_init.intr_index = cpu_to_le16(qid),
+		.vdpa_vq_init.avail_index = cpu_to_le16(vq_info->avail_idx ^ invert_idx),
+		.vdpa_vq_init.used_index = cpu_to_le16(vq_info->used_idx ^ invert_idx),
+	};
+	union pds_core_adminq_comp comp = {};
+	int err;
+
+	dev_dbg(dev, "%s: qid %d len %d desc_addr %#llx avail_addr %#llx used_addr %#llx\n",
+		__func__, qid, ilog2(vq_info->q_len),
+		vq_info->desc_addr, vq_info->avail_addr, vq_info->used_addr);
+
+	err = pds_client_adminq_cmd(padev, &cmd, sizeof(cmd.vdpa_vq_init),
+				    &comp, 0);
+	if (err)
+		dev_dbg(dev, "Failed to init vq %d, status %d: %pe\n",
+			qid, comp.status, ERR_PTR(err));
+
+	return err;
+}
+
+int pds_vdpa_cmd_reset_vq(struct pds_vdpa_device *pdsv, u16 qid, u16 invert_idx,
+			  struct pds_vdpa_vq_info *vq_info)
+{
+	struct pds_auxiliary_dev *padev = pdsv->vdpa_aux->padev;
+	struct device *dev = &padev->aux_dev.dev;
+	union pds_core_adminq_cmd cmd = {
+		.vdpa_vq_reset.opcode = PDS_VDPA_CMD_VQ_RESET,
+		.vdpa_vq_reset.vdpa_index = pdsv->vdpa_index,
+		.vdpa_vq_reset.vf_id = cpu_to_le16(pdsv->vdpa_aux->vf_id),
+		.vdpa_vq_reset.qid = cpu_to_le16(qid),
+	};
+	union pds_core_adminq_comp comp = {};
+	int err;
+
+	err = pds_client_adminq_cmd(padev, &cmd, sizeof(cmd.vdpa_vq_reset),
+				    &comp, 0);
+	if (err) {
+		dev_dbg(dev, "Failed to reset vq %d, status %d: %pe\n",
+			qid, comp.status, ERR_PTR(err));
+		return err;
+	}
+
+	vq_info->avail_idx = le16_to_cpu(comp.vdpa_vq_reset.avail_index) ^ invert_idx;
+	vq_info->used_idx = le16_to_cpu(comp.vdpa_vq_reset.used_index) ^ invert_idx;
+
+	return 0;
+}
diff --git a/drivers/vdpa/pds/cmds.h b/drivers/vdpa/pds/cmds.h
new file mode 100644
index 000000000000..e24d85cb8f1c
--- /dev/null
+++ b/drivers/vdpa/pds/cmds.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2023 Advanced Micro Devices, Inc */
+
+#ifndef _VDPA_CMDS_H_
+#define _VDPA_CMDS_H_
+
+int pds_vdpa_init_hw(struct pds_vdpa_device *pdsv);
+
+int pds_vdpa_cmd_reset(struct pds_vdpa_device *pdsv);
+int pds_vdpa_cmd_set_status(struct pds_vdpa_device *pdsv, u8 status);
+int pds_vdpa_cmd_set_mac(struct pds_vdpa_device *pdsv, u8 *mac);
+int pds_vdpa_cmd_set_max_vq_pairs(struct pds_vdpa_device *pdsv, u16 max_vqp);
+int pds_vdpa_cmd_init_vq(struct pds_vdpa_device *pdsv, u16 qid, u16 invert_idx,
+			 struct pds_vdpa_vq_info *vq_info);
+int pds_vdpa_cmd_reset_vq(struct pds_vdpa_device *pdsv, u16 qid, u16 invert_idx,
+			  struct pds_vdpa_vq_info *vq_info);
+int pds_vdpa_cmd_set_features(struct pds_vdpa_device *pdsv, u64 features);
+#endif /* _VDPA_CMDS_H_ */
diff --git a/drivers/vdpa/pds/vdpa_dev.h b/drivers/vdpa/pds/vdpa_dev.h
index 97fab833a0aa..a21596f438c1 100644
--- a/drivers/vdpa/pds/vdpa_dev.h
+++ b/drivers/vdpa/pds/vdpa_dev.h
@@ -4,11 +4,42 @@
 #ifndef _VDPA_DEV_H_
 #define _VDPA_DEV_H_
 
-#define PDS_VDPA_MAX_QUEUES	65
+#include <linux/pci.h>
+#include <linux/vdpa.h>
+
+struct pds_vdpa_vq_info {
+	bool ready;
+	u64 desc_addr;
+	u64 avail_addr;
+	u64 used_addr;
+	u32 q_len;
+	u16 qid;
+	int irq;
+	char irq_name[32];
+
+	void __iomem *notify;
+	dma_addr_t notify_pa;
+
+	u64 doorbell;
+	u16 avail_idx;
+	u16 used_idx;
 
+	struct vdpa_callback event_cb;
+	struct pds_vdpa_device *pdsv;
+};
+
+#define PDS_VDPA_MAX_QUEUES	65
+#define PDS_VDPA_MAX_QLEN	32768
 struct pds_vdpa_device {
 	struct vdpa_device vdpa_dev;
 	struct pds_vdpa_aux *vdpa_aux;
+
+	struct pds_vdpa_vq_info vqs[PDS_VDPA_MAX_QUEUES];
+	u64 req_features;		/* features requested by vdpa */
+	u64 actual_features;		/* features negotiated and in use */
+	u8 vdpa_index;			/* rsvd for future subdevice use */
+	u8 num_vqs;			/* num vqs in use */
+	struct vdpa_callback config_cb;
 };
 
 int pds_vdpa_get_mgmt_info(struct pds_vdpa_aux *vdpa_aux);
-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
