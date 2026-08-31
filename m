Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010039.outbound.protection.outlook.com [52.101.193.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0675E3CAA41
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 07:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163117; cv=fail; b=njFJ6IfTmvLlcAYZVNt5biP/kPtJg8did+7RCWi+OMplNaTYZnPtPuIhfDXQ7iAnYXu290kjMMI6tsIyDzH4q1UI9+1SBLr+VLz2ITspU7L+t4WOulaNLCCPlwmEvg6UUg06k0JidTDYYvvfPM65MOquxhOSxwuz3DyugpwIX4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163117; c=relaxed/simple;
	bh=6M34wuY5Gc65j+SVBt4N3+o9l1XUyvfg1B+2fHveDv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fGpPgZt5Gd1U9sItXVpb/pTCuE42VWgH3pX67p9/7C39y/BXsIcWbXOXon9Kf72t7oJMRZRrE1qtgsfEuYBqgVeE9T46F0pqUzjp/MqfRrmAS14ySm/eFnGjhQYE0eYwG9lF/JzA/c1UpaMQyWNlCwBhJ6O+sRPWE0m6tcJhshE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lu/m96PX; arc=fail smtp.client-ip=52.101.193.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lu/m96PX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B136PGSsZ5CxjrarxyB1b1GRkNCD0jknrk7GuLvul80ZoAhhVrKg1eSw7GGrv6YwvnzpAITjYR/yWtzXuL8b94zbiA1FgT6XtStgHFGfRYjU+8BSN0nxmIBrww2ITtH06vzPPRIRJYBq4pZyWRrJm8wEenk01BMsoZ7HI9L13WADtx9idYzID01615l55ESvlFx2a/2QfKYC3uedJTk88ncMs0fCJc/70tsvgFwWlPZw3xwEna1W97Nba2yEUFdVMBMlI0pBZaWx+X0X1/eY1Fx/I78bWQz4YQw8euLdBH1riNUb3y55gxfK8/Oe0B/yFFda9WdYcCUcsI0gY8rLAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vwbH+FyiyVW7R9cq2GxqvHDXxHoY49KJpcf3Lcz2Rk=;
 b=xCWKX5pnMTcmPghA6yjMIQZWhj+hj4GwHRyw4HlctsEPz38jhSrywyiMzRq5YG3IjOWK+QAcqVHdHMNt5Eha4a0wCBmfbskkfk5wWiSM+H3g7Yf6h8dr0/sL4yFK+tMvnE/zSCe+t6THl1O8+A0JycKN5fo4dOVcASs0zVLRE9oTpu/L+ViQIrhA+RyoLJ4jl2mBMFytknHpcPzEV+q3YE0asd0qDCcNf1XIfCtluMwM38xQvoEW7xXVNC7hkYAleKI239vFX4mxDtEdJ4SjTlIiRBMTxP1JtYrba91209AcmRd9s7HBzTF6Exa0fHQTQZkBBUUFUAtKoKzO6QUisg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vwbH+FyiyVW7R9cq2GxqvHDXxHoY49KJpcf3Lcz2Rk=;
 b=lu/m96PXs2PyQDhUNvTJ4A27yIkYyAj0eXDmqgBQtD1HvtH+ZBrAwIuNh10eGNs/uocTbd64gNK68iNy6qcqLkEfnFNFElX5PVet+YXRLPe7ubV9/EY/8/SyOk/30+oijDOIB3navBcYGUiTL/8vCKa3Sq3Gx5nxPY3kNYU535YfK2hdqOwgV/B2q6jX9uPvInN8YYpzy8ydV5kh3O1eeOR88neVjZSGSf3bmnLnK0+BygiOi1QlKIFTgOJEBlRt4QNac2tlE9T9e33z72ia4/nYawNgXGuKQF4CrOQCbTsekkhG0Jlly7Y+XOpLNHNE815kdlPP44smQlM0f28GPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 07:58:32 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 07:58:32 +0000
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
Subject: [PATCH net-next v22 08/14] ethtool: Introduce ethtool_flow_type_mask()
Date: Mon, 31 Aug 2026 10:58:01 +0300
Message-ID: <20260831075807.2891426-9-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: aaa70908-5bb8-4223-098d-08df0735a707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	EM2GQVogGVgLpDneBMnEPLKd+sVqoVY1cS6tNNWF2wd3mxPduUZbayDVKfajRoCrdYpMQlmd58Y1Lb2YKDpOCVjfiG0yw4HvuOo3NdPPJ/Eo0GJLdb4nMy2HkuX25iv9I0gDrOombVBWfYgEcI/agyEztXb3zuDFBQrNdF/3+PhLU3Vz0EsxC7frCol386qx7BdCRzwAFecL1CgZ8ojKe+hI/6+7qhiZP/xGbWIPnASwjkMYhO9ey8e7roUUs08TsVOUiDSkWMD/ntDp0l/MidqF5sYDM7+cBHmdWr4EcSKznJGtUKAh/vX/Nj9+bpikOO/J312ZcgH82ukiXRWc20r6PIOiyeRAqYw1TD3ibF+gsu+PmkDy4wltTrMVA5RxyPtV9HSy4afuu0vMaPdGkVJHE/hc1r208dX16HOg+G87IfgzA7EGhRd5KVzNWL7AbFyT30Xzt08uWHnCtsgfKWanblUSANciYKBFioh8JlMKI9s3k3oTPTt0EjHpu4Ey2Df7SFW0KUy+26SESStBzbs86XbngH1uvOgnnNyszLO1FnFRv1ZTLEf1gkW6fG5hdlVp/dvWjM/ySb+ZgAfWzdGSrGlOjkIj3Qcwum/Yk/RJe0CSNtEOzkjfhpd0Q7SfCDXKgFxyhd/J7EfQ3p/ULWQy4Hrmu9YD3Djh+pc4Zvk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MHUeUiWL+Ter2AT4iczImRx7kmsXggSvd+3zIMlH4lk61ZIS72UXgmVHbxKP?=
 =?us-ascii?Q?hgnlMZBuA1lni3LxBSY5PUPO0inO5mW4P9juKoqNdjw5AapiR9WQ+agU4r/N?=
 =?us-ascii?Q?VzS/F1iOcIhkI/MmiIhuYo4oIpTnNb/NyxyvVOJEwqno9mnZyvLRcYNnWrvq?=
 =?us-ascii?Q?72D8kYttV3MoSLoCZ7XEMqsXOmEVG9FNVpjWdFRZCv9xs65J/X5WoRPOvXql?=
 =?us-ascii?Q?pEF9h8kosUHkXZXQRX0/5MkVLhgdeU/45EsZnLS2dxX+GLnwH+Yt0O/sqDnJ?=
 =?us-ascii?Q?ogjDiFO91Q9mKO3sNZ5vItJSq/u1qsAi8oXEr2Z/k/xGuKhD/FNLfHCXUCKr?=
 =?us-ascii?Q?WFLPULcGwsImnc1DdPD+oPrICiibIVRZUD0kWu/2KREWXuZQxnggMbBqunUn?=
 =?us-ascii?Q?/c0itYM8nlI+x+UA8t7eExeDheFWoumzlE7Web0sIts8mroDq1e3Sc/RXPIP?=
 =?us-ascii?Q?uz8P+A9Dr+ktlAkcCjfHhynqKBr7t2SRZe2YW2gusapxr17K60Epks2oP+2S?=
 =?us-ascii?Q?ifBETF5PmY25aLTv6p8bQQ0wXy1RlH7Z/DpkokrLzKaWio+L7kgDzvQJIfkK?=
 =?us-ascii?Q?fUlpVKQLuDqKDbKHVkg1QxBb1Sw82Zli4Ot+OaDxAwxhqSF4Fsa/SyBSe6A4?=
 =?us-ascii?Q?zNKkid8Y6ec0ZdBnnBfyLSErIrZMmbXk1p+VETwbeX3Y9vueRXzBa7M83VKS?=
 =?us-ascii?Q?CpU8jqSyFEGzcWdLCijp6ukbmeWQ4qIqpr+JYN3x8CB94lWr2Y0Fxw8qtg1s?=
 =?us-ascii?Q?twRdZBwv6vyftN3BWBXCsV2wzeYuffwCtBif8VNtd9cipIyQswD5MGgM6rOY?=
 =?us-ascii?Q?Pf8LloHn3tTKOPRxxbQYicDzQCChk1Knhh5mprdEvHPIr5yHWBX1/zKGrsfZ?=
 =?us-ascii?Q?iLkRRflT9ykkcYA2mtbf9+1amJgaZYdBdEC6WJZ2y6BYx038xvzCkwiaA5Q1?=
 =?us-ascii?Q?UAo1earLFxYernYrYzzQJMkp/xbyayDtzS8gAc8JnPm3rfCPkyWyxedUc+Um?=
 =?us-ascii?Q?OP/UH/ocMN+P8ncS5R/JIyRqlUIneowy9aksJEGvLnSz7muM5LDmXEt4vj1H?=
 =?us-ascii?Q?VQcMyCNtJ/DSOZ3NPemiP+HOmLvrwmNoq6s7+pmjwvJW8zuIg4qLMV0inmyN?=
 =?us-ascii?Q?sEY7nnIP4gLKAH3M8YiEDs4BSQ7zEXiLCniNhUqqmf2x2pnN1i9+UxEA5EC3?=
 =?us-ascii?Q?PmadebH1w2/egjK2lCohHRfA89/9tOjGOKWvjlGSoUD4omXgSEL89KvucprG?=
 =?us-ascii?Q?ghaS0v17aB5tL65bnRRcZuooeW7RNI8vHWLXWvud3J43vBS/w/S6TMFnaOgU?=
 =?us-ascii?Q?NpyPds657Rkv1bRNKkMx5Gm7x7vkam+huktqYKR9hG1SJdLtMc3XmA4YkuPv?=
 =?us-ascii?Q?oWYs0zOMs6IVkCDjJ7eXIk7kfEjyVICg8b7CiZQsOSAIQHqfJ7AYOpWnmzIE?=
 =?us-ascii?Q?8CyerHG8dRiJ9gs25sHW3cjmg4yAUp8aE25nfksfc21AZZSIkqZGuQ6mBXe9?=
 =?us-ascii?Q?1ayZ2zOWNXs4mUV4SzOQW5wmULjo9lQzqtnfKMaSwYbxw1fFdQQFfyPx0GbO?=
 =?us-ascii?Q?qOd6etA8SKAAd5MhgN/wYUdP6J//ykpEOEHcjVlTuj6hYycSFJyDyHniu8j9?=
 =?us-ascii?Q?H9Lk0dYIX79A04y50TkUmiAjAnlw7QK8A6Va8dz3G2bNXo0kUvJS6S7BL6lh?=
 =?us-ascii?Q?pqxZHlIIOQCkETLasBqLVi5hDJorIoItdGfadVry81mN3t5EGOlpbn7Agax8?=
 =?us-ascii?Q?bYvNQaoI5w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa70908-5bb8-4223-098d-08df0735a707
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 07:58:32.8231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VonNmdwoa8Z+P0totHe3SaQDt4jgq9XBUWOfzXWIAOITpv6IBv32wfUMML3uy2nsjnrgjHs0sTu5cBmJAZRMCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430

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

