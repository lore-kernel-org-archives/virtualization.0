Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F5841685E
	for <virtualization@lists.linux.dev>; Mon,  3 Aug 2026 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766059; cv=fail; b=KfT1JhXUrW/78yZMf+CawGEq6I+4Tq2UEuWtDVfK3GuXRrUeub3GrzsjD9cXeUTSlpfNDXiq0u2CHqWYzO6hbSPLy9WuOPx32MkSSIFFtvouhwO/hGlYg9LUjk84UWPAu5hr2uy7uR3sJuEYVn7G44qNFVIQTi9YAyyjEqeRkGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766059; c=relaxed/simple;
	bh=el7WFFv1uRJgF6id3DdP/HUDVTTvQCQelKJxqrE+WKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=caY0tSsoNgnjFffB5SczZNBVt8vM5q8HNARH0Ksx/oLRLUQMdkNDlRQOlaPsaZVf/HrNEv3iqNmTcVZWtQ6QGn9x548X9r1LhMWmc19rGOxH4G0VBVVE2T/T7obpi4TKykS231WL7n2jxlTv6mYeUBPJLz691tVc/2japUJACh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fkEO7yuW; arc=fail smtp.client-ip=52.101.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fkEO7yuW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuyNu539wwU1d7lrnRYA5tEAtQUvF7EJhO9FJcb9KzN/HeH24JvVztbqTdMkB2eAd/u2lQIZItkLxvutZQzcEfF4V0QkM19WogyL5CvO8V0wglK59izOr+jaBpplEu79SAapzKEOTxodhB3eWSU1ixKGqrlWqKzGM7y7XGjAB7mMTQH8q21Cjs3WOQ9s4tJrsJ+cIrtmtHKP9Sv1MoSX+9be1rZedt4fmLm/VkS4es9eJOM5V7AHEO41HwOqChFGsl05alsoWmKHi7jIosLzdahJdRnJNYKsE/wqJBMhC6Y3c2PXaE1XK6KYmHWXnGlFipxU82BwYDeEzGmrN5DcwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WSojNiAWrymdmgK776jwuTBXAgmxUYWrc0xyKPSiO8=;
 b=ferSfF/e7pQI2yk9F++k7z6dlVGw41IhlI9A8qLdLPrys8bIWPJu34y7KBp07TTQrgXaqt8lNtg5aU2g0ivYnD+waNsyNqwqcOyTYN5oG6AyK9RzO3wipNsRejiGN/ka5LBuKcFjwEU1Nl1dnPLjoEMUHf0WNKky2hDEeKZ2uiLuUQhcvS0u5aKLDucdb6AFpkdtSnO42+b0DaPluzc4ukBuQKnaGOStulan/ypig3x9REMdLtPaFJMB3FHW7PBXEGW9+VwnTOAwcnFH73oOKR7GeuNvRd3Q8yZIUuGBjtT80PitFCD4V10YNb1VF9GLd+8JLFGo1esMDudy2lUtjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WSojNiAWrymdmgK776jwuTBXAgmxUYWrc0xyKPSiO8=;
 b=fkEO7yuWHbiibArVyR5f8M3wRW/OOQFGhQdQ/30w+lbEp1dU9ztbKWs1ddzvsyu95PE2dDscBBy9zhiRKpERV4biUCctdzhHRovRdrOEahXtW0/h1v3owggkOMeQjJl8VLTcb6np2JDX9ASzWr+4sBv7enCNA3+b+JkviPmTHkklPQwUxMsZ9yr79SMjwyCG4EJlLwsNW9AgEH21SDaMVqh3lZFtGT4S/G7YuCdBsavSk7OHUZf1V7TyGJrqpOUu7evHt1zmduImFlTNU0Xb8Qn0KO9kcZPHXsM32dEhcBrX3FZ6EpgarQJ9/Gz8ikjXCFflvIqrOjGp0WqIBeliug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 14:07:33 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 14:07:33 +0000
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
Subject: [PATCH net-next v21 03/13] virtio: Expose generic device capability operations
Date: Mon,  3 Aug 2026 17:07:11 +0300
Message-ID: <20260803140721.1871678-4-shshitrit@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260803140721.1871678-1-shshitrit@nvidia.com>
References: <20260803140721.1871678-1-shshitrit@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|SJ0PR12MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: 194ed9fd-0768-4bed-297f-08def1688ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ya2AQtB+wRtE59kZxmEvRR9Y3Qc+SAX1CdGtrYDlwx7Q3WRz45S8PH2GwFI/A81xBxLCDHjgfhGADm6m6DbTTQYGTjOTGYDDHiyk1AtMbCnMq1WhxtBwVH9pn2ADiVNckRmwbZdJcPI4ZakDCG8lDyody6WxzAbIQkirwDJAoCe6vDbnsLe/65LgfE6jJ65ZnwDwp8BvXIiwbXKAdIKx4KE53FbiL06JSAqcavTPGaZHRpNP/S5CkpKbsfmWkGo0ITY6Pvlnpx320bEvxMS5EW6owKWbRyL5U6JsZT+DEJmeroy3rQFFXmMK85e53fET32ZjxLy9nV5qYt1LpkpJejei2G9I8+NzGpUjPnHNBTdgDO7Bh111DfCO1K+WKuzvJGEmGpSZeBwaGPBVD70wUzUfl6GpCYhQtD4i1xt75lHuRFPyPxDEoGAnD9otAXWBp0XYQd88tO0tFdu2fB1tT7BIFpAWu8LZmYqCHwpKMe8QIEiTVLtXWH3gkI9fXmMU2CFCnnF0mZvFd0kOinBmgGgT3clI4/5cS6FQTGnEV267IM8JsSUmGwbb4fs7FWq01hFDoz3UZ/1TUn+gTtyIPUOm00+mEuIHm2/5Jh7+cOqDECJUng5ENY9LSSfWUhS+x73Ub1R3TlkLJzLhnGT1g5zsvqT6aECbJUD3WJjOhl4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L8U1bPbj3pvb/3GgAuvqKTqK5soeoxSxx+DirPrso1qFpM0FOVK3UiysvYan?=
 =?us-ascii?Q?oS/3lUBewcriUxL5YdkzcC0VlHgoJOAQI9RK+prp0vojDzmQ6jzM/2R5QRs3?=
 =?us-ascii?Q?xwk349bQIooNaTARSCP1RnejZNzjXLV1AkeHfCWt/OdQVzba4xauHfJfSqHj?=
 =?us-ascii?Q?/Rm5qZC9N+XooZrMHE8KGreBVviiz3WumMF8kaOCGZQLdP3C2JYymW3XtLmN?=
 =?us-ascii?Q?nBwV/L2hE/LxQPa4TZE3r/lu3PqadX7n5qoafsQwtF0iD9J7rBC30jib3hHg?=
 =?us-ascii?Q?ZaUQKRcaZymDf2B5enerdL7dcGFrQeNKbvoGYADU74TLmlpvMPX9WnYZg2ox?=
 =?us-ascii?Q?0fT8dC1UZul66Y8Dr1cPkWhDXIFfwGLOgeBT5izJ2KeSegrodjlclEErZHr5?=
 =?us-ascii?Q?kh1MeAAC5DGI/SA1/zJzF6fyPzXKN0jeD21S9J+MCoW9vWJvePrpYvzzK844?=
 =?us-ascii?Q?FQeNL7FQYKW+xncDSpJ/FGGCnqngkLddpTgmB3zytEcbSReEeqllC70OTBd2?=
 =?us-ascii?Q?TeDxqdKTqpLZKq05+WPEtmEXV7kV3MSyqi8h6XgeOno1sGylGKx/Lvj4pny3?=
 =?us-ascii?Q?wkshE1gLxDEGldk4ZQxv3BfXWhrgJTgbtgcO17FsTyC2EXLHfDsFiw62tevL?=
 =?us-ascii?Q?IhwStG1rcyhRcPSh585go3VOFl7nASjfleRBUasYnC1yWs4bPhdWyKGizEgq?=
 =?us-ascii?Q?z7zCc1FYp63yb3amWE3S8YLegOueGWbB/1aCs3EUNwCvuORkhqn3KvocDdCc?=
 =?us-ascii?Q?wYucQWDge7UMnkcAzYM2aSspNzZ+/s2fthZkb86BKpdnGNeVIXSmDrYusv1x?=
 =?us-ascii?Q?Ok4L8skgoQw6HHru9mYMMejNQGAqktxhcL8hdS8RALu7jEWLUuy2T+HbdGYl?=
 =?us-ascii?Q?ziK0GpPJ1tRWkE4V8fmUt4ij2WplH1hTSNVCuSIHogBCNbmtYXsFm/+AWrOC?=
 =?us-ascii?Q?+Dqe29PqpuU3JkGiAsEiEy13VwSesNug5RaaFxL+mCv/MRGB2JlJ8d9StMGJ?=
 =?us-ascii?Q?O+1geIdNXc4AkkPYt/a4ncCNmZzl6jeaZU8ErDCIdUfLzgwtj4htg+k9kKux?=
 =?us-ascii?Q?6Zw8mfLeaQwTogA9qm2cAxIbbgH+Ix1HMRl4nK01kwjZjyRFD3odoh6KJhqK?=
 =?us-ascii?Q?32QSVE/xfcF7vp3cBQ6Uvod6yxox3LWdT2uM36wj758XwPA/wofQBV96u732?=
 =?us-ascii?Q?u+IKAlvmOw3advztB67IiWGGLR9ItKlLtCEZ2ihu55MiEAINHx00rhtqNJZL?=
 =?us-ascii?Q?oOnZuX2R8SfpJOSnOaOZmMykBNuJ2jJ+7Pv0A5QOUHYux2wJWfCmCddVaDPu?=
 =?us-ascii?Q?1Ag3QhT01HKwhqgMB5ujzMmXs3ksDf34oAmru0lHHDNMXZighvakdC3aqXxY?=
 =?us-ascii?Q?oZv9qKrohLLyD2MkTdlfK6Vx2bprOK+4tHuFS+rgfaYB4ZFE9oyf0RQsBIA4?=
 =?us-ascii?Q?RugYqxHn8HWU8MqI6B7Dq25deZftQ+4RWvXUR0YS6B2PusbQ98kw3VeTW/nc?=
 =?us-ascii?Q?LTCOfSrPyi07iStmHJXx5aN01aUJ0wOZAc3g4nypjAHNmTrCZXYVLhq540ML?=
 =?us-ascii?Q?PaqspWR9fdVdN5GkYUrDgWFv/2GFmrzHnXJSSoYNjoGS3djpubKrfjTmzBOR?=
 =?us-ascii?Q?FbeWU5+SLu89hre/FKA5E01Xcxeo2XFGJ3xn8r868XkXt5bknE8I5FyfbEdG?=
 =?us-ascii?Q?5iSn8+CQOTk9Ht2NT/K0FMkHNdr49KFEtNGr53CVXFIMnxjxFvK/LfRmyhZW?=
 =?us-ascii?Q?WrvSaR4iag=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194ed9fd-0768-4bed-297f-08def1688ff8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:07:32.9345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpEh7T0joYQPS3GqQwk/yYMcKlSjqlceOSuErl0PV9oiBkgm/sCzd0Gqg7nLQqRj2xD3fGtAIDhWy23EpUVsVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459

