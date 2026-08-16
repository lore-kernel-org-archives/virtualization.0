Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010049.outbound.protection.outlook.com [52.101.85.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D3D3E1221
	for <virtualization@lists.linux.dev>; Sun, 16 Aug 2026 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786882916; cv=fail; b=KsJHE7gDhuxWUqbO+1GHtpzO61QRV/nAxM0xlymyMcGQaEXDVOuM/kN3hNbyFNh8ilCGi4EdrZ3GQ4tdIUuLQAr9YthCHMQJ8KahEFzMwEU6ptv0ORfWL5bS4pQ7zrKyjk2GXQhCcRFHUoteq+i9IYpcz6Ke1hOKyeJHjkCprBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786882916; c=relaxed/simple;
	bh=6M34wuY5Gc65j+SVBt4N3+o9l1XUyvfg1B+2fHveDv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JwrJHjrqof0cjoxKlyzFDfK1ZhBTGzqPYE4dnTnTPZ1uMgedejfT/VcHBJ1cwguP36pXcaOSSiB0AlkqYo8jURRNV9UrWN0jd/7lwShlu6iUK4vdzq2dP0fIaLnnxhLAi84rhy9SpzuVJt0p5JtngI6JfOgNKyo8oMBCpGJWqY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X6pNftvQ; arc=fail smtp.client-ip=52.101.85.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X6pNftvQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6c795fQbyeXTxiBMOMrK7iOXyN6Axs6M9O55PdryxqYKMUasXxyhV2YPZQ2Ay4528Uk7jeLNIfArmb4HDx71N5kaZO2mtMyZOwdfzJPkxCWSgkY+tTNOeGPiuemG8VY4LldCPSi2yJHIVW2jqDSgRIgllf1EUIu31PZj2Nr79ZH/7m6DZ4ozH3/6XZFZrPRTAhd6Ndj+X1V0xT31xAskHASkhcALIOM6pxpe1w/OYR8000RkAH4GIg/RpNCsKxGE6Sh6Nex14X5RlN1NVHERV8Dgo08By/ra7Wh2LINydb2Bl1hrm03DGnRYDeyRmLMcHltYBfgURXI54O0SK1gbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vwbH+FyiyVW7R9cq2GxqvHDXxHoY49KJpcf3Lcz2Rk=;
 b=wltL85r1Xg8EJPbahfpBY/agyZNpevuxpVcLBJtJaL1NC9rPJssNJQY3l4fdeOco9mZXiAiEZIqpMsQ0WGFKl7MihMQzhKrnmhIKAwORjJGIDysP+ih53RjokQ2SfNmtxWctFq0Y7bLzJs6vAYEpmMa/5pAexncDHf7whAf54Fcmhda7qS3WnACdODkr39HlmMrjmJGCEN6XzTKfkQFCEHp+k7c1HDPBtpgqEYQnbVOojlYfQRIEKu9rj4Cs2LOL6IwYZgXf1Ixq62/4l8gNPCDsX9frclMkyCNpHZez5+BCRm8t3SD3r6Ke7fG4y0ziC7smIg63XlafDAllMGcURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vwbH+FyiyVW7R9cq2GxqvHDXxHoY49KJpcf3Lcz2Rk=;
 b=X6pNftvQbaXKhYkdCaOw6iO+dcXgfpSbuRwWbIcko3Apf6n57GC9JHJXLInF+FZeO6zAPDH7XxdjeLMMwSb48CDlNqLELdcgXISoYViL+M1tB4zlVnKk67SwDGOAJUTIfsNNT1SrO1DBoO561QW9TH1CCm1uHIPzNP/ZCGau+2vSwLOCN0RpBsR7bnTfc81AUK7Vo6F33sPV1MBKRLvZj2q6mMkrTL2GmKZT2jIrT3V4xbD6jEzHuYFSGRAa37DNYI9hLSTw2QtiUQ3+1KoeerQSJUxrma8iHOKRHqeS/Xtg5jtGBtGbthhvrAC6a1pt/KlD8uvJ63B3fiAPLX+XgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 12:21:51 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 12:21:51 +0000
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
Subject: [PATCH net-next v22 08/14] ethtool: Introduce ethtool_flow_type_mask()
Date: Sun, 16 Aug 2026 15:21:05 +0300
Message-ID: <20260816122111.2495240-9-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 030cbbef-19ce-45dc-68ca-08defb90f374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	6LDtV/+/G9lkWX+0hxp/XUN/+7D9L4WTb/BSDEvkS7xe12TEMshcFRmdncpR2kkwZk1ERBHlRyZ/QVpq5qw6AYL7Wuzov7l6EDnb5s3YLfMjB1RKFUruf5MJHkAVMZmDgCieQ6gRKMBx9ESzxVtUkvTwWQNNlcX5Z4SFeGNHdMGb/RWZpu+gVxO5CVcvBSjX6kvV/MuG8pyfiVwVws7cHTePFx4yU1UR40dH/6O+AUSAB6ZpovRbaeBC0/Jb4heR3XxRq8hhNBJ27JA0WGZJkileBCcdhjqJ/0r+w3SldJLIIrf1XKFzY3uYl8b6Np7AWB5yfedQYIFgjGseGKsXDPErEPs/DanlofeA6gJkHp9TIGBw4mihiTKK/GJudD3mMp/5KVSKJC+AG1MB6SRoqBgJtvjshAviuua4uQE5FM4FpwgCNC1E7XYOjd7MKPZj7HrtoaNkAzyemN3enLEBSpXcgABZhR9qQH7FPSd4zAYeYRV8aGoyZ3Rl5STNyMBIIzSLRZTIKHKaC+/IV0MalDhXfUcTBb+ZigvB3hDM+UEHphEEqOTGUwSYP8BjcH4jos/0sdq+/3oX2CbH9Zejd0V/4ta8r1rhbZAdB1wI+ZGLnZojNYSOeHqEERz8gi9lGKg+OxPJZ5pFW4s2ZTdos+GS5b0AgFTtcDkaT6CQwvM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iwaPT/DF2FNSyTJJBREGQz2hhWMKXO+yAnxsHN5e5DDhpVoDWYkHeIcHyvtw?=
 =?us-ascii?Q?xQPd0J8PDeXU5cu6jw7MXNWep2BqXDo1XcpjPtUI9yebJEU+Rx93gWuxZ8TI?=
 =?us-ascii?Q?BgMjS8Ua8zMZFquO1fIK5h9ZcXF5Hl+FWxdRWJy8bNlZIiFeFPLtP27xKBaK?=
 =?us-ascii?Q?yu3PS6vUz84IGRE4ZcRYaMCnnwXTfNownfIdLVkyq5Bf0TZReqyimeC4TWzl?=
 =?us-ascii?Q?FENPHz6SsfmOFVsyx6ZWYsX3BwUFdG39UjWDm4oyhXXIV85u/drnVKeCDGZy?=
 =?us-ascii?Q?ZJZPWqCciwM8DVf0qCDryqlPjGfTEw+YPCZAb+KIjmqu0x6wqWSYMx1eMZ9m?=
 =?us-ascii?Q?kO24DXOzpuRWLbVHE8UMtoAH4HVbdMO1kazAJk8fVsd9lMDtmd/fLz99ZRvZ?=
 =?us-ascii?Q?BejfLYLtHEkCH+BMCWRtaaTzlIVfaXwUcOznzaYt3/dwSw0mUohoIHs2gpd1?=
 =?us-ascii?Q?uy2VEBuL3U7i0aE4IqWGPV+zWGbq7GE90ymTbBF8MLfCD5cHFRMP5nj25I7a?=
 =?us-ascii?Q?AiFbNkdFd1YXWh3bweFvbWFveMX+da0M8llD/8/H3xqTG97Tj9zZncyC69Ra?=
 =?us-ascii?Q?Y9ueZGjwCmK6iT5OBXYh1tC1Cvdb3FdBA7QbDq7xpmWt9kwhrwG6wMk/jGT2?=
 =?us-ascii?Q?2UpgPd8Yau69TREWJG6hF9xS3F9pS48/pNNL0CRwbhKPSG6x1f19MpRuUM8P?=
 =?us-ascii?Q?rBxbnpVndEGdhGnHD09zvMmPY3fhOBp0p+rX3FxP+EighwowAi+j9DV0QIMk?=
 =?us-ascii?Q?k1b3B8IhNqdu/8oaOca1o1Rp69Moom6eWIvWcDka8c0NLuCwzWDRuBW+7DBx?=
 =?us-ascii?Q?lzmlBAQ6GxuYc4yExBsGdbUANTx5PCesrHFdRcJAnCK1i6+d3a11+6QpZseH?=
 =?us-ascii?Q?oTQZMd1DN8blxu/r/kf9LuD+JyIwAMp4LK1AU2ynBLn+K/O3TX/yd057z1YD?=
 =?us-ascii?Q?DkpoP28YSofvu7LJwcKzEKrePAxlATf50zmFEjujG6cxO/IDrLkc9o5B6OCP?=
 =?us-ascii?Q?/UOSEWel3qFLg94DuxufglDq3QoU4EAHw2Nmy/8gHSdXCPLCEMBDhxYnV9II?=
 =?us-ascii?Q?QwjK5fN/d/n4OcerI2beGe0mEYxj3MYga+UCv8W4H+0iqSaxf1BTVvempD6H?=
 =?us-ascii?Q?1kAk8zeW/7Va3Q2L5P4TR05qIWlKBGcgPb345WYfp8xXpfuh1imeRgyWPs4g?=
 =?us-ascii?Q?SyMlPPZrDSs2EiXbKKBHPpFla3lCuwokUdv6QrR6+5QeygSZK7ZXmxuvvkW7?=
 =?us-ascii?Q?Lh1SvcRxQ7nNnV+h4UADw7UX7BevNL0JZXC+zN5vexkAv785Qe90wlUxcpJi?=
 =?us-ascii?Q?Nv4wSifRCqVL5ICLMWyZD2quSmvv41lB1ap0FkgJJlgE6dOus5OCzPO5r/hy?=
 =?us-ascii?Q?DsXoF3UJL7TwNSED/aM4OWhSBf3xQ2V1Qi7JXgwQOS5bQ6MuuEcfNpnvd6au?=
 =?us-ascii?Q?8RTfvD+ouMmXIPcavErkNKEV+fOJHVPvWB1ViRreRrup+r3GVJgOJqKLCAqt?=
 =?us-ascii?Q?fwQtE5IxKnXKG9epFghKoTkEdio0sDRgwDLhpFkV3g2o6t/UCmcpzBV8TJzT?=
 =?us-ascii?Q?Mat15PZvNB80rzK1L/tMT/fFwmsDD/pALv6wYUD/G0YiuDUCu+zM7s/SL3Yf?=
 =?us-ascii?Q?tB5KVbkw1/VkDj71I5JZ6gxWAZtCT2VWgLloCnKIws7PJFPnbQC5u5/je1+4?=
 =?us-ascii?Q?swRWT1IfUtiZPnCXTZt2ocl6RIX63nP8Tcmb1tHd15uWy+Wsq4xlYIgGi0s6?=
 =?us-ascii?Q?arhtNfeGvQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030cbbef-19ce-45dc-68ca-08defb90f374
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 12:21:51.3206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJftlyM9lY4aLVR48aIEIJfjGfc0yyADth/C+JO+0IZ9Augw9WdHW5gtak7X9drNZ4z82VxZ5Y/WSqMr00zxbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573

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

