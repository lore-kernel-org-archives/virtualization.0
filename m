Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3F04195C8
	for <virtualization@lists.linux.dev>; Mon,  3 Aug 2026 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766067; cv=fail; b=k+4isP64jVdOEC11Npr+zvL1L0viPqHTFxg+RHKFI5fZdnT1Vn7UKmI2RD6kbpIJ/vStX2aVMnWsBezUvjoBVdSs6kLJZdlDhF3Ynbmgef2QHElYpv92UEcwO7u4/a/Bei8xU1Fp1scmBEDu1m7bPuxDd45H9VORE1AAuMqpdTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766067; c=relaxed/simple;
	bh=vlya5FvZA5dp8sebkt82dtPvn3UrHle71zIp/z4deeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hADUJM0bUbdXu5NJId3gF/rjNIYUgb8bODEPSVwZAqYIDtv8t3UDnKZ3xGuYqFZkOP+qTNDlhgFhZjyYW1XIYppnS846oL9zJMRfJ0REvta5jbiOp4CTkikW37nJ2mRdO0ko1KIdjek4qqTwbDHdA/upJBwEQK9DHQHxMvIaMmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YpzWznHX; arc=fail smtp.client-ip=52.101.52.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YpzWznHX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3cYP2rfgUHFVB9YAWY1k+Wfp/otsftKq4jcxN+ygHSd0hHmyGCTJo5v0N0jaV/idluteWZyH8JVCYPaqpKCmFIL+SRN6UZJ91vyOpn7rLwyvQD6e3918aQWxuX9GOwbir9lryB3O0bNtZo//hPh6zYmRfQCXczm9xIql5rWup/GlSyNNpMrZQ80aKh5wPp5pUnrf7HlajH0QhzFIjGLaraMfyLHKiLf14oW3/UhXjvT1AAs0qZNNSJhksHNU+iO1H+9UNmYDZqTHenrgoUBa9VesMOSpJpowqEQUvNDw4pBqN1GA1QfXPPLf7Cz6vD4O4IHcJC7Gp3w4/HSOb2HoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Zm/MhDCgxF10scDf04xvUexKXvXPjAhbP5Li+kRz4I=;
 b=l1LVYTCjPGHDZnKMvX5hmlQgxwY7XY5T8xtgwN6RM3fCTP7x4keTYg6lplziQQKNOVn3CKmBlru/nugrjQqZbuivRFglC8BYpSoKo9/Cm93n5UvjJNrQrJihT6blolvkb0h++aitydUboOHyJ0QUJGMm6iQh4bC9Py+MZa6IQqB8Z1GIRZQylf/ikQxm8lbO4PlUje6OyFIcx8/28/v38soWzuwdPyUsVyL00rY8cX5Oj1wuvHxps6pX5LNs0K22hOF8VVRQwAmN+RSPeffEMBujJVA871mbqzvD7blFKkWHcp8imXD5q3bSgRarGIpNyURF33qC0g6LtoP9xHQVKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Zm/MhDCgxF10scDf04xvUexKXvXPjAhbP5Li+kRz4I=;
 b=YpzWznHX4g6hZIs85dUVPz67a5TmWmAIF9Yr+ouLBdKWVSkm18bV08P+L5QOzuFXXOfII+3hmIeRAhWA3Zl0MAnFiD5eqAadJXfgFz3JTCEwXv/8u3BBZbELtatN6tQLWfZSajuQOBbtLdqf3DOZ2xKpouL3z+S8LglcPngm8pwSvQALybDJ7gReqW6MOmqqfhz1b9rQ70x2VU8cOB+Hyrs3y/b9aaF2nU4X5iqcScPJYV/YEiYGghwmvQOwLyBNAUjwcWbJlYmK1ry0IdHzBgS+CE9DRFFuHxZAA5Bjmhm60OCXQfeAUuuM1NoHuc0+qPiVMG89P2QD0PBQ/udyQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 14:07:41 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 14:07:41 +0000
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
Subject: [PATCH net-next v21 06/13] virtio_net: Create a FF group for ethtool steering
Date: Mon,  3 Aug 2026 17:07:14 +0300
Message-ID: <20260803140721.1871678-7-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4ba3cfc9-b49b-4583-aab6-08def1689519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tELKtcKQGPkJzRC5sBkQiuFQKQXgXD48Dk7BbEO+G+XeKElWtLBBoJjmLwNSSQZsVREuQlTn6AEcU8i576gwmyIcPJ1pkfX3P/S1g6k9qIem9H50QFd6WHEkkIPCoeNkD82gqkpSmeqIIaRJxny7EwHIcroX5TDr+l5mBYfD6YOdNUFC8f+Ow/ZW8fbwS1UDXvJQvyxrtRZSpPCn0sqzQAjrjONll81UG6ycQOMUuJDe3lYCDuab2m6rbYOge9za1QYUEOhuD0ZHq9HZ9FPXn+iZiKFuAX9IOoNlwqn4pxiHJdX+YAmtLpKkaA5mHpObgXYmNWxHt8Vb4B3Nz8yk+CrJJsbvYPKOE1o0SelPh0Suvkn6PuMA5ZPeNK5AsXmYdmRnLDxGVeClNTgo4fe3G2GSc109GTI3hNUfExj2TMCrvJTM+q7nUiSWW8lyNjOp/4Pa9OkmCzZxYxa3n0RutjDMSXnFph+xo874tmgJCkiHX8S3m5Urw2A+E/HsoCTWhSZ2T/26CXp4U1RKPrm0Zh24AeeTz4hwTTd2DwI58+S/kWmETOkFioz4Ve/Duv2jSIe+Kjfg6YXQ9DG2C5ibvhWeTsyCH211FPwPK7Hhw+fR8F/QySKVvbKMEcYvxGpVihVNgw+ODUhTj7GIslF694gQjHMPPuX0LD85ZVYcKpc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vLbOvz8kWPqExZCzuCxAt5IF7H8LfS4rqNv32fN3wmziHiykDD7xm7WZdHfQ?=
 =?us-ascii?Q?3XaHEowoOxCUcyZF9aTeS2DwEW2UAlnW6OTuAdm/dwfTJrG/TdxY9P/P31C+?=
 =?us-ascii?Q?E1yaal519gbW+SwaKmE8GI5mCtXQLCP+rk5WuTg0AHygmLnJWdkG3mIp99S4?=
 =?us-ascii?Q?DZnqANRXE2FlWjbbzQ+ed5EEsEDgQ0lWpjOG8EMxGE4RNpKgFgRBY8lVDvRs?=
 =?us-ascii?Q?eFpKw+vvmwgbaoYuKK5ehwr7Sb71Z4QeMpjogXbr9JYmDQa3F+RhFrrWqPZQ?=
 =?us-ascii?Q?HIIOLXdms+xx5caYr+qeeIpqfYRTr5CrnxsEe1p6jHH6Q9qkNqjGm5E7QHFi?=
 =?us-ascii?Q?X+oEcr7T+LZyISdJ05qX/RrhUQNLCD6EEuWoJ4lnQobUPBPkY+zLOB7bPWcc?=
 =?us-ascii?Q?pFA7TzBxxIpW+0s4Zb1LmTRy8NVphXzt89pA20Mm5eJFEyVN60bzH+mQuM/C?=
 =?us-ascii?Q?v4Es8ddrcDd65uQ+s49ngP2hEQ6aOrMtRdJgQdwka2oFsqNctytFyW1PPFza?=
 =?us-ascii?Q?pVl9ZwqFhed3HglBPaLW4w7A70OjYWj38/nSP3yevcLM4BO/DRGPl2v5VkVZ?=
 =?us-ascii?Q?vGUAdRJDw5Q7lEgSUlvz1o38X1Bmq0MxBxD+z/Cq8VgRfL2BUv0zaAL7pBfG?=
 =?us-ascii?Q?p9Bfbb73boM+vOrf/QTWUi+JdoSW1u0XRGq4BdsuUawztz+8cwM/ZoxDkkg4?=
 =?us-ascii?Q?yvtiE4jMzJYPW1aN5bFe5mCerwnWPDki3+JoYQsSPzPxUFr8lpWaF/KbT1G8?=
 =?us-ascii?Q?KVwniVUMK8ZY7rRiLC6r0hL3CMhOnjjBB/S4qkFqV3oc4w2CxlOnpPpY/bMK?=
 =?us-ascii?Q?O0WH8gniK2VrJ1xhIalsIIhDWQhKvDnHEqDFVOSGRUFu8x5HtpgfnWSg2w4D?=
 =?us-ascii?Q?tf1roVi33o185cRHRj5h8HGQ0I4K1yMKRgCbOS9LtL9nLJPI9fhmbrVenTAk?=
 =?us-ascii?Q?4zI54hU6WroAvlUhZwd6zyy/0aV/El++pfcLC+S+Ya/q18UR/kCCKTSn5q42?=
 =?us-ascii?Q?un2ggzwkrDc94UVybZqRVdk/xpo13BGgn8Ghz98cjL+OBV9+Hg8hrugzoswl?=
 =?us-ascii?Q?yrr67gZZ2ajdPBMQQbaXSKrZ/sbSnUlbalBnJixjbilllqYbvYOb3avSMSYT?=
 =?us-ascii?Q?dYc3J7jghVK/A3/4kFWlh9LK7oPXbk+tuCRMAgQ1JSsNAZUfoY7VFVv93KsM?=
 =?us-ascii?Q?3J8A8MkTtsfvEi4rqVD4pp3vZdVsibXfxaMPkL7e8qVx8T4JhgFgVItkMjot?=
 =?us-ascii?Q?1fGVl2eHc5N4VWschD9z7VBoGLtH0ulIeWgkY1LukvFYbKohzVgFjhLEsFIl?=
 =?us-ascii?Q?N0Lwinphf6TqsA+5Umo9z2uKiGkWUhNjUBb/OX4y+RzKr5oYhqJVYc1SavAN?=
 =?us-ascii?Q?OTAM/FGN1Cv2PITcHPGlLffkGHNLxQtyu6ehn/+GMlecZHC5w62oKf7p84ll?=
 =?us-ascii?Q?Z/Da7wu+nzzTOMxZz8Q0qIvDHeoipmsKIc4iohNOik8twyZQC5bjno8TqN9h?=
 =?us-ascii?Q?aJtSYS7kJM+8wjrqJ0QqDpTsXn2B4CkaEFSXgyxT8TyTTFLt/v9x3Z45IVgF?=
 =?us-ascii?Q?cCtmmgZtaTqBJMlcZctXjU9RdGxmvgTnAU+al1C/hXcK7Jqp5FQDLfjb+lKs?=
 =?us-ascii?Q?rqtd64zn5Sf1CRvrU/8k4LM/CRPFE0fXj2kkdXQYTGiwmrVGuytb825JvxOW?=
 =?us-ascii?Q?i713QurDhnvcGJZQKlipsfQ5La+hNHsgbXMkzgppNy/ON82rYIyyWkVqY4ax?=
 =?us-ascii?Q?6yG+BzqUcw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba3cfc9-b49b-4583-aab6-08def1689519
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:07:41.5920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzu58OWG9Ui6ZXnFfdWFT7FmNeh2CSk2bFO9YMxHRUZcHvYIejXhM1eFwqezcGZ0tJB4tt5W8KEkxciir23faw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459

