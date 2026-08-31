Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AAE480953
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192710; cv=fail; b=uL53zeFgp0vu67ma7wxWFeDCIedHGek6ms2zA0dpIolIBvtYu305fCdavw1AZq3kEtzkpH/Wmj7KSQhr18bGPCsfXWd2T3x5ZJpXj/nmOUUyx9Ir9fLQbqRlO2tVHn905UYaC6hyGskPLLWNgyKwxGiC7kiw5WpmpCghDPfdpP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192710; c=relaxed/simple;
	bh=df3WBi3Pg4Q8VUL1coHc9QLMtq2pKVOj2gsCu1LUEJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uj5RZ6qdKOKErDUe4r/XQqfMarVZsnFSJcHIaIX8D09IOL86i7Ba5oYmK/y+C5UzjBER6KQoMDs5hIq/YGsQAYwTiW667W7/GaUQAkGG1/oMPw+aeA+HWxqti3jsSuJ4c1WWICj7bSU7rzVpR014C/z5NLxmntpaqNqQij1Ed1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ILId3kHH; arc=fail smtp.client-ip=52.101.52.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ILId3kHH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhHTJWm76u1uDx7psYZAFx6WOrA0hIhh6Pvjb0zryf4ntU4YyV0tYEovKwGA9dAU3f+MSa8cSRN71k83sYhJjVunjdNjpl5iROGhldpmUvDz32LgcPDWXOp/67KeGLkv2gGKctcrlTUiHr4DXnf5pK6vCKmvUWGDX45dNur+aCa8Z65k/5NNmf2ie2d+Yfd4WEggZI/XqCbTYCJgsu/1QW/LyQmpHJrb+f0XrAik64RepiFn2qgYy+piejQjEAXXLzZF5Aljoloq9QXcdArMKcsYbEKWmYscfR8oT/IsbQi5UPGFihlQ7D/4e4SYniciuueurml4Y+Qf/M+321rTfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l67GkKmIUYrVoPwKqJozBQIqAMANJcfSAE0v09pQXx4=;
 b=fDjFPcaKsVmq28LBrng93yZRtWjFWZTIjpaBmkFnztyUZKrJNb+SlNVB+xrYxnAED8r2zXI33LSSlTa0bq7IzdOxwh7pDuNSf/R86vrrlncUW/mfbIwrz/frxkEGF/cZWAZTsXx6O3tsvIuFlCADUbwhcH6+YV1VXJMKP6u4Gywn/APmGFQXBCuI4Jit3nYNVklTNr/gJb++5M/t8Eum4n1ZT4Oixb14BK/fIoyzs77WDq9F5zptAN5P87lfNc2ND6Pg4hG1Um/rNGmZpB+m/0SEVpxq7p9nJ2+dvh4sM3oUUHJKwctu9G1ylldFxFkAmyjeCUgamnJHi5qY6Nao/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l67GkKmIUYrVoPwKqJozBQIqAMANJcfSAE0v09pQXx4=;
 b=ILId3kHHA/2fnNpCL/m+6OOfc6/PkUf0uzyrrkavoEytrUzXbuHZOTnoiI+/D+eKNvianE6iOmaxQS+MuDKcRA9bKA2DLuDODYIOo+nTBrRgKMosUCIgqVKlqehJ7SYP2jgLV5bOLnvN3cxzPzLHlsmhe21fQPPjE0FWg9nxD1OiWaXDaNs8VGJpvGdS/iD52Y3fhltMqXBZKMmrQ89T+6AFwpu3C3boNiPmSJtjSlMEPO8dNoB4Tq7EE9DxegmBnO7/qmeShqb/TbSgpQDFhJKQOzCrz6OwqHD9LEiAllSO8/VBauYzMgry1lVsVvA9WtslLXwvk8QfUM91PLJzHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 16:11:39 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 16:11:39 +0000
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
Subject: [PATCH net-next v23 13/14] virtio_net: Add support for TCP and UDP ethtool rules
Date: Mon, 31 Aug 2026 19:11:08 +0300
Message-ID: <20260831161109.2999926-14-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4b1250a2-394f-4156-e6d7-08df077a89bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|3023799007|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BXE2ke0x96g0rs+yht8w/AV4KgrgH1Px3GjrDA38nHu6IkI1HpdjPQViaXNDvq6+BuXyPF24kZazfZu4up2bMjeyLFFWcOy6pbO3t6uVsBt/xMeSNea11Lhsmp7jNx9cQCqTgZvUduufjLPyWRHS7AEDYFs3fD/0ockDdLlQQe1VD6tNuEd4C2BU4z2DSUDOZYg1pCGNOYpcsVeYToLbE04ge+cAOzvrAQjchYcCe2BHzW6KPG6iA3kGVQiuDNb4XPOb8nFiTkD3ntaCfs78IVenZHi7mi68Gbkvfk/ihLl0dlTfzD7ujTuURsckbwuTTz3U/z7VjJwolIteSjlOeHusQ4xZgIE61JUC0Nr/EvV0mpKEIi+PpIVrDOPkfhF1/QSIV35AmoarDbMSYBgFgqxFuwvEyDKUYlvxPYjerne/wYtkrcnuze1rVGGV603RJBQpEEGC2kSl8BGuHGPRPQxSzrPRY1FTu4eQWRufa7uudjy+Zdjo3dsFVW2ejqa+Q41zcdnYYiDzOvi2QEwKH+wEPKsL6w+kpkudbHad7xKVQVdB3C6LPIuexmbR1hAPDn/EZ3y1jVqZwMLY5uQVjmloWRYlVa8uE9J22d1hRCVWnwxo2Ar9tTaSPJ8OAQOw4+UZzKmyCrO403S1awrpliLZSnW6weafGq7gryq3d8k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(3023799007)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N4DkG83+y9tae34iWM3PmbXHAOz0sm45VN3JJZB5p0aeBWb9sYz65gVxblvI?=
 =?us-ascii?Q?OO4u+CSn5ZZCXU848QFdUhiS+DRyLNwM6h3RuYb+egwAw6dy8gdf7pvm1vVE?=
 =?us-ascii?Q?qnBIYVqOlatHILvCz5bY7iCV96UTUhHt8dcH6emrQ0IqSD3Gjrkj2Zbe671C?=
 =?us-ascii?Q?5O9XAWroiv89qusloqGXu5AE0VL8Vn4xt6DqrLU/0i7ULlkNX35OILotsqPh?=
 =?us-ascii?Q?YVgSxUlxpzFK67T0NY0bzZJmoFzv5NFOA+M4uM5bUzWKtaaJAF1QulN04S4v?=
 =?us-ascii?Q?yg8jkTc7bBOnDKzKlZCYKKYDEQK5OnaxKglEnH+2JLeVAhgqJB1g6YvFRZTv?=
 =?us-ascii?Q?OgasOsDP2i/QRMcFDEtzc8GBXlND8iAk9EoqHasKyelYfRDfzlZq/29eBEAE?=
 =?us-ascii?Q?JOLya81O71zzkBR6lGyxvARRSmMTn9V+wCD9JEFES3OkblkoY651nsA+yOrM?=
 =?us-ascii?Q?TieUgWa+qkwwJK93Ld7dELXNT4XybdJie1Zwwnsr4xDKbgAVEadKGj+f9pnS?=
 =?us-ascii?Q?Kpc2y6952TcIMrFFwZsSin8vCQSIKw+0/AL3pjC5HVkyHbRGByR0S5rl2jI2?=
 =?us-ascii?Q?aA45dxGCm2VB3BbVSNa/mQJvgut/BfUJLTWwr1ze4rzM0CfY2O5Y0MbpuYjG?=
 =?us-ascii?Q?EMEpAfNZL94ch5JX+An+F3PlGBxjlva8hOkeW0/7M5v8emUehWWqck5RAJQq?=
 =?us-ascii?Q?Cpq/tx527STVTYTN9XY7F3yQ53q3fSBavZhKEjXwsn+b6nTlwqbhLgRsz7x5?=
 =?us-ascii?Q?W6+zBMTXJeWeYjhiFiIYdgoYF+LkMH+OWPBrOCGrF2vbIj6dVjND6PxN+ZK/?=
 =?us-ascii?Q?VAtla9Z1zIgUH0OQ91ehC5w2NwNisoBRHzz23x1UL9UGzjxREWnZ2GwZUZte?=
 =?us-ascii?Q?NdOka77TUfQDpFSEtmF4dXIXhcp7pQlqgXuPOVWp1jtEZuaZwjk6GiDOE3lW?=
 =?us-ascii?Q?2/WxIVpzTjinuxKZZa9QsHWc5wetQVYb2JRlSVF0m7ywSVRH1el6WdQ/b5bt?=
 =?us-ascii?Q?2IH551x7rgXeFnam9G0lRyld0QH/v6KnpRfLXtJvq5+mTMZWOWJSOLGhIDjh?=
 =?us-ascii?Q?VrtTZL5LfNhnZM/U+5wCn7qfcBNUtN7SABqaJlCvQfTpvnizphx3rQ+NJULd?=
 =?us-ascii?Q?ggRgOxbVgK0qsSJ/sW/RJh4C822wLQMASn3cZxDK2C5X1iRgVSZAlLeI2s1F?=
 =?us-ascii?Q?fwT4HdBagICSf15FCLflUENfrMQcJTbAn82/QSm9MY33z4A4N8HH4ZrWZAow?=
 =?us-ascii?Q?aA84YblcRhDnqkJSYKjVVCJNnLgYK+/c47IhGE7NvHj00VGnPUHeXqFxnn/g?=
 =?us-ascii?Q?jbxEbxJqXA9M4ijnOWnYGBjVZ6qdt6mZFHbox9pOxkDOtzpDIQ4bMt7Fc0qj?=
 =?us-ascii?Q?xpolL93P50bqAjZQOT8BbYVOAwz0TXG2MeMw5t3es2NRAbtkw6SFBpJ9P/uj?=
 =?us-ascii?Q?zHZwe0I1wC5CEZLDJLIfBqvoibjiI23IS6Da60zO4ZavBs2bH5M+rJGCWo+a?=
 =?us-ascii?Q?0MLswxzT/s83Gt5D6O4gsjGnNFUvyBDopwIMYH1BthD5JTfTFYGFhQRTm5xk?=
 =?us-ascii?Q?yOjsba8XXuCDQS78e/pjF5qFkbmQspYF+8jZbn0uSrot6ftQGT/pFtNrmgUh?=
 =?us-ascii?Q?ab3JFpdFKC6r/eSc/RZ4jb7QD61D6dXbmDja/Opp1gxcVplK0NW8GSmK2QUd?=
 =?us-ascii?Q?VJs3VLd+KxuGSaWG2lM1OwBbLPMlhos28vrPBGMRT11AWQz6qPPWevmMm0uC?=
 =?us-ascii?Q?9arkSzbD0A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1250a2-394f-4156-e6d7-08df077a89bb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 16:11:38.9987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93BxZKZZ4PbZpzK86SUdIhrS/2FanOEBRLkuKDec0Xbj/2p1YeKsbzZ6RZgQs1Tir0PVvqFlGrDNWG3sxJ/Ndg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353

