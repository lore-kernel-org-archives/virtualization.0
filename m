Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012023.outbound.protection.outlook.com [52.101.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBCF3CC9EA
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163129; cv=fail; b=AhFxfHXcByyEWHK6B1OZJxB5O7BKF6E+3j+BeHbqfID8OloljKupadIZ5TduVFLqKTF0abCsSdu7cVcHv9YVhWQRXm1E36ChG7bdQYc+Kl6OsC6/GWj3Bf7xVssqIMkNd9r7CkuaG/nIH9ZPMy3T6oaMtr8jzdukf7zM7LEoWfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163129; c=relaxed/simple;
	bh=QFhA/4zSyeW9FmDhVxTpnKKzLQIssOvFuJgRgeKEOP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k7oT7zlpJoM4OGIugPGbW2L41aid0/+hKLQ3JWKRN/pdH6AY9sAeSGsfXpKrZ7lXK9ICHxmf/GXgdCSyPOgmaRw1J1YiEWhB4nmaoMn6Hw7Dliac5OkRVyY3eqv/bEv41/zZOfeIXh2GypQOLKwwOMfrlBHLZMgZH0EVZJ3yN5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WPrLM0Lv; arc=fail smtp.client-ip=52.101.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WPrLM0Lv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=md3eqvuED5/Vsv7H6buYno0C75/+cH91l7uWa5nlfN95rdbR2Ce2J1jlhWk2ONtlvlv1F2l8JVnIiINLgjKaUcO+3YW9it3pN/7ZmN98Mz36HpeQc9R9KUAZA0D1Zq2vrVcyFT6Gln9QQqoGbkDLb3iZy4bXFk/lmJFragI1KkxmkohaMXwwCvF06HWRkzGn8qT3ir2vHQXa4D+mYaUwFUku82fwbx2dsdgLRlx3CMAbw+10SaQgP3KM/GpTVbKecWk1T7YozyczYYyXfQSS7R+rsLGX2FYg5rvZCO/wCJ8GX6vfa7a/HC0Ov+qXz3Kr3mUWxSPJPSWKGCxvbfwcTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Crs7Y7+X+JcDrGyYwpetYUVtRpQNIiNVIY6WcDIzELo=;
 b=RKMQJEDC+RjQfjzNbFGUPNiNqffDTI9qEy5nKJocmZYkWIMcciG07hbvTHozPlHiOhOe0rIVMg1n6/9MPLJK3K2fZg0UM+AYgCNLckiqrImnVv0qSGPjlSd0dB1kz+aIKwwTCAAojU5Y5CDxBK+YWjV/RbxnSrsR4zm6q1c4clKW8VIBDcmUPy80h2YjKEo4GL0spdnoGmVLdKPpOtup+Hdw8PVwd5tDyL5KvfquztUqYUnsEHe/ImyPoCVhoYBTT9zkkRD6ObgfhuRYUpRdiBncSJ2oVuk9HDlUF4tzmjfKKRuMZDDZxKh3a3WlPzIGQzzxjSsM6eQCnQNRUihw0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Crs7Y7+X+JcDrGyYwpetYUVtRpQNIiNVIY6WcDIzELo=;
 b=WPrLM0LvJPdDdJViLO3ByNOlqhhuccoGwZ8FReeKWEQgkAlB3dvUeGutkGYbi14cx2ZRBz11j60ZZzI9xf5XJv4XEloKNMxUMoS4Qfj9w0tR9x8ZUpgM9B9/ceIam/wclpMemyWhNuy76CsOaT65NIjtUqpUvC+QnllL/9sosBe9pz1FY+5uVBJEv0K2b0/JUxXb2x4TGnbTnEmgBdQwOuFi1NBdawr4uhFu6JpdqZksMisEEgWqdABn8vJ+WllURSRRXKdJtVeKwvv+KFZi9ZZZmfE8yoOKM6Bw+D4qQV+WZejMHY8MDkOwpLeR01L9Y1PvhWB7183bew1vzCxgxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 07:58:45 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 07:58:45 +0000
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
Subject: [PATCH net-next v22 12/14] virtio_net: Add support for IPv6 ethtool steering
Date: Mon, 31 Aug 2026 10:58:05 +0300
Message-ID: <20260831075807.2891426-13-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1980dd6c-dbbc-435c-7ad0-08df0735ae54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|6133799003|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	HBcXG9qPGbIZzBU9DGmzJVeg4QasYd3Orq1dY/uTypLPFeJfkbNXF4QtjhX+FWh0lwCGTm1RDkmfjW0xeJShixRTeowKXHJxXZf64CMw9/uKfA3Y8HiI8/hF5vp3K2yvFmwGP9XKcJGw+qr+j/LPxWuq90Q/Dyyd99M4c7iuuRJbtgAwHmezw7Mp+JsxmCT/iQLtHZhaIF1hymiLoAZxj3N7YuoBxzrgeNrWJmCA7IGCuuKEAIKPbVZi5f1rBOP91OOfzJMh+jW6h7eFm/zmTZZLug+dqMyegIYxCnUtKSvJ0StxduQ0Z9qzr9gkrai3SokhtpLBLHvK3KKIl/Wmt+VwV5cGUgtC+DybEHH9Boe7/rupRH+fSc+2i5LZiELnsGuozMrOAfrNyZVPQjU7GDwQf2e1nJppBk8dMC2OTVJh5tF8Z/Yr6gJwtwHfQSHUnYEftXYUCQTbiqYVrJopVwOfJyOy0II8qeHrvwKJfLxz9lTjD/bKmez+s3Lugdn2Rp1zPSzLXTJxHg/vbkGA0hPimvMkWya/s3XDjI8a4KVO+803Sug+bZGGNHuS62LX/09YRVSy8xErY5nSlvVgcf/4lflXuSZkcNDUIMkqkrByJQwPTKM/4JNs6zieV22W/r2PywOmvii2tT+davUatbWgw9Tm1NXybUdAKUMSbw8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a8Q7wmxvdSjSnSbAxkOAbjT1JQpSJEp7rDarVwxdreE3qtkBRcBInOiqylsl?=
 =?us-ascii?Q?K1djeWiQuO2WwQZnZbHOHkDZ6ya1vy/NCLlKWPf+AwV5OQHVQeqpDY0hT7BH?=
 =?us-ascii?Q?IEJRCOlfsmOTAGv1tYfQ+FL9Vr7gkq8F1OoebFCMS0T1iUL+fcwmnR4sB7yx?=
 =?us-ascii?Q?PE0fNV6EuTRs6ZxvG9br2uQZ1vWgjteg4A4+VFF5PdCtn7sVF8kK6LiYNaUW?=
 =?us-ascii?Q?AcUveKtk4oGlLTe1LeJmiYFJpfUFifA0JAgm4H4dKLgN8VYztSJXjfwgPRjF?=
 =?us-ascii?Q?0sMbq9fswn9VAgzTcwheUbjRdfMO1ra1oJxvKIcGeifzxhEDhKtH6QS/Ovtz?=
 =?us-ascii?Q?MbigG7r4Us6P10KAtZZ0y7SuwaeiTWpGcJuTzwnPkmradY9b+lTouGlZ3m4H?=
 =?us-ascii?Q?ALEMmH+1lRhD1ettszcaYM80YWwpSyRZxsp+8Gyz78dXYa++klvObhgsYLFx?=
 =?us-ascii?Q?shczLjxebkFLaAi9/cilporc8zFBxx1uOE3PztjT0GMjPwBEbCZMfLPwuxs9?=
 =?us-ascii?Q?1Y6p5Tje3OVHeKAQPcdkN8a2S2DCff3xSC93gxJkHBeGTu9/wrPMfZpLQH05?=
 =?us-ascii?Q?Ktr60Zfp1Td3BdICJ75P7O6I11mM15Vp5CURjf49gKXabFWqKEyb1AcZrg45?=
 =?us-ascii?Q?jl4Gh2E6eLiFFhrdMdjsMRS5/adGhd7grFfJdTT+VyVHXWslvN7Rsd38kaUG?=
 =?us-ascii?Q?Sn/+T83T8HcnAx8uccnb04To2U11fcnNvPRRkoaaTPfVBUnTQyqLScPoYpU0?=
 =?us-ascii?Q?ANZWO60ka/0JSeRM+62ItT8C8716lcqhNfpf8aXF9rPzFx+vpDpKBCm6y+in?=
 =?us-ascii?Q?IvPzwzfSRoJmhW345o1mECZzjM9dqJ2Be1kbRFrelA+bbmwld5hxijNKzana?=
 =?us-ascii?Q?tkRmo3cNTvncgrnmHMjcoR2vj8jxXwD2mO76HGCi441w08aIauWKwRUYIglp?=
 =?us-ascii?Q?N4NT7p4IS3n44G0m6H6gpjCR9axGTYt9HWGzfljj9YQQvUvj81pUGsngwjH5?=
 =?us-ascii?Q?qd8/wvUSdr8LwloPkK5D8wLXLgmhfPNktFs3w6wOoD0EcU2CfigtT0516r13?=
 =?us-ascii?Q?IbX+g/s6Yh5qNtJzWDULxUD/X0GWMmokYGF9K6c3Vivotg0GvfukEHPdOh/Z?=
 =?us-ascii?Q?qHmFrj2oOF3HyJnzGgKkBgABgATU+tUm4+gYD9RR0r7dAVg3seGhLcFZ2/hU?=
 =?us-ascii?Q?5ft3qPG37s3N0LHB235Q0sscbRlJrRbWvTUNk9J9c6huHerftrfwUKofiNR5?=
 =?us-ascii?Q?ugi6y/AM3oPNMswZuyjDclDvQoMcoCVEmLq8ZVYuS3k0CfsW9fHXOpYiDUwa?=
 =?us-ascii?Q?vWcLX/7h85rM9ZnAlIWUndqlGjXkNWIsxK1bF7QkOwQ57clqwhKFx467W7sZ?=
 =?us-ascii?Q?E3mtOY8cgyUOPWYfs2d2L8PmcahNk1OrL1i9EODfmDelJtRsxHnPCX1nvNYU?=
 =?us-ascii?Q?uaHtnbVofxU2bWpqzn9Fa5JXHiryGSjmu+BUWc6umjiihN4l+b0q+0hs+1a4?=
 =?us-ascii?Q?LHo/ck7KFqJfn5PTEwGwUNlEfJtV1+CwjA3am1oZvbYI5e9LPSmJnpT0Z65t?=
 =?us-ascii?Q?2K5HaU01+Uq6O/OBj6cKnrc+e0uUpC8/1pXLI+tyAdODbXgUEEhaWZpvGIK1?=
 =?us-ascii?Q?GTjrtZvon9wsMoDqrbZbBxd+H88GG1jd/3k4NUc1rNXvoJECXcC8qgloNTaj?=
 =?us-ascii?Q?eInasEQj0pckpGwjOy2tzp/Ysal0P5HQ/xepjY0KEzYNGvexwGLz2nYxRDTq?=
 =?us-ascii?Q?QyLjWx6F2g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1980dd6c-dbbc-435c-7ad0-08df0735ae54
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 07:58:45.0714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GJYy5EqkFxubjyqYhjd5Ypi3G+IFhNSNq2g3rTe02O3CMPSBYDP8+KikUOVZ0tTvIPwCFK7Pke6vLdj2kNtJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430

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
index 40397bd1bd38..a3be40663381 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5843,6 +5843,40 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
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
@@ -5857,6 +5891,9 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
 	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
 		return validate_ip4_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
+		return validate_ip6_mask(ff, sel, sel_cap);
 	}
 
 	return false;
@@ -5884,11 +5921,33 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
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
@@ -6020,6 +6079,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
+	case IPV6_USER_FLOW:
 		return true;
 	}
 
@@ -6070,6 +6130,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 		++(*num_hdrs);
 		if (has_ipv4(fs->flow_type))
 			size += sizeof(struct iphdr);
+		else if (has_ipv6(fs->flow_type))
+			size += sizeof(struct ipv6hdr);
 	}
 
 	BUG_ON(size > 0xff);
@@ -6097,7 +6159,10 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 
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
@@ -6108,20 +6173,38 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
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
@@ -6194,7 +6277,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 
 	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
 
-	if (has_ipv4(fs->flow_type)) {
+	if (has_ipv4(fs->flow_type) || has_ipv6(fs->flow_type)) {
 		selector = next_selector(selector);
 
 		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
-- 
2.49.0

