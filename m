Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012004.outbound.protection.outlook.com [40.107.200.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EA147DD42
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192688; cv=fail; b=aZSaUFzYrGziEWZSYElhB8E1jDVFjpkRQ6f9uqrxJChe6/KTZf8V7ZANOC6BctAHW2rjvaVmXKf03Zp76VHZVBl9NTgwBGkbdsHVqMyFDVkN9X1Wf2qH7+i0v50e5uvb4dqAEO1Nyp4umJVy6iwLMRcHZIeECsl8eXys1opKdpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192688; c=relaxed/simple;
	bh=lSsOCCY1olWGU8mDHSLQn3BTADDmwLERdwlGcX4RVp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QaEzzU/ltYHOb9BCVOYSSsImzf+AyDHXWZqTJ+67mb6W/5khfEignkFRps/9P+hIYlVG9IlicTduLc99Pe73NBNlUItjOPAz8t5VZ6dtp5RfV7KW72laW5DaSkqryEsm9Oo9YcBjgZXzu4otmm802kTfn2WYTH0M+XeJxqEuG3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ukdAPTqY; arc=fail smtp.client-ip=40.107.200.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ukdAPTqY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWVzPbxgE28v4yu+xwurMDM+Qppbe64AJ+14PX3zID7uiQZO9XsnrNJ6tFSlc7z1XibiINRPEqDfDT3AhXOmPykOAQE488PPPqRiKpSqlka+GjQbeu1EHHwWZvLQPsGa71Kc7D4INlh2nFjAAIemJpvo+L8zKwKx8h6b++cp+pnqKWsBsjOoaAAZv4GsnfohpU1UPjbD3GDvVyPSIfe1SfItRdn+aIxHMq59Wspwwi88XaExs4Q5kOZmDco0+EdjaW1quEEhCr5gt2cN0Yv+OL1jkJWpoR9LTpTXU3EfP3TaHUJhW6hz9r5Rj6D9qtmS6KxA1Hinn7kcbHYAFWXSag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jb9c3/cB5NkRQfaZecJPdeChZOkaMLPkwExlTlaEqxw=;
 b=cseWNmvwajgs+wPzR0PZUEAJotzpYOGEU72XZL5ANYkAT0zugrjh/be8Den0X6uTF0LZHYUiIaeNqx3HgpsSOjJoM94S+C+98+WU4jQT1nnDQwNXXKGJ+v0u07ZRbuIlY6yNnmHopdgjEYKEEsZfWRwnZA/g0U87WMJRmIosR4GcW8Qa++UWpZOeZv8l5iOsg3wWWqBFk7OLaMjtExz7eV+EN/AL6u8YqldhgUJi395pV/WIHtREmSjyBooIZK/qEwjblBPe09imZYqipCP5V+HRhHNAdRO9MflFhcArrkSdMqVh7XVn5/c7d8D8092rXqVZ6r9mc6axPfjmiKpbYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jb9c3/cB5NkRQfaZecJPdeChZOkaMLPkwExlTlaEqxw=;
 b=ukdAPTqYN6cXRx1FeHvnhDAOBvFGKE+/aS3H0ydbH/5io0e/2W7Crru5t4+bcA7bnnEAwlFEKoVY1CyBmRbPKXE8MJyxW+unJTrIkRDtatmIQiO5KqnxMnlAyxGdA2diZpUmNlG03mLIQhFX+dN8COaVmsEPTMAyP8N6FjUa1JTdMsfKTnADT/lvTtGkwsgcDhRZdS2dOeQDcjne9S/aMPPc8RPdXHVz24DyFbYXGtBjFOH8f+l5KE+Peo6n64leFPCT9pJbBRkAALDQ0JJMpGCy9b9I/GGgzs7xRB3mAkY7gUdWh39rp0u3ukNw0vQfPSeFXCF18+LE0N64gDiS7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 16:11:23 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 16:11:23 +0000
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
Subject: [PATCH net-next v23 07/14] virtio_net: Create a FF group for ethtool steering
Date: Mon, 31 Aug 2026 19:11:02 +0300
Message-ID: <20260831161109.2999926-8-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: b738fe5a-6128-48ee-bd4e-08df077a80c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SFGE4X2Jp/X5toKhrbD570J47ni91N+7QkH9tpmSCxCZFNWbNMsR20oE9zqGA1ZJYb+cYf/EOUp2foVWYePHwPaJsDgk4qmaiO9PCj+X62HdkvavVV2B8stmcp4wZRGwhJ79Izw27CFnbt2HzPR4PkUMWj8RZ3IvFdxxax9nSumtWgVR5tsMbsyWuvkZ6odmZGIu4yl7+wwkdSuzpKgxsK8PSupQbyuCF9+2y6HPVh8sqAU92HaTDXInztRMu/jnO9g1mE7b1hR/2BR17ZTx3o7qzfBBF0uQHVRLoGqK+noevxj4j3D/BwY/8dg3EUYkH7+Ip5VnRiOhlfQWo2gQqF59TJXmHqbnYme60rf6ZKCs9dq7CfhXNNL60M0U3Me1xBUwBPXJxCRZgkwbVqHbK248t/XIY0rbhFSTyLMgszAvKieBDhLug9UtJrRKfP93baERDe/GSUMdbxIy+l3xFyKEyfknJHWJIe13S/Zk4YepVwH7CRXDmq11N+3BbH+oa8218kwXRZyxB7MRgDbgUVyVZJuw/d0GcneFtN3nFyyLYwj7X1jLvgEbTx82u8th5GHgkl9VKU4IOSZXgAfZtNHHkr9Cj/vR8G3nFU+UP8MFu67okKPmxAyt+aGfdJ/luguA/ScMCXUr5ChkvTQtTJbkIvId9hY2Lyq34zNa1nQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1ZVEK73aXvc5LGJ0DmsNuWRDQTKuAdy2m/z5w0+Rx4Uv8VGGA1p6jKBMSyfp?=
 =?us-ascii?Q?rwQ/hQX9xjttwi8msCnSjSFzei0n/JYfhRzF9emo3wkLPP1ke0+AurASPfGl?=
 =?us-ascii?Q?YeqcFA0F20Shg7QOlJ0e40MHxalB4svK4D9l0dnBEZCrUr4GCpkjYPQEuQDm?=
 =?us-ascii?Q?BH9vgvYfqdUEkKQp9BTFdFYwtGhiDYKTL8BQEWxpurKXY//TkvXlbsOstf27?=
 =?us-ascii?Q?2s+jkVdjUjJbcrLShewKvIrhQeVAS8KE8fLH3MjLaPBdprc+R0XQZViQooS7?=
 =?us-ascii?Q?O5SsiGAHmiZEmjEbL18Z0BAl/Cr+1KwImnPP8wcRb3WlQsGGQRIx5etuhgkT?=
 =?us-ascii?Q?/KgQ7mGhrfA93CNrW2sSLwC+vwnpbdM9G7jJ+N5Yr1X5Dp2o3Qu2yrDt6uyh?=
 =?us-ascii?Q?dKcaA4kRgxZiyn4PXNR5kN0UBEqPPbLmC7xBMK3jY0nVfylHNWDjnN7pFTig?=
 =?us-ascii?Q?P41l5Cn1PBhYI6OuDEORMK11u0L2fiq/OZTXxuclr5DgFxjoL9/LJOZd0X4b?=
 =?us-ascii?Q?EWiHLzo4H70xGFPwvnKuGE5mzlmKnMl7F2O6QjYa0xUPualIwKCl+Lftwj8m?=
 =?us-ascii?Q?YQ84Hc+EI6ATQw8rt4FeLvKaWrStiiSY6sqc9zJj0TtSBrqF4k1IQvN0nFYf?=
 =?us-ascii?Q?ZTaToSFMA5jAzfRzTsQJkbA6Ieh7DqzOszQlOJltyusBe3vTlDzYg20hPxBw?=
 =?us-ascii?Q?0w3ir0tm6dD58dZ281i2ibaygM7HvWmEnVf6e6+Xjrn+PI/oX/3DXkBJwF5r?=
 =?us-ascii?Q?ERffR0/jJee5q97tSQ+i2co/lY2FeMr4eCBUiD9Z/rKw7zKxVQnFXeNxnhvZ?=
 =?us-ascii?Q?sOBtYsr9nFyKzoJGmkPmzf1rvKVPXFUmQ5fTWqvv1fGiaGXczfdLaYg7s0gT?=
 =?us-ascii?Q?1AgFGutm2/MWsw1BaHg8I0sA22ktfaoVitYOCNj17/21x4RceWjI9Nzp5SCl?=
 =?us-ascii?Q?n1oxnRc+fVlHEIiTWK9GQnfy+M6rvJ4gKlnFYO0H6kKTcwxZ35UVxCJ8Sg/6?=
 =?us-ascii?Q?y00Z5KgR1GzxI/WxeVajDbSokZUoIhaX/Ii9GoYnX7tV2m167SgSzHj3WvnZ?=
 =?us-ascii?Q?TW6cZ5dfMDW32QvCzV4qqInZ+mvpwQ3U7/35PmZuwGCRD/2jB9s+urtSfAGG?=
 =?us-ascii?Q?lQKiZIzi3iPFOUVuWF/X9eYjlZvQ0J3UbLm/vVyrFA7UD22l3eK7tcvCRaf3?=
 =?us-ascii?Q?1j0VQ6rtS4bXetT/QW0wx55wNvg8iTAPPj15BiiScUFgsShIllUEGKJLQtmN?=
 =?us-ascii?Q?tUQUZU5HbEL/p2z4g5Q1ZePEM/BJyoWUUgc+ofJvYmZ0d/j8v/qFJasm5ohq?=
 =?us-ascii?Q?3xRtJqEQrq+F/lfin3yRWQUDjhGzhQmtAEbklnsXmKOwaL58sdODHVSzFdbD?=
 =?us-ascii?Q?91hwrbhvL73Go6xsAI/H3w7qpl0vP8oUUFp719F7mJGkYRFPoMTUZtxmPXAM?=
 =?us-ascii?Q?b/SBqAHx3Dob/NEZx9VohZfQPaiY11uYlrZ3EiG0MKEmQ9Q5H/IJfD5SMx5X?=
 =?us-ascii?Q?UlH5d55PgxlOEf2pmEbNYhLZk07b2ki9b6g8mRX2X1jsENLSTks7ml+Ib5rG?=
 =?us-ascii?Q?qYJxzGZ5012MwCLLwFiaa2lnzYKdI2xv0An+Aap7y1LQNy467PCczJ3Ur/YI?=
 =?us-ascii?Q?1JqzKlzJ52/re/pm8arwagERzyujvGvVHaGE8fQj9GjNjh5uixyzsdJlhXRp?=
 =?us-ascii?Q?Kay5s1YeXxO69uFSNN/dHf+11L6nZQPzbjbt7KUENVZYAGeqGvBZJVewwDVf?=
 =?us-ascii?Q?j25f2w2W8w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b738fe5a-6128-48ee-bd4e-08df077a80c0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 16:11:23.8160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNwiJbD13Km+Qo/r92NIYzx7UcTZ3hq+J8jfmTu6D929XyOvk23Twwvsu3ULsget/K+1qn2pyxuo1O7K5FIV/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353

From: Daniel Jurgens <danielj@nvidia.com>

All ethtool steering rules will go in one group, create it during
initialization.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/net/virtio_net.c           | 32 ++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_net_ff.h | 15 ++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4f78b881e493..294cfd70662d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -286,6 +286,9 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
 	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
 };
 