From: Daniel Jurgens <danielj@nvidia.com>

Implement TCP and UDP V4/V6 ethtool flow types.

Examples:
$ ethtool -U ens9 flow-type udp4 dst-ip 192.168.5.2 dst-port\
4321 action 20
Added rule with ID 4

This example directs IPv4 UDP traffic with the specified address and
port to queue 20.

$ ethtool -U ens9 flow-type tcp6 src-ip 2001:db8::1 src-port 1234 dst-ip\
2001:db8::2 dst-port 4321 action 12
Added rule with ID 5

This example directs IPv6 TCP traffic with the specified address and
port to queue 12.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/net/virtio_net.c | 223 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 209 insertions(+), 14 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index bfe8f0bc2581..a1e042f356f5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -31,6 +31,8 @@
 #include <net/ipv6.h>
 #include <net/ip.h>
 #include <uapi/linux/virtio_net_ff.h>
+#include <linux/tcp.h>
+#include <linux/udp.h>
 #include <linux/xarray.h>
 #include <linux/refcount.h>
 #include <linux/unaligned.h>
@@ -5877,6 +5879,52 @@ static bool validate_ip6_mask(const struct virtnet_ff *ff,
 	return true;
 }
 
+static bool validate_tcp_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct tcphdr *cap, *mask;
+
+	cap = (struct tcphdr *)&sel_cap->mask;
+	mask = (struct tcphdr *)&sel->mask;
+
+	if (get_unaligned(&mask->source) &&
+	    !check_mask_vs_cap(&mask->source, &cap->source,
+			       sizeof(cap->source), partial_mask))
+		return false;
+
+	if (get_unaligned(&mask->dest) &&
+	    !check_mask_vs_cap(&mask->dest, &cap->dest,
+			       sizeof(cap->dest), partial_mask))
+		return false;
+
+	return true;
+}
+
+static bool validate_udp_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct udphdr *cap, *mask;
+
+	cap = (struct udphdr *)&sel_cap->mask;
+	mask = (struct udphdr *)&sel->mask;
+
+	if (get_unaligned(&mask->source) &&
+	    !check_mask_vs_cap(&mask->source, &cap->source,
+			       sizeof(cap->source), partial_mask))
+		return false;
+
+	if (get_unaligned(&mask->dest) &&
+	    !check_mask_vs_cap(&mask->dest, &cap->dest,
+			       sizeof(cap->dest), partial_mask))
+		return false;
+
+	return true;
+}
+
 static bool validate_mask(const struct virtnet_ff *ff,
 			  const struct virtio_net_ff_selector *sel)
 {
@@ -5894,11 +5942,47 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
 	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
 		return validate_ip6_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_TCP:
+		return validate_tcp_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_UDP:
+		return validate_udp_mask(ff, sel, sel_cap);
 	}
 
 	return false;
 }
 
