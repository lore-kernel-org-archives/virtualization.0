Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61093E123F
	for <virtualization@lists.linux.dev>; Sun, 16 Aug 2026 12:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786882929; cv=fail; b=ETAopHm5QjAu2kn88oW57jUKPE5YCFY4ugxDo23c9iTdAy8XuoJi11LJRyzssjvgF6+0A9W+oAmCpAcmzp4/q40WXnzbUUfnG6fplSL6N6PtKZCjf4b9fGeCQO3/BiJTUZFyeIWZcWfoGgR8orOSGVO2XnEjbgIlGLWvAxpJDH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786882929; c=relaxed/simple;
	bh=MQk14a40gdoM5BzfwQ9MJB7c8BpG/siYwbISYBRq9U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P/VxQkkPL7dSm/PqS8CDI08dff5z2AHfX2clBJarPj9eJUuvEqUyIHH27vUCqb+MyCDIKLanqEMzJf7RCXIJZmAdjHcdsuoRRI7BngsbOOr+IiT2Atg4r3JuV+qX5gDh7+/0j086kXvds/jrmpm7DGo1UUy05x0HvW8LgEa5SdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JfmX5nds; arc=fail smtp.client-ip=52.101.52.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JfmX5nds"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yy+AV3Sdqa2X3dAcamvA701h61i39SC9SAs1qFBmCzUVJ9o46I+ibqfaKn2dfATMiUuzMGeTD8iTm4B+4PpMdsgSWaqizs3VTrEgAcgVBFtxZ6s83uvvbMHe6VGfq8ZWcGhBr2jcQB4Tks0CRWoUlRQKoUl1y5T8vqVU7OTjx4Jwo8Z88mbT9RgqYChe1z/YFFuLooccnjk8qfIAcoVvA6UUb40mZpKn6JA/UuDweEbrR1ZfnTbApMWB2RyQYRTZ5QSrS/7wCm1f+0gO6zhy8EmFNHRtNem2t3nyMgAh9QZoQ0grfYY+P1ttEx+A7s8iAkyQy9Vu7mnfz2UOjOEuKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNk+DCfL7PaH/i7Xuvjqsn5XJfFGzcwG8pacv06nl9U=;
 b=wiNdH8InuG+0P70QVix5US4U/50RFNVLVVZy44ibd133A2ApHUtoDL2cvO3DKQbUVooPz5S+w08hKfWG9poei4Re+phGOz9UvIv7+TNSi5xkK5PjdjxAoyuP4M+2AD0mxQRzgzSsvR0QNTsGBkXjRuJOipZ92TNZ8d96JTYVLGiNZM3Ipy+tlxcNCZ7JMFdasY9DcmZCV7oPL3TVw57/SWSnKoWniK+kxhvLIdb1RR2o75ACeobBwqsHBwgg7ELVo1gtXvos5elFYRFbnMOw2QaA5dOewylrjnVH1l334HKMgGPpYFNDvHLLQSY63W2fmREWezS5jaSFg3WinQyXNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNk+DCfL7PaH/i7Xuvjqsn5XJfFGzcwG8pacv06nl9U=;
 b=JfmX5ndsLS4mB+EzvNbq9FMgptlUNC26aF5HuW3a+JfajpDWnsGEHixkNFsll3Aav7jPxhOkqwXZ0cvdB1jJqV9aYneiwsOeDXNoPKsRO1GO8g78eBecQ37w6D49eWKbLjc5C+v+XQCiOFtZiStSc9k1Ymgrg8O3mb0fd7Q69MpCfJvCSVauzSynJqKZtjEv3KhSfMZkmdVsu0WBy5XEwUoyKxwCK8yMRMlUpkE7+8t8ihKceyOK9YVXfRdoxn3XE5okdQZ4c7DESaMCp37GH5WqGv5qRuJ6lM9QO6QIvPrfLCao2HHyTHIE16TLQdm4G5kmoUqP0JzMPzAQzW5INA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 12:22:04 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 12:22:04 +0000
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
Subject: [PATCH net-next v22 12/14] virtio_net: Add support for IPv6 ethtool steering
Date: Sun, 16 Aug 2026 15:21:09 +0300
Message-ID: <20260816122111.2495240-13-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: d6298307-f0df-49e9-c131-08defb90fb61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	eN29SvmWmS9TARv+FpPTh4cyKkUQava7/xr2diubRW0l0AdX8VqZXGncz63Vi+QkRIgixLzwgBpGIJ9uURh5QzkVRv6/Lapu9JqKgJRidBVYd2K7wOCtKgOnPA51ndI8AQIJIg+lroKYjcBWTOLcXFE6+afdW2/BGjnjtRY4qBLSzCIXX0yZPpGyloGJFFdRutsp8HgMwLKW1KPM7Rj41mxVrgMtPsJt/H9qvSfsZVzzy8zPe0ltcgfKq+NLtFtb9UusNB+chu2BJX7az0TkHuIcCm0PPQCXKsm4Tsy3oIVv1hWT+2q6hMd6ud6KmY74nVVJ2cYfVQXQo7gj9UQ5JfLASUiRNk4pRadByFIp4NcqTun+mJLOUCNwoHQZVy51K+nvq5i+Ge9Lb42p8e65A9rI31QWWKQZhmzaj4UTGjAdVNvXRVrSpV3c0u2xW2W8UefShYjt0VBCouL+HbtX4wj1OzUIJeyvu25cRBqepPqDDZhsQSWaCCssJE/z7NFczR0WabTq94GtoQOIF8F+A9d/ssrEcSH3tdjyXXujPharpvokO2H52iipMN2/MXA4a2CtUU0baiEr+9hbXUe73gRbpZ/PoN/DSBoufu2HuVN3xYn35JC1M3KSSmmiT+rXSMvp9kDj4ajlbL7DZdN07NmJ+B8GmsMgusXw78SfR/w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fMX+ViJede5+edYGvxrdt8X2yU2kex1AoO7xGgt77EG3J0iObtiaLYIABhEz?=
 =?us-ascii?Q?G1bn9VTvNhGAjlArbsVFm7NUBLPw0lMPBwgouSkbXCER3zWUDWbu3L+sgPbE?=
 =?us-ascii?Q?7RT1HoJ4JfCBKlIWMGBKXUtBi2njcQh/wmmbVvIEXtMj7MbuKaCidH916WeV?=
 =?us-ascii?Q?zSU/HQSfiOSSZuSDs4sZbCM5VeHc74XxrVZ5gdHz2teS2Di/RCypi5gru3xq?=
 =?us-ascii?Q?XfI0vcjeSfY1Ne+DDkGq0K1B3QSDAg60SXjeQDeS0PKT1e2gLiRnY/PkwQ6t?=
 =?us-ascii?Q?xJ54RlKHQe2uOQF75HhZYz3+y3cDdBtla+Tz/1/8FUI2Xsi3Ethm5QgHqt3P?=
 =?us-ascii?Q?gD4qwW08tNb9mgeiEBTWG8kkxv7qRUwdXepAi7R4Kmzig8JqVjfZqK4Zy7Jl?=
 =?us-ascii?Q?LGa+BNQeuHrBsceZKP0di06iWtpDzjCtORpE7PdHqJaUK5eyQAP1iY+gvfLC?=
 =?us-ascii?Q?vOIcEJ5OkoLQiCdSeiqQDNNDyiea5ZQHge1rtFzDD8LHlsW4L6084a2yOYmJ?=
 =?us-ascii?Q?SNfk//o2ptg51GNqgyy4E5ELBMyykXTAo4C141BzA2bNmQYl29Ptm3hlT8Tf?=
 =?us-ascii?Q?yrTru0NVdgMH64SZaIHtrsJJW7n0HPGFA1LVAXh6HB2+EaOXQWCmL+q0v/Oo?=
 =?us-ascii?Q?dnWCzHL6eE+qELXvmuSAyntsaBI/tFlFKGTXGFnbFozIHaVycyJnXLgYRujt?=
 =?us-ascii?Q?EFnfB1gA1fR/8/SRLEALq2Yl4O0itKMFptdhyGUoWGmpkFixgvp3VtMheKFy?=
 =?us-ascii?Q?fRejrnfyFsehSsM4/sEFcZMQv7dO7SHdFjbx7GtoydKml6xx/IRbk7wDxDGu?=
 =?us-ascii?Q?2ah+AD/pWb/baQv53OExALl2dHertWdtvnQSLfWTbq5n8jziX94Y9cO9Y+mO?=
 =?us-ascii?Q?GZxNMqSuuHSk0Q6wG4qjEsArCAfveHZmfaaZNP7XskYYMSuKN4riVnpR4lNW?=
 =?us-ascii?Q?fm926J1wtaM7AWK0TULy16rGyOhA9cz0/E0UpIvMqNL5Smtsp+zkeaaoTblk?=
 =?us-ascii?Q?Bfr6sK/c8skao6cCfrJ+T6tT+R5V+l/QgZTZQPVX5Z0iLds3fq9kBhirPQnw?=
 =?us-ascii?Q?Ajx8U87fHIFoqbkGqYRwQnPsZcxlh4oPPtZPqqYHvXXGA6ndFViYb4ZSxshg?=
 =?us-ascii?Q?t1eVwj5rAgpK1SXHR48+qGaA3JpPw6N9gxD5Uw8ZoEpN5OMzd1MssNlUvLuO?=
 =?us-ascii?Q?RgTSllFhw9uZ/Pvk0pCwEiFhWFNOzKgaplGJUKr0PdDJKNYixt4zjq72rBLi?=
 =?us-ascii?Q?Hdixp0LnshOI1RxoFSAsmKJP8pCZpeH7AM8Xnp0UZSdYKdtqTwTCKnSM9nRQ?=
 =?us-ascii?Q?KIJaB5SxWvC2fBBa1I42UiavLkYL4ojV+4iGevx9GFPfc2qg3V5TZ3sF6UVz?=
 =?us-ascii?Q?VxIiOz5c7d323Cx7aXLGe1OGFQvt35p8T1ByUQnWTmEMTbzDYx75QZDtiI6r?=
 =?us-ascii?Q?UnoOTuTIGHuZJjsnTlUwTI4McQZBkiX2bX2g6tVtS0ZFxxCX9wpB5cAI2Wxg?=
 =?us-ascii?Q?cRDYWtDWM74uC4Ut3x4KKuCOqLj1WKC2As1/YijsHPbmQOJf+3ocRIHR27ae?=
 =?us-ascii?Q?ERLNOaoWP39c8RENvj2SOeqItS0K/MrlctheuRNftL57TeEW5lQDsOvn6vhE?=
 =?us-ascii?Q?6TVayM5E8iTGsWWXLVHmXqwNZLziGgwVC48L9T8iL1Wqn+FyE8bLRTtK66qV?=
 =?us-ascii?Q?0t/O0FxWQ7gZw5DfH2vtxbOJycv/fw+HAzf+TtHnxWmZhDO41aHXU3j+H+0Q?=
 =?us-ascii?Q?Kns4+5RsRw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6298307-f0df-49e9-c131-08defb90fb61
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 12:22:04.5917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcod1wvugUKeaEuSafXvAZGQkE7TnKsZxn9WZYJ46Kex7RTzf5qyrEpDFVQNif0BctGAaCcS5eJheJ7aribmJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573