+#define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 0
+#define VIRTNET_FF_MAX_GROUPS 1
+
 struct virtnet_ff {
 	struct virtio_device *vdev;
 	bool ff_supported;
@@ -5762,6 +5765,7 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
 			      sizeof(struct virtio_net_ff_selector) *
 			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_net_resource_obj_ff_group ethtool_group = {};
 	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
 	struct virtio_net_ff_selector *sel;
 	unsigned long sel_types = 0;
@@ -5852,6 +5856,12 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	if (!ff->ff_actions->count)
 		goto err_ff_action;
 
+	if (le32_to_cpu(ff->ff_caps->groups_limit) < VIRTNET_FF_MAX_GROUPS) {
+		err = -ENOSPC;
+		goto err_ff_action;
+	}
+	ff->ff_caps->groups_limit = cpu_to_le32(VIRTNET_FF_MAX_GROUPS);
+
 	err = virtio_admin_cap_set(vdev,
 				   VIRTIO_NET_FF_RESOURCE_CAP,
 				   ff->ff_caps,
@@ -5897,6 +5907,19 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	if (err)
 		goto err_ff_action;
 
+	ethtool_group.group_priority = cpu_to_le16(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
+
+	/* Use priority for the object ID. */
+	err = virtio_admin_obj_create(vdev,
+				      VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
+				      VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
+				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
+				      0,
+				      &ethtool_group,
+				      sizeof(ethtool_group));
+	if (err)
+		goto err_ff_action;
+
 	ff->vdev = vdev;
 	ff->ff_supported = true;
 
@@ -5921,9 +5944,18 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 
 static void virtnet_ff_cleanup(struct virtnet_ff *ff)
 {
+	int err;
+
 	if (!ff->ff_supported)
 		return;
 
+	err = virtio_admin_obj_destroy(ff->vdev,
+				       VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
+				       VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
+				       VIRTIO_ADMIN_GROUP_TYPE_SELF,
+				       0);
+	WARN_ON_ONCE(err);
+
 	kfree(ff->ff_actions);
 	kfree(ff->ff_mask);
 	kfree(ff->ff_caps);
diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
index f9e771a0baff..b0780e49df9f 100644
--- a/include/uapi/linux/virtio_net_ff.h
+++ b/include/uapi/linux/virtio_net_ff.h
@@ -12,6 +12,8 @@
 #define VIRTIO_NET_FF_SELECTOR_CAP 0x801
 #define VIRTIO_NET_FF_ACTION_CAP 0x802
 
+#define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
+
 /**
  * struct virtio_net_ff_cap_data - Flow filter resource capability limits
  * @groups_limit: maximum number of flow filter groups supported by the device
@@ -88,4 +90,17 @@ struct virtio_net_ff_actions {
 	__u8 reserved[7];
 	__u8 actions[] __counted_by(count);
 };
+
+/**
+ * struct virtio_net_resource_obj_ff_group - Flow filter group object
+ * @group_priority: priority of the group used to order evaluation
+ *
+ * This structure is the payload for the VIRTIO_NET_RESOURCE_OBJ_FF_GROUP
+ * administrative object. Devices use @group_priority to order flow filter
+ * groups. Multi-byte fields are little-endian.
+ */
+struct virtio_net_resource_obj_ff_group {
+	__le16 group_priority;
+};
+
 #endif
-- 
2.49.0

