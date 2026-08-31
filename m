Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013044.outbound.protection.outlook.com [40.93.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD41F3C9EF6
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163105; cv=fail; b=fojGU5WlunSQ/VmhbfheZmKQMCUsb2tCI6tuhNG8JXsmLEXZ9OF0kiQdHe8hJFnLj62k0VhKmcdJTV7yaFeM4E7ADiytSNjvXPXUT+No6eZ3eHdRv6Ci+sr0gudFdZDWGpuYr3IqZrR+7hj+kTy/TTgRoXYBmtxaX0TJX15gncE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163105; c=relaxed/simple;
	bh=lkIDFI4GUZZkw9c167Tql0ds0yLhSMxpxrgHCdYOTok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CHim7NTIzutxxFA+yZI50+csL2PkAbBSoWutzqQpTC+qS7lVBxA96rJ5njmwA3S20rvDmwIEzLkCadWgP/QZOYGTrmeeWhnXT0Cdq+Kd+aGaGV139JD38iDC2lTz1lvu5jf2r2jCA7wwp3uhUTmF3NvDbhjSC43qvU6O4rfAb+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FNWuxFgF; arc=fail smtp.client-ip=40.93.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FNWuxFgF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaEhFmK16pP1wMInNyBIouy+FV1nrcnqdEUSrJtgnqP80OFUq7T+Nqr+dh14ziTAgUZpeze9FnWRa05daqSk8mv0fgH4gCj0j3H39a3p5yki50mv+NpQT91nmomFci2BoRciRgHYNSqBfmNcIzHhRfGL2wGnpgrxSxWn+gNqTi8UJ0IoBqEOsOlXgJGg6RF19mfseFGdORU5RrTvZwX6hul0LH12wq8MC/pq6Wi8ziWdyKZ1qlUMpW8VDcYWV2YwIEUXRFZO5ugm2MWuI3YYPncr3Zhp/M3Te7E5ilK0C5UK6I+XSDN3FcSobkhWTukL8INeZ79OJeBmT4Y5TNi1pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOmka1n/ycoWyMnGGyUVMSmjr76popUVGDjlmXut0xY=;
 b=P0z/0m9eSpy9I41aSkIFFUGLXJmglcDPx07sNN7dfLPwOOxA11aImWMy5ww+cwoXbENXwNeB4Kq04LsI4JVRHTc0fMy/X5iuKX+k6Ybjss7m0HLZlU9JORrELuDX6zLsfXWDD4PhwilXBi/sjqDB7gdph9kubvJRaYGY+zXN809jezNB0kmqLRF7wUW4HDqw/WD/PK6s0/UiJUJdxrlNPhcklQ4VSBwy9UpS2IJN7p493maX4zE++abJnvf8QgTp2yUcoW3jOEULj1Enwd4ZfqjNtZjFcQmd71LeDNVWRcZr6X6/HpVThPzzeWmHzqxM4hgDubXlbMhPTl4mZVcKSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOmka1n/ycoWyMnGGyUVMSmjr76popUVGDjlmXut0xY=;
 b=FNWuxFgFnVwapygfhj4wFZA1YamZDNFW65Vau9FECWFxsWoXU2CGHmossOCgcCsOkADndT/93BAG4izeZzRD717pT0pnXOG3BaPRw0lKRgw7G3iRKeZanvNSgGtxGr4/yCQ35AyW/x3kdBYux31XUO5EgoVh38AN8wRwgDieaiYlbrh1I5NOzPxL1+J17J34c8Yv6ehJp7JKAuMz18kTZGt+73mcPcmCfO3jPgLVPvTdSVKJtXmdCCdVxS/4qC5ElfP2wTLmaWDBH6Hbx+VlWKkN9vXMppQuIVasxTBZH+POmVkHZIx6wqw29Qw73HUCseMm0HeJEf9sCl7qD1Tlzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 07:58:20 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 07:58:20 +0000
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
	danielj@nvidia.com
Subject: [PATCH net-next v22 04/14] virtio: Expose generic device capability operations
Date: Mon, 31 Aug 2026 10:57:57 +0300
Message-ID: <20260831075807.2891426-5-shshitrit@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260831075807.2891426-1-shshitrit@nvidia.com>
References: <20260831075807.2891426-1-shshitrit@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::12) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|SA0PR12MB4430:EE_
X-MS-Office365-Filtering-Correlation-Id: e7501cbf-d01b-4021-2bee-08df07359f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|6133799003|22082099003|18002099003|56012099006|3023799007|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Jrthyf1gDNnwJE9d/ikLdYGTQAxyb08c8mr3vksH61KPDpG0KEFr4X+YE8Ie+BaE2cawCi6p1AtiAY9DHc6M20kRP/mTdATrTVmwNOzMNrjOmkEWeQNengMayduTUL+C/jhknKsu1keNJg7+4rl98SyngIurV18FaXx5lhkVNDJ3wjha9VpBFEslGALLy6YsmmKKuGI9XWsIbsqaZPfrmlrBc8lMkQ2rrY9sj3Ka6CYwALk0MpvZeDVG0xrKNFarVaSYA0enQRWzmIBW8e1mEBuW098Vt5NpOoJ0srVAQWWVngeuK2SEaFIf0oBF+H52OciPMcwVMXoGEgycWgKTXZ4epNbJL/u9zsEtFOn29JDSDIFEbs3rG/B+FFJRiXIwHMPOxbjOKTD2TayAle0hbswx/DBGobQImHkwCxv9NdiiargXYV8AosnlF+nhOpIxNHrza0601IW5SIjwTkLhfYiB9/kTdckE6I6n0WEMc/UH2Ooo+8isIevHf7iSdbWpOIloQ3Tv5TqH/PFB/nxGg7RGyaDzhoT6WXgMASWm697t2XVOkJOOftY9lcjM/RL3392eeF277fYUJ3nF6970LWJ9JlbIxuViLlX670yx8QqArpyg89rNpKhjpbnPXtO2y3AKHfFbmr2d6r24z2PN0tsJ36fdG8++yHgLrgQA2ds=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(3023799007)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yqPFwXvFN6d1t8gb7fW/2IAKWdyuY55WaA3X90tYaPYjkvp/JYPrmqtSJvmV?=
 =?us-ascii?Q?6WbGOqaICL4Mq8hBDEn7Ugctse4pma4mt9aRFPxMqzQIFloOR1vDrR41CLzO?=
 =?us-ascii?Q?M3bC85j8bfqsWpxNxpiQXUgR56ST6206E71+OFliJ+g3rvYfSkhOwYksKjMO?=
 =?us-ascii?Q?YNp1ODeD+dK+g3/GjfGg9TLu/IRlqcyfLrhX9jaqvXN+9Z9f9lkTCSsBBF6m?=
 =?us-ascii?Q?b7ElrbJ5FnYs6qf0wRIYCHWbp0deO8GPyyubBrsesruBEJkCd9tM91926Hun?=
 =?us-ascii?Q?8efKVMfFxKRR3/1Tyd1lNoNWPMLN6RinoGP8hbMH7w1bdtvKX/soQapgrSIU?=
 =?us-ascii?Q?rtZ0+iiWrHT6tKDpoP0rE06nKUHs8NR0VN2IAebDRrFQ0uHk4y5IDtc45Mzg?=
 =?us-ascii?Q?zKqYQnvGc8scmOJzduhc9eQ/sym77uySmD6sCeJ2jtH6I0ull4nsWe04ELpC?=
 =?us-ascii?Q?VVeG8RDvnneKOOAmciXlN1gpvIU6JZ8+OS2p/gSYvpiUg/5xaD6YNzQ4TrKp?=
 =?us-ascii?Q?tljYyYEtyopAp8jNBzt0114T5z9jJwI8urHtqzVeAnjqXo7HH445bAlwAZmp?=
 =?us-ascii?Q?qN8GN39sIi/qbztc+pdi9h6gUCXxEH/AEjiaB3C7B7A+bgP+ivOluSsOc4YF?=
 =?us-ascii?Q?zuSsK0dmFsOPRMwI2yoxsGRC1yVxA4hWik9eOcKFYT5nCP4UnJt6BVr8Kxuq?=
 =?us-ascii?Q?WTMEDkELio+gHj3gJ2HrArrT7XRBvX1YlwaaOjzTcQvCtuGXPeZflROqpu34?=
 =?us-ascii?Q?QH8MAE2+mP+tRUJ2lhiEM6a7bHKlN9FE/I5B7E7eLXOr7wQs6TST5KERAgAq?=
 =?us-ascii?Q?evDSIXijKPPi/cxpA6Br8l/VtOWyjar9X3qRnWQVuFv2VjM34/YhI3J385/v?=
 =?us-ascii?Q?5gt78IK6xHowemwu6qdbpQ3SyrI2Ngc8XYQPlfE5vKP556VP3npwMbA/B+sf?=
 =?us-ascii?Q?MK3t7yMnKkRHXuzOsFGlZTajUw+kIsGlOAo5iB0h+da60F92qXsPm1CH3S0b?=
 =?us-ascii?Q?IKzCOHbLWvumdRC5630XVKLdQJPo3PfaJz8ILQfSJL5PNDCgeFLM9qCqynyF?=
 =?us-ascii?Q?RIoCzh+LBbKib9P94uKzkHHFdmoI/Y52w1/M0KwtkLzI2Lqqb5oYLCcVYXVj?=
 =?us-ascii?Q?Biu3x6BBNXwXwdUH5R1zNB1A3vgS/B8m1LBqDUpBLFRt+2E3CdIAWcdGSpNQ?=
 =?us-ascii?Q?rbfYygR7O22BF2Hm8/7gaLLPSZfX/1MzMzVVzqn4tDtkpqqtoG9Gh4E33gPw?=
 =?us-ascii?Q?3bSNW+4gxBwvixH3IV8dsM3ljxgVeBdYgOx6fhK1XPVrG9ASF9d8R5ZspgXE?=
 =?us-ascii?Q?/7PoM+aIouQutN5sTQmWG+eoCG8+SX4qQWfzRwznTnUwv1ZNg6W0SS0Jzy/E?=
 =?us-ascii?Q?DSMRm9FEnaTzXq7d4ct4p/uYk9rKh3INivK8ulvOUGk1upMXziFHAHJbmP58?=
 =?us-ascii?Q?Bh4B1vELwHTF4/dWLst+60ZLSZFOBqGFKMNWN7nyfPBJF5TvJz1AuNRBQ1c0?=
 =?us-ascii?Q?l3Qd7L0Q8iGMlOY2iolZ43ETXxf+07TrQl/mPxsAlDjhfXe2j5akcshZf+s6?=
 =?us-ascii?Q?zBQcbMy6zcLf5jRKzM1DVFQpK3GwuzkJwe59cWkBO4aGbMUdrR6Ph3N2KIiF?=
 =?us-ascii?Q?+DsbFBi7rbxAoqrGqtvraGiDHGV9Hc1h21Qtg2ATYcKt8f2iE75PkUkawGMC?=
 =?us-ascii?Q?5FlVtiv/i1Qou0T0x19t1RbvNRoMZyJ+1REYKzDj8GTTJkea90bU/Sem1DCd?=
 =?us-ascii?Q?EMzZWSfZ0A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7501cbf-d01b-4021-2bee-08df07359f89
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 07:58:20.2633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zwmd2VmXZj92o0myyaeatoHYpl63FIK9O5rA2bSLi8WznoKQPBqgZP8Pku0nti1vnU+vMrUew4V7b33a0cqmWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430

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

