Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85915C77B7C
	for <virtualization@archiver.kernel.org>; Tue, 25 Apr 2023 21:26:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27B60820EC;
	Tue, 25 Apr 2023 21:26:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 27B60820EC
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bJCjZ4Bf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2jn7qN6kbTrc; Tue, 25 Apr 2023 21:26:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C294B820E0;
	Tue, 25 Apr 2023 21:26:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C294B820E0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87C36C008B;
	Tue, 25 Apr 2023 21:26:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BC34C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 21:26:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 152CF40195
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 21:26:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 152CF40195
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=bJCjZ4Bf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sYqnYZ10xkvr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 21:26:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CAC4140981
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::611])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CAC4140981
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 21:26:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDN4IXiETZjgndHYiYiwK8IeM9tJUHG1SmQWvbc/tKlYrcIWpuUqia4NnmYtpJhdEAVoeo1mLzIp35Kx+Dur+zGxfpg8j0sDkSgaLBuI3LiFBE4raZS+1o9tLOTqXaoLcpMB0bCbTScelpDIw3SVF38zQ0f8+7kqJ+fwRqOlgc+WbFuWnABr7WQEUZW3Ei/8yIYjkhSbsWARu8xefyoWemcNi+aubUCM+OtThVdjK7KHZWRkJQo7m0Dbu4uVsT0/QzfeR1NLe4A1S9lp90Lzr0WnCe230DzgKMV7Nh2kcKSbkKrZaj3UK7xAS2HxwcEA/ZolC2ahi1AO5DFATQNbsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BXXmMlOghaFsjm82PSeEGxoJMwenrq+zymJvKn6pvY=;
 b=Cnh2+G3DNxOXzrrsqaBWckJS/SNRHGb9LYLHETAUKQ1hxmLcdK44xRae3WIq8OU27gCbMNrgK8lBc92aTgZnTDI5VJYspjse4pOb96i0rjlMDGvZo3Pdey27fmQy9SwjQd98WscyNLelpCCTNMC49K7BJqcKmbb3L+cTtIW3ME7UkKopNiOWvCZIJgvEHdNWhZGjF2UTewqe+muedpABvJRVDHF+G1gGO5dG/bfQRmxiBrgH3giGUpleRNh3VS+atWDJbppgPPTXsxJhSlyBQk7BQPW68EPn8fwtPhHIc6BJ4dHGmHyRszW31ekr/qfKJVlktb17Fgy7+9Bq9lsvqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BXXmMlOghaFsjm82PSeEGxoJMwenrq+zymJvKn6pvY=;
 b=bJCjZ4BfAMMTMMeT/Rp0cVUusME9fVYP+3Egg+nGSpu9XbjPqMxODrw+z4hvJ2ap5rvUt9nruimmnOf1t05FHNrT8wsGZw1CvVGsYvWpRoG2kZ2L7dzMUCAYrnZ/ZTENBS2KPl0pGHsKG6aAjWHl2dmtzGZy34vnC3MRdtx34CY=
