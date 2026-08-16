Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013047.outbound.protection.outlook.com [40.93.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D6F3E1204
	for <virtualization@lists.linux.dev>; Sun, 16 Aug 2026 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786882903; cv=fail; b=Idh8rTO18Z7W8ZjHGi7dz+bL8VU/DkS8MPmgBJuYGPf3oyWsOjaC03S8jnX16J8YXTteb1uYUa7d1TbAqtaNI6rurKeSFS79puwVmvD1cVe1bnRy0JZOGF7sHXvYdjCYGMhezbC5QcLMKmBRMV6AqwFyexn2AS9hdPffAfRIcP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786882903; c=relaxed/simple;
	bh=lkIDFI4GUZZkw9c167Tql0ds0yLhSMxpxrgHCdYOTok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bto2ceaQgvx8A6GLhNsN7als5a6rOqZ0f7Nz9i2gYxnIrRd7b7KrCO6rO1DY3DNSgqOBU+Robd7QWa+536w/uziqdb1G9BZxSBG3JQ2jt15zuqkTmDsESwKQHnjILmktOIMOsd8zZQeoHCMdqdV8fDbeJQm6xcsfztBJADSH9OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fz2Z54Xv; arc=fail smtp.client-ip=40.93.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fz2Z54Xv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8YE5CAuHNqQ/fghGxvrW4zj03awaF1TowD2jzuEssv7wKVN5Sksp4aDR4RCMAqrgTd91lOFVLJS4b97RmjgqRLx+9Qx4ArAxmX0qU2u9CH8O0Jz9NHjPKcvxMu+1XmtV6xhfidcc4loX+y1KXDhu8GnzzLx3E20WwtrSIGsom4swcy1fpkK9rrkTD+oNs0KA69B1x9Mcwlk9dlBzzsYbOytWVm9TK4xvuAbnqfjWr1s/U3Mu/tRQPs9vHdgLdszHQg8+f3eR1IlHw7ZAJ3zWRwJ0oAz3QiOISdgqFT0s8A8TWHLXF6w+gwXB6+eLG0T98jShqxGJuKS3isL1GruHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOmka1n/ycoWyMnGGyUVMSmjr76popUVGDjlmXut0xY=;
 b=P2T1k+K+68CaTHAqojahZIYpW9v8pk8ATk2D/NguegCLLJoA03IUwVLkgFhtYW5T2UF0rre/aIKQoRbQba84MTIaR/4zpGpOpcInas1DD8t4d3kwy3YO58yiqYimhCKVEg1CGX6r5pWS0Uq/45uP9ZnoS3i8eVZaetZsDJsPS/4JryWkLB5fNN2ZXZ3kAkMWHS/6WQDgyZJJQNuYl+VA6JB1YZc69MixmkF57zOUSQxBl9LnNdyLVDv06KwFUWwiAXBNGvpg5KjCwAAV2E1YnDvMiBBZQWWm5ji434s09W+TkTw6nBLjvjkz3el1zFTFkrk60sstI24qfPfC0yv/dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOmka1n/ycoWyMnGGyUVMSmjr76popUVGDjlmXut0xY=;
 b=Fz2Z54XvZyUFP2Q7igJ+S7rkNca1Ml01Vx4osEIbavor/yOIAwnSt89IyIaQmnD4J2VUgCSIs8rxcLMNpPGouzcDbno7Bwy3pAIhY29ZSvxOUTTPwOCmrstjQ6yuvyvDB3mPV6y3GGp4hkdfze+IQdZnjtdhaSGyQlMUawrXfJk8O2klBJYdRPOVr95gHwIzmMDVtfUqL9B/HatPByOBn9YUmIwVjVxW52R1btBOeRdFuc3YmbeOOiFLXzAZyQvSi3V26sv0Bsh2puTCogRhsnRup+iWq3TLeF9LXZ5qkHCarS2JrqRQcXladiRbNFixiuktRWLmsCVNRznF+biD2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 12:21:38 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 12:21:38 +0000
From: Shahar Shitrit <shshitrit@nvidia.com>
To: netdev@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	pabeni@redhat.com
Cc: virtualization@lists.linux.dev,
	parav@nvidia.com,
	shshitrit@nvidia.com,
	yohadt@nvidia.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	danielj@nvidia.com,
	gal@nvidia.com,
	tariqt@nvidia.com
Subject: [PATCH net-next v22 04/14] virtio: Expose generic device capability operations
Date: Sun, 16 Aug 2026 15:21:01 +0300
Message-ID: <20260816122111.2495240-5-shshitrit@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260816122111.2495240-1-shshitrit@nvidia.com>
References: <20260816122111.2495240-1-shshitrit@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::20) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|DM4PR12MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 605fd8ad-aeb3-47bb-f5f1-08defb90eb91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|3023799007|18002099003|22082099003|11063799006|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	1jJr9FHDsON5yAMAVEdYH7IHptWUBSGI7tNts/5hCfwv1vmwUky0LArdzmy6agsf3ITA1aAoC5PgafRNOjbQcvNaqZACitBJGErQNmhF1up5y9Ee0sXrxYaHM7WbHVM/LNhBlr+Iv7kFBi0lO8lNcasKPIfTMVdGx4pnAFfB6kHJI7mlttOrj3LKTMw6VNIa3Ek25GlbYh4S+3qnPYpKdyoAaU9xEIXgUpaUbxNJFXNhSQonK4l7TPl00ULWPPPMnCM08ImdngaTpFvJAGhUz3SCcLzeExnryoaWPkTIw9J/28RP5hslES3s7VQXRJus6ngYe70q+WF21UliHbfzmEJpxhB6lX1TmioAFKJE6ZvdG53Q5KTcx9GXEgTVSKbPnJ3vHTaNBQS06boeKyE9NHuEJ4cxmz2pLzwPo0Uko6GeytDxlvT5XC7tM3lXCduDuYCUm/dZmX0viZeCkq3sQRmFqhXajpE6AbDGNheeix31qaB2k1LiCYzMzdEOarQ9ycZFguCog474WJAGHE08J1zuWMqxUPnbnuOFC854eZdAhHNl2rphxKaPH4eTZ+3E5v/1Btx6mgWH/ZJvcKv4AzsldoE3vSZtkNuGkzZQAlyVwie/frs7rz5UAQmJhhwnj8eJUKDNzW8yiyrWArdE30gxSD706Pn1mz/v/iQhrus=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I7x6D0swkFgYR7vCTnCqXvJ8dssFRm0jqu1g2NTxRxv7mCDqSB3HJhl6I4tq?=
 =?us-ascii?Q?pJUySAU90TYumjoX80XCipMd/FsndvoZbcZpq7EheZH7uCZw5VxfOWIE8cmt?=
 =?us-ascii?Q?72lI861+02mn3ulyAD/ojzm0FWEFUd7uVy5D9U33hf6NRW6lwCqfiKSdxIU2?=
 =?us-ascii?Q?AkJTNMSNJIyaDHd5ybr2GsN40/VXT3LSanQ3E2esvdYlYcwtUCelecZcKyev?=
 =?us-ascii?Q?h3jhuB0snx18gP9sX1Zp7NTbt144A2PanoqavRNmBuQliCMzMbMrEAMXt57j?=
 =?us-ascii?Q?MUNbtgaanU+eYC/O+GQLuy2Bu/ihdApkU5xMmEeU1e1jYX9yjaoMwK5bxxqT?=
 =?us-ascii?Q?qMb/wRD7OaLF1ASqdxyRnRr9eMdAu5WeQ/pCRMHqoevI4fczoyIPRbLCc9WL?=
 =?us-ascii?Q?C0Zycwy45zOgLHgqkz9VCP/H+PuAZG9hZSzA1aMeDE53b2MaWrokEQOf6l0C?=
 =?us-ascii?Q?PL2V/r+yB5aNzRMX07up51YepYtW27GLRJh/0GX5ylHMbNCZLpgwIUd6f8l3?=
 =?us-ascii?Q?FI4MRsnRCDNQmy8nOgrhVlQMgzf/ks5mq5ZB9uJg5i/UeY/ES4umuOczHe67?=
 =?us-ascii?Q?3VJF+UwtXrtMqfudVf6uFgyU44Kom74KIcw6YT5ZVAAOb8Oj7QgR+tyNj7pw?=
 =?us-ascii?Q?ZQ72YcvMeijoe/T2z0IAqkQ9wAJgEzaV8ZJKqoR1xUv0uA+eDs5Clba21RW+?=
 =?us-ascii?Q?hz+HJpzl/Vwva4Gew4NlKwMBfKwFkWDESC6TMAtqADzHoOGQ2obAwiAI8LJ5?=
 =?us-ascii?Q?AASOi6nm11U+AUA0W3+92LPBO4FRFnPzec9hGUXBzyFWQY1GFeeB8QktDNTM?=
 =?us-ascii?Q?M9igVmYrf4F7dgkwBy6e6SluolfhTTgSMQy7Eb/fbLsU4z+s0fqNucuyyott?=
 =?us-ascii?Q?UJCPD9r0g3bvdrJj7JdN+WOHB8gzf6H8VUr/DZFPqkO40TMYytCM5JvjLMlf?=
 =?us-ascii?Q?mlYzuH/q8XIQp8TydVPnvNX8mn5N2mWtkQyNg1yhbGXEDRiAmNBiCTrYj4r+?=
 =?us-ascii?Q?EAiIuS8zCxPejcLzYac6t0js2/GBqbsprZw027sAfNd8TV4bLFGbyHBrwP5Z?=
 =?us-ascii?Q?YOMKP+DdvWHVYy6Xs8n6ClhPmXWIYkQFcyCYfPfpW/OlivCN/IruAvh0P5WX?=
 =?us-ascii?Q?dXl6DIec8JfTGY8v7Y3dUJbkBN55XAZDcaC4kh8xlr41BX5x2AZ/LdobPHYl?=
 =?us-ascii?Q?3qg3EvTUvPJgXyL7VvLdjD/WhA3Kv7QybpGFkK4dw9ANtbUMLs/47d7lsLbQ?=
 =?us-ascii?Q?dwmDfcfPokb9VKLyLC2mQuSMO+aqx0aT4IrQGSOs4tJqqmNos+CMu6IQu5ef?=
 =?us-ascii?Q?2aPsmJPSwlGlwF62mfvClkmG1xho3RVhS3SJLmtRF0o2VoI7wBiGMMzhu5tU?=
 =?us-ascii?Q?iDnB6aT0ngLo5xdnusIS6cYtSmxTT2bPLtOuzzH0ck+nnRKbVSIAkmm0IAv3?=
 =?us-ascii?Q?PF/ZUlSgyOUkVp5F685h67/49mUaaSsGKtdtpljOVFHX8y1WITZillt782Ij?=
 =?us-ascii?Q?U+jzvS6uBfAtGq9ZuQo9Jyi4kHLPCYsz5qyA3xXyPYaPFmjBIRpMvsL77M9Z?=
 =?us-ascii?Q?EHcE/8mJTlbsETNBqKvSponpujKfV3TFRVe3x4kXBlwTgC3PpBRl75Rll0KD?=
 =?us-ascii?Q?v/e9QTtVQOkPyEKnmN6c15sDYtHtAGpNuUL58KjGfiKtGXTss7DVuwLar3Up?=
 =?us-ascii?Q?vcF5TX1BW2bh4+wBqCM0GM1H2HFPdTM97GaLjZvP7OZgKFq1IfQaYlaqHRRe?=
 =?us-ascii?Q?Ue+CrubnaA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 605fd8ad-aeb3-47bb-f5f1-08defb90eb91
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 12:21:38.1063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qT5CZcS2nZel5illZdqaXKM8pPzJj4IYbdg8qNxT+edj0O/KB9zjkPRWExcJEDVVpXSe4eVuORiFc1fBfo37rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573

