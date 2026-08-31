Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF3C3CEBA6
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163135; cv=fail; b=LCmH7y6IjancHdbbfRBDmMoflwRPbusx8goF5u2MEgxnNfHocqHc0+QfhHrOgnNo8QfMtqabKoiwnFZE/xrFq4Fyl7WnsDndgGdwx/eIQZljPZe8FRiikvE+jwoa7H1a9sp3q1wrNADDVb34mzZRpfx83CVDZVEyZ1CKZTWKVms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163135; c=relaxed/simple;
	bh=ubl+ydWSaA25XWTYLNTxLzduGeA7dhxVoirD1DlxEM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oEOtFCTohK7Q2N9b6k1ybexJWecFvHPSuawFjC0SP2fzUzyayfLKF7c2FtKErtxWa0w3kV340fnNeHrkx7A2J4aBmznAvWxJOAyfxnEJ1TRM+SLkrlUKZB4FQu1itw8lD56M1CWtxqB9vZ96iw3qWhMocirLGyDgmkTh11SvrIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TTgBF7E4; arc=fail smtp.client-ip=52.101.43.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TTgBF7E4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0Z7UG/Q/nrLZWmv/qEJP7eMjEl89cA4LEfycuAOrJOh7jVpgyPvgphlJ6xC9Obej8ETw5+Hc7yg9BD2LqSLhjTlJyepHda6kArlSGYN0S1dNTcGCZfY0qk166AnKg1wHDRu2mFEodpXz+59pCZfnUyCqsx9u/EQdpAngBUFiHBQsrwUaK6qte7wA6BfLFCrYZb9zdFhoRkBv67xawOaamYvmW5z7ouNYI8he6NcdED69ytLe+OegJUq/8ZUPJZ7n3Ppz36V1ds6WkKuEtfBsEVLL7wps1O2ToFGj4ftPOmAZ4pOBM+UGSMXojWBRVpCdWBIoQmhCQXbfxbu3SkLOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7m/lLezP/uNJbCz/54kth5XryO/m4re2w6HakfCZgg=;
 b=nv4RsqLYAVvV6eL/ZeoHh9s4sE7MS1EuF6b8q9DjfCdJOfILL2831yR1Rrds41RIRnL9K0Sxd8vQfxuqTVXXN452lGA9gB/akaEOQrNq0JeXKtRWJRrx//WDfWKWlZwV3DKfL+sGsF/LCDU7nwyDV/lNiyCoTs9NdZMvL6VG4DVJs2U0WptylDM2IOZLULByBnQC621Z1aBrvhT9v9iuoJ2timX50PuQB8fQurph9NqRoaiQUnD4li4ED/TTe4Wtirf9s3tsX4XxcTi7EvlXVGORsc081Lamd4NYB7+or76pnEDQs12eGfXri0wUwMLZ9iVikpCNRgu6BZodFAqW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7m/lLezP/uNJbCz/54kth5XryO/m4re2w6HakfCZgg=;
 b=TTgBF7E4EQ0SYmH/p0pXUHXB6XU0lK4dtp266txQDVp7aL2UjP7CDLZSR//NVeUC8A1MolCnnFsBZkMPEbatYDew9gL34PbCORwBMB5NvGKVdx/wrmR6E+RdLQ8fBjV4/U+buPGeboMAFmToE/cO7XroL6wnnNwbDEG9g/YQvM994kSjwWfBCyyEB8WAItG8g/NOr7LawtCFq9SCR9mcYipAmh8pGRLDHDSL9jDL4pTxJmMwZ5J9WXCzyvq2HXGEkxh9iHK6UBAg/5jude5OeGst7BKQq587i2C/An4T5oDw2F56TQRYU+r1bG+Mf5ccJOkGlg4JCJAWl7dTeX2F1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 07:58:51 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 07:58:51 +0000
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
Subject: [PATCH net-next v22 14/14] virtio_net: Add get ethtool flow rules ops
Date: Mon, 31 Aug 2026 10:58:07 +0300
Message-ID: <20260831075807.2891426-15-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 59c853df-f855-4d2a-47fe-08df0735b1ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|21046099003|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	7WzEUaT82jzZZZrM3VkXgSzXyZUAw7XwpgtNptz0NK0oekn4O8V9O1U34aDQer94rylRA5f0MohaXTIsOFJA6PQS9nVGtbDP/W/XGLmBzvJDaGvEj/yhVmrLMTRx8oDKlSnd3kYsskJ6m1Jdv03W8gvLJjgQv5OqhJcv1vnTUx0b4FypFTvJxpI582T8GyG9jUJqZVaMjTsQPGNi8M1TpSCvibGqeiOJjVQOPgoRQQv06s0AbQFZYOeGFJwSmjaUxyRJE+MNFV5oUQ1GrYEZIrmWbHmchf0zaGA7RZG8JFtfeX2LZtAYSPPhY4HG78TYBddcPNvU3ZQNBgMmtrQz30URW8Ey3okCt1fU8BGIvDf5a3+jdrsyqCBmiu9eiNjxGl3vAyYEaPbVYiWTU21Piq52l4mJk+PXsLYHcmEctaVXALsW87mYOBdowBsk54gJPlVaI04rpH+EGpBsR5ZR4kDnuTi55/prqftsSxk7fNldmNM37P1NnUB/ag/6frcBCdhIi3OljbqJn7Gvf/q+vvIRUia0+wgkxBYscFJCM6QeXRdwvmO5Hv8JZlLj2zTrELT8xkRUG5rnYu1JnZ1Z7jJaZutqBgx5vqsIIS6wvdZO3DuxjJDOakj/ZdNWURJ0OHeEiSGVDE1fdQkVG9NnkyS9Vh6UDfQp+mMQgeVUGUs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(21046099003)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fGuXXGrsC2/r3ellztlAvYhnTNALD4zIAjRDo4OH0sWpFgPgOAi5fmPaV0N0?=
 =?us-ascii?Q?2z+SPQYEiyMToNJTFjkQZxMjrOO0spcV6SrkzH2TO7jYOdUkwtTEaTb2gNJA?=
 =?us-ascii?Q?k28RCjT4P8x/TRytmR85kkS0TCyNjjyzuSGRvfVGQpvYdad4JccXFqkcubEo?=
 =?us-ascii?Q?NGQMetxs7ll1pNf36hlo0d7JeyUeI82WX2kYuwtJI98PzW9g9w7qBqKfZ0g4?=
 =?us-ascii?Q?1U1KcvTRiop6Ubldg2Q1N1XRd0uZaj/TibG5w0Pbn2IBV3p2ERWkx+sOrU4l?=
 =?us-ascii?Q?gmVVnUGde118wDjRs89rYj2Kt3dj5oQoFwfGHyCBu53c76M8Rgx2PN0sTpHy?=
 =?us-ascii?Q?PsLtqWagkBL6yTJyLCfN86Pu0POK9DNzeVKYlagQzv0/r3qq2TssKdAB6BRW?=
 =?us-ascii?Q?6kRUPkT7vWJQ3yJNapJsSWu/es9Cz2T+y3+77nfnrfwSYPlvvQyG8XzFavYG?=
 =?us-ascii?Q?hRY4hBtqQMC1yWDwEd1DHNaR0MizO6uurZFKRzPr4aRPGivnaZ4klLoVIDhq?=
 =?us-ascii?Q?wN2icDLtTde0EBHREZdN5z93YnXI0/oHiYDGs5da7Ly9o2sxpYAFJBFRdTwB?=
 =?us-ascii?Q?81VZrrskMuDaP4ByAfTVbR/TJp7sXR8GPeEoggxxBqZYJmu1jRjimBn2Ro4o?=
 =?us-ascii?Q?58Tyks6sNzMfARkhMK42lEIrB/y+/zD9Xa1XLIWbwaNG1q8orz/vyFXas69t?=
 =?us-ascii?Q?LSWxdVBiEu4Xo4VkLhPQ8XVbZ8hVbwl4meqk7xiHFVOOj/csJjPVWoZOsTC4?=
 =?us-ascii?Q?CHxxo1XleYvCO8BgQ7/c8cCjyBycVD90fw0jb1h1M9/VSy911lKmMmF3ZKg8?=
 =?us-ascii?Q?E99epHBMCLJt8H5LjzPyWxyAU9kPf7QWEK9xf0dikEbRR6Wyn96pGyy5l+vk?=
 =?us-ascii?Q?GeAQ5pKpXqGOEb/7Z/JNgXulPGQrnT/aps9dIunTxvoTSqI6omWdJw+7x4tw?=
 =?us-ascii?Q?JpqYdspo2D17fKYJ3bGTR98f6+ylV+NANBTUCOO72U7cW3l26jKZn4svIX2M?=
 =?us-ascii?Q?bzr3nEbsjmx/grsTextBZNJR+GwbLrrFBBFJjm/OWsL3hPqaM2bJTu+0VEhf?=
 =?us-ascii?Q?ZGarc/F5RGNMMGV0xjxK2ZZ+hEKeHDuli5KGJADQwVwSU2mere7Fyk4mm6z1?=
 =?us-ascii?Q?buehRw/qzR/mfg8+IiXl3XqMLTrij6PyvvRvgna07Oc7dJs9ryoAMMmgarwm?=
 =?us-ascii?Q?SG4pbgPCx+MYOH6X1R4B2wYAlR4UDTy9lq5z8eK8g+OCiHkT9fY7isq7KENg?=
 =?us-ascii?Q?ob75w1jfKCHhKwDFYaRBIiHyKQhaN04Ftf1A+VsmCqfNadxnsXpxBF3m6Mhk?=
 =?us-ascii?Q?r1ozEJ7z/jk1lPMPtEoJR2DZoDmWRkC/k/UT4UJoyPDV01qPEJUXdrZNj5yg?=
 =?us-ascii?Q?pa+wHaYIHgd0na7Iuz5Au501j6Ozhm9ydL7S6gzMupyVi0bmWELHluezJl/S?=
 =?us-ascii?Q?EUdewkHhikUqIpKW6ZL2/jGbXBzQ3tjAfunXx2HgZlHDW7F9w2Jvp2gj/gO/?=
 =?us-ascii?Q?WGZaCTc+gBBTJZAETczugipm94XRydXyxe8X7RzHsoJxS2EnXZnGyf0339uf?=
 =?us-ascii?Q?HdatRDK5CzGeRnord5hW3YG2HTmjgt9lIRFoy33CkTErXG4JtSD/DUjGBtWO?=
 =?us-ascii?Q?zM9UmF3pcBYD/vRjb5Pyvf8ElrxQPndxO+/q3uX57dny8uVh4gG/ftYaLmFt?=
 =?us-ascii?Q?cGHiIdgSuCO6ElfqaIGEDuRM1OlemNJ2oc70aaCKY52tsg43uJ6oQBIvTmzF?=
 =?us-ascii?Q?NFBoUvz0Fw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c853df-f855-4d2a-47fe-08df0735b1ed
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 07:58:51.0982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZ6uUEnYqDvsmaeTtJk2l5ITThQ+MK6NLXDvQrB2Nr5Js3UUopEFRcV3Uu68lDlInysX1FJQDg/vS0i56E99QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430

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
index 0bbbc3d33806..ae9febcdc8ff 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6568,6 +6568,60 @@ static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
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
@@ -6586,6 +6640,28 @@ static size_t get_mask_size(u16 type)
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
@@ -6627,6 +6703,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rx_ring_count = virtnet_get_rx_ring_count,
+	.get_rxnfc = virtnet_get_rxnfc,
 	.set_rxnfc = virtnet_set_rxnfc,
 };
 
-- 
2.49.0

