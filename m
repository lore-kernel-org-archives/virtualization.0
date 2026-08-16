Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8743DEFE7
	for <virtualization@lists.linux.dev>; Sun, 16 Aug 2026 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786882911; cv=fail; b=XUFoTWb3dQgxug0zofF8bFBaM5KF7mObZTY8khlvUWxnCvnCMk03TWArUU0q/hoSd0pu7mV54zhH6sbn+SUkgZguLt+8SfmUg4QFyE65Xkmc82CWiHuggArrsScbV/Adrr0CzfI+wxxLmFQkKZO8We9vwgBwMwbBZcHqQQ0BlH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786882911; c=relaxed/simple;
	bh=+bSRqrLK/SWj6Nlxfp1AIcE0UM/hgx/NNl030owLUBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I00bB5EOREDeAvqILBlU6fY/SD4skCbeHCUcwZ5HRDMx8p6Aue6wjuVKlvFFsSJJpGIopGT4O8IYb91rbFtjAsP4N89DBYSSpIuxQl3MNcgea3KsTYnasz4uLHksV1o1I5f0jwqTjJKGU8Y2nO/8KrCEsCqX+Cp50tJ8AwLjDkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kDDSH13/; arc=fail smtp.client-ip=52.101.85.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kDDSH13/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHoTwmMulWZfHhTz6xQFZFTb/YPR0vURIrsUeM/ogqbTRIGffkDO00VkRt8Yr45qJ3iq2Ypb73GaPXMQ5Z288ZFcwZk33iqA7zY+LEIs3AE3rTEx0+o35I6i7WBkHkT6HCmXUHC/SzLN5Z9b/dK4c9osho/CxxXDFeg10zRe7bSsBXeT0aVjdXbVfsOckgWUlrMS2u7uoo2Bi3oJNw17iAbnB9Tfuiyr+KIjraHExPWV4yP+3tXdlwc1FQqxkxG5S/qF30fFaGu287AboqLbElB3EWzd97ZMw/99OfprSsCcMPaexAOH+1aQpGG/+FWQimeJVkkOplJ7PeEjBI8fxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAjyEbuAgd9yHaw3fP36sP/eCfGfKJg2o+Ho15P1Mq0=;
 b=H7rx21c2l8+KFzi4bwALwJxT1OOdemRKIIrVTE1ea4pwGBFA2ARpH/VYSqczvmrJknyiaCzzG3/DFBB0D8ealOG3N7yXR97mWADatcyeYcBL9ICgbdPLedJzAFIHN6kxVq/KrU+KcdPCVqjh4ROAuGdrIvL1jx62R7e0dGaKkmhHVtQDD89XRZ/LxmD7pdf2+Lbob3IeoBTjxAeSUwO0M5vCr8cqitR5YBy1+rorwANDP/GuXewPElsRIqShsgJFZE5c4vpPphjvTXgURtkw8jfEnpxeU9hpNP2VKDt//rY3FpJZSNNy9Ef+I16RuRW3SANSTXmb9cWK8GuKPEcGeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAjyEbuAgd9yHaw3fP36sP/eCfGfKJg2o+Ho15P1Mq0=;
 b=kDDSH13/iKVEnRz4VL+0Eu/PqUzlwYiX5ERie+A8bwYYvIpL631nR/YHm+E6Vi9ftQcrOUKrq8qbZKiEFbkxxuZhA5vRFvmuLW1ApzmgJNL2d6YGlaEAVof8O65eU3goQsf5NCigFEjN0U4kXA8ZvaEaKnyqwe7IDA0VTQjZy48hM5DHiarHy6xQU05kqMblt7nUCxmzF96towukinXLDcabNr7/+4rWFHMXUSK+BAzgsZ9LHkqdC3gF7Oxvajo/U6glRvbr2BJ2Z74cO3c81rvObKzCAFf4w8uxyn038isrxXxMmfEOp6d2LANzPQwA5ZSOHHBFR+r2UcGx+d34fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 12:21:44 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 12:21:44 +0000
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
Subject: [PATCH net-next v22 06/14] virtio_net: Query and set flow filter caps
Date: Sun, 16 Aug 2026 15:21:03 +0300
Message-ID: <20260816122111.2495240-7-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9b3d9342-d06b-4c16-890b-08defb90ef8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	YNMx4al9SK3lhFERPpWq0sq/PGuphVmgNp2Nkk9lMv2uwaPtwshxUutb8Occ/F5QmMh1r2whhlLxAH/wVavt6UrepSTQl4BtoWW8/C56Qr9iEI76e2baWKFkYVzxT/ZMG6Xp2wMrdx2Q08B8izf3A7T7+N31ZjSF/RgbwUZF3K7xhfnLxotDk9NcAvnuIXJ2lEchFOqmWedIAv2zwMgSuut6EhitUowXG4NKDDCKBMMjTi7elI0ODEqO/2RzcPUZcs5aOfYMfZslbOZJ7ve2jcaU1UTGnrwI3IlqEESqNYjbNB472rQnlX5JxfHiXIMYLWDTwBOa7pG3eUjtiMt631Xj4ZOlJQ4T3AH/xV/Av0lh+nEyuf4FBiYO79Sra+Zrc2slX9U68tf5e/JXEaViW9NBGVbLQxBzLcEjfdCXN4GcQn3+kz5rNQzlBZ1rQJhgO+LacCRaalQXKCxq4LuehRzQlActXfyJDfspp50MMWP9p2CFWp8IQQwvAzU9ktffo1z0Q57johYGaIk8hXGQRvdd2YtFB6+A1gG8q57gzRYL0+qKi2LaGIpKiaLX0GZPmknjXXitePhcfShaOmFeG/pIfK0RIW99864P+cZjoKhVeeLvROWxJm2AJoPmvPeVs3RxBmCJPClQLrMdnNNcKSH6fv0Jnp9QbJ6fpOw6oaE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vn/mvNEaH5lvmYE0dESN8Vs+uxBiCrAmoGcXstuZIauLDkPqlM+UbxiWJEE8?=
 =?us-ascii?Q?PIh7imYZuO0OqcjNuzYjeAq1FEhqUTFf4uIoYWeKoS/7067GDmADmZELBhpz?=
 =?us-ascii?Q?+0N2F21/HEP/zrMto2K+BuEDZXviEaXkv79cGzdrfRQZczrZ3/3hXLXg9QH1?=
 =?us-ascii?Q?xaSwtrUzOUcXTz3K34vpFWdfTzIHZfSomFmG8Y/5I8K7gdyDrwnWut8y7KB+?=
 =?us-ascii?Q?nITEUw8UyqZa1ioqEyxJyJAnpkxxTGw95lJ2odEbs3nH1xxS3SEe2joKmiXl?=
 =?us-ascii?Q?tJ7Qeo6ys6ie9rXsAhnKkcPcQsBr+MimSsONi5Ph/DbS7eB16Ei8iW2OciVZ?=
 =?us-ascii?Q?xlb6ZJw+oDiAI9bp24OrG5NEpl8WBiKukbwnB1FY+J2jaM3ksOv2UwBIieLa?=
 =?us-ascii?Q?h34JlUizj0qA6wN7gfsQ8MooGjXtDO6VyFu0CNiC1Bym8KY/dcFk3M8C6vri?=
 =?us-ascii?Q?/8Zr6N+u/iJCa8FqEr8UadV88FGzPXkfkj2/ZQj9zlwU0BE/yKKCcFxtDG26?=
 =?us-ascii?Q?Pr2zvQ2smzBPmTLWMSfgfZOFoMiceocIUI1dFkjSKAkJ0ElDYLqc4X3yj5LI?=
 =?us-ascii?Q?gEX6hWY2JhhQzkeAfFZ5+qmK2s73QUa5ziEEQ0UX+UBi2tcBAG+TpdTRZsZB?=
 =?us-ascii?Q?gNiZg3E3aP3kXbwCS28VuYaZ43PAux9vMnDOCwYG4YXi/kkm/eU7efizgjBX?=
 =?us-ascii?Q?BCepM3FOpjH8ThskPBM+fah5jr+erJXrOGdaevsl+nPvc2fJY3fvHrC2GYzE?=
 =?us-ascii?Q?kLqVtUjpnWpww2w7faw8WHI91jg/JmKt3eHsWB/4QiZ5caUV9uA09jFqJBlQ?=
 =?us-ascii?Q?kdIGV5kEf3tTKvPQGleXKSFvydHlK/TIYt5+KEt/3nSxNqudJVsT+FfTuG+4?=
 =?us-ascii?Q?fMqGeTfqh72hCfBLoLcPOP1Ed/aEZoJrhvXRNuWHmRi6U6fbOCkQM8Gbckie?=
 =?us-ascii?Q?yVhb7Rhy+V43q+9oLRkvBRimiweiJTYB9fkxtlwto60gTyU7P8o/fEdZfJ3w?=
 =?us-ascii?Q?8svzoHIV1Z9aaB/CAbF9JRJSbeWuIlEZ4LfcangdfeKgGYrAB4WQW1wSPvLU?=
 =?us-ascii?Q?HSEl8GOCgXACRSGapKa2j6YiGJphquUqLl67oSyqWvJvPwh6SM025olbyWuj?=
 =?us-ascii?Q?aOAzekgAZsWHB85quawmmdH2SRflsOwnZbe6ffO3jDxIK6NdmYEVKzYxmDUN?=
 =?us-ascii?Q?SWpbPqhceNlqyxI0tM+zqftIwrckDVfRqN/oBEI8pMqM1NhlvOqKRgPhk+Q9?=
 =?us-ascii?Q?Npb/Am5+sEyVnUHEboPmpClar2bJheTjVvM0SSXc1wdwmqTWfRtfpGPDSvva?=
 =?us-ascii?Q?dYNcQwt4Z7d+J4kdDZIIb0QtR9zCV1zWFjIxDRNNdBZhqfmcplXM+s/qNUh9?=
 =?us-ascii?Q?aGEOaUHCrkCeyb5Q6T8KLm6iL5vjMy7hTBEba3RJGsHZCTZWXlvlCHL9Eoqm?=
 =?us-ascii?Q?1pkU18B1MAIrTRb5VlsGDqUoERjWiw5F0vCQufAk8UcR5IYX8uXiT1eGk1aw?=
 =?us-ascii?Q?WO6Ggw+Q9P31ltmxX2/t71fI8iLmUb4nmjmm9VY4cQgHMiQb7x2UTxNGKLZp?=
 =?us-ascii?Q?ExiiMA1A4GK5pDvHJ7dtl3EJwaGWpcgejn6m4ZZx+HVbPDPPvy7HWJ2G2NLY?=
 =?us-ascii?Q?2YA3Abe0Uw231ye72E1RafaHl0RLSuF3Kr/PDAIDiduFa+bLi7ckKu3CAq6w?=
 =?us-ascii?Q?bun2bE4VawOWfNCQ84v2wx4bB35K5/hCejvoyYE+tZCOQwpR4biCSP1baSI8?=
 =?us-ascii?Q?AS8ElbPh7A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3d9342-d06b-4c16-890b-08defb90ef8f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 12:21:44.7426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dx3ftbqqVah93+YAzkQTRn2fRRhVDnzAeMQn1Tr9ojFW/UMJAdo2eidTQhVQIeMnseitI8ljtKxnSh295ZpgRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573

