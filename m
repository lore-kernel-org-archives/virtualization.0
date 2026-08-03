Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9863F41686B
	for <virtualization@lists.linux.dev>; Mon,  3 Aug 2026 14:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766065; cv=fail; b=T9Lijf31AqnHFHtgk/utPVmffC0rMZxR+MOq3/m5ineNNwDNhcXH15unZBGA+kxMg+/Lx95A2fBABxcFKfGuqpCG4O0MBCFfsEKo2XDp6fiqaLF4FB1h2aPD+Kuk1CO/5ICkDB3KBqXArOSFDOgDlg/DB+TojRToRzQupc2geB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766065; c=relaxed/simple;
	bh=rdMDDMCfWDGAgm/rgqDJalxsUg1FnPoeyCik/oU2a2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sHvRVvryfTv91yVQPxS6r672mYrAX+kty2hxppzP4qSDiuTJiE+XHUn+j3D6lps0mWTDVG0hqGPuFXb4by7uidCERWjvYR14AQ6QobJeT5V6DcySl+Zwv4g/xBzeP0RJCsRnOGjg85vnXu2JsaX/ekN3kONRCpn7uVOD/VaM1bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Be133jC2; arc=fail smtp.client-ip=52.101.52.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Be133jC2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSfqxEn0Wh3n4IK/MMwLZ7nlXG6GmyJ9YHICQQZoxv+JK9ULv6CQaQZleAhi2zOtWQpWFPgxXLL+wOeLnws5B/bt2Zou4V7PTWBi7p/ZtZOqJPpX7mkdxnlbypjenF1gOhirAadbKxrw360lQht7xG7B5Ggu+JVuF4up/t4TkNwZNV/TIS90ZpSZwvbEEbn/b1ViAvYPAMpgyQsRTSVo9AWGcCpS2JqffZzttNuUEhcz1Ln42KPdnxryLGhsFMoBYfalTRGKVNy4vSEzQQKwXt86CTF5xWrTxn/h/Dl+4j9DiN5JBz0jjMBT5LDLNJIzlqv2KSLOVSmnaz5nTc+jbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDEaB5SlyyzlL3ihYTRofuhaOD7MLERLsUKygIoGqCc=;
 b=jZ45puauzOXVx01EpyvIxvSoMnMkpeOjw7fgcH8J6U5Hgg7sox3jgAnAXlqAwbhtO/zIphXvE0HhasrbdupJaJyPj7CesLVMOceEDXU8o7K8DqTiXAT6hO3JEbmnADO7/hWYkoWaulLg+Hn3Uk1h83VIHaiUvvOUF2Yi0zwl/MNDXRORoF3o5d5P9j957bWAeQPXZRidatoYuhZFR8pXshp4AzWgHThXTVtzE0bqb/6/pE7REK4J7G+Au1AENLEbxwIw5339KMaegPPylf9fIyIhOXjYbpAz1BsGB1Lq72Slz/fUEAt031NrNZbMXB32e8wFF6+J3Ym/u0pSvSH02w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDEaB5SlyyzlL3ihYTRofuhaOD7MLERLsUKygIoGqCc=;
 b=Be133jC2XRu+pvM4BGFK1469tphf9dQIdcNiQdU38iCOV3J5/dgjVnL50IDMD6Qc/nNw6nihrtxBhLErZxIh2SDUCV+7VXbL3bRUubUzn7dQFltpv7DpGIttJjJD5JcE+mAMof0to6o9UyRCQutOWyj9NHgqEknLMoZ+ZgTccAqMSQAAgPNbDOhvQ+MPbpynYJ/1PbcvhYEXAhoWcRvobmJpwNlBM3ce5h+GxlvZiqhqsJQsH4o7hlFx5gXLgEUEq9r1YbI7jP/cgj9sj/NjKIFDweStgFnBddafQpCf4axFPFl9HYdH6nn5zV8xdxbcTSbrQVFSuAgCDKrecE7M0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 14:07:38 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 14:07:38 +0000
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
Subject: [PATCH net-next v21 05/13] virtio_net: Query and set flow filter caps
Date: Mon,  3 Aug 2026 17:07:13 +0300
Message-ID: <20260803140721.1871678-6-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2b635494-f578-47b2-be32-08def1689365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CLFfRfl454XurbumQcITjk5Gje2Hcuu/Xx6CI1cRVV/QCDS72k2+n4zpCH5TJzD1HERqYpqS4VSoiaytOZLLeu+sG8zWoT27psdwIKcRve40h8mlpfo63EpV0zbDcd+GwSNSXQQ6fLIZB/6SFR5XclPktglgdfxjH3CVByU0Xb9TNbNBKt6UNKLAQukxi7qTAJsoFQEpGuSwbnzwnZdaz8G+Akwj9QOKS8M6JF5QZcKI3FX9DErhVNZV44Pb/GjKUlArdQT6hQp3PZap0FN/hDlrRTDDA3B/zk9XmL8aeU/FsahqPGGyy6jCU5A7EWJbxXncyCFM1LLFCpmpEy9QwakCN5Pp3b0WJnyM7c+KL9dJCjW0+yWSiVh2F+BCNiwx6MuCTw0lOZ/jmcC3IRxnysTasjScqDM3O/nRdudu45oy/dDdQqy2fTjxo9Wmoedw0kaKsF3/Lv4mBIVHRVVFNoYC9OeI2EBBJyIriSeXf3cOrokNwz4F0rzIz+y2pbcjJnlgKPRIzEGDLNSzjZS2+/vNxustLgEgr8sGhjDoERQjAPda3hmCJZk7UuP7HZyfk1Yu38P7H7dEF0nbNHdNwHyKzOwNJGgqgdQW5FLxulE3OUp5daehN3j9TskIxrNzDOQeEhHUJWI9tmmARJLh0C+kA5Zo8tV4P38UeKjXX8g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XGfxWSPn7knV1eYDIXIVa2iP7X5ob3RDMX+/DwkT7KOWZnnophy8lOaEE6iA?=
 =?us-ascii?Q?OEqT/k4o2D93wGooIfDIxy7F5C+Iqgli/dD83BccMRBk6DlMxCT9bBw1avex?=
 =?us-ascii?Q?cV02NijVs9VJpJaXneRIRmO49WJJnJKu1MoLUbOHVriSrra9WbxWaeqpUyc4?=
 =?us-ascii?Q?RClaQxu8g30UnA7l93JmVEu6kkeMnAXnrAySFmUXu0lM0sDEtZPTmF4oVTnh?=
 =?us-ascii?Q?Qih53jl5b3ck2BT0TORV/6W0T6vB6GvceTnMDHd1qSGVH6hSHSE28lrMlGB4?=
 =?us-ascii?Q?mhmVufZDp/jpLqKr3+EkZYIauyq4c/v8j63E7WP0O2MSkXtmRCMt5ZpZIOow?=
 =?us-ascii?Q?6NQF9qSLEi3ld3MnAzk8wnC0RvYW9QcoTxAxzM8RgmSHaOSY1R6McufIZ2mV?=
 =?us-ascii?Q?mJ+Zdsk+bWFFK7064QV42rqHYzhN3KGBe71YAPafTDVd6VyInr1sLWG+9kfm?=
 =?us-ascii?Q?1z7V7OTjqed4BXTgcDqekXCaz+yKmPGvdb10eL45vYdrvCZQjLP2qL5XTOvo?=
 =?us-ascii?Q?6bw/cLNTyjvN1LLSFGzsVc7vlfYbd2y5fBIo62tY0INwYPG0oMvpmjos36+2?=
 =?us-ascii?Q?wtpLoNZB5HriTJJ5qb7GfL2zGPzs1aqnJwpVxqKz2lnU+eChiplamJ7w6Rho?=
 =?us-ascii?Q?3R6ewmeGEOYW0Crbx5JbBoYoDd1+tPUIZznwk44AGVHEMED699PBlBjOfx2j?=
 =?us-ascii?Q?nBsWUMPN+rhuHR+zs8BTrqmgiYc+rxqsMNd1GWkMppV0A7RzOXkjvPzinADG?=
 =?us-ascii?Q?gDCAkZasDZ47inOkdYxjOyu2VyPgswAyrDO7dLShIGIRkOpwecSxKBntIxtN?=
 =?us-ascii?Q?KXMK7nI7F7YL1Qz9BbkFiwJYxfqoi6hHzxNrKT0hZadD8e1He/FG0iVZWR4l?=
 =?us-ascii?Q?EEHEqlhKlVhmUNXGN6Rx8zVrFCHa9WWZ7fx6VQKLy3D5KGvxRSY+WuS2GFmF?=
 =?us-ascii?Q?pz7za4ZznzKD7MuF3XYu7KNwtlhyjLeIltRYHHFwJa0SINJYBrvteHv7L5cV?=
 =?us-ascii?Q?tMyUIn+0pbBRkAGCwf023V3gl6PKtyGVUEhql8ZwzPoq+Vbk6g8+EDUENluA?=
 =?us-ascii?Q?LpaEtLZu6uYH9XF6E+VRAebREkbbgXlS2lMKaS4lh9pqYTixHnRkOMPXVpJK?=
 =?us-ascii?Q?o4R0x4POHqdKGA1H1hMHq+Dv5VKm0IBtGZvKx6fT4amMgIQ3BIm6ir23o4xu?=
 =?us-ascii?Q?tBh6WFq9i727elSzNq8im0fTVPweyQ6kjjMp8J8b2nPH4gzZ4guxEtxFAX8N?=
 =?us-ascii?Q?8rVrNY5DySJvOKn+SWyNVFjH9P0pom3rVVr5vlbiAcA2l77+cGzdC8AULoIO?=
 =?us-ascii?Q?rEZYeFJ4uOlD0ERWd894jhcatIrzaxSrRjpPVfolM5tAHTbn1In82mHE89cw?=
 =?us-ascii?Q?bq6VjxBTrx/FBQUWZavD//ni1NlpQnPaXOwtZ+SLuewQbmtmjKMt8ALTIyrP?=
 =?us-ascii?Q?LUuI4GKHSRAVnzouS12JVKCq0Qd9ksIpeDMxUb2zHYchp2HDx6Sue37ENedG?=
 =?us-ascii?Q?liEUnxcyAePx2X06f3skgPX/kQAx+jvVbLO2wKZc3qImDU2iGfVVoVe33yhK?=
 =?us-ascii?Q?pfKJTfD33WndKdNLFSO6+j8QhMRn5oQFrZD3hvrosrsV0cPoXh62F/azwysf?=
 =?us-ascii?Q?El19G4AK3cuU+fvYltMeKOWrcSu7pfey9qIEeZycySi73XuGFmXNw4qbC3T/?=
 =?us-ascii?Q?3Q1C5I8e9QwVinjdPqbieVH+CmRRdcmYbSxT4I1zkbnJAn/LLNRNgwUAwAt/?=
 =?us-ascii?Q?bJvOyostEw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b635494-f578-47b2-be32-08def1689365
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:07:38.8211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VR4HYXSUM9/beIKkKYMLSZW2+tqFxZahpP3sMxvn3I+TRaS+f9H9OASoXY71t62MmtTNNfqsTPgqkNc3BlnLig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459

