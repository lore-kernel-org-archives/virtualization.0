Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010033.outbound.protection.outlook.com [52.101.193.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502E33CF1FC
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 07:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163114; cv=fail; b=UIViMD8k5UjxJZuoaAwaiCFi2SfOQT5XfKClcDjD2wJGgqcFnc48epyuVGN/XgqPrWbxEBYJ/yv3F93bYLXScozSSgRJVITENsSnnJcxHCRzrGXtGZLMe+pX9b8G+1Kh6WGz8gRib4EJbILiKNlSJUuGW277Lzq0kbdqwu+i0is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163114; c=relaxed/simple;
	bh=bkeIL68+Uql5jXA/mffCHvIrq+g5IWCQ2icvKdabozk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kqICVynGPcc6eeT4PAY6GZ9XTkNk9eMUBsOP31tubinbjzt9omOWRAJKWQRKH44maMdezjYhsyIx2QKwtidCoX5e+dc4QQ4b1lGcEnKtn7VWMRbamBbsfnS5/Tr7CIFcykQQNZu/SPSceL5QGeIX8ZNPqTggXpuuF5xE0iBA7h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bIZDdfeq; arc=fail smtp.client-ip=52.101.193.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bIZDdfeq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bg9Ary5tRNGCrRr77jpnUtyxQF5TqXTUQk8HG1ingfab/+ephh7+eXbEbBjSEyq393s+0Cm/7GTip/eiTB2TIlje74BW7Zmq1KGnZkn/F/X0wGA2HXbWBMEqdOBCh3gpY1QVsAnXvFViHe8eYxIWZvdrvpnQuXQcF7zGrsX6pi/dNXph1NqJiBN9tEzVFEM1cvLXpWrS7KIA9mP+VCzEDpwf+47MjT1VAovt65TTpTEeHCvA1GeRucEkfJ6lW3T8TUcLk6ii/isXEH0sLdvo1qnUx07TtCOb/D7QN07SwbSuATWKhfS9XCtuRkPheB/dI45Uxs/rKjgtuCh6d/XDGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDMv0pMxQ8aDr4tzGQHMcjs9Ddz9qACT5TrG0ZWt+ZQ=;
 b=XMjsvXUwtoUliAX1GQMDW7Mdk9RTJ1pJtEOCLOzUX9nVlr3QkWR6dqLnjENUBu6oyyNAvqh/9kwGy8fmt1ELswzaxbKaCMSmCxNTBjSVh/LtSOodWZTiTOy9AwH00lU5m2oMjqxBEhvtRh0XEMRLcT9GZj+4QAz+/i9EniMY5Apd28jS7pTTuRLf/NdH4DP5ZZg4rDrJwlPDkar7pR2nynTGGZNUBqwrwqHLXzDTk8VcfCUbKZekRiAHMK7KPtuVMTQ1iHuSg00lKR0ziKPanQOsBk18d35XPH+mre9mWHth3E/Ixn7Gjv1d5I7zVUwk1BWYTxfABTJ/Zd7En7v5BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDMv0pMxQ8aDr4tzGQHMcjs9Ddz9qACT5TrG0ZWt+ZQ=;
 b=bIZDdfeqDS1gwry7ptP3vJcn/j1bWbGb5u+f4azOpkrL/9JiKDaV7Fp2xltwuUY75Bnn3PFY1ClTJqUjKUhSid4ow+bbl1E+ZE2CHvn8R8FSaFJlGgQE9IGcUqreGSYIupcYzX5DFgc8UH2WMUYSUwmMCkFv0nVjUU+0wOF9k/AFuGkeZSfF0qQbNtPUzfoewvb23h7Yhr/ouEkdKGaTRs2wkz5UWVa311rl7SnW76DSroXLLo9cQNGCgRxkk/zWS/B92nbonn9mH66HwBQhajwmo8zVyKFrIlpy6cHTrYNKcynY/rd2slUy0pV05QTgk4//W1KBRWXWyv9LGnWcZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 07:58:29 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 07:58:29 +0000
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
Subject: [PATCH net-next v22 07/14] virtio_net: Create a FF group for ethtool steering
Date: Mon, 31 Aug 2026 10:58:00 +0300
Message-ID: <20260831075807.2891426-8-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: c5197178-efc5-45a9-0803-08df0735a53b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|6133799003|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	llIX0yaMLZY5mfFoDvJE4IolcEjZBlFCCdDE9KAqBHX58spR24c0zwnqwyja1yY1tubEQM9XoVKppWAv4k/0mam2JWsj6OC9ajCqaDP+Mmxb2fYrirSR1j9JZ35eqCQ0xrNZaBR5ceSmFlUYboWhnld1/TZXrOXYSPffeSdUuIcKeoydU9OPrTDn3z0fn1q+0x8O/ZsDzz6hO+Q4tXSm0xIbDoE/kR2qYw5nK5W+6ETCfxobaDWIRFTMlXuGJFgIneintcOUdiuu4F5Dxih8iHdmUGNMBx90vAB/lZ5FzYZdOCeOpE8U8gZR0p1nR3wy7TSV7YdbY7YGbeJaUJDITkc1d+nw1yosLzk3BxZZdwclb/h9f8b1BaBmzt6MIm12pjl/phcZRiIae0j9KcYJTqkWCTv6/INJPfaEenoh/qrscTuIKsRiHKH3Cl2WuJpBXTH2c9CtLK/JXANBWxDMeb1OV1+2YNl/If/u2YnIqvilGjUyU3n/McmPYJlDqlLc8hHtH27rr5Jk+SvgIjusyUNjytA0Q6du4YpLE6itX1eGyDkiuBRw10to15jh+IU4stBV4SbtiT/ufkjd2qQKh6B/DyDsMf+xl2C8dVTRQcJyPJs7hC3jshFADeJfKfSH6JunDbmkX/1Cit6IYButaHLR+0o3pr/75jDB1qjVecg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OoWyGwPs+u731DNnx70Quc3w1t6gUGVFvMF0rMthji8boTPnAXU2K5Jj7/8d?=
 =?us-ascii?Q?aVhUIfd55GASpnSLv06Xbm8dcIQnzuF2pUzHgv9LgoVqZg18rGSK/Luy2hVY?=
 =?us-ascii?Q?TchXi1TSN2yEgIt+9kz/vBWvRDP8uLJ+cIME8MlFzBrlZIOhIrNg3g+YbsCF?=
 =?us-ascii?Q?uZtiJc8lYXNN3U3d3AZbpjK2tjKiZ41qmXgXeo+y4MUNJAfUylupACtqmV+G?=
 =?us-ascii?Q?B+dfRr6UeP+BBd9ecAkzqI1MvTh/Ii0XRwszTrJufP6XN8cBF0QXuWFFsDBn?=
 =?us-ascii?Q?HeP05nlF+xiYPCMOlPKiM3Tb28Qt7cAGeAo0cBhAwSzRTbxurXe8whe1CKG+?=
 =?us-ascii?Q?n9OzmIkqhDdmIUq90V2iotUaZdoYLfqM9VDxfXRk9g+LPSiV+sR9JDWX22TW?=
 =?us-ascii?Q?QDqCRLPpavj5UtINVV2YNSQnvMWFtK0F8+6jg9HEPtuhZSemS3/QbUUJq3Al?=
 =?us-ascii?Q?jP3JxmehJ+NtwO7CwenQv1XHsZXQLUdFNS+pfBFS7sdOIDixoMlS2wJm1MpO?=
 =?us-ascii?Q?2Z16/H3H/3lQb70WGDlw09AY7pA0CD0iXrGv9zJrOt/ApSAkaxXRUNA3sYe6?=
 =?us-ascii?Q?UndN6WzheLixzQpZ3D5AfteCHb8t0/+5cgfQH5cN89o5nGW3SAjlcPb7DB1w?=
 =?us-ascii?Q?53z0bsggx+1z4XLqhu0XJZgSnkuHii4Ft+nqtBTKlSzGTWHLm6spUJmDf2Eo?=
 =?us-ascii?Q?JBHVkE2Bp0kllFIvZXPZZCskdZuYwcgO6bhbtBlfJw96FQ53FfLJV4ynEy2u?=
 =?us-ascii?Q?3mkw5CD3cwx9l3u55Vs6Y46NJejCCNiwgJQ6x0SVpPNVEDlFwB5GoC9eKtgh?=
 =?us-ascii?Q?zWJdzHtsL4hLRq/LrCbJXwWlF9iyQ+u1Eba+N7zhLS9/t6PFVsV4za2W219C?=
 =?us-ascii?Q?5CFkOZVRI2YrmpS8b+jGkEH4mhWT7UGIlAstzAQUaqs//DqsVvQkZiVUpRg+?=
 =?us-ascii?Q?1cc8OppEtute+/VdMj4NXh6SVsaxjKtj2+Oq6jvTJnmu9UmHsFTJCuZ95k/c?=
 =?us-ascii?Q?R6YxmIFJBcA4a06EKPT7w0tZqB0Yu0fyn2HrptAzzOi1A4nwdXszFhsaI1oY?=
 =?us-ascii?Q?PpBSo3s1KE+I/ljIOKHq52OxLPOT53Fsa+iUymj8LXIi+ryCFhOAu+OYU+2u?=
 =?us-ascii?Q?xj+rYdFXK2+Ve1ESEoUh24LEEdq2wAw1FFwKvtzQqSbPgfHk62FyfqRooY/0?=
 =?us-ascii?Q?a+bDel5IlPoPwMcnoSc9WnsJx1u6tnQoWxVY94vUQvE1vuyVvMJhOVE/wmUb?=
 =?us-ascii?Q?yso5Ci28E3xJ69sngET0jErujhNFlkosBsE53JCQYTZJFHtrEuwH/ou1Eqrk?=
 =?us-ascii?Q?9hYXzwcFszhiyVoo7HMMDmO48pAbWZdcS7tEOWbB/fwac1DwBRiZL1UKS4Io?=
 =?us-ascii?Q?3LeEVtB2v8RZLyu6v0b/m7TmXqPdM4E689pTziA7dPBSCGKAYBLCOFtOSLLv?=
 =?us-ascii?Q?ICw5pGQqF+iFn330zsqptiTf4dXOEJlZkRVfF1YY6d7tICZPXb1RTdiuK4fc?=
 =?us-ascii?Q?lZPEAb1pWjK9ArBEIjugoiw+OdVL5Hsz0a17mTjzkUFN1MIihNFTDUJre+XQ?=
 =?us-ascii?Q?UOHqJO56GWhgh5z2Niywow5yqsedA4hWbya+hST/EVLaxjodSl+n23xE5yGB?=
 =?us-ascii?Q?4uFZ5y4m3iER0jQfb/ZiLEqvV7QepYQOIMWX5pNRWWmf+FKIiHTDKWJS48r5?=
 =?us-ascii?Q?1zc4By3V6VKMVYhSsi+NGgAHDg8c6Xyx8t6VsAihGGhArqWtCQ1MDpjwJpJK?=
 =?us-ascii?Q?ofrG4/wLcg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5197178-efc5-45a9-0803-08df0735a53b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 07:58:29.8002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DcLEmihJU47z/jEV/00j1o7tbFoE6inFujke59Nov0Akps/yrH1baw9aSYCQpLBNis7kxbaDSF51uJkEDYFn5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430

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
index 4f78b881e493..05213ba97f3f 100644
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
 
@@ -5924,6 +5947,12 @@ static void virtnet_ff_cleanup(struct virtnet_ff *ff)
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

