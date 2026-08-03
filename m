Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C60D41D214
	for <virtualization@lists.linux.dev>; Mon,  3 Aug 2026 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766082; cv=fail; b=VyTYuhMlMhHrtNR2KtGmZIwup55tB8UKjaFNMcA+KxJWO8E+6c7HrDcq13FvZCRX7jLiafkcT7tSfLorRQV0AYAni1y85A98DgEMNCnULP96704nmONeJgZZQwktJZHqfc4LzPhMq6237n1y6i5t1SAhwQ6SDyY/2ZKUPFJDQ1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766082; c=relaxed/simple;
	bh=dPYt2x7KlnC+/63k+xk224sA2qpSnLN7XFLpgfIRzF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cPoOQHsDiDqypgUvL1Ecb2lToMdWRo4NgucMF95PlFqoV+PeNZE0Ym10/QLz0f66CbNCTaB7L5n482nyn4Zj2bLidp6FghWePjc+gIgD6eHnM9l9ObKNEMUOnu5miwgXwBX/QjCuVuUaJ64coyNDASEIFsrmIOPiNw1Colxh55U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jiatLdb+; arc=fail smtp.client-ip=52.101.56.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jiatLdb+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxkmCvt74zKpsEpq4GNzTmsdzanGtthoZbz3orQ7FeYDl5MsDDzg55BFb1axaTFdIspSMBmv/KnYZzaT9R69+rtQVlw0l+xy/dAzoRuMhe3QZCKQ0StCj5sFEueLnqb4Is3mv4456D+12131ZoKfIiylwuLpLQ6BGpTHSG+46ATMsTB+vkyrgpmp2ThkINpetkDibsIhfBg+DHgRvqgqYZqNXxv8x5zy54thVGEKEnQZv2UlOVaOvPyCGT1TnEhWULe2VgZkmKWg+iKPVebRYMkvqigQKrY5PK9/Mb+NiNG9CWfLrDZQuSKNOfujNFJgWdAHk1jvOrbbzhSd73yaWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvWolcwi0V+nxX/kM1gcMOGzvzsh23dVv1Om2TvnUSM=;
 b=N9i6Pzxgvyuwo+CBKdGls1gW/T1+CvEEAd6ne6D97RhLycJibeIljc9gfmtXMWxhe/bIbV1wPOsh2w7nNNM8Qi1ONRzjvSlEoRLe5Sy9Xhe9A8iiixmQBwIcT36cyub7AENgb8tFivf22Aoh+F2TWBrMtdLrC2t5OW8wxXlyHLaVEIBTXxMBnUdK55OVMKqUjyPm3yHfUOWV6+8P6oLIL5b3OAfxnM3g8vKyjC4YQlxdbQNQ5/SOLZuUeBTQ8+2pcvX+CcKFpdwEzTjGTxUhFk00KYirOh1rH6nIz24HZK+fVQAqh319ua94w0XN0d3tm0D8rzzoJdeii62X0Dk/pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvWolcwi0V+nxX/kM1gcMOGzvzsh23dVv1Om2TvnUSM=;
 b=jiatLdb+JGwqaFfa3eYdP5DcGfJv6Mpd+tJhKdVOTf5cI4XEwM/PGVd38X9h1OiDZgR+fnyCrd8qhpuV8GJYrCT+YeAwkyEc8Duyn0PCLoncPRBGirtoFv7ible2Zukz70b24b0DrbOQIdjoFmBMFCvkzlPIdPCeSJ4uaLLCiCBFt054DeC0AjHczd5UtpMN5SFXTMog5KAIRyflnmwcnb+fSNv2CElrSAtTSDUjHVL4HwtZpxJnTXLYhQIZrncHmxhhmyAJsfR+V7LvsqIEaNis7ZCTeecFdU6XXPAyAIAzhbMooA8xlIEQk3q1Hf2AXNTn+Ge7VR8hcXHjNzPSkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 14:07:52 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 14:07:52 +0000
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
Subject: [PATCH net-next v21 10/13] virtio_net: Implement IPv4 ethtool flow rules
Date: Mon,  3 Aug 2026 17:07:18 +0300
Message-ID: <20260803140721.1871678-11-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2364422d-4706-442f-a200-08def1689bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|11063799006|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	cBmmYNniRvd49mV7tOzBO9ixL6Kk++owsVqJ5sYwpD1WthAOlGt1ipceHS+AgdhiX3JPL899MWS5m/LWlVXYogfrxQ7slcyTMqjNi55JLFtk4NdiEyWGyRP9oImSExqiqCdWAMcvCwWxq9Hv3GzgchuEzECC5upyof9zlUHfN+1WO+qxTE60PZMJNG1vGVJkms2biyywou7ucLFPX0b3ZiwZt3+n2OhutIe5qleX/mmWySK0L3cYCfri0d8HCKE2Fq4WFQQ9c52/punQlBXsLf2LydjfiZ1xxtwan9YeiWsfm1aFb3rgmJBkuDtZtySAlzW6wOwqahKEhmqq2DoPEYOUYHlePJPzKKkjU+Ifb0qHTpJnI/Yc8LRIjGoWchX12I+x/imnAwxJogZL9OjsqRC/dshFkMyfiGOe6dn9nhZVb6jg//LvjifXqvGaX2Vn7bL9RYH+1I8h6yOnxYIBsJDQPbGy/MueIxzLzExw+PotwtPcy1Zv7EEpVe92/mtyL2gZEKLtAsTQa8FN5nozglO+ODhkvNDxSLM7O564Gy4llHe9QbwYG7/mou/vRpGJhBJKJ8+okXLI8/djMaDBmOg5XPh9cVT4m6PhX2h5EMFMz3pgZwKICVGcTjJRqJHKAyPJlRy22No7QFZuKCXytO9wzub38/YJxO6WNylWDHg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tgC//8IKTUk08OxkRm/I5K30hB2p+tDKANMCmgFZEATaMeoFEOKa5ohWBXQi?=
 =?us-ascii?Q?xk0WN0/ZOGKABTSQP7SMsVV2gI7EJyA1Q/JuIqwe3c0/VweS+eMhn0os/HHv?=
 =?us-ascii?Q?+OGnADdgGBSUDDYNSzpvVFqi8CgyWNjx87Mmir8GzpcuvByyoDziq9VWKHxN?=
 =?us-ascii?Q?PzeH3uXhjFBzw1ni1UhHPS2j3vdWhOjec89YdNhBYzARdVUNsrVew8RM8p6C?=
 =?us-ascii?Q?T34l6vc4ql3oqbPm8BmFwCz2Bv8n8RNydPz42KTIktpLGNtIJyqHheUTaarD?=
 =?us-ascii?Q?hIDc29JPCyzqxifLREfFs10MQLJmFdgmOlzx8VrhcBGVtF+JTOejW9qRy7IY?=
 =?us-ascii?Q?EiAGrJIY9uVr7Ug7p8yReM1sAeDLg9K+2dxArz6HFFuInCSyhvTntBJAvD68?=
 =?us-ascii?Q?WcpNwnQwg6Pg9AgZ9/Wkpvan9JvXEZ1bTXBvQ2Jg7c56oyQO+7Pwy1IXhOdg?=
 =?us-ascii?Q?oCUlFj9yRFmVgGhtGzqQwPKoE7AXHCBMjTqvglWG6UQbmrQEOzloqdVAhVUe?=
 =?us-ascii?Q?r3GdKMD7k2rkD5SMeODH/tk5l44Q8AJyzxIUR0hMBupS8aO3DR75JB2Kd7EB?=
 =?us-ascii?Q?usmRc9WUqBCOmCUa9Bq4U0RYOTg3Uirk67k1Jt6+PoZwNgVHGlgFIwZdERNN?=
 =?us-ascii?Q?ZwnwgeL0Pi/plCq5kN42OalIT1U2aM8LlKyVxDTV1NdOvEi0BnjKyS4dMnNh?=
 =?us-ascii?Q?gRHiiNNmT7LTjxsr+nfokBQtg3TFeHQWKuOjUpSsGa0jajTWXG3T9Ggulj9L?=
 =?us-ascii?Q?pSpEC7YHqMdkbaq8UnYetaAYkkmyxFxJHJFi6jRPxdHIVJ+YnuX01vGo9Tz/?=
 =?us-ascii?Q?aiH2H13KZY+ZcrttLG1vINoae8dVsMXdFr3x36cyNbX34eawYwGyiN8QaEjH?=
 =?us-ascii?Q?6MDMpVxPqKNtIzPVW3MZ5vSlJm6DCKNo1n8o/FUUZWhOnzNE9Y/X4Hp3NuTR?=
 =?us-ascii?Q?uKItu8NxqDXX/oo8bfVwNsLCL4KHqaMatWBUUl9cfMVIyjuZA9+XvTPTkWg7?=
 =?us-ascii?Q?50R8mypptXi5BCdXvPGHDOn94idF0GkiSrXapVJ430XJjIslbGrPuGX91w+D?=
 =?us-ascii?Q?NV0NCLAztFpcmHtu8OkpN7r4pijf4q/q6GgHEMFgOb1uxSXBT73Ex6t03sbl?=
 =?us-ascii?Q?9NC9j/nSV/ReIBcPrRvRw2SSRI0VFKXmWSz0sGNdiVtGg/btaHSurz7AMXUT?=
 =?us-ascii?Q?Ooe3qsaRgB7tkFm5dmIYAT54RJptn8kvH4jKVZiYQwvMVUBBTyEggK7cCGtL?=
 =?us-ascii?Q?CIIsLpk8tIpy7FtX/vdu7Jxk0vrYTG6LkXV+dEMjexdKS8PvMK1sH7FTyyrA?=
 =?us-ascii?Q?0UvlmiAb1Yx7C3uCCYTpozJLUUmiLF4N0YMlwy2M+X9b/zc5gqbYp/kYGwl+?=
 =?us-ascii?Q?VNVM2XsAF6x4tKJH4fwLh3okVjfxBfoCae22EZOnH6e4MlKi/fNimKGlRxSx?=
 =?us-ascii?Q?rX89hs/oKHbLY7k7MxxeSBL2vcpUZf+aaQBcEsSLNMIuBtofxzPEYfRKRRM2?=
 =?us-ascii?Q?aOsPT6/6RBARrXUb92/lOBniuhmP5vE3PQs7gfG3yfdW5BVspzczwFssgKIL?=
 =?us-ascii?Q?g6HTZ+TryrEutwJEGFrwN0X/SA/qyfQKe3LVjaYhutGUGkD9gUh37QMKopKU?=
 =?us-ascii?Q?rpAb4ZHB31VTsbkEQRUUgqqoMp3/SVgHZGMpIBTM51D9m/9vwzx/by4akFvo?=
 =?us-ascii?Q?Bvbh0gCfk09596KAQ370rOkSN+LjMmevQ+DbwbE5WbGzeoKLlN808vavg94v?=
 =?us-ascii?Q?X/oP2JyRsQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2364422d-4706-442f-a200-08def1689bcf
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:07:52.7708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WQ2EbWoxaWm2A7OqJULyo7Bc7RBjz6S5XZOHJUYtMwXbB2+7p0R04PRcPxH2bFM8W2TnzMl/bcAJsc9Sr/Wow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459

