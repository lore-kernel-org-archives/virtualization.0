Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010033.outbound.protection.outlook.com [52.101.193.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163A03CE497
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 07:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163113; cv=fail; b=p7oU+bvlz8d3KdQ/M4is7WnLI0qNdZfT/9NqPukHPXA5XgfIGozM/2XMtKiXhNU2/xTFzMLjpB5BiMK+sabndCbiS+J5bfcQPvJpaGDIQazW7jOTzmaFCE7I1mjCDoUJs0zltC36Glrn25or9zQdltACEe7xTXoFesY8Ri9sHUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163113; c=relaxed/simple;
	bh=3yp1n6CrxsPllejHJRkW9Az5uW70tO+T2HpWXtpmLrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XR4xlqJuFJkVcb8hRJHcJfuIBuLr1TWweHaxQ4JE+qDlvUl6GMLs2GElohwoYX2nkvAO78OinMwPD32w5NWrZlRCMFN3cC59EFzOC6Auh9HDZvJRpILCzGX9tYGeS5kksyLpLHw7AEpWFHEuThxyK6ZL3FI4dqdUU8G6LJx/yeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S6gnr2DQ; arc=fail smtp.client-ip=52.101.193.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S6gnr2DQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMtNhFL7sAWc1JyBir/TtX1QIukm3B/x36jHSN50d7R+P2QDL/FswA+2YoL3soeXqibFXPuGMgh3fAOLffxQnrl5V/wBLrS8mK32bCjbgQK9lWOQbZzHKTyhOf/ezjwFeeVhVLFMprtn6DNsHVXKSM/p8lvpJPCpggvvM8+ZjdxDdtjUrLAgTNzK8EqFCUSEfA4DC8jsRAWecqV8CZLByUUsQa3owOrUwQEFDkZ7J5G3nctkWaoeX+NoHGcF9Hh29bY69SHp1569dKk2C5zjf4AMhG0lCjqUZ2SLMUq7jjtvk+gu83oJFcOinXuUSagWyQ28cWn79JdkNXUju16BKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZ1yOq0eFrlJzjvCrKsizU0WrNhGjzA+dvPo4oKmO2g=;
 b=SLA749rR8cl8Z4DMKQEERNGd5lVJeoOc1YptNQKHyZLA5GS1fRS56cGohwMgB+D6Qts6ethgLtZKQKx2OSciRwbYPqtzgr65feTEIpBXu89mPrwyyBOAXhNTdLKipT4K/j9mREEdxUsiYZU2q+rrIhUr3V0u7ldS+ZhnxYnj3dWEc5GyoA8nG1JlFePPm6RCW+kV+bY2nhCqZWRFt97rojAEQQEQ+dYQKHwLfPlEWPU0A79ToRGr35E+92evlWjuMF5ZDcjilT9fZqKEJqhXO8RWHIaDX24WCHCHdffugu4vbFlasG3o5KXzWExyHC3JPu/JPRQQMqF38GMUTG+7Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZ1yOq0eFrlJzjvCrKsizU0WrNhGjzA+dvPo4oKmO2g=;
 b=S6gnr2DQlM7JtCUl1gDyD8e0NbpESZ2H6G9oWGgMFGr78Ng64CUBgU2zmSeEj4t1LtCy/Jp/BGGZrSwlDXK6QDqsJyY4ANSyW+VPaMZbNVUwKlIpCGPskVpqrvvdn4uefcw6JeHklebspqHr2+tPjGvGMFv7CFCspILwR2ayqUCTiFVDR1fEALgaE98o5qpqbQ/rKUlzu+65G2kCDJmaVtCPsSXh4ERnruBOKgVHJ0gElZt1sUdIP9LaEUWnnZUyK65EMYHiB3/8BbrOygxVMBJBJBvKaAi6ahmDrypkQK6pjDfdHVnIu8Ok8J40UP83kKKuxjbK/+oVAEH94ffXHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 07:58:26 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 07:58:26 +0000
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
Subject: [PATCH net-next v22 06/14] virtio_net: Query and set flow filter caps
Date: Mon, 31 Aug 2026 10:57:59 +0300
Message-ID: <20260831075807.2891426-7-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4473ecc9-99ce-478d-4890-08df0735a35e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|6133799003|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	6T1DbMR75SLV0XMb8MvsBARgY2zvns6e2NbtbuFnYTlepLjLzoTNr5CWEiZKjkJg5h5u51UOk76Z6sunB2BAuOYsWLhadZZypK3dDtMwfsBRSYnT7La/wnEEwuWxLkWZvvNl32b2Xr0l2xK/eQaH9Lfgkg04L+mtaIO8NFGtRkG8KqzcUrxHYHauGo5XeYqRVBvh2IflN1Ir15P+uvrYwqUT10dbEC41hhuG78GOabBIyTL4Q4zGdygYYdR2O5DczMCe6BaDKQc668+plmKNBNqf78n0v9KB/xrPX7nteveXPhKmp5Yav+6rpcYBG/hyyzDsIZNiGpCzM03Waud+CIx6/obarJwh6f7VkUNXkdDdTX+9QJvGsR/sJuN/3/JhTJEkd1tSUPs7vS9hlyhxCMSnEl+ID3r71xAVRfFZSskg4Sf8a5XNbDf7SVR4Je15qat/VV/6g+xbuDCRK4XQq+z7iabS4TKbkjPdI00S2URv1v24p5c6oyn8d6h789woeT0lSpgm0HopRjk6dY0oSxckjGWnwxUqm9/Tf9YGwdQwUX7674VtXBNL8etSWhO6jKDhQH3gXH19lnJ5YE5s4huGRYkwk+aIWZDMWqxgh38XzpImbHwZFIz7BxYzEXp8PMzhJMz69jbLlYPKb8x0kmlCAaVm/pT+ZoGymPTdI/0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7IaTUFuuX8KqnEMLApvon/8vMkX54wzcwY2mVPtKHE3VrF0CQSlaHPfiAUNi?=
 =?us-ascii?Q?pBHxMise42oAL7kM2S96s1A1xebIprs5GHk22yBrB/RE+9jpu4mcUZQqfZZv?=
 =?us-ascii?Q?x5jxnRStEXjyJsOWUYRBdGvGHdjeaZPu0dSMZZQLaKYKD4xWDfmwhYDs2unu?=
 =?us-ascii?Q?5GkWAbKgo3gmVRkrSVCrIVgF8L4HPIN1pfbicleQrom0S8WtuASQVHUvrJZ+?=
 =?us-ascii?Q?r+c8ksNLsCRgDCI2kZbSZKmsL82xxPS21qJvSICUAW5gcWcarMxKsXcBeaFw?=
 =?us-ascii?Q?riiChohQk8d6P9gvVF2Afo+T18rtf5wNesmEOQq+ZcOU6RzfxGuGsRuCpwGN?=
 =?us-ascii?Q?AZst841YVZMwUoPqAl2ejoPV2ItO/rXZp13zrohApqZuTSg6snOq7KuvbMdZ?=
 =?us-ascii?Q?3cGl9qbieZEVwiv3e3JKdIHbwgj2yBXqIFyJgmO5JVkXz3frCAvJ5MN13TT6?=
 =?us-ascii?Q?e1WYieDZ7bLEcAE8j3Vg8CoEP5oryq8+mdqHBELXEkMxfYe9Qsgt7tx54v+C?=
 =?us-ascii?Q?//GMHmNSv1Nt6cGBpgujSvNWVQf1da7vX0b7J+207HBJ3AlL4ysqKl73J+5X?=
 =?us-ascii?Q?I0DK4+Zy3iAlHsnyNULT/RRzgV/3TvIEtzUWC8iza4baXCNcTfrUg1momzoF?=
 =?us-ascii?Q?91VGLQvU/OZihmp4v13r5nJkgY4VzaMSwpa5p7aMxKe0qkVa96mm0zJMg661?=
 =?us-ascii?Q?J0fUJ8iLFU21ZGhn7qT71sis+z3R6K1oR2oQAodJnd+MOQz0n2bQtWKCn6yd?=
 =?us-ascii?Q?PoLHKP72V57suj9MSKxnMenv6WqndxAZqQ3f36btW3C6kBCDQTFbk948YoWj?=
 =?us-ascii?Q?qyjJypp6Xi3nTzPv5DrT+4q3kbT9gYL9MU5eQHXhKhb/ascaZ8GZSQ6i0ReA?=
 =?us-ascii?Q?FJuUHgLP3BMR/vDFwLd2jIvuh5v+jVl1DMDtWpJ1dL3igeI1eSsKY3vGxhOw?=
 =?us-ascii?Q?w1rvGn0Y0+5jMg/gZn7leGEUZ/KyZC98nSkt5K/q6Zuvq67F9Jbg1aL7FbhO?=
 =?us-ascii?Q?x/eGuq6u0JBthfH+CxpKYHzBib99NtHvpdFFt9e+JOPTIiWTPRw5EwME3exi?=
 =?us-ascii?Q?iYwAI+HrpiWcRntEcdBN8vD4F+Z8KIVwVrMqvLD4h9Vt5HesygMfaBruoIPr?=
 =?us-ascii?Q?xF63LTi5M5XSKLmpuGhKbKid5sKyLfigYGzL32/0ytmAn4bB0yyO9f4Kg4GA?=
 =?us-ascii?Q?8itFErh1ZOvZnddjGERCEzWH7fTDxuo02re1ybJ8snGkGdhK22Ro+cxQjieY?=
 =?us-ascii?Q?8L3fNj0S65kuMNwl585K6sxpArJlwnaiSwpY+AeRHrKZRsYGxWj7VZkFucvo?=
 =?us-ascii?Q?okffOsf4dJEFg2lwonnFFIw6MmYwTMhH7G7n9EV28RD+n+Jp0CtvN+GgWEqf?=
 =?us-ascii?Q?t6fBPxrCfAgJS0dWde02dXI4xWnsJTooNvbUv7lQmENNcwZ47pEawnYaR/x7?=
 =?us-ascii?Q?wmj5qJH2sb4jb30VoDlP3fjO9A+jc7ZGNww7ahX3Z1UhKdMOdMnVN9tyWNG+?=
 =?us-ascii?Q?17gjWnA9bcF4J/k8Wf8ndyG62kDuSIUqwBXGzBKEeQlmcr1gkOtZ7Euhqw2p?=
 =?us-ascii?Q?zrUpL/zhtLZM9FbyXZHjRV0OPv0ZG29s0kMdgRgjIb13SyLlCpI5KCh6CPu8?=
 =?us-ascii?Q?iP1ea0DhagQB9hniujDNbioFsb405dSR5hCXV9dAPrbNB6u6PrJLe2g7Wo0j?=
 =?us-ascii?Q?9biZwvyWL91XNhB1+ta4DGbWQySvnV2OzbBFCgxn6/G5FUFztrVhMWGPuE2e?=
 =?us-ascii?Q?9nmrz/QaUQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4473ecc9-99ce-478d-4890-08df0735a35e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 07:58:26.7283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfSl2gwGbIwAEG1zzQyxWazbk1Qlg4LLmYbvXwKHGf7mGU30BgJTvsCJUbpIL/w/gnaHHFC7GLVaD7pzqoyGCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430

When probing a virtnet device, attempt to read the flow filter
capabilities. In order to use the feature the caps must also
be set. For now setting what was read is sufficient.

This patch adds uapi definitions virtio_net flow filters define in
version 1.4 of the VirtIO spec.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/net/virtio_net.c           | 236 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_net_ff.h |  91 +++++++++++
 2 files changed, 327 insertions(+)
 create mode 100644 include/uapi/linux/virtio_net_ff.h

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e34c52d059d3..4f78b881e493 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -27,6 +27,10 @@
 #include <net/netdev_queues.h>
 #include <net/xdp_sock_drv.h>
 #include <net/page_pool/helpers.h>
+#include <linux/virtio_admin.h>
+#include <net/ipv6.h>
+#include <net/ip.h>
+#include <uapi/linux/virtio_net_ff.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -282,6 +286,14 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
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
@@ -474,6 +486,8 @@ struct virtnet_info {
 
 	struct virtio_net_rss_config_hdr *rss_hdr;
 
+	struct virtnet_ff ff;
+
 	/* Must be last as it ends in a flexible-array member. */
 	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer, hash_key_data,
 		u8 rss_hash_key_data[NETDEV_RSS_KEY_LEN];
@@ -519,6 +533,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
 static void virtnet_xsk_completed(struct send_queue *sq, int num);
 static void free_unused_bufs(struct virtnet_info *vi);
 static void virtnet_del_vqs(struct virtnet_info *vi);
+static void remove_vq_common(struct virtnet_info *vi);
 
 enum virtnet_xmit_type {
 	VIRTNET_XMIT_TYPE_SKB,
@@ -5724,6 +5739,197 @@ static const struct netdev_stat_ops virtnet_stat_ops = {
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
+	if (!(virtio_cap_in_list(cap_id_list, VIRTIO_NET_FF_RESOURCE_CAP) &&
+	      virtio_cap_in_list(cap_id_list, VIRTIO_NET_FF_SELECTOR_CAP) &&
+	      virtio_cap_in_list(cap_id_list, VIRTIO_NET_FF_ACTION_CAP))) {
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
+	    !le32_to_cpu(ff->ff_caps->rules_per_group_limit) ||
+	    !ff->ff_caps->selectors_per_classifier_limit) {
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
+	if (!ff->ff_actions->count)
+		goto err_ff_action;
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
+			err = -EPROTO;
+			goto err_ff_action;
+		}
+		real_ff_mask_size += sizeof(*sel) + sel->length;
+		if (real_ff_mask_size > ff_mask_size) {
+			err = -EPROTO;
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
+				   sizeof(*ff->ff_actions) + ff->ff_actions->count);
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
@@ -5742,6 +5948,10 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	netif_tx_lock_bh(vi->dev);
 	netif_device_detach(vi->dev);
 	netif_tx_unlock_bh(vi->dev);
+
+	rtnl_lock();
+	virtnet_ff_cleanup(&vi->ff);
+	rtnl_unlock();
 }
 
 static int init_vqs(struct virtnet_info *vi);
@@ -5771,9 +5981,24 @@ static int virtnet_restore_up(struct virtio_device *vdev)
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
@@ -7057,6 +7282,15 @@ static int virtnet_probe(struct virtio_device *vdev)
 
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
@@ -7139,6 +7373,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 free_unregister_netdev:
 	unregister_netdev(dev);
+	virtnet_ff_cleanup(&vi->ff);
 free_failover:
 	net_failover_destroy(vi->failover);
 free_page_pools:
@@ -7189,6 +7424,7 @@ static void virtnet_remove(struct virtio_device *vdev)
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

