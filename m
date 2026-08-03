Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E0841A4E7
	for <virtualization@lists.linux.dev>; Mon,  3 Aug 2026 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766069; cv=fail; b=G3m32LchnCr2NpXhMTsWFBCttMIICvVlJJ+KNqrEAfJKl+jAE0LrOouq0g+inE6zlRbsXbwBdL61yIabpyniXcPsUnInDNUWIRHZiFF9WhDa5b18XI5rLxFd3kHYM9khkDUt+3mRyWnpKOn3q7e394eIxFF/B/3M84LmNDj6c4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766069; c=relaxed/simple;
	bh=WmIQaqzLyeE7kT88iJdVH+m7xcnWtvzJI4ugOZXvwOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aetLYNpX4jTPR2B6Jth5GoIeg+c1d8HjEccy4C8LlF6xrpD9JJKvCRahcE4DNIQU6DnP/wjCoaPwpqJAAM3V2HonTo/4qhJLI121Ia7blKbfZYg4YlfR+R3PYLnBWogW6xq5YCmw2B87GZ9X9r+0Stgw+agndhX6cVlT2eeYHT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cmpnGzJn; arc=fail smtp.client-ip=52.101.52.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cmpnGzJn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huPRppDapHuO4+wq+9UYqrZg+V+VD0UymTYbKwF1EplhKBtkN6SmmFkr4FC+vM2FAZcAKoLe0Q1IaFbe+JbhZ4ygPOa/IWhCNlY3+83FTEcsd+PK5BPEtbBetew3ZCzrFoyBpnlVPiA/G034J6MZOOg6RfU61vKvOhE9JhcCXAzNP9SZ6fDHQugD3PdIJagSMcs1Xaf0KY5ElZ5tCEa9x2RbKAW+NzbIJI4GmC3CpP56uka27sWTI2SfVH6ImEhPYTgC13qheHNdBNKRip0BE5tBRjgPWajkX7hEJ4nrrIEqCX+31kmsddWK0UeESOrTd76uarvh0Kb44/OteWGt4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9k+u8obh21SlXKS78fiGTwAC9TqUMHLVfhmrAjA4sCw=;
 b=ESjePUZC8DLlMcLq1/ScS1fTM9BDPTu6k6zCt5c3s6TLj3c1jcU3uYbL4WOnZ17SjBdcbHMWqfXU0G/eUhcNN+9xRTBwrqp9ycWK2a3fPF2iL+A8LVx7/gAg3OCes9W3XYfu17nZW4JXi7mxOz5HACDj/S43XDpUbY+dYLP29hgDYswWXH5xYGJA6sKRYhTkqEMwu3Vv380yXDyNDqhEaO3sSI2EHCDrDRsmbYv80LNFUhtj4l0t3k8aj43iFMGnq9eQTyvZ8eh5Pq8I6Ef4pXF33WvS87uD1W2wn9+JL/RTUGRRz/OQbKkxfrmMEOKbp/Nju3vK1c9Ish0qxx2aPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9k+u8obh21SlXKS78fiGTwAC9TqUMHLVfhmrAjA4sCw=;
 b=cmpnGzJnkgMZNRsZbak4EXUHMn0grXsiueAWuAEvZ41muaY5pqwBRwzrdwsX7E2VSgAFTUWv2dYZrbsqbqKnAGHLUKuj5h4WxuPiwTj7TOtHivWFzevUUFzq8W+PYbrjK26OeTXDKqQLDGpRYtZhfodq2wxtbdCy0C0HAmN6izfxNMkysYNeEn+obELVGjNBgLbWm08c/EttBW7qqKyKkumAQns3WKE9i5D3NiWhXbeGCHrKHjezrh0dh/++fMOK/Z3i2Xz/m9l1mq9ZKnx4LMtAEwPRIX+kENjA29s3f5AiMnaUMgwOfpf4iLWzilsRkTW23IDQdHNNSds8O3sVfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 14:07:44 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 14:07:44 +0000
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
Subject: [PATCH net-next v21 07/13] ethtool: Introduce ethtool_flow_type_mask()
Date: Mon,  3 Aug 2026 17:07:15 +0300
Message-ID: <20260803140721.1871678-8-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: d88d15f2-ab4c-4bd7-470b-08def16896b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tghD247KmpOdf0k7gBxy812CwLnhMh9PamGC/WrO5Ffyho1eqFKKTOs8xChFKtFFoKXqVIScO0ADLWJo8fPFrDOP9QQlBV7qlowNrKZ7XgLh8c+k7ahSTi5Sc4NR2SUUu+E0aoYwAK6gQup4kFVTaJ10AHQ4H3Q9NmU16EhQfln/Oykr+HSGKahB0FKj93CvcmtsuEd+cyGpFxowztblPi5SvIf1b1fUalTa69ieQPPjmVAssNa1SJo4cr0bZxcmoG93WlJ+mdeoCsKa+ViWQkjauLBY5Wov68z5PmgVkEnIbUGAPPnUnJgeUGSpZxPIuPadCCVAOMTFwHEHYU9U0WmncsFuMcXZVRgM1O9M0V56Tf3Q0ZACPZfuo6S2Ld3LniGCD1YVVKzEGz7+rg7E1Qsx7Jv3Z6pQKLDvUXb5LLAkl5rwVO4yoD94e83WEZbTkystbEE3XmonUvDSJOnaG1Z/GORlBFj/eMur/XZtoifL+UC051caPES5UxxFtR1w95SXWSCu2KMqj4kfntCe4DvT+gIbMowxib5B9k/0Uy69mn2MFkgEpjVRVDTTRnq08Zoab4KevYt2G8D9UmvtjSoGe26achHlOVliqw4iPD0TSCn5Z4w3bakUqMIZwmiwRUkmOIOJH0JiI/qeVbqwv4Ekso8Fe7grOffQ3+cjsj8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IzALTtcTASEcS1POYmBqFtwZoYY/lNhAkm7J9mR/XW1AEGTU2Qf3FXUi6HSY?=
 =?us-ascii?Q?X5UVI+qGpShNN0SDkp5xg6bOS7qfFUPiPBy1LQuJH0Q6lobGiTEoe+UYMdnI?=
 =?us-ascii?Q?mhfJZkZ2w4CxtBXQOSLT2y1XkEsoWEp9GKTJNew/fHKGZK2G/FPysBtCVQnU?=
 =?us-ascii?Q?LCpoKSi/k3geHWGhvmagEPMhvUKUaXHG6nWa5hPgud4+/bfYWn9K+PS5Ot91?=
 =?us-ascii?Q?um7CZmOWJJhsNdgUNI4v4HSFz7WMgfvBQarfWNVKZ/Ns1TYnMj2iNDaNgsYe?=
 =?us-ascii?Q?3u5dbvzYhE7O0Gp+NxTO18//i/kpvkPW0D/k8AzepYIUhjcsj/xKpVwJDM4o?=
 =?us-ascii?Q?GUBjIJSNhTrerfakzOxJZEQhcqZbBF666a61QsYqkZpZi6GQKLQAk3dCZzwD?=
 =?us-ascii?Q?HDPZ7FGqY/LwHnvoLlAvjf741PajNIIx5H/453tlwEbCyRmhvFc2VMO0ZheF?=
 =?us-ascii?Q?Gntddoe2k5ZOj/hFtzkICSKSEEPTl8iuW8boPXbJW5kVqXN7vPgkbo85pvv6?=
 =?us-ascii?Q?M6VCzmmpQR5WfmB/ytTmeLXXrC0A3ru9I1iO3/gaHUvFQKo1sq0fOzaW1mp0?=
 =?us-ascii?Q?/Jh7mY7U6Wc61B+l7+g+7dgHRpmUvVo+WuVHX7vlGMh7FrDZfuHoxpwqsEaq?=
 =?us-ascii?Q?qjR5aCAOKN7JzI9nAwhqrXG2QMGewF+kpKvxnAYjdy+1kBdPPBrqMveEnSu4?=
 =?us-ascii?Q?A16cM/rLCyZ/6w6a5NRdCUtStCiqT4VqCfcrvvRBbsj1zaoieWMEgDiGWV2u?=
 =?us-ascii?Q?VQg54CuGktexT2qm/Qx33yuCkmUdyNjsTF3uvlQZMNdX78ZTscWO62eRc/Bn?=
 =?us-ascii?Q?DF/dWDlP07pGfVItJtABDBUfgZK/zGcRtatQHY62DE3EeSrsXx5426G63B6S?=
 =?us-ascii?Q?inFym6ei6IavQ4FT6fP/e2JW6ULoUaXYHJc/Lin3go7OXBHg9WBL8TzvObSo?=
 =?us-ascii?Q?z4I0GerXw6db0Bd4BsAe0nE5SsAkQpIgH0iUMEjkGd+gN/t60yaXmhtCgqWs?=
 =?us-ascii?Q?K6cu8oHB9nJ/11W0gBvTEM5JSsE1C7g4+yMDTA+gMpfKAWmCMhmtEEsJ8y7G?=
 =?us-ascii?Q?jO6s1yHoV9kTh/nBS0wmM+v24vunxecBEwpLx6xcx2SBMhZVf14LuHSMA1DW?=
 =?us-ascii?Q?4iuSIShySzkRBTiouVtXd92GkG7HofHgqzxuqdch8syg5kXYwsupY+HsAKnE?=
 =?us-ascii?Q?GRd4uEr91cs8QnfUILliXgxhVO5Stt4yC3SL2V9hsrF5aSx+8WGK1aXYXx/6?=
 =?us-ascii?Q?4MyqR1YGh2NnSeYFY+WUA5c1BJ9BRz0x4nuFhbKKhn2NWqQHcsEUwSdWDKvv?=
 =?us-ascii?Q?KcpZ7ycVZLg8YFGA62Fci15x2qxCpJS8rzZfNpZ5Ij1p486Qkcnr1o0Q9ia2?=
 =?us-ascii?Q?TyMR9sv3GjQXVOahFlZA2+V2lvydrHumcbxx2JswVP0pHi/DTwt3G+c9sPBY?=
 =?us-ascii?Q?puflJefhGsNytt47v72BGNHA+YesI64QjQxUo+2HMOdM09Ks8UOzSMg5LLjN?=
 =?us-ascii?Q?feMHBa4okDI1dDyLAKhk6R6EZdqnP7huzlzDMJdUuOAdTpfHCOn2+ey/L/vR?=
 =?us-ascii?Q?jIQX32SWU+twbKv1P053lHAjPI9ppg57xLyo0DRaTONTmmHrBi6FSAjKZ5Pb?=
 =?us-ascii?Q?154P1haQJ97bY7oChrEwPevHLTP0Is/UWFlV+buc8nb0b3tv2lCdIxpoUbRj?=
 =?us-ascii?Q?h+MqOsQhIPBrvIfzrl1TwQtAXscVCPMeFKc1YbqTsrhz1NEB5qA2GEmW/OsD?=
 =?us-ascii?Q?izTnD71fKQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88d15f2-ab4c-4bd7-470b-08def16896b2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:07:44.1830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egnoRbl+tz+E9kqMpcMFCYRuWF6UYV6Etk2b/9cwxFfv7aI/BNa3wzfWoWb6KDwdf9Mr7aZhciaVxO0UX0tSXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459

