Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06821C77B7A
	for <virtualization@archiver.kernel.org>; Fri, 19 May 2023 21:57:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB75983FED;
	Fri, 19 May 2023 21:57:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB75983FED
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qr7Zs4WH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TmXi8ou3BDwP; Fri, 19 May 2023 21:57:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6150784014;
	Fri, 19 May 2023 21:57:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6150784014
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC666C0094;
	Fri, 19 May 2023 21:57:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65B7EC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 21:57:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B495E40C0E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 21:57:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B495E40C0E
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=qr7Zs4WH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NuWBINPD4en3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 21:57:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 333E240604
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::629])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 333E240604
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 21:57:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I33+7JUxt7I9oBGILsOaJq6w6+0AKaefCjBSTK3DzurdaaMz9k4ttaXMsikP/+z+HRGxnU28YwQjSf224zWTWU0M+e2QzbpETVIfaupkU0sSddAo1o/eH7HCeqZhbBGCHqSyn0XQDBzxcesEdd2excwES+YteHyyaUxzMbo5mUUm0Iu7627RpNuwGyhuQEUJrWrNm4U3vHhGe3KbtiyhcFlr+hDYlyHeWvI9oaKoBfGXvCHvQ9b94DZtDi/JuNxrtgwYI7IGWy9ZgFbI8+KUCudWyccnqyntNDKvxW48GEUTzJfmYzZSqhMZrt2vDpJ/izduh/vKMuxXkKt6yRssRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cMQJdmdzsxJ2kM66vHCHLSEYBcgp+6lYO1eq3z2SsU=;
 b=Rdacup5mRbwrZD5HmM+B704cqOvkU4cGJgbpJUg1gC5/Ck7+Srlga6m4yf+tkneOyTeTZuGUNZRDF92deUXe3W5GupdJclivHyKW71214f90hkQtfNPoRyEnrgsYC2a4IjpzLMQYisGYOi0TYaPhi1ryZd6uHen5vzTvzxthXuROuXuCOZFZF8XGC+vS3ov9gxAHfTAHWB/d1kqkQMQOTpwif2U4VNpa4IH55iBo6kBWP9KPstqRlfAaJoMeMvoLnRrD2yXKP1vHC+xvu1rxpp/HzoeWdzprjCnOVoRGQAkLY8KWIuu+q97Lah5HajF0Y6rczBiedx+MsD4oDhCD4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cMQJdmdzsxJ2kM66vHCHLSEYBcgp+6lYO1eq3z2SsU=;
 b=qr7Zs4WHYc0MBR/geksD8RbgMvBRDO0lohAsIEcpuACh7yER6xrKF58vSVqiTzveKZFB8FPzSB0G3pQEHRARQB2BY6hkqol66dFKIfG9+EbTK8U4q569ol1VYp6Gw4THfo6ZvAO8mJ3lbnw7a8mnImqMOXy8yzKBdFaVK4mCxzs=
Received: from BN9PR03CA0964.namprd03.prod.outlook.com (2603:10b6:408:109::9)
 by SJ1PR12MB6196.namprd12.prod.outlook.com (2603:10b6:a03:456::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 21:56:59 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::ab) by BN9PR03CA0964.outlook.office365.com
 (2603:10b6:408:109::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 21:56:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 21:56:57 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 16:56:56 -0500
To: <jasowang@redhat.com>, <mst@redhat.com>,
 <virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
 <brett.creeley@amd.com>, <netdev@vger.kernel.org>
Subject: [PATCH v7 virtio 08/11] pds_vdpa: add vdpa config client commands
Date: Fri, 19 May 2023 14:56:29 -0700
Message-ID: <20230519215632.12343-9-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230519215632.12343-1-shannon.nelson@amd.com>
References: <20230519215632.12343-1-shannon.nelson@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT009:EE_|SJ1PR12MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e5083cc-36f5-433a-6146-08db58b3f788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qcYyK+UgdpkTMrJER1vnL4HkhEBru+7h+q6OPbHxNdxJy9NCd44PoF94eQSUsfsPBk0N9t9lCONI8B8wINpzkNTi0JLn/tB2q6g3swOoKEj1RWZYVRHALvr+tJVd4PWmZXZ3R1I6IwuD/MxRV+2TxfRcjSym+SOD1I5lt+A2TqQdQH7oHlt7mqmOy23gdgsB90iLQrA8YAEhjFoAdm9nso1J9I+Y6LJTN7FvtB/v0h0ps7KOyKly/lDGmBDSREKOUS728pLqkQms4TVfGangrIy5sHCsHcsCE8ZvchgAGZZxVQVVxChHlJV0NMEfWO5cS3Ij0HMMTYArW8PcB3tzabE+Ljhfolx2O2QPfsXit63iRwtHgCMZtcpM3ODNvP6Xc1ggRALJpuxKMG9Lw/RuvLbcWvzUXBCyjbv0jzUa4j4+IehT0sW4yaygxtYH5EqEj0me46geuqEGoUVGYx46Evi4apmYnob25VpLKF8b/UCMQfYbrFfH0m886EjRFamD/Tkz3DoGTRx45k7y0lFR0/4X69htdZX+Mwmklp2qWEODiQ2quqdxA+Ut4HMBCainsr8d9q902uO2m1REgTOX0mvtY590+ENc+dL+D1aUT6ZSMc1AwkTdzcZl0A0+T7ME7nAi1zXOhJ2NhxjrI7bxoyGzlpobsazSJStBqD/wqcU0z/1IdVaqDZhSfOSdk02mXHnz2y+YYS4HFVDBWxbllNUogZgsGW8lN6S9+ReRzAEPxzFBy3TW+osQkIVRzZzUM8a4hc4GujWemkqLF/JIIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(26005)(1076003)(40460700003)(83380400001)(47076005)(2616005)(40480700001)(36860700001)(426003)(336012)(36756003)(81166007)(86362001)(82310400005)(186003)(356005)(16526019)(82740400003)(2906002)(8936002)(8676002)(54906003)(316002)(110136005)(5660300002)(70586007)(70206006)(478600001)(4326008)(41300700001)(6666004)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 21:56:57.7888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5083cc-36f5-433a-6146-08db58b3f788
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6196
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