+static void set_tcp(struct tcphdr *mask, struct tcphdr *key,
+		    __be16 psrc_m, __be16 psrc_k,
+		    __be16 pdst_m, __be16 pdst_k)
+{
+	/* mask/key may be unaligned; use memcpy */
+	if (psrc_m) {
+		memcpy(&mask->source, &psrc_m, sizeof(mask->source));
+		memcpy(&key->source, &psrc_k, sizeof(key->source));
+	}
+	if (pdst_m) {
+		memcpy(&mask->dest, &pdst_m, sizeof(mask->dest));
+		memcpy(&key->dest, &pdst_k, sizeof(key->dest));
+	}
+}
+
+static void set_udp(struct udphdr *mask, struct udphdr *key,
+		    __be16 psrc_m, __be16 psrc_k,
+		    __be16 pdst_m, __be16 pdst_k)
+{
+	/* mask/key may be unaligned; use memcpy */
+	if (psrc_m) {
+		memcpy(&mask->source, &psrc_m, sizeof(mask->source));
+		memcpy(&key->source, &psrc_k, sizeof(key->source));
+	}
+	if (pdst_m) {
+		memcpy(&mask->dest, &pdst_m, sizeof(mask->dest));
+		memcpy(&key->dest, &pdst_k, sizeof(key->dest));
+	}
+}
+
 static void parse_ip4(struct iphdr *mask, struct iphdr *key,
 		      const struct ethtool_rx_flow_spec *fs)
 {
@@ -5940,12 +6024,26 @@ static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
 
 static bool has_ipv4(u32 flow_type)
 {
-	return flow_type == IP_USER_FLOW;
+	return flow_type == TCP_V4_FLOW ||
+	       flow_type == UDP_V4_FLOW ||
+	       flow_type == IP_USER_FLOW;
 }
 
 static bool has_ipv6(u32 flow_type)
 {
-	return flow_type == IPV6_USER_FLOW;
+	return flow_type == TCP_V6_FLOW ||
+	       flow_type == UDP_V6_FLOW ||
+	       flow_type == IPV6_USER_FLOW;
+}
+
+static bool has_tcp(u32 flow_type)
+{
+	return flow_type == TCP_V4_FLOW || flow_type == TCP_V6_FLOW;
+}
+
+static bool has_udp(u32 flow_type)
+{
+	return flow_type == UDP_V4_FLOW || flow_type == UDP_V6_FLOW;
 }
 
 static int setup_classifier(struct virtnet_ff *ff,
@@ -6086,6 +6184,10 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
 	case IPV6_USER_FLOW:
+	case TCP_V4_FLOW:
+	case TCP_V6_FLOW:
+	case UDP_V4_FLOW:
+	case UDP_V6_FLOW:
 		return true;
 	}
 
@@ -6138,6 +6240,12 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 			size += sizeof(struct iphdr);
 		else if (has_ipv6(fs->flow_type))
 			size += sizeof(struct ipv6hdr);
+
+		if (has_tcp(fs->flow_type) || has_udp(fs->flow_type)) {
+			++(*num_hdrs);
+			size += has_tcp(fs->flow_type) ? sizeof(struct tcphdr) :
+							 sizeof(struct udphdr);
+		}
 	}
 
 	BUG_ON(size > 0xff);
