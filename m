Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012004.outbound.protection.outlook.com [40.107.200.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C7A43F8BF
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192693; cv=fail; b=iZL5BQFi/iJaSBGdsiVp7wDKtciLmr8poHWABzHdV0iN0N3tTgUy7nMmCYgRd4PTmtXL4aaKOsu8+rbSsXDnIJmyZLOFhAq38fHLp+k619z5Yr3tCo0aTaClkdF/Em2im00ji79/hOfnZVd9ERHoTwU9VEuOsca+0RhWjL39Z6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192693; c=relaxed/simple;
	bh=6M34wuY5Gc65j+SVBt4N3+o9l1XUyvfg1B+2fHveDv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tp2EFH7oZe6ooCoQVMcZiAh5tn9vD5vdLpWQfgmjDL7KkWi7nufHND//MXxYRCaIgirQqbv4eqMsSZgWA4Jy5egDa6FV3dBphQ/Fxg0WtIwAK+WXTThQPsoB3osa+FFpuPe6y+axtecyHEzNqveNl+GBbVpIVFJwst6F6J55fp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aH8Dr5ac; arc=fail smtp.client-ip=40.107.200.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aH8Dr5ac"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8jMBAQC7xmXz61HL22N1PJ6IGwGxO8U3/VdKNA5/J01wE1O5CnuXI6neFh02G5ssV5ReIdl0x7I4E+sKKJ7Nwq9Nf9AAfHYesRFGO10Hnycw6bcdzHSm/LTJslXqw3GXa/L5MSJW8L0ICj52OzguUNLT03XPm46mT6EHT5xZoW3DPybWEOrGK1BB91S1cBa1yiHEpi2og0J0NSV+AMNIuxHtcAwDxn2CyzJ03rMiBjnLV7HQiF8QVET0a2CJBShvXPTpT9b89HUaXhT55EeXppGjXHtKFrkK7RMnW8AUwpN08rGx7kD3Hv5oKWSnLUTRjwlDXegmEXjprj+/WfcrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vwbH+FyiyVW7R9cq2GxqvHDXxHoY49KJpcf3Lcz2Rk=;
 b=xCXkTTgafevrY2fe4mODkmGAYM1Q1xZKysauo90EVk4MKpehlNZ9hN4DoskOlcydYwP7jffvNu9R0jszu1U9h+kWG0N2sClVL9kldul6Wqn3sZtro5i5M4Mg7x4PDeCsA9+Dpn8NjtOTbl6TPFuCa01Sq5dOToWjfNMGGw3IxhvyYDPTvPNGvfzDAYC7b4epHBeBGYr4ww3rY+7JvVzh5xqhDfyfWJfMHydnCfMmeLORqXins2w+fUCBplYZ5bHQMP8KCNuj0hn3sGfe3KcYBqBdqiJc3yXTyqpCrWNukfz3Lzdaf8PyTMCCL6PcoznE/yt1ZDPyeUnWW6lrN1xPPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vwbH+FyiyVW7R9cq2GxqvHDXxHoY49KJpcf3Lcz2Rk=;
 b=aH8Dr5ace9NYW/LYescbCWdg61jzN/m7llmKonk3O+9PlywJFR4votUQim6wK8cq4/BIyWcH/j56uziLRiiiCu9InU7Ae0Ijga6Qy7qwPPPRdfTudy/ih5wQQO8yQdp1CQjeyo8oz7f1M/KLC/iZE30HmH7Q/aqHZ5Y0pH963wNEyFmD+vjnK64hmJqwLwC9vE4duZUKqDLOKZAFyyKtMVBFkmmMoCfQ07/NsbgQFxhtucA8IRyhCQQ6bm1h3I3UszPNWVUXO2WGKgRm8149rBt5RPd9TwpwJgbwSVX0rKmttwPf8ecASkdmWDzcSemjtnw2L/ivowQPfnLdoOamrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 16:11:26 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 16:11:26 +0000
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
Subject: [PATCH net-next v23 08/14] ethtool: Introduce ethtool_flow_type_mask()
Date: Mon, 31 Aug 2026 19:11:03 +0300
Message-ID: <20260831161109.2999926-9-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 217fbfc4-d809-4cab-a676-08df077a8239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FE0nq2PiG13ezINJ4ydLuk4TF/HOlf0vzca754Tjhk6b70mX/BVLK1umC7xSKFc9AFWk7dcKkv9fdsb/dLGVoHYhIjAby5UfoQgxRlx90wIvjv0VcmaEKVmm6Prebr0EP8J1IEoF3zoYuudjj/873KAGUE/AX1/xxrZ17ljViKgQagWXbFBik316VXPylILgm+egdE/SH0oxmDqZtb7FuDkPE+ueCxk81o+q628J03rdj/teQ3FzuE1yZv5fUMPiuxq53YkTOT8wFwIn6U9mN8sbK+IZyAj4qZ+O8NwQlr2RMsb+3skr/siA6pRKi9Q8GQKi4qnsvBQmabs0mmjdmmIOq59U+DFMaWDc82Ax/ZhaQpbWCXH/kZvy7Ry817HSZCRQwPU8rht4k5CGKyrLgO3zAmHdgOvFv9BbGtFr1/eLyUpY/nKal84ClWxa2coNO/qvrlTAn1z3aSHDv4mQ1wxEqdSuoIB1T0/euK74698VEzzYnV/vlS4bU8+Q5Wi+tLL2JXHxo9m64Rp+cWN0W8o5ytbUvhSXuSliQpF0ARswRcex1RAV8sSp8fZEJCFLNUdqX//V1RWa6Vr21m140dxEK7auX/xDgxjDhoihCbRrF3CXinKbURmu6es5XS9/Xu4O9OjnDWhBU47tTK8ZCnoKBflHAxf/9/74+GtoGO8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UhaBacg/w/LtbMha5IM9fnpgTcvAc8RfHvm5XFepxcBtTA7mGSE2j7kAhFBa?=
 =?us-ascii?Q?G2cMHJAakNRM/PUqtVGkuBTBZKrsjBPcTDX/Jt0DPRWUckmXO3tbMoZBAHNG?=
 =?us-ascii?Q?zw19iaFN1VRcbh8pyeO38R8iBkGMXSErgbEhXs5jTilaxE7GivrkzOMMxV3s?=
 =?us-ascii?Q?wFWNZgg7j1UFGWwaeC/j2NrYHOtDI9OxQZ0yfvF176gYMBqFjOl7Y2OaALMU?=
 =?us-ascii?Q?jM7zT+aSKPhpDIwRCZrZYsB2tDp/5EAJMkyfWYqr0Jw9gf00fvRoUEuN3YVd?=
 =?us-ascii?Q?KbkFv18UqxVs//aSZciDrzUt1pSQC9vCe5YA0E3BBnt6FAP2gUCmCleqalOV?=
 =?us-ascii?Q?SgBDScK8TG0fEzvK/L6THRYkyWaAPUIraEgc4ARrDYwGpdw/R+0mLtpSyP5o?=
 =?us-ascii?Q?z9H71+veTPkB4ZCp8Gwfl0yySiJGt/GO9zj7cPyA02dHUofvOt6T/Sr+wTHD?=
 =?us-ascii?Q?DeZQhhxTQe6DPBw912zj9tntUQ2qsmOhIG6tIVNPRFTeeCxYUdu6HwGEUSxo?=
 =?us-ascii?Q?NNriAIXFfQ0qq0f+j5qL1sxwD+1NJkeXoY96dBVFucoq0KuUPTJDhiwhUBRK?=
 =?us-ascii?Q?eyQjFrCjXX1j90NTw9r7GzRxoC4+iWU2/IYZpocrO00llPXZCx9+0DqUdPbP?=
 =?us-ascii?Q?e2PIFLzvMjyZ42vMYmkLIrmM3OQcsSAfs6+TnLqrlm4GSGko9VG2jHQ2g3te?=
 =?us-ascii?Q?6o4i/cak7539q59ERVyjd9A15GagbWzkhUjn5yv0voL76Q8Av9QvVc63O56U?=
 =?us-ascii?Q?hJ1hjqCPhduUDGHEcN0+ZY7VEJ41KLN3WBfcJyN24/nq61M75DTTjm+52ybz?=
 =?us-ascii?Q?pYX+gycPJh5UlnvSkjR1t79FCsa6m3jKCe3ZnYD6RsodvoECldwZYTO3G9JP?=
 =?us-ascii?Q?EOO4EgwcX06ypi8WpwPkUzmVGCkYrN6j8/Oes6lwBoSHOvjcsHmp2R+kOTiV?=
 =?us-ascii?Q?Z6G0yl715KMKQMi+TcmxuHFKKBCPY009zW0PYLZDut+XI8YiuKI1esXYzWWA?=
 =?us-ascii?Q?wwNqlIP52BWZefA/fZ7f6JG/czWvL+IZAe8SuHVOIT1UuWzzyyMZIXEXSw8f?=
 =?us-ascii?Q?aCHu7pBnFA71IVxWEH02+7ZYPTQhNkYxkWity1kU4M/vDrdclaTK9I4AjCS2?=
 =?us-ascii?Q?4TRiS8TrvSRv5kmpq/2pUMfgS6B9DgQRL6CgKd9zwqSX5darzoR9oc7ZN8zh?=
 =?us-ascii?Q?b5CZFIgKsny0QuMxTA5JUMlliQiW6d0YzoglykXg00OGhytVoseunB7Zyskh?=
 =?us-ascii?Q?tLT/2Haf+xIZH/oDMA53aOpPFWJ0bQfJ6gniXtKxWewcW3dnbKF5pTbwez2y?=
 =?us-ascii?Q?ABcgxUJV9hTIiBWjO8s8u0UGA7cN5Z7vKmFy23L1EhDqu92ba5ZIDNMPKYK1?=
 =?us-ascii?Q?u//CHUEP6gzCzAvNZD28mlYdopiPpLcezStTQjnHbWFKmCTdnmT3MXPp8RX9?=
 =?us-ascii?Q?f5jS5jfCJC9B47j/46UjfTApvzgl98pJn91ANr9fGVrFJGTJ5kaDGmOQpz4x?=
 =?us-ascii?Q?dwI200rvMNe8Ah2yAHKtFhVjrSUpbUC4f3oWCLQn4pnoSCvHHuQk6c+ziWgX?=
 =?us-ascii?Q?cpZ9QHbPnnSAgFBPPP90DwB+4zt8Usf5VTCARjo16B6lDmPbzuP9mbaYGtYB?=
 =?us-ascii?Q?QkQYzY8AGuYif95qsWByhenFDoYJ7gsX3SoXE9P8Ez78j+TpUCNyrqCzw5pc?=
 =?us-ascii?Q?N/ylrRGuGXKWH/MSDHNRJZ6SGkRUJHRcYvXJY7efuKMC38IHC/jdaugWVC1L?=
 =?us-ascii?Q?B/kGuBER9g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217fbfc4-d809-4cab-a676-08df077a8239
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 16:11:26.2851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p51Qzofu5k/hkOT0Gfg1+0gROQ1DHgi/Uz39xyP9qJVWoaTkCRej5aPQYZhWU1+fFnJevgL53v1fo2Nfo3GKCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353

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
index 12683b5d125e..adecb9225ee3 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1567,4 +1567,10 @@ struct ethtool_forced_speed_map {
 
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