Add a common ethtool_flow_type_mask() helper to mask extension bits
from an ethtool flow type.

Move the helper to include/linux/ethtool.h and convert mlx5e and
mlx5i to use it, removing duplicate implementations.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_fs_ethtool.c | 17 ++++++-----------
 .../ethernet/mellanox/mlx5/core/ipoib/ethtool.c |  7 +------
 include/linux/ethtool.h                         |  6 ++++++
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
index aecfba7deeb0..7247f6cbdb32 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
@@ -53,11 +53,6 @@ struct mlx5e_ethtool_steering {
 
 static int flow_type_to_traffic_type(u32 flow_type);
 
-static u32 flow_type_mask(u32 flow_type)
-{
-	return flow_type & ~(FLOW_EXT | FLOW_MAC_EXT | FLOW_RSS);
-}
-
 struct mlx5e_ethtool_rule {
 	struct list_head             list;
 	struct ethtool_rx_flow_spec  flow_spec;
@@ -91,7 +86,7 @@ static struct mlx5e_ethtool_table *get_flow_table(struct mlx5e_priv *priv,
 	int table_size;
 	int prio;
 
-	switch (flow_type_mask(fs->flow_type)) {
+	switch (ethtool_flow_type_mask(fs->flow_type)) {
 	case TCP_V4_FLOW:
 	case UDP_V4_FLOW:
 	case TCP_V6_FLOW:
@@ -350,7 +345,7 @@ static int set_flow_attrs(u32 *match_c, u32 *match_v,
 					     outer_headers);
 	void *outer_headers_v = MLX5_ADDR_OF(fte_match_param, match_v,
 					     outer_headers);
-	u32 flow_type = flow_type_mask(fs->flow_type);
+	u32 flow_type = ethtool_flow_type_mask(fs->flow_type);
 
 	switch (flow_type) {
 	case TCP_V4_FLOW:
@@ -435,7 +430,7 @@ static int flow_get_tirn(struct mlx5e_priv *priv,
 		if (!rss)
 			return -ENOENT;
 
-		flow_type = flow_type_mask(fs->flow_type);
+		flow_type = ethtool_flow_type_mask(fs->flow_type);
 		tt = flow_type_to_traffic_type(flow_type);
 		if (tt < 0)
 			return -EINVAL;
@@ -673,7 +668,7 @@ static int validate_flow(struct mlx5e_priv *priv,
 		if (fs->ring_cookie >= priv->channels.params.num_channels)
 			return -EINVAL;
 
-	switch (flow_type_mask(fs->flow_type)) {
+	switch (ethtool_flow_type_mask(fs->flow_type)) {
 	case ETHER_FLOW:
 		num_tuples += validate_ethter(fs);
 		break;
@@ -906,7 +901,7 @@ int mlx5e_ethtool_set_rxfh_fields(struct mlx5e_priv *priv,
 
 	rss_idx = nfc->rss_context;
 
-	flow_type = flow_type_mask(nfc->flow_type);
+	flow_type = ethtool_flow_type_mask(nfc->flow_type);
 	tt = flow_type_to_traffic_type(flow_type);
 	if (tt < 0)
 		return tt;
@@ -951,7 +946,7 @@ int mlx5e_ethtool_get_rxfh_fields(struct mlx5e_priv *priv,
 
 	rss_idx = nfc->rss_context;
 
-	flow_type = flow_type_mask(nfc->flow_type);
+	flow_type = ethtool_flow_type_mask(nfc->flow_type);
 	tt = flow_type_to_traffic_type(flow_type);
 	if (tt < 0)
 		return tt;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
index 01ddc3def9ac..83eaceddc437 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
@@ -233,11 +233,6 @@ static int mlx5i_get_link_ksettings(struct net_device *netdev,
 	return 0;
 }
 
-static u32 mlx5i_flow_type_mask(u32 flow_type)
-{
-	return flow_type & ~(FLOW_EXT | FLOW_MAC_EXT | FLOW_RSS);
-}
-
 static int mlx5i_set_rxfh_fields(struct net_device *dev,
 				 const struct ethtool_rxfh_fields *cmd,
 				 struct netlink_ext_ack *extack)
@@ -260,7 +255,7 @@ static int mlx5i_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 	struct mlx5e_priv *priv = mlx5i_epriv(dev);
 	struct ethtool_rx_flow_spec *fs = &cmd->fs;
 
-	if (mlx5i_flow_type_mask(fs->flow_type) == ETHER_FLOW)
+	if (ethtool_flow_type_mask(fs->flow_type) == ETHER_FLOW)
 		return -EINVAL;
 
 	return mlx5e_ethtool_set_rxnfc(priv, cmd);
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 5d491a98265e..c5d814462eed 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1566,4 +1566,10 @@ struct ethtool_forced_speed_map {
 
 void
 ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps, u32 size);
+
+static inline u32 ethtool_flow_type_mask(u32 flow_type)
+{
+	return flow_type & ~(FLOW_EXT | FLOW_MAC_EXT | FLOW_RSS);
+}
+
 #endif /* _LINUX_ETHTOOL_H */
-- 
2.49.0