@@ -6177,7 +6285,8 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 
 static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 			     u8 *key,
-			     const struct ethtool_rx_flow_spec *fs)
+			     const struct ethtool_rx_flow_spec *fs,
+			     int num_hdrs)
 {
 	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
 	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
@@ -6189,27 +6298,99 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 		selector->length = sizeof(struct ipv6hdr);
 
 		/* exclude tclass, it's not exposed directly in struct ipv6hdr */
-		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
-		    fs->m_u.usr_ip6_spec.l4_4_bytes ||
-		    fs->h_u.usr_ip6_spec.tclass ||
+		if (fs->h_u.usr_ip6_spec.tclass ||
 		    fs->m_u.usr_ip6_spec.tclass ||
-		    fs->h_u.usr_ip6_spec.l4_proto ||
-		    fs->m_u.usr_ip6_spec.l4_proto)
+		    (num_hdrs == 2 && (fs->h_u.usr_ip6_spec.l4_4_bytes ||
+				      fs->m_u.usr_ip6_spec.l4_4_bytes ||
+				      fs->h_u.usr_ip6_spec.l4_proto ||
+				      fs->m_u.usr_ip6_spec.l4_proto)))
 			return -EINVAL;
 
 		parse_ip6(v6_m, v6_k, fs);
+
+		if (num_hdrs > 2) {
+			v6_m->nexthdr = 0xff;
+			if (has_tcp(fs->flow_type))
+				v6_k->nexthdr = IPPROTO_TCP;
+			else
+				v6_k->nexthdr = IPPROTO_UDP;
+		}
 	} else {
 		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
 		selector->length = sizeof(struct iphdr);
 
-		if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
-		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
-		    fs->m_u.usr_ip4_spec.l4_4_bytes ||
-		    fs->m_u.usr_ip4_spec.ip_ver ||
-		    fs->m_u.usr_ip4_spec.proto)
+		if (num_hdrs == 2 &&
+		    (fs->h_u.usr_ip4_spec.l4_4_bytes ||
+		     fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
+		     fs->m_u.usr_ip4_spec.l4_4_bytes ||
+		     fs->m_u.usr_ip4_spec.ip_ver ||
+		     fs->m_u.usr_ip4_spec.proto))
 			return -EINVAL;
 
 		parse_ip4(v4_m, v4_k, fs);