When probing a virtnet device, attempt to read the flow filter
capabilities. In order to use the feature the caps must also
be set. For now setting what was read is sufficient.

This patch adds uapi definitions virtio_net flow filters define in
version 1.4 of the VirtIO spec.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/net/virtio_net.c           | 236 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_net_ff.h |  91 +++++++++++
 2 files changed, 327 insertions(+)
 create mode 100644 include/uapi/linux/virtio_net_ff.h

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3e2a5876c6c8..c8fea721ef0f 100644
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
@@ -5710,6 +5725,197 @@ static const struct netdev_stat_ops virtnet_stat_ops = {
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
@@ -5728,6 +5934,10 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	netif_tx_lock_bh(vi->dev);
 	netif_device_detach(vi->dev);
 	netif_tx_unlock_bh(vi->dev);
+
+	rtnl_lock();
+	virtnet_ff_cleanup(&vi->ff);
+	rtnl_unlock();
 }
 
 static int init_vqs(struct virtnet_info *vi);
@@ -5757,9 +5967,24 @@ static int virtnet_restore_up(struct virtio_device *vdev)
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
@@ -7043,6 +7268,15 @@ static int virtnet_probe(struct virtio_device *vdev)
 
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
@@ -7125,6 +7359,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 free_unregister_netdev:
 	unregister_netdev(dev);
+	virtnet_ff_cleanup(&vi->ff);
 free_failover:
 	net_failover_destroy(vi->failover);
 free_page_pools:
@@ -7175,6 +7410,7 @@ static void virtnet_remove(struct virtio_device *vdev)
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