From: Daniel Jurgens <danielj@nvidia.com>

Currently querying and setting capabilities is restricted to a single
capability and contained within the virtio PCI driver. However, each
device type has generic and device specific capabilities, that may be
queried and set. In subsequent patches virtio_net will query and set
flow filter capabilities.

This changes the size of virtio_admin_cmd_query_cap_id_result. It's safe
to do because this data is written by DMA, so a newer controller can't
overrun the size on an older kernel. Since the API does not report how
much of the result was written, callers must zero-initialize the
structure before use. Any portion not written by the device then remains
zero and indicates that those capabilities are not supported.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/virtio/Makefile                |  2 +-
 drivers/virtio/virtio_admin_commands.c | 96 ++++++++++++++++++++++++++
 include/linux/virtio_admin.h           | 89 ++++++++++++++++++++++++
 include/uapi/linux/virtio_pci.h        |  6 +-
 4 files changed, 190 insertions(+), 3 deletions(-)
 create mode 100644 drivers/virtio/virtio_admin_commands.c
 create mode 100644 include/linux/virtio_admin.h

diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index eefcfe90d6b8..2b4a204dde33 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
+obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o virtio_admin_commands.o
 obj-$(CONFIG_VIRTIO_ANCHOR) += virtio_anchor.o
 obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
 obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
