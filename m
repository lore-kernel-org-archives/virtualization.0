Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293AB47F79B
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192707; cv=fail; b=cPpmys6zCSYMQ1vbT0/CiT+JmHQ0sZ1LiwJ1EQpaxJJjRaySzXlfAD2FgnRJO5IJRMyZSk56P6TTD4Zyxy/pUXmJybNuQBUZtrDXUWTtiV1t22G8uL+XnvsNC0ZuaJvlIwmNrbUOuwOI8Ab93DbRzq6UFWR4WGiRz9OqGYm8vKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192707; c=relaxed/simple;
	bh=PhtIWxN0k6msP61qADppiNsRPZmDrFL9mZMJZtRyeo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GQNXa58/swopE06SaiF2IkG3F1xIEoRVUBmyfiPt9R4kcLRqRvR/2HhzDK/NQUSDCWVciUkkGHynf1rpsbbgYf9hKV1w+sc1phlmmrsgi6gxQfgNeKkl2zIBF9JobW30QnHsA/tV0EtHG0Exs3faXIMbPEXLVnb2miKGvLF0u/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aSiRzea/; arc=fail smtp.client-ip=52.101.52.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aSiRzea/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aelxD7a7wTGs5LJlET3fqKMlEj6PlURQT3mQ3kVC991/vm16P4dP/Zsody6t6xV6VZtIaXm2CRffhOqL1uU3aalkr6ywqzK427pjQJO0zBB8IfkEys7Aa00FLb954h33UH8fgG8mMS4rO74cYNc0MlCU1fC4QepnZl8iNM7MnXWbIb7dcGkUtOdz9ctrKODGe1BMlv0isZ3OorLfL930oIWeaOrsVBWp+wBRkiZ6llosoypMW5tW7lIA9OQtZEMpBs2UJa2Wt7F9nLdJmiuTtq4qohmNJcyOPr2pI2ig4wI4BMRZqAgVp8uoyOJuWfAsLmIf1K73AZLKSGqvBwUYLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Qc/dP0QG7SKTK8MJe1WXw0vTYs09N3/jvcNl4t8XrI=;
 b=HR9yd4qI2tVf5nJaxf0jOmRnb9SIyVsiaHKq4XMaDIFoa17uzzd83GVdpfu3xA1XhR0gJ+FgZV3WrqCY9iqGG6C8+i/IEla1g6/xH6LnzGBXrGweJgS6w/4UzT/Hd7GrsAGt4FF+8aQBNzAJe9NJ9rqVlifmFJnPOZa8FO/pXvlXnJSu+sdSUIT3mQRBQYAXRQqqy9BR1/FwHoyu+jUEbHJa+wWzeTFT1r6BoGlZHOr/PiFEUQ7vYsYE/t8ne735LeQOClE+8V8bPxpcjrpi3kFodrsL85uArvnEcCQGLaQdShGXbqpHVgI0EYW1TmUe5g32cLdHPkkLJR0SoI9LLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Qc/dP0QG7SKTK8MJe1WXw0vTYs09N3/jvcNl4t8XrI=;
 b=aSiRzea/CXgv0MKzwoKhm5BlxlZETx51geI/Y9/XZ/mhxs/27ixGW7sIE1FeU4nJmIm5ADl1tRAmfngE2Z+0Qat72ounKL7MY2oSZbHFRu7LOM0J76ZIsuG7FN10OINR2/TlP490Nb4v+PZCR9Wq48m6m9/8vhZCu8R+Dm1d3uBpEF0kgTH+GekSzWA5Re0WhRj/mNiqdHTdVR0kCdYZ1WmpPcebPMI9fFllcz9Z/y8huWmRozuSWVKhck5SmjzwkZnoqSDByT26sh/fNDSoFsQiSV01Mod9jueB/borFPouR8X5zddcxDY/8gxmrgA7QQ4QZQHsLTjQEy44+ACYaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 16:11:42 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 16:11:42 +0000
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
Subject: [PATCH net-next v23 14/14] virtio_net: Add get ethtool flow rules ops
Date: Mon, 31 Aug 2026 19:11:09 +0300
Message-ID: <20260831161109.2999926-15-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2823734b-34bf-439d-17b9-08df077a8b46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|21046099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	br7T5+WfR4d0SOqh3vIA7SW6XrjDOtCizHc93CvT8v9XGoCPkJkmO1v7NKg7tZCV4BmCa7Tm1rgztqjxm543/HoLZBa/FFj5Zc34GYMB6V8gvNpEwnvg1s8T+DOY2UK4Trk66OCKXB2FTG9Kk78KKQZkhuNOKiKLnrBJxWMlQyJ47rztF3hHfO2LEYhqhBnmR6Up/wqkWt1CG1jiN/0cQh7B7jqTbHmFnDy37hQAeefZWWHbLWrX4idI66swMJrCKrmnSoHdmTQpXzwP9jQEI2JQSvzUimw/as+Z7KMwbJQKLKqF/PMb3/HUAWxXPITtJivzOAMCXIFUQtcFZApEWlt8egRg3bl448I6utFNOw32z1HNWV7wPqFK8ZPfQumloCBDQcaWmUMDyGlv7SvTLoY0D2pq7tr1QI+0UX4uuWh1tN07uNEa9P4o2qjQSsNdelp9lBDM3JyDNqxrf0M9eg4jnCObn9rDqktrrT3v1RoZephzvMJOSl2FtH1JRAHGYbBdRKRhuXEAbII7QDJeSsBCYMUb0czxjx8+4p0E1EhFpDtNsOVsyc+723Rrb/axUnnxQkavw1BBkb0mrQeGo72JT5Ob7dtWtIHcHdcdm83W+DC4REykt5YzocwF60wPb4MOHe21GanRgXirKG/L8HU7keAEJAcPLFc8CBdSZpo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(21046099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bI1vxMWNzHKuL4yyDH+PoLCLi6bz2mmVQ0TEl8cQ3g+jqX3HfLTRhHktXYBB?=
 =?us-ascii?Q?R2Bz+C92fPDpnk5LuHFd/46Hf8M1ZA9j/76ULnMalvaaqfK3/Yza1IUiZS2h?=
 =?us-ascii?Q?A8zahQXgsWcvGGI+BWSPLhDXUgKdcEL9aw9oMVLZzRabd9gG4OpuaZZrwOjY?=
 =?us-ascii?Q?HC8o1EI/p+z3J/s43mU/8rj3F6b+UXfUcBeZxLOZ1HdCJh2eo4tYWTUZkRQE?=
 =?us-ascii?Q?YV/ez7sSIToSV+r6HZwldiEU0AEv0If8wB2X1LjfWEXzYt+bWoHmGgk1DIXC?=
 =?us-ascii?Q?T/mlYVtBWjH3wT8koYDZ2Raq4VmRoyrfvzzeJVx0I7l0FEvjqk02FYyNkmDa?=
 =?us-ascii?Q?bpmzRvatLXg2ovkciK2J45WabEPlzH/VejeqKMCCHWPCHJeJ41RMZGac4P8d?=
 =?us-ascii?Q?f7ThH+Dv51Muxxtc1PpWBdcxHl2Hy289AcOm+JmstjpXBmCzhTIt32yFqUDI?=
 =?us-ascii?Q?Lxf1urIZQ+A+13UiUPk/Xe/v1r+W9b9hOM2MEwjf2BkPULTXMupPUMdUEMvI?=
 =?us-ascii?Q?ZQvn8WnvLr+70KPyJ1TVc9bISqaxlBMOFtNOBC/qxZ3WU5z/GTVeYKom4P5F?=
 =?us-ascii?Q?OneW+JsFJOPwmWma2/meShwkn4cAdBsllQp8/KyVD5gTp2S4wrO9gRYnoris?=
 =?us-ascii?Q?WH/j3AJTLe2bgdzftMqfRpF0RmcjJOHcfp+XCnUumVZDXJd7gJf3yZuCtoBv?=
 =?us-ascii?Q?QglMCs1UZsgbkICEN9NXj1DXxHhLsloGdfMjv1SVcNcMp5bK3TCyHBdPfYFq?=
 =?us-ascii?Q?qZqGk65mZGPU8vunMSYL3f4i/DNhaNa6Ysn46I5w7nQk9EbzCfwPEMQ1Q3S9?=
 =?us-ascii?Q?1SxbaW00Zhgd950QpuhxqM9cU0D321w5/s4e49a235XmALTILdXIDn3npsoj?=
 =?us-ascii?Q?mGyQic1QWTEmQNmtCubbssNB66Xm7nAHx4xZYxFdHK9QP0F/JixB8w6HZNKy?=
 =?us-ascii?Q?SWnBrRtVZvZgaREdLBOsDZu8fBMf3YdWhajisupoH9QF1Rr2B42p2eKOPeir?=
 =?us-ascii?Q?081afR1FL5xwFEuPKqobSWU4auHYvuefL+YzSFEFe8z6hXmh+yjNJMT6GGOo?=
 =?us-ascii?Q?GMUuI2hjIf/Mfu9tZLZPkzRj/c3hHRA8A/icV4dTVc4T/QHdXJkohH+uzyJn?=
 =?us-ascii?Q?XhFZXJ82si9+Q6yl9Zojd3ptE6jShvr9KXxBXqFn5azzZ9xl0aUv4buZlF4O?=
 =?us-ascii?Q?rcQwZvwpqkxvRRfJ6RvB89mwvg3I06hYPUdcz7hmA45v7Cb7yZgfMgDVckKK?=
 =?us-ascii?Q?7bo20EOHxmth+szhH/GLpcopZvpgz8b7c3yJDXrhSWs9t6MufwopruSqVY6R?=
 =?us-ascii?Q?hU4QwxtXjzpFs4Hghicj9yGjM8oNXkfWcv9yN7ZqLr+ZHCevkvBtToMcAEFT?=
 =?us-ascii?Q?GSEJe3ybtmClcRXN/CydQRPy/8rGJXI9E1apE03WXylCqnkVYxMji1vz7XTQ?=
 =?us-ascii?Q?2nNwu6MYSPMiSk4I0pojyKEPIzUAUKUgybLvBkBZgdvKgNn9/CRT8fYsZ+nl?=
 =?us-ascii?Q?tZ5rLgbX0DaRI/jbXLh+XFGzi/Va9OTFjQHGzG7GEvS1e2fmQUzI3ibH7xvq?=
 =?us-ascii?Q?E626lkXcu28CoQkiuAUC41C+PwU/GwkE4e+xnP12Utb9+HprMg+MmzQlZO8N?=
 =?us-ascii?Q?BE/wk2s3vhoW3GZtPdJGsSuKH7caJjMmUcXnN9l9nzHmRQZaS3ASmUby86ET?=
 =?us-ascii?Q?ndRyVDgBu5v3KJ2UVs29LxWAbFL//1nIxaHZR+SDKcSVj3/+jIuLhNNxXIVk?=
 =?us-ascii?Q?zvt0e6O3iA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2823734b-34bf-439d-17b9-08df077a8b46
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 16:11:41.4930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sr0KhVx/wFXNE8wUnUsgPO0KOy/e+/44/Txuz/xVM8aMJnr+4yw4hU06r9gZfcgJwFwZIqCw8qFDps85D7LlBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353

From: Daniel Jurgens <danielj@nvidia.com>

- Get total number of rules via ETHTOOL_GRXCLSRLCNT. It is
  used to allocate an appropriately sized buffer for getting all the
  rules.

- Get specific rule
$ ethtool -u ens9 rule 0
	Filter: 0
		Rule Type: UDP over IPv4
		Src IP addr: 0.0.0.0 mask: 255.255.255.255
		Dest IP addr: 192.168.5.2 mask: 0.0.0.0
		TOS: 0x0 mask: 0xff
		Src port: 0 mask: 0xffff
		Dest port: 4321 mask: 0x0
		Action: Direct to queue 16

- Get all rules:
$ ethtool -u ens9
31 RX rings available
Total 2 rules

Filter: 0
        Rule Type: UDP over IPv4
        Src IP addr: 0.0.0.0 mask: 255.255.255.255
        Dest IP addr: 192.168.5.2 mask: 0.0.0.0
...

Filter: 1
        Flow Type: Raw Ethernet
        Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
        Dest MAC addr: 08:11:22:33:44:54 mask: 00:00:00:00:00:00

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/net/virtio_net.c | 77 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a1e042f356f5..911a5142605b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6575,6 +6575,60 @@ static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
 	return err;
 }
 