From: Daniel Jurgens <danielj@nvidia.com>

Implement support for IPV6_USER_FLOW type rules.

Example:
$ ethtool -U ens9 flow-type ip6 src-ip fe80::2 dst-ip fe80::4 action 3
Added rule with ID 0

The example rule will forward packets with the specified source and
destination IP addresses to RX ring 3.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 105 +++++++++++++++++++++++++++++++++++----
 1 file changed, 94 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1b4673a3962a..110b2fc6680e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5829,6 +5829,40 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
 	return true;
 }
 
+static bool validate_ip6_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct in6_addr tmp;
+	struct ipv6hdr *cap, *mask;
+
+	cap = (struct ipv6hdr *)&sel_cap->mask;
+	mask = (struct ipv6hdr *)&sel->mask;
+
+	/* mask->saddr/daddr may be unaligned; copy to aligned tmp for
+	 * ipv6_addr_any().
+	 */
+	memcpy(&tmp, &mask->saddr, sizeof(tmp));
+	if (!ipv6_addr_any(&tmp) &&
+	    !check_mask_vs_cap(&mask->saddr, &cap->saddr,
+			       sizeof(cap->saddr), partial_mask))
+		return false;
+
+	memcpy(&tmp, &mask->daddr, sizeof(tmp));
+	if (!ipv6_addr_any(&tmp) &&
+	    !check_mask_vs_cap(&mask->daddr, &cap->daddr,
+			       sizeof(cap->daddr), partial_mask))
+		return false;
+
+	if (mask->nexthdr &&
+	    !check_mask_vs_cap(&mask->nexthdr, &cap->nexthdr,
+			       sizeof(cap->nexthdr), partial_mask))
+		return false;
+
+	return true;
+}
+
 static bool validate_mask(const struct virtnet_ff *ff,
 			  const struct virtio_net_ff_selector *sel)
 {
@@ -5843,6 +5877,9 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
 	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
 		return validate_ip4_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
+		return validate_ip6_mask(ff, sel, sel_cap);
 	}
 
 	return false;