+
+		if (num_hdrs > 2) {
+			v4_m->protocol = 0xff;
+			if (has_tcp(fs->flow_type))
+				v4_k->protocol = IPPROTO_TCP;
+			else
+				v4_k->protocol = IPPROTO_UDP;
+		}
+	}
+
+	return 0;
+}
+
+static int setup_transport_key_mask(struct virtio_net_ff_selector *selector,
+				    u8 *key,
+				    struct ethtool_rx_flow_spec *fs)
+{
+	struct tcphdr *tcp_m = (struct tcphdr *)&selector->mask;
+	struct udphdr *udp_m = (struct udphdr *)&selector->mask;
+	const struct ethtool_tcpip6_spec *v6_l4_mask;
+	const struct ethtool_tcpip4_spec *v4_l4_mask;
+	const struct ethtool_tcpip6_spec *v6_l4_key;
+	const struct ethtool_tcpip4_spec *v4_l4_key;
+	struct tcphdr *tcp_k = (struct tcphdr *)key;
+	struct udphdr *udp_k = (struct udphdr *)key;
+
+	if (has_tcp(fs->flow_type)) {
+		selector->type = VIRTIO_NET_FF_MASK_TYPE_TCP;
+		selector->length = sizeof(struct tcphdr);
+
+		if (has_ipv6(fs->flow_type)) {
+			v6_l4_mask = &fs->m_u.tcp_ip6_spec;
+			v6_l4_key = &fs->h_u.tcp_ip6_spec;
+
+			set_tcp(tcp_m, tcp_k, v6_l4_mask->psrc, v6_l4_key->psrc,
+				v6_l4_mask->pdst, v6_l4_key->pdst);
+		} else {
+			v4_l4_mask = &fs->m_u.tcp_ip4_spec;
+			v4_l4_key = &fs->h_u.tcp_ip4_spec;
+
+			set_tcp(tcp_m, tcp_k, v4_l4_mask->psrc, v4_l4_key->psrc,
+				v4_l4_mask->pdst, v4_l4_key->pdst);
+		}
+
+	} else if (has_udp(fs->flow_type)) {
+		selector->type = VIRTIO_NET_FF_MASK_TYPE_UDP;
+		selector->length = sizeof(struct udphdr);
+
+		if (has_ipv6(fs->flow_type)) {
+			v6_l4_mask = &fs->m_u.udp_ip6_spec;
+			v6_l4_key = &fs->h_u.udp_ip6_spec;
+
+			set_udp(udp_m, udp_k, v6_l4_mask->psrc, v6_l4_key->psrc,
+				v6_l4_mask->pdst, v6_l4_key->pdst);
+		} else {
+			v4_l4_mask = &fs->m_u.udp_ip4_spec;
+			v4_l4_key = &fs->h_u.udp_ip4_spec;
+
+			set_udp(udp_m, udp_k, v4_l4_mask->psrc, v4_l4_key->psrc,
+				v4_l4_mask->pdst, v4_l4_key->pdst);
+		}
+	} else {
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
@@ -6252,6 +6433,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 	struct virtio_net_ff_selector *selector;
 	struct virtnet_classifier *c;
 	size_t classifier_size;
+	size_t key_offset;
 	int num_hdrs;
 	u8 key_size;
 	u8 *key;
@@ -6284,11 +6466,24 @@ static int build_and_insert(struct virtnet_ff *ff,
 	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
 
 	if (has_ipv4(fs->flow_type) || has_ipv6(fs->flow_type)) {
+		key_offset = selector->length;
 		selector = next_selector(selector);
 
-		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
+		err = setup_ip_key_mask(selector, key + key_offset,
+					fs, num_hdrs);
 		if (err)
 			goto err_classifier;
+
+		if (has_udp(fs->flow_type) || has_tcp(fs->flow_type)) {
+			key_offset += selector->length;
+			selector = next_selector(selector);
+
+			err = setup_transport_key_mask(selector,
+						       key + key_offset,
+						       fs);
+			if (err)
+				goto err_classifier;
+		}
 	}
 
 	err = validate_classifier_selectors(ff, classifier, num_hdrs);
-- 
2.49.0

