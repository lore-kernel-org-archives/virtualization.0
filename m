Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5762347FB1C
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 16:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192705; cv=fail; b=M3Il5aEnHSGB7Q3yjEQ3+oUiS7l9YJ9GVY97dIjMiKNzNCKtN4wWcBOwlRxVCioXdK7zUsQlLGLdO5VzInJ2/6WeHbOYyxeuvnwftTB2Sr2Regcm+ihmZWlECq8W0LOhDb3Sh+U1JV/6NAw3pamDVYp6QASH8TdSMVTb2CajWPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192705; c=relaxed/simple;
	bh=ntcTIp5QWHkhMnRRi0zH1vP5L8auIM5tQJEoHXAhPn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F7TnyMl/N17ypXqmR0WvX99kl8NXMj4pS1lGR+duhJw5jFyK1KINLUek2e8LacWD4np8Hm8vxZ2VCWbR690Kl4yjNqst+vOAO9/Ln7389FSwaioCAbG+ERQNCfSlGC0cvRsGOKST0yQp7Cx6U6/ogmZL48uJ88PtUm+vHvW+0Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c8TqT/Zc; arc=fail smtp.client-ip=52.101.52.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c8TqT/Zc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtpicR9gikrG0uNtikzzU/V60EJPcj2hZROF29M/GV6cv+s+ykNpwGVhtGksT1SZ0KLDbvgMyfuro1MN5P8QLQvCrGRiCVogXH97i5Z3wkdtMVG0WbdxKgIvRM7zEAS2G9pkxElFu4h4kFFZAh8YNPL7R54sH0FmNVGU+kp6HgV0XTUNziD3HfN+2UXLyeRuEddXVi8u2TOppUBB2Jeuv87ox8790CsvahBLb/MgSFjJVw9dj9CKSNzQKZRx3lTddlTPjU9RxUA11GrWOznpAHyI0yccbyILeOjOhnHzhResmwoCbFLjwXuYCPrlnSFEbSf2H7MxftAhtqmKZYUI5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgJCeBr1kxQWmMdcKf6xre5slYMn4J4JuSUeHudDtHg=;
 b=EAClbnQfTgE9KI4nhDZgZxkhMa6pZhe2K8aLii/IRcXX0rNg3+858/TTz3jO3Nuz8Yf4C5wpkogdYOSNXcykWBR/TYkejs901FblMFVOvsvar3/bzJzKdk6ngpxIqzfB5vUTjijZcCTJUD4nCjhd494LMXc4Yblmyof9Y8JN6YEyKwGsQRoKAoHl1NDw4zgoXVgcZjGC6Ij4oSekG8dw4Pntm+TZeuiV+Cdt/9ZBndMFrHJcsy1KSiVKCKyJWbzunC925wCUu48y0gKODRkRBOM4aGrReOBaTYDiVN/EHjzaRXSUYjQwuO9XSoqPQxblnO3CPxFaDoaE08Qx3PMrVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgJCeBr1kxQWmMdcKf6xre5slYMn4J4JuSUeHudDtHg=;
 b=c8TqT/Zc2dFBq1h917WM4/Is76X0U4+8IfrNLYRihXWp7TQ6lPE9EvwXZZn0fyzH2tKoRtfh30ggd+56w8bY7bsjI8FGcVA/nANnHwUZzSDuiLYCTisTdI7cwiaqSma8xvtx7o2o7QMG09tSJpBGwzmXDsqeJj7XkIevkpmvYp7IdH2RzfZXAHP1+r7bIITb2EGX/fcaXZU5+61ZQcvS0V/tlJd+26/F2NVnIFthPAhfY4KZPm2rEJxD5jIOA+qVy8nqd2xB2n8ue9RxZpH0LmNzeToMiz7qmJwoG2Pw7f36qf+Umes+5AO2dKu+/df6qINTnBg/GkLulo3zJ1b0BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 16:11:36 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 16:11:36 +0000
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
Subject: [PATCH net-next v23 12/14] virtio_net: Add support for IPv6 ethtool steering
Date: Mon, 31 Aug 2026 19:11:07 +0300
Message-ID: <20260831161109.2999926-13-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: ae841923-343f-4eaa-c86b-08df077a883e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	20X0ueaII7M3bAVGrnusTaTQ2fY4L4BhxxkTHsCPukhdAmajqjMwCZLRmUzDFGHzKpKPtI+Lwa/DcmGV12FyUDwudLZvo5Pchfybop8u/XORBHykLegUpqwZdjGpAFN1z7r1jciGcVibJPIsK6THSKLhnxJw/49ta3tZwQ+GyMj3q32m3OObjz6jpdRBCcXXuwCH/mkOHZonFti74p5FlklPL6DgQfWkVWj363QSSIrDCsyrfMZb+tdr9+pq1GVE0CK9aFZXOm6+ZMrjpjNuEigP3kf/tCxGZqiDPBofogBrUKkiOPppBcc7zWDrPjkt/mEh5Na2L5CwYwHQm5drVm5hOJvvTHPthgoHFl7/YiES9lH6QQCFi5TN/Vub9BwztTyepu/MExWBZD6A3YNQF6XyWTIl/7CQui3cQxfeBNaGwRmb4EiDKtJBMVcT2hVwoPvp974Mxn+pax2/M4Q+qDvQ+NIR16J1fHxs6czYuWVyiT3EbCda1rq2uMwvt5NkYz0bvUQsQHA17KhFlP30GioUYTAUhkVwxKz+ZoGN2n4f+hNqvxCWk7PUA6LQovwGtFO/aInL3IMl4DhNHk3a8YqQ/83fRdtMiqAMJX1R4Tri3jXCoNcjWxbLpGxahIHVCNgPEK+ZG/2LaQujoweFyz8hE9rtr4E5VoIINnrYVxU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5O6xqa5Aix6umtsFxktnsiYBetXkFs35bquCc39pNQMcD3XGArBJGrI/qJU1?=
 =?us-ascii?Q?ULJ2hypX73Zy3K//BD+lB1nGmvGUm+gEvpDYKAVGMQl2lDnNi+EuF5+GR0/9?=
 =?us-ascii?Q?hUT5wY68XLhuiSWyIH5mZ04TivhKUAOKcxp5XDuOWrUqN3teICk1lUJvGH2w?=
 =?us-ascii?Q?/jJgIJBYA+VEbNyxYfrNBplBlSjZwoqYM59ugLXqGXafju4pWREd/tFwU4ks?=
 =?us-ascii?Q?ilbllhmOBtEglfboXnAQF6i9adt4Id/dzYyfcO8EmgGo63beXPXz2rDTqxgi?=
 =?us-ascii?Q?rS4MVx6IpCFTERzbUsrC6gkQt507OMoHToJ8VcEjm4fia554mMc6J8KKKJyP?=
 =?us-ascii?Q?ZG8AEO87l2iUm+uq1wB+gpiy7eNOEFo9ETWzxp8ytOFKm+U1a8UW56yxo7KI?=
 =?us-ascii?Q?/H/yIn2m/m4yWoZGHzxwTE17h13tkeeOTwzgvplgWl2ugjUsyUB6cQjsoIGX?=
 =?us-ascii?Q?JRG4GuvOnlotzvYm2oniUA6bzB66CCXfPBCXyAbnPKCvXG8Ihu2XiT6xkmI4?=
 =?us-ascii?Q?xQ7wHWDSa85nX0UfBtCZiSAp8XIoQKCMcX3CRxs2xyoZ39QM+7SMM/sPtu2O?=
 =?us-ascii?Q?JWLOYid1fiTsuLOZcbRi8ysU+128bk1HVs6rVPUPb1zW+8C1mSkLxsGUfFOv?=
 =?us-ascii?Q?f0d/UfZosJ1WfHUqnI203fYdnszwG/rXH6N0R0gLZjVddII8sfwZp/IvbvGI?=
 =?us-ascii?Q?AM++gkbnvMcofqibqJcTlfOfX+TdaXVXa7oP5Et8Y2JQ7xgPNyFnvJpIRYgF?=
 =?us-ascii?Q?MrI9ACjO/zG6JXfBcWU59CTUaYWETC6vGk8h2g0RCWFw6ZcqRhbkwLafCi0k?=
 =?us-ascii?Q?KXtI6JoEtDxXp1Icjmhn6BfYxJeb3PJbX0//7NswIWueeRNTRwPSjVrLNdmK?=
 =?us-ascii?Q?LGvpuDs37mQX9+a8kgzqBLu/OEafM4PVZERVEWYG0mPTMGO7PBa5sOCF7hiW?=
 =?us-ascii?Q?bzzB7QetYv26+Wxkp473MWHot1HgRt4MGa6hqPMAd0AKw/bvxx/p/icRwdXV?=
 =?us-ascii?Q?Ll0ZgBdpHuVeISksptnvHnMBkwJ91YjTPyEkkrrTIYDPdxl29hgAJv6W/z3K?=
 =?us-ascii?Q?+097dMEstoqoXbEfyL+3dZJJsGWX44GU46ffQDuQPPME/4q8z9SLfuW/seYU?=
 =?us-ascii?Q?TlVK6nKcLPJj2kaOhlXvK5edKOSwUCO49Oc1r9Lfrcki1L6lfzCh1CRGGouv?=
 =?us-ascii?Q?HkcoNGLyZMyr22/z2cYR+eKn/i/RgW///wbK/tz6Vtt7E1R3Qp8f6vAzpqn8?=
 =?us-ascii?Q?coGyUFlR1lGErPUSxwhr0ztuVIOfD5KZhXIHWxiqkOE0WCoFbMHhTEC49Ezi?=
 =?us-ascii?Q?Bb01SQS4QHwc7ksSVIPgn+B9K3mQjSG2Y2oW7aT/NBVmax4+mvJjl+/q7Ass?=
 =?us-ascii?Q?Mme5Y/kDG2fYDTrvI0Pj6X9esoSG+Ke/Io5lI8ZWWRU9uCj4r9crQ5uNEegM?=
 =?us-ascii?Q?b6XJvm0n1BudTSFLzO2hOi+Xh6tBKFpaiCPnpxSOOp+ZcdgI5VI+Y3DIkxxk?=
 =?us-ascii?Q?aoCntYGtmYCOSIv7zTjZF4Nok8h1CCfWyq4jcH1qq7SZ2KB/mgIECpvKSfhl?=
 =?us-ascii?Q?FLzTDStf79fl6EyAFhsyNErudv0aytzzI0t0sdlf7UY3jAcPgADtiepY/5N2?=
 =?us-ascii?Q?tA9sN0SiplbmJphEY5KfGn6/ZqyfP/IRJKwcP51l3BIf2HYhpOEE0KDeyyOa?=
 =?us-ascii?Q?bw0a+yDwXUuOiIqtRg1+5G4i20YofqSn2UxZa4Xsem2G6pJIirCeNaykMpuM?=
 =?us-ascii?Q?+gOG+LDssA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae841923-343f-4eaa-c86b-08df077a883e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 16:11:36.4148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHeUC3ZS1smvcZLXwS2hvqMZ/r4FjyB3TpJV2XrWyFBGaq0XPdo/r9gXaPNRlzktRrV+wz+/M30blj9A1k4ShA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353

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
index c33bbdda7559..bfe8f0bc2581 100644
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
@@ -6026,6 +6085,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
+	case IPV6_USER_FLOW:
 		return true;
 	}
 
@@ -6076,6 +6136,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 		++(*num_hdrs);
 		if (has_ipv4(fs->flow_type))
 			size += sizeof(struct iphdr);
+		else if (has_ipv6(fs->flow_type))
+			size += sizeof(struct ipv6hdr);
 	}
 
 	BUG_ON(size > 0xff);
@@ -6103,7 +6165,10 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 
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
@@ -6114,20 +6179,38 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
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
@@ -6200,7 +6283,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 
 	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
 
-	if (has_ipv4(fs->flow_type)) {
+	if (has_ipv4(fs->flow_type) || has_ipv6(fs->flow_type)) {
 		selector = next_selector(selector);
 
 		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
-- 
2.49.0