From: Daniel Jurgens <danielj@nvidia.com>

Currently querying and setting capabilities is restricted to a single
capability and contained within the virtio PCI driver. However, each
device type has generic and device specific capabilities, that may be
queried and set. In subsequent patches virtio_net will query and set
flow filter capabilities.

This changes the size of virtio_admin_cmd_query_cap_id_result. It's safe
to do because this data is written by DMA, so a newer controller can't
overrun the size on an older kernel.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/virtio/Makefile                |  2 +-
 drivers/virtio/virtio_admin_commands.c | 96 ++++++++++++++++++++++++++
 include/linux/virtio_admin.h           | 83 ++++++++++++++++++++++
 include/uapi/linux/virtio_pci.h        |  6 +-
 4 files changed, 184 insertions(+), 3 deletions(-)
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
index 000000000000..be9144b25d84
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
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
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
index 000000000000..0caeb6314a77
--- /dev/null
+++ b/include/linux/virtio_admin.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Header file for virtio admin operations
+ */
+
+#ifndef _LINUX_VIRTIO_ADMIN_H
+#define _LINUX_VIRTIO_ADMIN_H
+
+#include <linux/types.h>
+#include <linux/byteorder/generic.h>
+
+struct virtio_device;
+struct virtio_admin_cmd_query_cap_id_result;
+
+/**
+ * VIRTIO_CAP_IN_LIST - Check if a capability is supported in the capability list
+ * @cap_list: Pointer to capability list structure containing supported_caps array
+ * @cap: Capability ID to check
+ *
+ * The cap_list contains a supported_caps array of little-endian 64-bit integers
+ * where each bit represents a capability. Bit 0 of the first element represents
+ * capability ID 0, bit 1 represents capability ID 1, and so on.
+ *
+ * Return: 1 if capability is supported, 0 otherwise
+ */
+#define VIRTIO_CAP_IN_LIST(cap_list, cap) \
+	(!!(1 & (le64_to_cpu(cap_list->supported_caps[(cap) / 64]) >> (cap) % 64)))
+
+/**
+ * virtio_admin_cap_id_list_query - Query the list of available capability IDs
+ * @vdev: The virtio device to query
+ * @data: Pointer to result structure (must be heap allocated)
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