From: Daniel Jurgens <danielj@nvidia.com>

All ethtool steering rules will go in one group, create it during
initialization.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/net/virtio_net.c           | 29 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_net_ff.h | 15 +++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0d1f5a6cfd12..e11e42583243 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -287,6 +287,9 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
 	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
 };
 
+#define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
+#define VIRTNET_FF_MAX_GROUPS 1
+
 struct virtnet_ff {
 	struct virtio_device *vdev;
 	bool ff_supported;
@@ -5749,6 +5752,7 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
 			      sizeof(struct virtio_net_ff_selector) *
 			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_net_resource_obj_ff_group ethtool_group = {};
 	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
 	struct virtio_net_ff_selector *sel;
 	unsigned long sel_types = 0;
@@ -5839,6 +5843,12 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	ff->ff_actions->count = min_t(u8, ff->ff_actions->count,
 				      VIRTIO_NET_FF_ACTION_MAX);
 
+	if (le32_to_cpu(ff->ff_caps->groups_limit) < VIRTNET_FF_MAX_GROUPS) {
+		err = -ENOSPC;
+		goto err_ff_action;
+	}
+	ff->ff_caps->groups_limit = cpu_to_le32(VIRTNET_FF_MAX_GROUPS);
+
 	err = virtio_admin_cap_set(vdev,
 				   VIRTIO_NET_FF_RESOURCE_CAP,
 				   ff->ff_caps,
@@ -5886,6 +5896,19 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
 
@@ -5913,6 +5936,12 @@ static void virtnet_ff_cleanup(struct virtnet_ff *ff)
 	if (!ff->ff_supported)
 		return;
 
+	virtio_admin_obj_destroy(ff->vdev,
+				 VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
+				 VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
+				 VIRTIO_ADMIN_GROUP_TYPE_SELF,
+				 0);
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

