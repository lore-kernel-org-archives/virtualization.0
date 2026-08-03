Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2725341D228
	for <virtualization@lists.linux.dev>; Mon,  3 Aug 2026 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766084; cv=fail; b=AMJr0ru1TbbxmXoda9kRyy4nXEwXOaYKiAN43YjzOAeMMb3HhjJQOGC3pBVhBuFqr0VBOH2/FXGxtcihcCLK2u8pVUxwuQrfTQmxu3zR/oX5aS4GNatp+R6HwvnV1pZkemnvAzFbB8sTamMIVEcJ0Vf+iMi0HEbbl42d58RbHpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766084; c=relaxed/simple;
	bh=cGDof/tdxgSYrgX9zg00ckeLy4ekpOt0vqgCZWRaxr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cYTZ2Y3f62AND6u6WT7MTsK0dLvxuMVFt8X2S89lvhp7V1NlzIuUy9RDRUZjhw4pMQbQjG4p3QD9XoWzgbvGxwTNH6jefolq2gigXZ2JHbG++dTEfOoLgfmbUM8Z9vzlQ+EqhP9PMb2F6VqsuJXLwzjWAYLD/lPpUDc4dj6YEOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r+MsVywz; arc=fail smtp.client-ip=52.101.56.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r+MsVywz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZN+UVU1H0JDV4zMONtxQHJwAVaBtNU6JeDcBAMow3+VeJQLtCAgXS9fSkk2XBAiss0Derchpae8RpJOV2r2EAIr6+ThdRsUKLCVEyPtaFzP2NrVG1Nb+v9zBjaivW8R3g9zRJAMDjcW5KXLEytlKF64AnC3ikMCDBDzbwcMB0zgDtACYvD3X7cPeDPEutgxUI94i1kzbMpBuYMw9RTHaleB2LfMSoC2RQob0dht1Gs7OGpyydZBw6zbbtOtCcgX/1cz0fjmUkXvzXKs/1MAXlBNs3z9ge9OtccUIwboSk2Z0qweaD57tA3UD1KzvHdreJY5ppeSKh0A6YFjCapSB0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22gMR2xDALHEMUciLDbNFtdvgFeC4VqHIjSKKu1zvq8=;
 b=dzE1Hgk+LmaZeseY63OACEqlCH2T2N1RY7t8kdzvyXvyXvCQ8XJHRFsSjPhI8cwCUWq7wrFdebYF+C9xaPLj0TgRNPRoPoW0+2Yw7sN8wqD9++IaGKEG754bU5XnkNNd4xxPb+lXKzm7FrxWnzEGP6GrTWHHS7J4/jlc6qOB+EflE3lDYgzrfFSSyprGyn5sN0p2kVy+0MvUQAbx9Dwt8BxAWV3Cqr115J8UOmKV4AeRtHoIbTFGp4zHsVMzSRHtsAbU1YeBY6atjghqbuW0ckCcmNq7BwVQDr2w7neCzbgHW3EPc6cAE20z8ebNjsah0iCHP3MilrSJCd6WtVEOwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22gMR2xDALHEMUciLDbNFtdvgFeC4VqHIjSKKu1zvq8=;
 b=r+MsVywzrkpOLqM7bfxu8zhdu8uIhfzutJ7GfI/79Izp5rk3ywQIgBMnNozsAp6OVt04TSiDoDUQMw5iC4kQ3wiyAR5wCxXEuRX1s77dsH11vqrj4ufCxsWI+TK95iN8fg0y75YcvFBLryNFGMIgqWl+hf6d4wg0ATpsSy6l4x4aus47U2iY2OlGe8SH/VkYCVedOjyLeJs2K1KekhUZNHmAsWYe9H9HOoWTqldhA1ih3xMsF1nskE24tCqHBJS+h4jqV3NqVzdlbl2mAwQAG6hUtpNYBxNsL29pQ2EY/Sy8gCWAAm0x+we1VKlXm4Ag74X4jSKJu1MY2NiV8FbZ7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 14:07:55 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 14:07:55 +0000
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
Subject: [PATCH net-next v21 11/13] virtio_net: Add support for IPv6 ethtool steering
Date: Mon,  3 Aug 2026 17:07:19 +0300
Message-ID: <20260803140721.1871678-12-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 44798554-1957-4160-7986-08def1689d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Krnztd+Y6hp0IEkb5+qB9nFFfdRI50tEgaLAjDBH10ZnVe2L1NW9MQhoRalhTz7R/zvdIsAE74hG5v+T1am1XQkWqKDv+VfD2clmZkZ0I8hcHC5P/WYIWIgsnIoklZha3QIAzUO66IMwK3JRqKvkYROmC88y4108F7cnJkCIYDzqV594Ut1/U9Ii15Ya419k5xG+k9d0F3JF1EWa+C86yNpLpUfZO8OzhO3jyG4lqowxcmeNUo8ZXARHkRTolb/VTvUfp0BQJ/xts3ZUl2XsJsGn6nTjwCNyHHdnm3IM9wtgEDPu76RkwpQsHTJiQsyDWZue4BjoIu/WHG9Z+T4ibjEQNW01/6hxQV7mmVtUcTPJZUBRQ9izS9wAK7vcupfvXQIhbP4wqmsTTeDWD4cz8AoWB/fpwYJNikryIAugyJsgiHUsDVGIUiBfxEL/fh7ozYZDuJOD1YL0RbCqCiN36v2I8rM5x4aGmwtqf/h4YSgqTgx8B6cVRsLhrG2cX9LpnARVK3h65nf1Nxdz9yei3HkMaD5qGBQ3GWhlyWPMH0smqv4ac9HLmSqApDPmkP2KW1g0buWLdlQjkvS12wYXwfqZlyHdgeYtISACxp7vkEp3oHbgFnp2A8mkf9yOCrZGyolu773HTfaAmuP57KavBe+ZVhEZYUWCfDhPwnkkwJ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ppOOYlgwEHuoMf+vRPDuO41tTMf+AVX/WL791Z63wkMb9drwWexcIG0FARCD?=
 =?us-ascii?Q?0m6c9++cj2W8yJMRjAaBhveZB8LtL5yeICDFg3a6YRamthWk6wBd2SRQ9Ie4?=
 =?us-ascii?Q?MPAgpqpa4vrgxU4Y1TiQNINuF8uoaszv9nSRAd7zIVSv+sOL4O5uVO31+d6x?=
 =?us-ascii?Q?rmko56BnihEB1KpQtK3CXfk+zoNIXsNOlMnMmiStPwybXIF+RD+2rPi7qeBl?=
 =?us-ascii?Q?svhWhFN/BY29i5GmpYefrYhiuYVxzb68xjgtJr8GepiHLEcyrfIiukColoFH?=
 =?us-ascii?Q?BLhhf9rEOXabDCk8QPVKDu78kTRF2WQDNjrs/ADSNEWwvVI8xsqjvD580exW?=
 =?us-ascii?Q?rcFLM7vBRhEAd+fmaCT0BOtdcC4OEBGIyU1/gQ/OKlmGWYjeg4J2cMJ4NveL?=
 =?us-ascii?Q?sqZuycrU6IjeOrAEZ8M4aVD86EF3w6YX/6TL5HAoXOxfqjrCWWgM1yuglPN2?=
 =?us-ascii?Q?twhE6ZCyhE56ZHtvDYVkZ/IkhvjAvGy2umvjMemNnB5x5kLhnpIj8kVMD1HE?=
 =?us-ascii?Q?vTS92aQS/F2GnoIYn300cVWjAcf4MsmKe9QGARSINjh2tZj02q5oU1IeDXmx?=
 =?us-ascii?Q?1s3MOF8KS9pJSleXZC148N/3AxYgyz0v+bMGgjqD7tAOLuW4qJzTzMnuo24R?=
 =?us-ascii?Q?3vZlFZyzrkPkpD2X0p99xYfTdgCeTsg7GJ/IGrDTTqopKdgaXRL2kPSrf/xH?=
 =?us-ascii?Q?XR+qm2NDwkNQ3V74KRdP3xxQ881KxZaqGm8NRF/vOFBa9xYcwSF6cacAWAlH?=
 =?us-ascii?Q?WEQt1+3V3lbD93Zg3elBHLC8/C1Ggnzau9GKrZYhKtrcssoxRmA6/6bn5kl5?=
 =?us-ascii?Q?EzJsKfWYkPiqd36UYHNUuS6iqVcaxt1d2Mpuh/1hBxp5pj6IpyqAA6einoCy?=
 =?us-ascii?Q?aSR2FrL6OhHlV/6Rr9m6Fpv3OKH/ynTEIyxFlnxFE+9aTkklY6ltPvUnsiWr?=
 =?us-ascii?Q?G9uQ+689AJUcQHkjqetDJP3NNQYVNVSz9eh8R2L8+gg0/edfyTQECY4uiBO0?=
 =?us-ascii?Q?acUx7OKyNhga24Pm6vWYSQqMbfgLRHD0L4CQYTyTlyldCewWQcAiNXY/x6h2?=
 =?us-ascii?Q?ROctem9yfWRkhMgKnC3mjcMYiV7/BkBSym3O08oDCSZhVf7uGtp1YeYegaKJ?=
 =?us-ascii?Q?eloOn+g0eE9D/93IqQFDh2LxxcaGAIFHzJQsyKkBaZUyR+jKKPZiQxs39hC2?=
 =?us-ascii?Q?MEcxWGGpvKaMeBWoxGJLp6oDlZPEZqKbF/9fhRz47K/HhClNuyjzr5frRqZ6?=
 =?us-ascii?Q?Sq3ZENWQ6dpElArT6qudm5enpv/Tm6DPnX3w0cP1hcnlr+ZXUhqyB+DtBUaI?=
 =?us-ascii?Q?ofCo4RQuSiYOatydoGIziWLBr6jGZm4EOEdkuGX+hmI7mMLYipnRkOgXAXH8?=
 =?us-ascii?Q?VOQVH13HSWcQTaWRXGhg0SVM4qXYDZtmTeg0a1NzTU/TDsWLGh89c0HR96B/?=
 =?us-ascii?Q?b/7QZeixgjIGA0UMsNaiYq8UTkHN+kyaINotYWJG+VNpN7axNyoxjrG7I+1B?=
 =?us-ascii?Q?q1O6Iu52hpXQdBSV9yUw8AsDd2/YWhwb22KzvZlbycEc/w1YFLnMsNJ5ooGC?=
 =?us-ascii?Q?i4U96fE3sqbBDrarKN6h1SicAX6VDgZ6UZv3OYSpQmFXtH9JllLN9Kh+oDus?=
 =?us-ascii?Q?wlbH7zrPuGYTb33LlW5xwCfME9AJ/xM4DKQPSxrw/zc9Vl4/wemjHVxvkm8i?=
 =?us-ascii?Q?f5bskNXovtL7C4aEPCWSIvrNZu7FW6PhJ0+nCdBRSHpgCkG6LMN48EpgvCic?=
 =?us-ascii?Q?J/ny1OIn1Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44798554-1957-4160-7986-08def1689d67
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:07:55.3805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBBQP2yXQjBU9EhcfsceIV9nL5g1VtyrnBZCA5MQ8fyz2u4o8dloNRTRJ0gPpFSK6bOFi7h3lke75xNHX+W7pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459