When probing a virtnet device, attempt to read the flow filter
capabilities. In order to use the feature the caps must also
be set. For now setting what was read is sufficient.

This patch adds uapi definitions virtio_net flow filters define in
version 1.4 of the VirtIO spec.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/net/virtio_net.c           | 239 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_net_ff.h |  91 +++++++++++
 2 files changed, 330 insertions(+)
 create mode 100644 include/uapi/linux/virtio_net_ff.h

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3e2a5876c6c8..0d1f5a6cfd12 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -27,6 +27,11 @@
 #include <net/netdev_queues.h>
 #include <net/xdp_sock_drv.h>
 #include <net/page_pool/helpers.h>
+#include <linux/virtio_admin.h>
+#include <net/ipv6.h>
+#include <net/ip.h>
+#include <uapi/linux/virtio_pci.h>
+#include <uapi/linux/virtio_net_ff.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -282,6 +287,14 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
 	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
 };
 
+struct virtnet_ff {
+	struct virtio_device *vdev;
+	bool ff_supported;
+	struct virtio_net_ff_cap_data *ff_caps;
+	struct virtio_net_ff_cap_mask_data *ff_mask;
+	struct virtio_net_ff_actions *ff_actions;
+};
+
 #define VIRTNET_Q_TYPE_RX 0
 #define VIRTNET_Q_TYPE_TX 1
 #define VIRTNET_Q_TYPE_CQ 2
