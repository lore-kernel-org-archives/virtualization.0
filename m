Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012004.outbound.protection.outlook.com [40.107.200.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5008147D951
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192685; cv=fail; b=cGdnOxK896kvpY9HSdW8j7i4X7NPhNev9toolu0IIEMkWB3Iv2D1Abf3f1HvnDfRUfqn04N7U72CL16IXVO9PdOkhsTwbo6yRDaqUyhEZXHhyw+RBHfSu3FlUfLkDCwifcb7bh4AS1Y9F72ruUBG9Haxkaz8TLD+ThMWKoiScrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192685; c=relaxed/simple;
	bh=lkIDFI4GUZZkw9c167Tql0ds0yLhSMxpxrgHCdYOTok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mnytSIOAOyZl3JZ4BkVY64VfeiQIE+HlkgVOpIQNOjmKJEbHJXqI4L6sCpNu5KZFKoflxqPEkBzYeKBHmjEQMBy2cFV4WUQOTiGMiegTFh8Pthn24Dv2HZY3B9vamaPFUqeGiEWccOO9KcK/Id73D7nBBhDhYPsEWQGPMSPD29Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bBAlVwaU; arc=fail smtp.client-ip=40.107.200.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bBAlVwaU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmckUXtLAdjUfoFGJToY+7qMrktdrwL/AGe5bVDXILnUuOdYG7TY0EZT8NMqSUcfpvhTqLNPMAvSkXXZYSfU7HEx3CTSyhH2mDq9+3y3CNkWWM7uSWlDDUTLXGcNWOWMiiynftQIOw1AnJu0KCZFb0evF7njyHbMkyaf6GaeHkEj75M2IXk9ZTTOIwh49wFpAmV36bRSFI3ws/sDlmjdd9IdtL8YBSALIZlq73EoQvOV4Jv1I3JwzaxvA9dm4gDT+7INiE5oR/W0AlSqoFQfKcWFJkrhncfscGkvh66DYTxK/6u/GyjXUhTxmqgPUOLOPO2UG9f9+blKi0W7fOzlYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOmka1n/ycoWyMnGGyUVMSmjr76popUVGDjlmXut0xY=;
 b=G25lL+Uxs2zBTdcp83dOiOrcxcp7S58YMuFx4fOMLppskKv8NFvGjcNacuq4YjWmRQh5ZZT1Tz7Ar2D7B5vgeRqxbJoBrLIPjlvmoa1FgFL5wQ2fDEMqBbOadPFrfleRWGki2vW5gzSYpswy8i/p8M+inCYsCoHxksVAxZz8GhGZ0zW5uIBPTQuujbyahsS0CwXdFWxzVIfXWO37yoh1Wp8d9hnsvtB+tEP3o632oqKhumiWwODGKYNNUZomux0NKdopPY5UV1cnZJs3sbXl2Hg9zsHadk9xOTsE7TxFsQuFe7PhaTTJxpJbQyVOFhkO1rQ6WARP9cpEBIoVPQANFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOmka1n/ycoWyMnGGyUVMSmjr76popUVGDjlmXut0xY=;
 b=bBAlVwaU9IrYmTnEQrVkEsVcazVLoues8lzcwEs3YVROPy635cRsWa0fPAk4AAemUFX+QIotyjZDkQXZhmyba3AtiUOkUdpf4/hSoa4yzbzlZ5nsPoinKcm5YuoeCg7qjyadqcyg3D+zFB/FpPN6UDmG+W19nlFCUdbnE14D0bTtPWeN467AZ4cnQsmRGywWP54HS9LVYzQIpDVFQpAG156aM050Bw2D9LxaTfaWEAV+7SE2Zd8deRNqqMkJDP0Tp3d0UIX80G1Er4avEGow8WthA/fpFYcr5GGHKmUkiuB4yBWyMQlW3Uc8ojESTZ9mXE5olf8139sYB6hFknfSYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 16:11:16 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 16:11:15 +0000
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
Subject: [PATCH net-next v23 04/14] virtio: Expose generic device capability operations
Date: Mon, 31 Aug 2026 19:10:59 +0300
Message-ID: <20260831161109.2999926-5-shshitrit@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260831161109.2999926-1-shshitrit@nvidia.com>
References: <20260831161109.2999926-1-shshitrit@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::10) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|LV3PR12MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0b1895-a251-4106-6578-08df077a7c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|3023799007|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NuilpStsQhHk/ob2mOVIKnXDt4srK4/Sb9JqTAwLigcx2xKSCb9cGPsKYttVvZaAlrG8RzHm/Mz8U4mB1LaB/nL6R0O5hI/Jch0CgrFYYKm+aysK1zWTABdOCTo394ficcbI4V1Thvw9c1lcTmkNFITVwfZGwTm/IO3fdVKhqBMq94g6l2kupzVahOBNKIgUViK+G1bSpGDYllSJm3qTZS5efVSdrfaaqtV5ej4M3/2Y+QXQInixKijb2KLyBg1HtJoDgEsp955/EzieO1xqK2xizZyvcC1W6q8yYg31Hn6YdcpNj4qDnKgEC/asXAm7bA5LCM/NGyxbTTT1JUlok/dSkRrc+bTPGKiIHCMwqs2rubcWDOfp7YozCgxLbhVHmNw2QwxvguiHKwKti/Q2JtqiIBrZ0sRgbaVfwXrmolPnkJssX8mvahw+mNMEZGao3ZOLarAc/u1pxBqEXI/cHftqAWTn/K3u+63iZsWGW5bIoo7uElkksT7b+V8SMUf7yhYXfcezYZ+uE3BGuKC7ojf4Of0crxUi2FjWUxZbjgY2Ty90HmdJyWcIAgXaMTYn6AN3b2tdurteIIttzNGDLB9groOQ+ywfY4kI+8e6E+0ckd/8DYsXWPHOE86nCCd7XyScKBL7s2SHlE52jQ9PxRaVP2RLx4j6eBQ38W0lIjo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(3023799007)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yd/egF5V+NuEAloEw72qioBOlGHrO+paA5wYtcN2dpnSwbtZjwPEfBWUdOJT?=
 =?us-ascii?Q?R0YZPNvogK0EYQHgrJ0Li85sJqhWAJjb45XZxyZpnrfsREr5wskPOgsOYy9O?=
 =?us-ascii?Q?FDPoW1MvjUc8xJep4RNt2vLwIlEFOycIeXHXssdw1+OgV5ZXESlPxAWe9Fl9?=
 =?us-ascii?Q?h5pBRlErmxkvVX9rvkg0EYNjYJ+TFzi9Ft4EDOaFM8FHA8u282TEyXrLWol+?=
 =?us-ascii?Q?eIVdRC1+JqlPhgxDR7bBMGw7TbnGAs5YP2hyWiS/e2Q2CKStHzamK3yuevQO?=
 =?us-ascii?Q?kbq/W0/uvwZEjnsE9SyiHhrSSdj1iIR/+3a4zqGgzcei/qjne2Vq+VBAaJXZ?=
 =?us-ascii?Q?cBw6gCjy/cPNmr6kgTEX5LEqgbBAu2G+9HQmSXa2+MaQymevrlfVpvenpU3W?=
 =?us-ascii?Q?aCMrimIJ5HdSautry/kLIekI5gkeAbdHNzLyGKxnKAVfPpWVvuxjMe0xNFFL?=
 =?us-ascii?Q?IJS3PXVbDrNDvahIf8x/ZL1Uh52y7mpWZgweGEA+5/N3shFefzJPZL7/eBcf?=
 =?us-ascii?Q?hq2fPE97tytnr8k+KzKfrBp5iKaWwH6YY7RIHLLnCfG2yQxYVyJw1lAM81LP?=
 =?us-ascii?Q?R4VcVLw0rakELTE7gdxezW10DO4nkJqxpa5kTOOx2DGHwSU0ArTLMlca/ZSm?=
 =?us-ascii?Q?tbWr69TCV+AalVipOBjlTCR0RL41iuJeXeUg7+DH18PJgf4wLMk8ZixdAROa?=
 =?us-ascii?Q?qL16jnsRkLNRz1XeEg9MIfx1P7a5k+bK/2c8CptRQq2sP7RbUK6ZMyjP1fIq?=
 =?us-ascii?Q?qr1jb8eXjAvKcUVt4k4KCAY38eZi5OaUqrrkP14qFUi2GjmPGYGwyh71a/l5?=
 =?us-ascii?Q?FOjQ56rrMDbLEdLgTt27BXb1gBqWW07DzeSxIWB5UyZe7nPu5bKXIRsq6FGl?=
 =?us-ascii?Q?dK7UnTgOmcwSh8X6y2ANGXQ5nfzhqD4S5I6rYjGbIdG/GskyYB7OBnRvGeWx?=
 =?us-ascii?Q?OE2/v6I9elj0YrUeKCLbcR2CBcdtVvq+tZppHDd9JeRapOh8F1QG+C6x1uUz?=
 =?us-ascii?Q?ce+Y+uNppapqftnkfgkBFwj9FQIENVKE7VKWQY64VCUzoSAf01+JEy8anbw/?=
 =?us-ascii?Q?IFIoIKHRZtEGq0YB1H/ZxLA6qwkT+OVUbetWzZb7UADDVLhCiOWxAOFq1p4N?=
 =?us-ascii?Q?9Mcl4OIYy9CGpC4pVJ44YoNQFl74YRyHocK8nVqbK+BcuZl3DhoT1Dx7Dt8l?=
 =?us-ascii?Q?qRY+UD+kHMKHmuXA8m8jiej3QUPQ0F8jrkkcpJEKMVr1c07cZiBdLt5r/kR9?=
 =?us-ascii?Q?Lc8/TG+Bg/e1RaUrP/22AoV+hnWTq+2zFSf4ON8u6aBoxKiI7fHzhQlIKrei?=
 =?us-ascii?Q?xzpJjKdRhSMIv7/veBGJ+8VRMsLhVBUj1LEcPpQ6urVthnvxi4GPBT9P8tO2?=
 =?us-ascii?Q?dnsaX6ya+jjEHdsb0fv1afK0BJKNPhkZHGlYB/3/AUlyaIMVeF12iEKCkZ74?=
 =?us-ascii?Q?aA764HbDHt+4zAzPn+Tw4PLTFZRL178kcmQ+pXYnW1s9dDkDukOP7YdHaDwN?=
 =?us-ascii?Q?EQ2RL0fyrhsJrvg2l7D0hM6aS97vfEXJ6i4XFN8kgc+9186uu1bjMMBQErVA?=
 =?us-ascii?Q?hJuJ5cjjd1gA8MxuEwT6Wn/EoLvBpT72JG5M5dBfA80q4mpF7WH7SSKUxW+0?=
 =?us-ascii?Q?U0SrgcwR1DblgYzWEtzkdN2qGobSrvcCtO3YnkFJfZ5z1//jJ3UXAgw0FeZB?=
 =?us-ascii?Q?2yfQroObRn6PXBk9YMPKHD1CohTZ03hZuypEFb5LIU56VdUG3FMs3CVYrM8o?=
 =?us-ascii?Q?WQKaGKmWXA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0b1895-a251-4106-6578-08df077a7c0c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 16:11:15.9421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNdPKVm9hFr5pQaIGcCfM6aWNnTaNjWRvJDc/TaTKoJUMJiZxQ5NSFB1yIhqo1wbzkj9NoSNtWIv/9t87r307Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353

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