From: Daniel Jurgens <danielj@nvidia.com>

Implement support for IPV6_USER_FLOW type rules.

Example:
$ ethtool -U ens9 flow-type ip6 src-ip fe80::2 dst-ip fe80::4 action 3
Added rule with ID 0

The example rule will forward packets with the specified source and
destination IP addresses to RX ring 3.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/net/virtio_net.c | 105 +++++++++++++++++++++++++++++++++++----
 1 file changed, 94 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2403e888da33..7750447bbb34 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5830,6 +5830,40 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
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
@@ -5844,6 +5878,9 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
 	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
 		return validate_ip4_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
+		return validate_ip6_mask(ff, sel, sel_cap);
 	}
 
 	return false;
@@ -5871,11 +5908,33 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
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
@@ -6007,6 +6066,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
+	case IPV6_USER_FLOW:
 		return true;
 	}
 
@@ -6057,6 +6117,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 		++(*num_hdrs);
 		if (has_ipv4(fs->flow_type))
 			size += sizeof(struct iphdr);
+		else if (has_ipv6(fs->flow_type))
+			size += sizeof(struct ipv6hdr);
 	}
 
 	BUG_ON(size > 0xff);
@@ -6084,7 +6146,10 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 
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
@@ -6095,20 +6160,38 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
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
@@ -6178,7 +6261,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 
 	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
 
-	if (has_ipv4(fs->flow_type)) {
+	if (has_ipv4(fs->flow_type) || has_ipv6(fs->flow_type)) {
 		selector = next_selector(selector);
 
 		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
-- 
2.49.0