+static int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
+					  struct ethtool_rxnfc *info)
+{
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	info->rule_cnt = ff->ethtool.num_rules;
+	info->data = min(le32_to_cpu(ff->ff_caps->rules_limit),
+			 le32_to_cpu(ff->ff_caps->rules_per_group_limit)) |
+		     RX_CLS_LOC_SPECIAL;
+
+	return 0;
+}
+
+static int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
+				    struct ethtool_rxnfc *info)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	eth_rule = xa_load(&ff->ethtool.rules, info->fs.location);
+	if (!eth_rule)
+		return -ENOENT;
+
+	info->fs = eth_rule->flow_spec;
+
+	return 0;
+}
+
+static int
+virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
+			      struct ethtool_rxnfc *info, u32 *rule_locs)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+	unsigned long i = 0;
+	int idx = 0;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	xa_for_each(&ff->ethtool.rules, i, eth_rule) {
+		if (idx == info->rule_cnt)
+			return -EMSGSIZE;
+		rule_locs[idx++] = i;
+	}
+
+	info->data = le32_to_cpu(ff->ff_caps->rules_limit);
+	info->rule_cnt = idx;
+
+	return 0;
+}
+
 static size_t get_mask_size(u16 type)
 {
 	switch (type) {
@@ -6593,6 +6647,28 @@ static size_t get_mask_size(u16 type)
 	return 0;
 }
 
+static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	int rc;
+
+	switch (info->cmd) {
+	case ETHTOOL_GRXCLSRLCNT:
+		rc = virtnet_ethtool_get_flow_count(&vi->ff, info);
+		break;
+	case ETHTOOL_GRXCLSRULE:
+		rc = virtnet_ethtool_get_flow(&vi->ff, info);
+		break;
+	case ETHTOOL_GRXCLSRLALL:
+		rc = virtnet_ethtool_get_all_flows(&vi->ff, info, rule_locs);
+		break;
+	default:
+		rc = -EOPNOTSUPP;
+	}
+
+	return rc;
+}
+
 static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -6634,6 +6710,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rx_ring_count = virtnet_get_rx_ring_count,
+	.get_rxnfc = virtnet_get_rxnfc,
 	.set_rxnfc = virtnet_set_rxnfc,
 };
 
-- 
2.49.0

