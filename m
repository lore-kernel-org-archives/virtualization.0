Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02C03E0250
	for <virtualization@lists.linux.dev>; Sun, 16 Aug 2026 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786882913; cv=fail; b=PiH9zxNsuqb0F7P4/Ys1fWW/FEzGuaubVeOvMJMB/nB8QjjiY0vV6lpSxF6J6gp81kDCwN/YzB82gIVFPWlG2VSKYCT/bJZVBUMHhmVjmVcOsM2YXkLMqhwt+qQksV7dCRVEHIMJJB0+JgFH3TSgUDIXrpl5fqIFy6RXAarlk1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786882913; c=relaxed/simple;
	bh=v8TCNjMuJnu9ikn/WbaH6ICMPt+lsRwOy0chXfjGt/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eDwYuMPdYztrP0Z5S0/PuzqsTyTvN8dso8JeQdb3416QdaE9t6KT7H0S6p3X0YXXChQpBMWzHzlZ2Mcvj5JrbLuwsP9puuNOMq7F55g0q/u3xFfVaVXfGkgmcX4AVQBpjZFYYRDMnFb8CJwhs4fkM66CMIZBGF9JLUC2BDbCWRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ReQY+oij; arc=fail smtp.client-ip=52.101.85.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ReQY+oij"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbeA6Q3H3YNNFbAKfJ3AeUYK0gf1hEgZJu3ZTFUYYNa8sxKmHX8QIJ1R0qRP2qsRNjK4a/BTn27Em4PQ6UiJgjpQxIn7bwQ0lkghOJjTDqpvhYTQ5IKj44wF1aVunjDK9ZaJeq+HRxQv0d4kdnGxNCZ/fVKHGWf+LoTpBqeAFHR34ZLV2lAd3sksHcRlBVqPcjz+ik1z03yOCBhzkGQLrpu9q/PmYkfOgxXf05jMiFhAMz7GnhFo7BdG6DVOqOh7p1jM9Noqf1KkpXPfYzGrxl3TcxlX396zWdCmZHopITIbpSyKVBvsUqfRT86TvKKx6GQvJmXI4fBYi/TNX9/OKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evTruxJ+T7I/jpSrocjyMVJY8KOnfH7bck6OQSaTbYc=;
 b=tLE+fO0yazdB2wlfbdRzYdiYeF3dfRK8d+TVakyWNh63y1RMx978P+PKg2MVxfnc88R//sAu8xgBZUkQii38EAmI4vHFB1Xi+GOF7/CnGQXIWHIUimdCl5oW/nRvzXwSH9V730smzkK3zwSmGc4eoK6ZqyNUM7XmqOm5p1tFW56Jw46DzqwGbu8L/pZij8SWgKcBuDwOD1w0/N90KQGcM5PTZucaU1aNpYwrRATFYpIJAlmbk/VYIAv85hD2f8kZk5LPpU/GasK5kR0MkHWwFzS8KRUdXh8w44yubPqUTurWTcscXGctCrXCGik8Xi35+rkXoO/DMpj/RvMJDByT3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evTruxJ+T7I/jpSrocjyMVJY8KOnfH7bck6OQSaTbYc=;
 b=ReQY+oijOM5K2qnnvxjC/QvDmLD/+i3Ke3LiCCL6jJcVX+m/ULPaUV/99Aqxfrx0FOzrJt7X8XNXek0eDMqI4IBBLWb3+fEyXusymIStUztOFv9vcP/KS1KRN/vJAaRsWRLSLSlzx+EMR56CLBtsnl/Ww99MGoiHRImjNA0K/zvQjHLeGu7XRYuR3cGodCgymjkCeizQOgAHcJhPxlT/Ixusozbc4PCxtvWEa3JUKLYLv3PSvjEWtI3CYi6PMBXdLgi2DxQr/ZNsuR7jVU+iy83GqjBLhrBw8wu1qJwoP9t6hhEfxL/P7l3OknJYnq6MY0SehVYyUGaptKLLPgvDKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 12:21:48 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 12:21:48 +0000
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
Subject: [PATCH net-next v22 07/14] virtio_net: Create a FF group for ethtool steering
Date: Sun, 16 Aug 2026 15:21:04 +0300
Message-ID: <20260816122111.2495240-8-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 83082a7c-0172-4c65-f955-08defb90f180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	+wsY8d0n/RiR8BTxXeBSvGOy1G9l8u47iUNfnKhe48HSBePv8YZmjzhi0WAobS9GXPMRhfJbNG0QRNMNzBpP5FoK8NqoeGS9eBYRneHAdLuc/nDoD2kVQOkZnBFLxv+9FZClDQ5XciHDPAeO0EylPwq4Kq1yt66iLcPZx0ZgEgD24msgQijnCE7sfOdsRGReDRHGX8m+dmA/u5rYz4HlolvlHcF0mon4O7i1ZENN4HfYRaVeWUs/0iE3DBBnfV+Q3Kp7Vn7fEBDA9nTuceTrDrIf01fUqWUOkvHnk0xbnsle6BjdP0NHLJWOh8rWl6VY33lE0+3AYWEo8kci/mD5CLt+MbQMw/TDxrUN/cGDFZVc8ovhJkwbvP1SbHbK+bE+NOD51WDqKwr2RVV3Th4WML53KHvsLiu2V7bSC7zsDVjh2Qa+ANuROKbssPUrsmCvdO6aTWxK1Mgbz+KHFM+lYIq1CAFZUFpeg3WdZgxwNkuFlkCAPlM2Wh8YCERzR4eUjo6KU5aE9UH9kQgUMcWoSULAHBXjht01xop6FHAP2uq3rGfSNSbn4rZkMwUd6iO1uxE9hsvbmnUXv6x1E+29S1rSwGE475ILcibYcKvmcVIy387lLUlO68qgzcCmtKU4e23EANVFRpvU4c4BCYSQSOkRCjxBDMPCX8I7s3JpzDc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rb+wQjVMp4+4/llY+SY0JCkkSMG2BdVz4UJerWEyRs/Ht0k7dYmJgDTxyxdK?=
 =?us-ascii?Q?RnXWs7f22tQju4Nh2qZF41CXKVeIq/imRuzJz5JMJs0jT9Ib2dNFoWYllyQR?=
 =?us-ascii?Q?r3SbvQYz2kQBWRgrfX6/Q+23eeo3lE6zdd9ODHZUYtwhXGjqvMITgRlO1xqr?=
 =?us-ascii?Q?Vx0ZefPnlHW0oWjExhyiX12EVw3zClm5iyWgwZHm1C22SN7kKsQHC8a+Mw6B?=
 =?us-ascii?Q?FwmAVMinNjWwxCIVVe5axRKsfbumubfoC6hfyLe+oxeYAuoIGJUDJ1YwWVs0?=
 =?us-ascii?Q?oBEOK9nXKj6AHf0uRZPkGc+lfPztMgWMrDO9GkCuK1OLaUD2I7M6V69SCUf4?=
 =?us-ascii?Q?8bUk+qQuEbRUqXo3sA9jj6YDtRyetrfPIfel5N0cIcvLJ2HFOcY3c2JUxXY3?=
 =?us-ascii?Q?MKLYhpG+uCqOx3XKx9hjA+28Y24FbgH8oPX6qkUqR0YqYWtacbB55RLIJ2i7?=
 =?us-ascii?Q?txMCthbsjpZvggs8+nakOAsx5BbIvIGLc4mltFCro7+p//TIrIdnHejuOPDk?=
 =?us-ascii?Q?UdJFeTm6ZHDilMw/OJ0QYh/GhKUBDL43iXurwGZrI2o2UR/9aHgHVoEKiTST?=
 =?us-ascii?Q?gfFPvrPbeRM/otUi6etx8eOywY0W8HLTnmCARSONyR2YvbAucTgQPHwJVOW2?=
 =?us-ascii?Q?Jtd8JxE4IA05vDhMDSkTyXHzTeFWHxZuuvXUU3gocXC5d4IyCpRtxiR5hKnU?=
 =?us-ascii?Q?fOea6z9mCAaEFfswGdenJIoA0/fM0DzWl2EbHGrz1BaNzqM4crGU01q5mDKC?=
 =?us-ascii?Q?EzfgbKwFYa4mmaZK1n9wBSLeD4rQSqfCjKng4g8US4e1Hu0nRFrhwYhWy6Y5?=
 =?us-ascii?Q?vNfPEYOk79KXt7Enf7Z64xHhmbCXKGJa5IQw+f5cwN6YAI1N/ivuQSsB+IjF?=
 =?us-ascii?Q?ZSz/3jdPEqkv6MjiizyYa5WdcPOZvKr9YYWtLOkxtb/VOfWACpajmOTYYVtF?=
 =?us-ascii?Q?cpygtoweXxKJUQdVq+X5sK5OGPc9kSKfe4020JM3QGKxNGXCzBmJ7/kzV+Ex?=
 =?us-ascii?Q?7hBkYaky9YbkX1Mb5zJer6ebkKN0Q7F097LhSYzg+d92GG8RJNPO0hvwpcm8?=
 =?us-ascii?Q?CNuJxPDQdAy4jesTkeeTpfb/HipsQC3R+T01I3EMYuUjWyMrAYOghmktXGif?=
 =?us-ascii?Q?tgEytWh8FXYlOok5ySdg2fXpjwaoK1NhyG5dHo/lbW+vEyPeu5fqck3tgpvl?=
 =?us-ascii?Q?gX7E48FfxHoyJNTZyg/sIhWWJGp4Obb/TRNC1Qhi8ju/nWjFkSGjqcKxBJjF?=
 =?us-ascii?Q?sXbl9bnNeeIzis6xhriRe5SujzJK28EjAoT3oox4tLKKZpoShlFU+sDtKrMe?=
 =?us-ascii?Q?vQDGgIlncvMcBPErBYT3kcqKL0U1Qvcq2birwyn4HcttnEJrDmKB2TzPm79m?=
 =?us-ascii?Q?9lSaT9BJ0dZfxaEoTIGWRCUTQARkGNNQzjt1DTENngZbdeRnJ27+FoB0f+9+?=
 =?us-ascii?Q?Lz8oOFx3rkNFqP7nVvqotD/fsJRMByqGdm5OU3BuGd76v+uOCheAa/8UABxo?=
 =?us-ascii?Q?F3rD7sqx/dZx4c+m6EEfzf4jRZ1j9VfkSyJa7TsJRLhiOj6lBx3Ctxl1tKMc?=
 =?us-ascii?Q?wALx6v6wXofv58lfenrI6ipa6usfFXUY/7jJtMDUQDhTt/UyYBh+Kw308jqB?=
 =?us-ascii?Q?+tE2t6bM0EuvC9+uqiRwvMYu7Ks6nGMKEdGcVzYZYHuhGmHIH9Mw4uYpbFlz?=
 =?us-ascii?Q?tCC0tctT8lM6sf2CAP2wQ17edxQvuUWfW0+NAeL6kzOEmIhUN3tL3puTKNdG?=
 =?us-ascii?Q?yREyHrd0iQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83082a7c-0172-4c65-f955-08defb90f180
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 12:21:48.0001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sETlnlOPA1iTK6lWMeYuBUP3/UhoaA43zjU5FU5WZiRnrwarRmlbPTcX2/7rvCIGmLmpRnXLhNzxVUF/HYW68g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573

From: Daniel Jurgens <danielj@nvidia.com>

All ethtool steering rules will go in one group, create it during
initialization.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c           | 29 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_net_ff.h | 15 +++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c8fea721ef0f..1029742b19f3 100644
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
@@ -5748,6 +5751,7 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
 			      sizeof(struct virtio_net_ff_selector) *
 			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_net_resource_obj_ff_group ethtool_group = {};
 	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
 	struct virtio_net_ff_selector *sel;
 	unsigned long sel_types = 0;
@@ -5838,6 +5842,12 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
@@ -5883,6 +5893,19 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
 
@@ -5910,6 +5933,12 @@ static void virtnet_ff_cleanup(struct virtnet_ff *ff)
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