@@ -474,6 +487,8 @@ struct virtnet_info {
 
 	struct virtio_net_rss_config_hdr *rss_hdr;
 
+	struct virtnet_ff ff;
+
 	/* Must be last as it ends in a flexible-array member. */
 	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer, hash_key_data,
 		u8 rss_hash_key_data[NETDEV_RSS_KEY_LEN];
@@ -519,6 +534,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
 static void virtnet_xsk_completed(struct send_queue *sq, int num);
 static void free_unused_bufs(struct virtnet_info *vi);
 static void virtnet_del_vqs(struct virtnet_info *vi);
+static void remove_vq_common(struct virtnet_info *vi);
 
 enum virtnet_xmit_type {
 	VIRTNET_XMIT_TYPE_SKB,
@@ -5710,6 +5726,199 @@ static const struct netdev_stat_ops virtnet_stat_ops = {
 	.get_base_stats		= virtnet_get_base_stats,
 };
 
+static size_t get_mask_size(u16 type)
+{
+	switch (type) {
+	case VIRTIO_NET_FF_MASK_TYPE_ETH:
+		return sizeof(struct ethhdr);
+	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
+		return sizeof(struct iphdr);
+	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
+		return sizeof(struct ipv6hdr);
+	case VIRTIO_NET_FF_MASK_TYPE_TCP:
+		return sizeof(struct tcphdr);
+	case VIRTIO_NET_FF_MASK_TYPE_UDP:
+		return sizeof(struct udphdr);
+	}
+
+	return 0;
+}
+
+static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
+{
+	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
+			      sizeof(struct virtio_net_ff_selector) *
+			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
+	struct virtio_net_ff_selector *sel;
+	unsigned long sel_types = 0;
+	size_t real_ff_mask_size;
+	int err;
+	int i;
+
+	if (!vdev->config->admin_cmd_exec)
+		return -EOPNOTSUPP;
+
+	cap_id_list = kzalloc(sizeof(*cap_id_list), GFP_KERNEL);
+	if (!cap_id_list)
+		return -ENOMEM;
+
+	err = virtio_admin_cap_id_list_query(vdev, cap_id_list);
+	if (err)
+		goto err_cap_list;
+
+	if (!(VIRTIO_CAP_IN_LIST(cap_id_list,
+				 VIRTIO_NET_FF_RESOURCE_CAP) &&
+	      VIRTIO_CAP_IN_LIST(cap_id_list,
+				 VIRTIO_NET_FF_SELECTOR_CAP) &&
+	      VIRTIO_CAP_IN_LIST(cap_id_list,
+				 VIRTIO_NET_FF_ACTION_CAP))) {
+		err = -EOPNOTSUPP;
+		goto err_cap_list;
+	}
+
+	ff->ff_caps = kzalloc(sizeof(*ff->ff_caps), GFP_KERNEL);
+	if (!ff->ff_caps) {
+		err = -ENOMEM;
+		goto err_cap_list;
+	}
+
+	err = virtio_admin_cap_get(vdev,
+				   VIRTIO_NET_FF_RESOURCE_CAP,
+				   ff->ff_caps,
+				   sizeof(*ff->ff_caps));
+
+	if (err)
+		goto err_ff;
+
+	if (!le32_to_cpu(ff->ff_caps->groups_limit) ||
+	    !le32_to_cpu(ff->ff_caps->classifiers_limit) ||
+	    !le32_to_cpu(ff->ff_caps->rules_limit) ||
+	    !le32_to_cpu(ff->ff_caps->rules_per_group_limit)) {
+		err = -EINVAL;
+		goto err_ff;
+	}
+
+	/* VIRTIO_NET_FF_MASK_TYPE start at 1 */
+	for (i = 1; i <= VIRTIO_NET_FF_MASK_TYPE_MAX; i++)
+		ff_mask_size += get_mask_size(i);
+
+	ff->ff_mask = kzalloc(ff_mask_size, GFP_KERNEL);
+	if (!ff->ff_mask) {
+		err = -ENOMEM;
+		goto err_ff;
+	}
+
+	err = virtio_admin_cap_get(vdev,
+				   VIRTIO_NET_FF_SELECTOR_CAP,
+				   ff->ff_mask,
+				   ff_mask_size);
+
+	if (err)
+		goto err_ff_mask;
+
+	ff->ff_mask->count = min_t(u8, ff->ff_mask->count,
+				   VIRTIO_NET_FF_MASK_TYPE_MAX);
+
+	ff->ff_actions = kzalloc(sizeof(*ff->ff_actions) +
+					VIRTIO_NET_FF_ACTION_MAX,
+					GFP_KERNEL);
+	if (!ff->ff_actions) {
+		err = -ENOMEM;
+		goto err_ff_mask;
+	}
+
+	err = virtio_admin_cap_get(vdev,
+				   VIRTIO_NET_FF_ACTION_CAP,
+				   ff->ff_actions,
+				   sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
+
+	if (err)
+		goto err_ff_action;
+
+	ff->ff_actions->count = min_t(u8, ff->ff_actions->count,
+				      VIRTIO_NET_FF_ACTION_MAX);
+
+	err = virtio_admin_cap_set(vdev,
+				   VIRTIO_NET_FF_RESOURCE_CAP,
+				   ff->ff_caps,
+				   sizeof(*ff->ff_caps));
+	if (err)
+		goto err_ff_action;
+
+	real_ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data);
+	sel = (void *)&ff->ff_mask->selectors;
+
+	for (i = 0; i < ff->ff_mask->count; i++) {
+		/* If the selector type is unknown it may indicate the spec
+		 * has been revised to include new types of selectors
+		 */
+		if (!sel->type || sel->type > VIRTIO_NET_FF_MASK_TYPE_MAX)
+			break;
+
+		if (sel->length != get_mask_size(sel->type) ||
+		    test_and_set_bit(sel->type, &sel_types)) {
+			WARN_ON_ONCE(true);
+			err = -EINVAL;
+			goto err_ff_action;
+		}
+		real_ff_mask_size += sizeof(*sel) + sel->length;
+		if (real_ff_mask_size > ff_mask_size) {
+			WARN_ON_ONCE(true);
+			err = -EINVAL;
+			goto err_ff_action;
+		}
+		sel = (void *)sel + sizeof(*sel) + sel->length;
+	}
+	ff->ff_mask->count = i;
+
+	err = virtio_admin_cap_set(vdev,
+				   VIRTIO_NET_FF_SELECTOR_CAP,
+				   ff->ff_mask,
+				   real_ff_mask_size);
+	if (err)
+		goto err_ff_action;
+
+	err = virtio_admin_cap_set(vdev,
+				   VIRTIO_NET_FF_ACTION_CAP,
+				   ff->ff_actions,
+				   sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
+	if (err)
+		goto err_ff_action;
+
+	ff->vdev = vdev;
+	ff->ff_supported = true;
+
+	kfree(cap_id_list);
+
+	return 0;
+
+err_ff_action:
+	kfree(ff->ff_actions);
+	ff->ff_actions = NULL;
+err_ff_mask:
+	kfree(ff->ff_mask);
+	ff->ff_mask = NULL;
+err_ff:
+	kfree(ff->ff_caps);
+	ff->ff_caps = NULL;
+err_cap_list:
+	kfree(cap_id_list);
+
+	return err;
+}
+
+static void virtnet_ff_cleanup(struct virtnet_ff *ff)
+{
+	if (!ff->ff_supported)
+		return;
+
+	kfree(ff->ff_actions);
+	kfree(ff->ff_mask);
+	kfree(ff->ff_caps);
+	ff->ff_supported = false;
+}
+
 static void virtnet_freeze_down(struct virtio_device *vdev)
 {
 	struct virtnet_info *vi = vdev->priv;
@@ -5728,6 +5937,10 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	netif_tx_lock_bh(vi->dev);
 	netif_device_detach(vi->dev);
 	netif_tx_unlock_bh(vi->dev);
+
+	rtnl_lock();
+	virtnet_ff_cleanup(&vi->ff);
+	rtnl_unlock();
 }
 
 static int init_vqs(struct virtnet_info *vi);
@@ -5757,9 +5970,24 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 			goto err_destroy_pools;
 	}
 
+	/*
+	 * Initialize flow filters. Not supported is an acceptable and common
+	 * return code
+	 */
+	rtnl_lock();
+	err = virtnet_ff_init(&vi->ff, vi->vdev);
+	if (err && err != -EOPNOTSUPP) {
+		rtnl_unlock();
+		virtnet_freeze_down(vi->vdev);
+		remove_vq_common(vi);
+		return err;
+	}
+	rtnl_unlock();
+
 	netif_tx_lock_bh(vi->dev);
 	netif_device_attach(vi->dev);
 	netif_tx_unlock_bh(vi->dev);
+
 	return 0;
 
 err_destroy_pools:
@@ -7043,6 +7271,15 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
+	/* Initialize flow filters. Not supported is an acceptable and common
+	 * return code
+	 */
+	err = virtnet_ff_init(&vi->ff, vi->vdev);
+	if (err && err != -EOPNOTSUPP) {
+		rtnl_unlock();
+		goto free_unregister_netdev;
+	}
+
 	if (vi->has_rss || vi->has_rss_hash_report) {
 		if (!virtnet_commit_rss_command(vi)) {
 			dev_warn(&vdev->dev, "RSS disabled because committing failed.\n");
@@ -7125,6 +7362,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 free_unregister_netdev:
 	unregister_netdev(dev);
+	virtnet_ff_cleanup(&vi->ff);
 free_failover:
 	net_failover_destroy(vi->failover);
 free_page_pools:
@@ -7175,6 +7413,7 @@ static void virtnet_remove(struct virtio_device *vdev)
 	virtnet_free_irq_moder(vi);
 
 	unregister_netdev(vi->dev);
+	virtnet_ff_cleanup(&vi->ff);
 
 	net_failover_destroy(vi->failover);
 
diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
new file mode 100644
index 000000000000..f9e771a0baff
--- /dev/null
+++ b/include/uapi/linux/virtio_net_ff.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+ *
+ * Header file for virtio_net flow filters
+ */
+#ifndef _LINUX_VIRTIO_NET_FF_H
+#define _LINUX_VIRTIO_NET_FF_H
+
+#include <linux/types.h>
+#include <linux/stddef.h>
+
+#define VIRTIO_NET_FF_RESOURCE_CAP 0x800
+#define VIRTIO_NET_FF_SELECTOR_CAP 0x801
+#define VIRTIO_NET_FF_ACTION_CAP 0x802
+
+/**
+ * struct virtio_net_ff_cap_data - Flow filter resource capability limits
+ * @groups_limit: maximum number of flow filter groups supported by the device
+ * @classifiers_limit: maximum number of classifiers supported by the device
+ * @rules_limit: maximum number of rules supported device-wide across all groups
+ * @rules_per_group_limit: maximum number of rules allowed in a single group
+ * @last_rule_priority: priority value associated with the lowest-priority rule
+ * @selectors_per_classifier_limit: maximum selectors allowed in one classifier
+ */
+struct virtio_net_ff_cap_data {
+	__le32 groups_limit;
+	__le32 classifiers_limit;
+	__le32 rules_limit;
+	__le32 rules_per_group_limit;
+	__u8 last_rule_priority;
+	__u8 selectors_per_classifier_limit;
+	/* private: */
+	__u8 reserved[2];
+};
+
+/**
+ * struct virtio_net_ff_selector - Selector mask descriptor
+ * @type: selector type, one of VIRTIO_NET_FF_MASK_TYPE_* constants
+ * @flags: selector flags, see VIRTIO_NET_FF_MASK_F_* constants
+ * @reserved: must be set to 0 by the driver and ignored by the device
+ * @length: size in bytes of @mask
+ * @reserved1: must be set to 0 by the driver and ignored by the device
+ * @mask: variable-length mask payload for @type, length given by @length
+ *
+ * A selector describes a header mask that a classifier can apply. The format
+ * of @mask depends on @type.
+ */
+struct virtio_net_ff_selector {
+	__u8 type;
+	__u8 flags;
+	__u8 reserved[2];
+	__u8 length;
+	__u8 reserved1[3];
+	__u8 mask[] __counted_by(length);
+};
+
+#define VIRTIO_NET_FF_MASK_TYPE_ETH  1
+#define VIRTIO_NET_FF_MASK_TYPE_IPV4 2
+#define VIRTIO_NET_FF_MASK_TYPE_IPV6 3
+#define VIRTIO_NET_FF_MASK_TYPE_TCP  4
+#define VIRTIO_NET_FF_MASK_TYPE_UDP  5
+#define VIRTIO_NET_FF_MASK_TYPE_MAX  VIRTIO_NET_FF_MASK_TYPE_UDP
+
+/**
+ * struct virtio_net_ff_cap_mask_data - Supported selector mask formats
+ * @count: number of entries in @selectors
+ * @reserved: must be set to 0 by the driver and ignored by the device
+ * @selectors: packed array of struct virtio_net_ff_selector.
+ */
+struct virtio_net_ff_cap_mask_data {
+	__u8 count;
+	__u8 reserved[7];
+	__u8 selectors[];
+};
+
+#define VIRTIO_NET_FF_MASK_F_PARTIAL_MASK (1 << 0)
+
+#define VIRTIO_NET_FF_ACTION_DROP 1
+#define VIRTIO_NET_FF_ACTION_RX_VQ 2
+#define VIRTIO_NET_FF_ACTION_MAX  VIRTIO_NET_FF_ACTION_RX_VQ
+/**
+ * struct virtio_net_ff_actions - Supported flow actions
+ * @count: number of supported actions in @actions
+ * @reserved: must be set to 0 by the driver and ignored by the device
+ * @actions: array of action identifiers (VIRTIO_NET_FF_ACTION_*)
+ */
+struct virtio_net_ff_actions {
+	__u8 count;
+	__u8 reserved[7];
+	__u8 actions[] __counted_by(count);
+};
+#endif
-- 
2.49.0

