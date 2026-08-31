Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012004.outbound.protection.outlook.com [40.107.200.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1895D47DD56
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192691; cv=fail; b=aD1XNPn4LPahVgMS8MIoNyBNicopxS/8fMNnhI2YbOk544IwjzMts/WK/ksCToPV4vOR+2rPV1b8nyaay5Mf9gjg3z9/WuzRBZb7a1So6Fx5UC8RF6qDi/Mx+HTWvEWqOz9fAc3/jkowDSfIKgVRtsuvZ+3Zgt6LEmQ2UFrAEVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192691; c=relaxed/simple;
	bh=3yp1n6CrxsPllejHJRkW9Az5uW70tO+T2HpWXtpmLrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XprDytFNAMUbHw5A/ign09kBq9SpMDnpGX7+bUCkdf0R85UEPWtD+5Ab6fDdqnqvgAqqdPFOSz/2b9tOq0J/M3XrTsVAz/wL9iKgQh6Hf1+qeOZ6+wPp2QXCy8GNLjWecbaFA+N4wezwGzmOGVzdpEWbiQeZXMkb8uO6hI5Y38Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZB1bCwf5; arc=fail smtp.client-ip=40.107.200.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZB1bCwf5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWnn9F11eByqn3GQmKt0jfjToDHYyLuAOizEliOLBxCVEilm7Xxz2hhq0pNyM9RxdiOsCT53wejYAvID+R/86Q79681yHgdjGiQE1fFUtpp/LZXnj9uHNsbzeWP4Mqs+TtX5CD8PyM2lp6TLGu0F/Uqs7wpePUV+79UqoRCJ5VJaaZeRGLkSU4PC5c8PIrnB0xR4Pa0o9py41g4DY+UXIqqrThTnv5PsMcd+eJwbtF0KPhTZx7pxNj0lH9iIfQkHWeUuQjkl+t0gO8vP1DCiiQvUM7+sLut3PYO5tqYzS2F3BxsZJDYCwRZbSHDtZhfAtS+cVByyLKEHCPVDuEp9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZ1yOq0eFrlJzjvCrKsizU0WrNhGjzA+dvPo4oKmO2g=;
 b=JKLB6z41NWn/DOyBNRT0bawEmv6ZygVWyzd4nuy5361ul8sB4kJsyTMPU5XJ7vfxmUNk6aJnaR+SPBD+Eo5rZqGQWsXlg/tekwEsECRvJjKBIIhPQXpJoEZ/ubTxe6A1sqwjxVDJf/fdnRwTGnzk2E27bAjHfm6p6JlpuT3RHNlr39baUVRltWsIrRUYUKNHjs3wxuXGc8g0081Fx44Cqr46T4o+bj+N9RXrYZjadqI55JHEH8pJ1ZmBRWu037GivB/JBnCyH8DCDYt5dX5fkjhz5jMNf9DohgiOieXT6s4ugkA4dFZiZs+5GgzCNYZrnQlaTsg8uOHXmiAiKW74qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZ1yOq0eFrlJzjvCrKsizU0WrNhGjzA+dvPo4oKmO2g=;
 b=ZB1bCwf5ZUcIxreVaFWLsVR9NAT03WRlOGmK/Xr7D4KALdJNb2nLUzOvEhdHDwCSSbq8NXeQgd5qjyaw4j54kEvoWJjhL+YKmR2bybMcV5SG/zbvWqloyY6KMYFlqz3D7wjSjiAkNZbzXkqkygNnNRmpzCDmrRu6uilUV3UQzlrCQNxwpajgYcONxsnHJ44lHR25mbvsiTE5Iv48B5VK9a6/EFcQb9tJ+W0Hvg9s3v1ovA0Ic+xtJK2GC5MGTmKwLyfqHc+cJE7rSFLvRZI53GVcLXs1Vocbz1RYTQ3UCdEayXsMl0/Ba8JJPWFO5+tHW7T3FXitomUsiSrKgzOHFA==
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
 16:11:21 +0000
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
Subject: [PATCH net-next v23 06/14] virtio_net: Query and set flow filter caps
Date: Mon, 31 Aug 2026 19:11:01 +0300
Message-ID: <20260831161109.2999926-7-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: c2db7ddb-de2e-4eb4-09af-08df077a7f37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	c8k2ayzUgNj5ZhQlhJMyUFwCafHVHNcwzh5fn5VywpifjGPtCg+N9EYTGoLkyDvg/nK/corLHsfyuagt7mGi5tvwKs3LnKlw1esMNF6ay6+7Zd5oysnR3+8Pu5D+SO6Sbc1SxdQOpQqeLA4loFJH++WzCcm4QEHRm7MiPmxPvIbFH7SolNqtjlFNWyZJf6pQ9nL+t44BfwecrJDXVTs3yIJYn3HOxv28fQAVt2ZY2MnuQ6RIiiz9CAOmhDv8LM+F/t+oooWQD1mUKWmFg6Pry3m1/7zn18yTVzqpeuW/j0c5zUxiEBaHNWbdwl4O79fPQQyFStt57bAjal/vjteN1Hb2tmDAyI+oRWGJ3EfAKFA2xBzxKpcKfNU5LVwfAZStTAWCHTUEIgsFTL1S6rhr62rln4iVB0hGzzlmRgQEvcmha9X9XbMY7OUOrK28jGHs5ICTqX0c+CRhg2ltaRSkCR6Zz1IC9m9ItQSGQS65sqamr3VtZN1ujPozNQ5EZKJP+DW/Y+RaUCVWqvgnjD1Wa3OTnqWWRlnGgUZOB77pY/9U//NU9T4rTSQix0GiYXnekqw0sihmv+mqzt0WQYn0+xyL1bQjYb4pxDRIqrBk3ojRNGz/7dxviaTaU0fMFTsddq5y2w/zQ/dtu7+4HBY0+BPI61B1ccBuYdEVYMFaVSY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EKn+2Tg+u7n1mC98iMu2zRQZTWT8CUcWxwc9w/rUd+VpCcxfiMBAYjZwRWHn?=
 =?us-ascii?Q?XFBgDWPvkbgGtwr+H9C/Sawg2ypGy0ir1g0PMc70/tvhEsRo8nqZ/FhQ5+Rp?=
 =?us-ascii?Q?LOVFTcvUrdX5mtd6+VmJMWoLwk7JFfqw56XgxLm83A5FKzt9CyAsfkM6FrgI?=
 =?us-ascii?Q?u3eKLYTjylTXqq0b/Xn4FQ3+WH7E504bbe/JDd/nLP68F9izIBwN5cqEaeMk?=
 =?us-ascii?Q?FekbaIm+ircyBOvyD7v9ELp0IyMZGmnYGZseJBQm4Jv4cS5Wi/NYR+6jAwze?=
 =?us-ascii?Q?XaQV6lCyTRhH7H/E+WGnI3sHsCyoJ/BAOnAvDRtoZm/o7VeAxOkV5IrV2RZn?=
 =?us-ascii?Q?+Dcm9Zg1hLudIwOXZkz8LraNTuCEF6z4q2dluft2ha3IOzcSZQNR4d8r/CF6?=
 =?us-ascii?Q?Wv6R3pfg3xzF67oovU7XZBA2dQwuAY6Wj6jatSyWezGtisZjoDTMvfSuZ0pl?=
 =?us-ascii?Q?2MDBZSrYoldkQ3shrVF93Ga55XTSFAEGJLX2GTCnCHYguMuY4sEB9QMVMSvN?=
 =?us-ascii?Q?AoE3rIQKvX5jz5+7+AsUaopk37yodZa9jdRzDb2FT+EFLcBxciaxq6VbDaK7?=
 =?us-ascii?Q?Dnwm2edwOyH/8ICK3MlqwsM05T27FM2E2q/o2AQxktUGl6e7Ol8qleXJiMK2?=
 =?us-ascii?Q?t8lm2wP+9zRXqDYf+y3VM7f33wanC4/Jvv8U4uF79+yx4Ma7NMvA8eND1JBw?=
 =?us-ascii?Q?6AehTLAYDo7Ox6p6MKgCo9+tpaIP4KYrOL6XM2pjeAOCLeUixsWCM5fV73mb?=
 =?us-ascii?Q?9kJfhWlRWmr1R5C8NcLRGJdfqLw2egh+1VJ5wHta0ocImt51DVPWHJV6zMpI?=
 =?us-ascii?Q?ApXOfxzYgRVsfhC8YbcdnQ+008b8Wc3p8KJRjx/perfgbvcF7bYMNuuynct4?=
 =?us-ascii?Q?ejd6T/jPqRRsBNXp8Jv36RA8J+O28gsbdnsLpx2QUynv/ahAKnAZg7KIyhac?=
 =?us-ascii?Q?08y+JYZyFrah7gD8vpu0hdtMq1xlHykp/XXPlwgqKDje1PdEdf+JdeyCfcRv?=
 =?us-ascii?Q?/S0DLf91lt7k24Op+moWASQS1LVV7Y0u4Cou7PVhAHsBU2KhfK0ONT4qBQTp?=
 =?us-ascii?Q?BWrPOxev3HhGDl/ipmhGRFH4jZTKeyXAh+MvTdOMxRv9sEj9d7onYHzlHdj4?=
 =?us-ascii?Q?HuHGTRSCM4ty6Bvr0t41sEy34KrJt+yvHQVZIxtLBaSbeQmduNwOQTKOqV1q?=
 =?us-ascii?Q?aEwCsu/KK0dOKRljJzIkXLPBom/HgbEF7u4WrECkOOJmnxUp8EVWZneUoTvH?=
 =?us-ascii?Q?xR1C4OcT64K5Q4e5+8lFBfWD7uDIJ+K6OdJq0OZCsapPsJtrFHsit87fmc3R?=
 =?us-ascii?Q?+34M0OR7E4W6C/J+5U7X3XoSPgMMfyLMZ8zDUabkDAbmGsDSmxGvOE4gRKOL?=
 =?us-ascii?Q?CGCTlA7Mdt45c7bWHVHM4n9sjyWGC+lFF8XfUOi6rUuXW4nPbpvBuefgqz2M?=
 =?us-ascii?Q?9beoYEUCUV8P12Uz3VjupcWaA+drXEeKRySMYIuPxqYbAwv3sdYMwrAZ/ql8?=
 =?us-ascii?Q?70xIcYveND2UfJ+/sH56aP5ukCgcid75FdmRnE1ty7gNkvfu09gafkcpvQN8?=
 =?us-ascii?Q?svkZE3Wq2LRMe1LOoy/fCbLzvm0gnkZSFenNnqjYqRQ4jWw4CMOVmzD9+Qmx?=
 =?us-ascii?Q?CYNzsFK0HaZgf0ni27Xb6Wh2CXDJNN1l9RVFxvTQIB4m9i80H+z3lCKsAyOq?=
 =?us-ascii?Q?NDgbR3Uk1vgQcPe4X/3sDnnwa4IJzCyOkY2mEyLOXIbYURd5yJ/cNlEA+Pgi?=
 =?us-ascii?Q?fZ4PqoCyCg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2db7ddb-de2e-4eb4-09af-08df077a7f37
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 16:11:21.2643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9WWaV+z+UCvKF0J11pO1U0fmRTbdl5SC8ziTwo33fL7kkfMHnXmdKT2DIKra78l1CA3vsn+hhrUglabnxmscg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353

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