From: Daniel Jurgens <danielj@nvidia.com>

Add support for IP_USER type rules from ethtool.

Example:
$ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action -1
Added rule with ID 1

The example rule will drop packets with the source IP specified.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/net/virtio_net.c | 130 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 124 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index cfcbd8bcd550..2403e888da33 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -34,6 +34,7 @@
 #include <uapi/linux/virtio_net_ff.h>
 #include <linux/xarray.h>
 #include <linux/refcount.h>
+#include <linux/unaligned.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -5796,6 +5797,39 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
 	return true;
 }
 
+static bool validate_ip4_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct iphdr *cap, *mask;
+
+	cap = (struct iphdr *)&sel_cap->mask;
+	mask = (struct iphdr *)&sel->mask;
+
+	if (get_unaligned(&mask->saddr) &&
+	    !check_mask_vs_cap(&mask->saddr, &cap->saddr,
+			       sizeof(__be32), partial_mask))
+		return false;
+
+	if (get_unaligned(&mask->daddr) &&
+	    !check_mask_vs_cap(&mask->daddr, &cap->daddr,
+			       sizeof(__be32), partial_mask))
+		return false;
+
+	if (mask->protocol &&
+	    !check_mask_vs_cap(&mask->protocol, &cap->protocol,
+			       sizeof(u8), partial_mask))
+		return false;
+
+	if (mask->tos &&
+	    !check_mask_vs_cap(&mask->tos, &cap->tos,
+			       sizeof(u8), partial_mask))
+		return false;
+
+	return true;
+}
+
 static bool validate_mask(const struct virtnet_ff *ff,
 			  const struct virtio_net_ff_selector *sel)
 {
@@ -5807,11 +5841,41 @@ static bool validate_mask(const struct virtnet_ff *ff,
 	switch (sel->type) {
 	case VIRTIO_NET_FF_MASK_TYPE_ETH:
 		return validate_eth_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
+		return validate_ip4_mask(ff, sel, sel_cap);
 	}
 
 	return false;
 }
 
+static void parse_ip4(struct iphdr *mask, struct iphdr *key,
+		      const struct ethtool_rx_flow_spec *fs)
+{
+	const struct ethtool_usrip4_spec *l3_mask = &fs->m_u.usr_ip4_spec;
+	const struct ethtool_usrip4_spec *l3_val  = &fs->h_u.usr_ip4_spec;
+
+	if (l3_mask->ip4src) {
+		put_unaligned(l3_mask->ip4src, &mask->saddr);
+		put_unaligned(l3_val->ip4src, &key->saddr);
+	}
+
+	if (l3_mask->ip4dst) {
+		put_unaligned(l3_mask->ip4dst, &mask->daddr);
+		put_unaligned(l3_val->ip4dst, &key->daddr);
+	}
+
+	if (l3_mask->tos) {
+		mask->tos = l3_mask->tos;
+		key->tos = l3_val->tos;
+	}
+}
+
+static bool has_ipv4(u32 flow_type)
+{
+	return flow_type == IP_USER_FLOW;
+}
+
 static int setup_classifier(struct virtnet_ff *ff,
 			    struct virtnet_classifier **c)
 {
@@ -5942,6 +6006,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 {
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
+	case IP_USER_FLOW:
 		return true;
 	}
 
@@ -5984,8 +6049,18 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 				 u8 *key_size, size_t *classifier_size,
 				 int *num_hdrs)
 {
+	size_t size = sizeof(struct ethhdr);
+
 	*num_hdrs = 1;
-	*key_size = sizeof(struct ethhdr);
+
+	if (fs->flow_type != ETHER_FLOW) {
+		++(*num_hdrs);
+		if (has_ipv4(fs->flow_type))
+			size += sizeof(struct iphdr);
+	}
+
+	BUG_ON(size > 0xff);
+	*key_size = size;
 	/*
 	 * The classifier size is the size of the classifier header, a selector
 	 * header for each type of header in the match criteria, and each header
@@ -5997,8 +6072,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 }
 
 static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
-				   u8 *key,
-				   const struct ethtool_rx_flow_spec *fs)
+				  u8 *key,
+				  const struct ethtool_rx_flow_spec *fs,
+				  int num_hdrs)
 {
 	struct ethhdr *eth_m = (struct ethhdr *)&selector->mask;
 	struct ethhdr *eth_k = (struct ethhdr *)key;
@@ -6006,8 +6082,35 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 	selector->type = VIRTIO_NET_FF_MASK_TYPE_ETH;
 	selector->length = sizeof(struct ethhdr);
 
-	memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
-	memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
+	if (num_hdrs > 1) {
+		eth_m->h_proto = cpu_to_be16(0xffff);
+		eth_k->h_proto = cpu_to_be16(ETH_P_IP);
+	} else {
+		memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
+		memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
+	}
+}
+
+static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
+			     u8 *key,
+			     const struct ethtool_rx_flow_spec *fs)
+{
+	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
+	struct iphdr *v4_k = (struct iphdr *)key;
+
+	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
+	selector->length = sizeof(struct iphdr);
+
+	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
+	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
+	    fs->m_u.usr_ip4_spec.l4_4_bytes ||
+	    fs->m_u.usr_ip4_spec.ip_ver ||
+	    fs->m_u.usr_ip4_spec.proto)
+		return -EINVAL;
+
+	parse_ip4(v4_m, v4_k, fs);
+
+	return 0;
 }
 
 static int
@@ -6029,6 +6132,13 @@ validate_classifier_selectors(struct virtnet_ff *ff,
 	return 0;
 }
 
+static
+struct virtio_net_ff_selector *next_selector(struct virtio_net_ff_selector *sel)
+{
+	return (void *)sel + sizeof(struct virtio_net_ff_selector) +
+		sel->length;
+}
+
 static int build_and_insert(struct virtnet_ff *ff,
 			    struct virtnet_ethtool_rule *eth_rule)
 {
@@ -6066,7 +6176,15 @@ static int build_and_insert(struct virtnet_ff *ff,
 	classifier->count = num_hdrs;
 	selector = (void *)&classifier->selectors[0];
 
-	setup_eth_hdr_key_mask(selector, key, fs);
+	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
+
+	if (has_ipv4(fs->flow_type)) {
+		selector = next_selector(selector);
+
+		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
+		if (err)
+			goto err_classifier;
+	}
 
 	err = validate_classifier_selectors(ff, classifier, num_hdrs);
 	if (err)
-- 
2.49.0