@@ -5870,11 +5907,33 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
 	}
 }
 
+static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
+		      const struct ethtool_rx_flow_spec *fs)
+{
+	const struct ethtool_usrip6_spec *l3_mask = &fs->m_u.usr_ip6_spec;
+	const struct ethtool_usrip6_spec *l3_val  = &fs->h_u.usr_ip6_spec;
+
+	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6src)) {
+		memcpy(&mask->saddr, l3_mask->ip6src, sizeof(mask->saddr));
+		memcpy(&key->saddr, l3_val->ip6src, sizeof(key->saddr));
+	}
+
+	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6dst)) {
+		memcpy(&mask->daddr, l3_mask->ip6dst, sizeof(mask->daddr));
+		memcpy(&key->daddr, l3_val->ip6dst, sizeof(key->daddr));
+	}
+}
+
 static bool has_ipv4(u32 flow_type)
 {
 	return flow_type == IP_USER_FLOW;
 }
 
+static bool has_ipv6(u32 flow_type)
+{
+	return flow_type == IPV6_USER_FLOW;
+}
+
 static int setup_classifier(struct virtnet_ff *ff,
 			    struct virtnet_classifier **c)
 {
@@ -6006,6 +6065,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
+	case IPV6_USER_FLOW:
 		return true;
 	}
 