new file mode 100644
index 000000000000..60d92875da23
--- /dev/null
+++ b/drivers/virtio/virtio_admin_commands.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_admin.h>
+#include <linux/overflow.h>
+#include <uapi/linux/virtio_pci.h>
+
+int virtio_admin_cap_id_list_query(struct virtio_device *vdev,
+				   struct virtio_admin_cmd_query_cap_id_result *data)
+{
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist result_sg;
+
+	if (!vdev->config->admin_cmd_exec)
+		return -EOPNOTSUPP;
+
+	sg_init_one(&result_sg, data, sizeof(*data));
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_CAP_ID_LIST_QUERY);
+	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
+	cmd.result_sg = &result_sg;
+
+	return vdev->config->admin_cmd_exec(vdev, &cmd);
+}
+EXPORT_SYMBOL_GPL(virtio_admin_cap_id_list_query);
+
+int virtio_admin_cap_get(struct virtio_device *vdev,
+			 u16 id,
+			 void *caps,
+			 size_t cap_size)
+{
+	struct virtio_admin_cmd_cap_get_data *data;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist result_sg;
+	struct scatterlist data_sg;
+	int err;
+
+	if (!vdev->config->admin_cmd_exec)
+		return -EOPNOTSUPP;
+
+	data = kzalloc_obj(*data);
+	if (!data)
+		return -ENOMEM;
+
+	data->id = cpu_to_le16(id);
+	sg_init_one(&data_sg, data, sizeof(*data));
+	sg_init_one(&result_sg, caps, cap_size);
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_DEVICE_CAP_GET);
+	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
+	cmd.data_sg = &data_sg;
+	cmd.result_sg = &result_sg;
+
+	err = vdev->config->admin_cmd_exec(vdev, &cmd);
+	kfree(data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(virtio_admin_cap_get);
+
+int virtio_admin_cap_set(struct virtio_device *vdev,
+			 u16 id,
+			 const void *caps,
+			 size_t cap_size)
+{
+	struct virtio_admin_cmd_cap_set_data *data;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist data_sg;
+	size_t data_size;
+	int err;
+
+	if (!vdev->config->admin_cmd_exec)
+		return -EOPNOTSUPP;
+
+	if (check_add_overflow(sizeof(*data), cap_size, &data_size))
+		return -EOVERFLOW;
+
+	data = kzalloc(data_size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->id = cpu_to_le16(id);
+	memcpy(data->cap_specific_data, caps, cap_size);
+	sg_init_one(&data_sg, data, data_size);
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_DRIVER_CAP_SET);
+	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
+	cmd.data_sg = &data_sg;
+	cmd.result_sg = NULL;
+
+	err = vdev->config->admin_cmd_exec(vdev, &cmd);
+	kfree(data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(virtio_admin_cap_set);
diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
new file mode 100644
index 000000000000..1177c4a20e53
--- /dev/null
+++ b/include/linux/virtio_admin.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Header file for virtio admin operations
+ */
+
+#ifndef _LINUX_VIRTIO_ADMIN_H
+#define _LINUX_VIRTIO_ADMIN_H
+
+#include <linux/bug.h>
+#include <linux/types.h>
+#include <linux/byteorder/generic.h>
+#include <uapi/linux/virtio_pci.h>
+
+struct virtio_device;
+
+/**
+ * virtio_cap_in_list - Check if a capability is supported in the capability list
+ * @cap_list: Pointer to capability list structure containing supported_caps array
+ * @cap: Capability ID to check
+ *
+ * The cap_list contains a supported_caps array of little-endian 64-bit integers
+ * where each bit represents a capability. Bit 0 of the first element represents
+ * capability ID 0, bit 1 represents capability ID 1, and so on.
+ *
+ * Return: true if capability is supported, false otherwise
+ */
+static inline bool virtio_cap_in_list(
+	const struct virtio_admin_cmd_query_cap_id_result *cap_list, u16 cap)
+{
+	BUILD_BUG_ON(cap > VIRTIO_ADMIN_MAX_CAP);
+	return !!(1 & (le64_to_cpu(cap_list->supported_caps[cap / 64]) >>
+		       (cap % 64)));
+}
+
+/**
+ * virtio_admin_cap_id_list_query - Query the list of available capability IDs
+ * @vdev: The virtio device to query
+ * @data: Pointer to result structure (must be zero-initialized and heap allocated)
+ *
+ * This function queries the virtio device for the list of available capability
+ * IDs that can be used with virtio_admin_cap_get() and virtio_admin_cap_set().
+ * The result is stored in the provided data structure.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or capability queries, or a negative error code on other failures.
+ */
+int virtio_admin_cap_id_list_query(struct virtio_device *vdev,
+				   struct virtio_admin_cmd_query_cap_id_result *data);
+
+/**
+ * virtio_admin_cap_get - Get capability data for a specific capability ID
+ * @vdev: The virtio device
+ * @id: Capability ID to retrieve
+ * @caps: Pointer to capability data structure (must be heap allocated)
+ * @cap_size: Size of the capability data structure
+ *
+ * This function retrieves a specific capability from the virtio device.
+ * The capability data is stored in the provided buffer. The caller must
+ * ensure the buffer is large enough to hold the capability data.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or capability retrieval, or a negative error code on other failures.
+ */
+int virtio_admin_cap_get(struct virtio_device *vdev,
+			 u16 id,
+			 void *caps,
+			 size_t cap_size);
+
+/**
+ * virtio_admin_cap_set - Set capability data for a specific capability ID
+ * @vdev: The virtio device
+ * @id: Capability ID to set
+ * @caps: Pointer to capability data structure (must be heap allocated)
+ * @cap_size: Size of the capability data structure
+ *
+ * This function sets a specific capability on the virtio device.
+ * The capability data is read from the provided buffer and applied
+ * to the device. The device may validate the capability data before
+ * applying it.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or capability setting, or a negative error code on other failures.
+ */
+int virtio_admin_cap_set(struct virtio_device *vdev,
+			 u16 id,
+			 const void *caps,
+			 size_t cap_size);
+
+#endif /* _LINUX_VIRTIO_ADMIN_H */
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index e732e3456e27..96d097d3757e 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -315,15 +315,17 @@ struct virtio_admin_cmd_notify_info_result {
 
 #define VIRTIO_DEV_PARTS_CAP 0x0000
 
+#define VIRTIO_ADMIN_MAX_CAP 0x0fff
+
 struct virtio_dev_parts_cap {
 	__u8 get_parts_resource_objects_limit;
 	__u8 set_parts_resource_objects_limit;
 };
 
-#define MAX_CAP_ID __KERNEL_DIV_ROUND_UP(VIRTIO_DEV_PARTS_CAP + 1, 64)
+#define VIRTIO_ADMIN_CAP_ID_ARRAY_SIZE __KERNEL_DIV_ROUND_UP(VIRTIO_ADMIN_MAX_CAP + 1, 64)
 
 struct virtio_admin_cmd_query_cap_id_result {
-	__le64 supported_caps[MAX_CAP_ID];
+	__le64 supported_caps[VIRTIO_ADMIN_CAP_ID_ARRAY_SIZE];
 };
 
 struct virtio_admin_cmd_cap_get_data {
-- 
2.49.0