Received: from DM6PR11CA0041.namprd11.prod.outlook.com (2603:10b6:5:14c::18)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.20; Tue, 25 Apr 2023 21:26:25 +0000
Received: from DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::4f) by DM6PR11CA0041.outlook.office365.com
 (2603:10b6:5:14c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34 via Frontend
 Transport; Tue, 25 Apr 2023 21:26:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT092.mail.protection.outlook.com (10.13.173.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.20 via Frontend Transport; Tue, 25 Apr 2023 21:26:24 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 25 Apr
 2023 16:26:23 -0500
To: <jasowang@redhat.com>, <mst@redhat.com>,
 <virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
 <brett.creeley@amd.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 virtio 07/10] pds_vdpa: add vdpa config client commands
Date: Tue, 25 Apr 2023 14:25:59 -0700
Message-ID: <20230425212602.1157-8-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230425212602.1157-1-shannon.nelson@amd.com>
References: <20230425212602.1157-1-shannon.nelson@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT092:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b8c3eb7-7811-479a-ecc3-08db45d3b902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SmtGhYfgi1qc+nHfwnTYXZDfSeB5E+dRaubUfc9j0UPcHChL2AnR1ijp5ibjLQuWF8mJqIUopY5B3l3lnASDzqtVKWG+DbX9HYi441/mJdKuEWijrJz06aW9os7zTufzJz/posNhiOKkBiI6q7fUGR4q6w6w8FIqHORVHwiswcIoXu7YbeqGKzKn3gw95PVi0Qnj3BEzbYLUHTqi7OTzK2ijcNX8l9au59bybU/t236x428/3LNjyuhR2o6/UXPJ7DxirgZyL52+H1KhS+QIHl95Um734K+TNWNFZsJbM+BxuV8XdfVx42BGFBm9YFUMLRtl5iyAWW5tBbFb9QM2p41sSiIWeGlaTOvAc0jHHhK/7lbQrcD0eG8PTLlA2JgWsKJS12ANWOlU5DFyfWLrGuHv8+vl/XTBnahHtB9Jtqd9a7s251Y8zqew5llgZCg/DXIZDIycApS6n3GePKLWTPUwK/MI1lj9PjU4rOYCFZrDaFrBxvvIVKLZOoqcuNWH2WaUXgAAHzABjSv9aHSzuO+RPQIpqonwm31SgXj7Bz8nCDVPZHkjOE3Umc5E83LJB+YeMHYXqRt37FzftYWV4Z/bLE5pAfopQytL1RwYjUrYZdo/+FHJeI5PsL41YO+l7iv2Es9UrvJIZn1IkKEWxMoV2IUPLT/xwXr9R8lLhbA/cFV6Iuwj2umlER9tFFHCuvp20Kak6ziOWrVmPJs5MTmK3J94XZyqhx0FSD47Tsg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(478600001)(70206006)(110136005)(70586007)(5660300002)(4326008)(8676002)(8936002)(82740400003)(316002)(41300700001)(356005)(81166007)(2616005)(16526019)(186003)(426003)(336012)(36860700001)(83380400001)(47076005)(6666004)(1076003)(26005)(86362001)(82310400005)(30864003)(2906002)(44832011)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 21:26:24.6668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8c3eb7-7811-479a-ecc3-08db45d3b902
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423
Cc: drivers@pensando.io
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
---

Note: the previous version was Acked-by Jason Wang, but this has gone
      through some rework of the adminq command API usage and added
      two new commands.  It is still essentially the same code, but
      I've dropped the Acked-by for now.

 drivers/vdpa/pds/Makefile   |   1 +
 drivers/vdpa/pds/cmds.c     | 207 ++++++++++++++++++++++++++++++++++++
 drivers/vdpa/pds/cmds.h     |  20 ++++
 drivers/vdpa/pds/vdpa_dev.h |  33 +++++-
 4 files changed, 260 insertions(+), 1 deletion(-)
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
index 000000000000..405711a0a0f8
--- /dev/null
+++ b/drivers/vdpa/pds/cmds.c
@@ -0,0 +1,207 @@
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
+int pds_vdpa_cmd_init_vq(struct pds_vdpa_device *pdsv, u16 qid,
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
+int pds_vdpa_cmd_reset_vq(struct pds_vdpa_device *pdsv, u16 qid)
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
+	if (err)
+		dev_dbg(dev, "Failed to reset vq %d, status %d: %pe\n",
+			qid, comp.status, ERR_PTR(err));
+
+	return err;
+}
+
+int pds_vdpa_cmd_set_vq_state(struct pds_vdpa_device *pdsv,
+			      u16 qid, u16 avail, u16 used)
+{	struct pds_auxiliary_dev *padev = pdsv->vdpa_aux->padev;
+	struct device *dev = &padev->aux_dev.dev;
+	union pds_core_adminq_cmd cmd = {
+		.vdpa_vq_set_state.opcode = PDS_VDPA_CMD_VQ_SET_STATE,
+		.vdpa_vq_set_state.vdpa_index = pdsv->vdpa_index,
+		.vdpa_vq_set_state.vf_id = cpu_to_le16(pdsv->vdpa_aux->vf_id),
+		.vdpa_vq_set_state.qid = cpu_to_le16(qid),
+		.vdpa_vq_set_state.avail = cpu_to_le16(avail),
+		.vdpa_vq_set_state.used = cpu_to_le16(used),
+	};
+	union pds_core_adminq_comp comp = {};
+	int err;
+
+	err = pds_client_adminq_cmd(padev, &cmd, sizeof(cmd.vdpa_vq_set_state),
+				    &comp, 0);
+	if (err)
+		dev_dbg(dev, "Failed to set state vq %d, status %d: %pe\n",
+			qid, comp.status, ERR_PTR(err));
+
+	return err;
+}
+
+int pds_vdpa_cmd_get_vq_state(struct pds_vdpa_device *pdsv,
+			      u16 qid, u16 *avail, u16 *used)
+{	struct pds_auxiliary_dev *padev = pdsv->vdpa_aux->padev;
+	struct device *dev = &padev->aux_dev.dev;
+	union pds_core_adminq_cmd cmd = {
+		.vdpa_vq_get_state.opcode = PDS_VDPA_CMD_VQ_SET_STATE,
+		.vdpa_vq_get_state.vdpa_index = pdsv->vdpa_index,
+		.vdpa_vq_get_state.vf_id = cpu_to_le16(pdsv->vdpa_aux->vf_id),
+		.vdpa_vq_get_state.qid = cpu_to_le16(qid),
+	};
+	union pds_core_adminq_comp comp = {};
+	int err;
+
+	err = pds_client_adminq_cmd(padev, &cmd, sizeof(cmd.vdpa_vq_set_state),
+				    &comp, 0);
+	if (err) {
+		dev_dbg(dev, "Failed to set state vq %d, status %d: %pe\n",
+			qid, comp.status, ERR_PTR(err));
+		return err;
+	}
+
+	*avail = le16_to_cpu(comp.vdpa_vq_get_state.avail);
+	*used = le16_to_cpu(comp.vdpa_vq_get_state.used);
+
+	return 0;
+}
diff --git a/drivers/vdpa/pds/cmds.h b/drivers/vdpa/pds/cmds.h
new file mode 100644
index 000000000000..cf4f8764e73c
--- /dev/null
+++ b/drivers/vdpa/pds/cmds.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2023 Advanced Micro Devices, Inc */
+
+#ifndef _VDPA_CMDS_H_
+#define _VDPA_CMDS_H_
+
+int pds_vdpa_init_hw(struct pds_vdpa_device *pdsv);
+
+int pds_vdpa_cmd_reset(struct pds_vdpa_device *pdsv);
+int pds_vdpa_cmd_set_mac(struct pds_vdpa_device *pdsv, u8 *mac);
+int pds_vdpa_cmd_set_max_vq_pairs(struct pds_vdpa_device *pdsv, u16 max_vqp);
+int pds_vdpa_cmd_init_vq(struct pds_vdpa_device *pdsv, u16 qid,
+			 struct pds_vdpa_vq_info *vq_info);
+int pds_vdpa_cmd_reset_vq(struct pds_vdpa_device *pdsv, u16 qid);
+int pds_vdpa_cmd_set_features(struct pds_vdpa_device *pdsv, u64 features);
+int pds_vdpa_cmd_set_vq_state(struct pds_vdpa_device *pdsv,
+			      u16 qid, u16 avail, u16 used);
+int pds_vdpa_cmd_get_vq_state(struct pds_vdpa_device *pdsv,
+			      u16 qid, u16 *avail, u16 *used);
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