@@ -6056,6 +6116,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 		++(*num_hdrs);
 		if (has_ipv4(fs->flow_type))
 			size += sizeof(struct iphdr);
+		else if (has_ipv6(fs->flow_type))
+			size += sizeof(struct ipv6hdr);
 	}
 
 	BUG_ON(size > 0xff);
@@ -6083,7 +6145,10 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 
 	if (num_hdrs > 1) {
 		eth_m->h_proto = cpu_to_be16(0xffff);
-		eth_k->h_proto = cpu_to_be16(ETH_P_IP);
+		if (has_ipv4(fs->flow_type))
+			eth_k->h_proto = cpu_to_be16(ETH_P_IP);
+		else
+			eth_k->h_proto = cpu_to_be16(ETH_P_IPV6);
 	} else {
 		memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
 		memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
@@ -6094,20 +6159,38 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 			     u8 *key,
 			     const struct ethtool_rx_flow_spec *fs)
 {
+	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
 	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
+	struct ipv6hdr *v6_k = (struct ipv6hdr *)key;
 	struct iphdr *v4_k = (struct iphdr *)key;
 
-	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
-	selector->length = sizeof(struct iphdr);
+	if (has_ipv6(fs->flow_type)) {
+		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV6;
+		selector->length = sizeof(struct ipv6hdr);
+
+		/* exclude tclass, it's not exposed directly in struct ipv6hdr */
+		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
+		    fs->m_u.usr_ip6_spec.l4_4_bytes ||
+		    fs->h_u.usr_ip6_spec.tclass ||
+		    fs->m_u.usr_ip6_spec.tclass ||
+		    fs->h_u.usr_ip6_spec.l4_proto ||
+		    fs->m_u.usr_ip6_spec.l4_proto)
+			return -EINVAL;
 
-	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
-	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
-	    fs->m_u.usr_ip4_spec.l4_4_bytes ||
-	    fs->m_u.usr_ip4_spec.ip_ver ||
-	    fs->m_u.usr_ip4_spec.proto)
-		return -EINVAL;
+		parse_ip6(v6_m, v6_k, fs);
+	} else {
+		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
+		selector->length = sizeof(struct iphdr);
+
+		if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
+		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
+		    fs->m_u.usr_ip4_spec.l4_4_bytes ||
+		    fs->m_u.usr_ip4_spec.ip_ver ||
+		    fs->m_u.usr_ip4_spec.proto)
+			return -EINVAL;
 
-	parse_ip4(v4_m, v4_k, fs);
+		parse_ip4(v4_m, v4_k, fs);
+	}
 
 	return 0;
 }
@@ -6180,7 +6263,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 
 	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
 
-	if (has_ipv4(fs->flow_type)) {
+	if (has_ipv4(fs->flow_type) || has_ipv6(fs->flow_type)) {
 		selector = next_selector(selector);
 
 		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
-- 
2.49.0

