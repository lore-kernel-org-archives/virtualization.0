Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013065.outbound.protection.outlook.com [40.107.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112B63CAA25
	for <virtualization@lists.linux.dev>; Sun, 16 Aug 2026 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786882934; cv=fail; b=acqueiKOPSYqXD12AYzSlRuTiNJwbs+K1lCVTbdSYRguxl5zKLLR9m51Juh6QvCk+ynO79uPFNz+An4u94/ypxHQhFWsTLyfgJt7hZbNDfO6WKIUukgRqcF7qybL5ZozDCs/lvFnXHoHEG43HTxxsMOgjfzcuWXIcHU8RIUyxb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786882934; c=relaxed/simple;
	bh=CR9HIhKkr8RdhJZzj46SX+0G4TdA8cKhNdxvp10VVSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BHRKSq2IuWUBIscStmR/pCTAeQyjk4TR4hPvly1wnZxvwnyHp70V2UQv5KA8OPrGVdggRqoZKuGh7rfKEImAI/jxsWABaI9SNBuTYkN3E96hYB5KUDo+wDo2lhy24Deo58fCe4K9lrv08qbAuCDiZ9juki0zVRx143cNBx7taOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BHuHt9xv; arc=fail smtp.client-ip=40.107.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BHuHt9xv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BsYe3qJzWzsY4f5azK3UOl4FUwi2xGIJmD2KjqwNqOsXJ7xqso/FiILXd355HdHICNrkb/pZ6GFELFI1CsRTtE5Jen+LQbe+1PWHW8GaeAbtCgvwhnrBvsx70vIfYUWO1AGHIeVu5gNih3toalgk33U1ZDlmOyBGBRSpuADqQc3YPixyrEtS4e3dy3FFDa677g4BEBLp92IdpaZfS5Sjknk4ITDZ4V7j0bpLgWEAc+aKydnkCF1y9Z7dhV+jjRfuM3MGtTG5tINAvaMg/4zmZNPVKkxwMq1DmmpavqAf9oJqMlprEzrqc3Dofs01kfk9eHZk41SEXPvPR3febNW/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agk/FSG7KifmpahEQyS43UYyQQj3aw4Bp4YOwpbd224=;
 b=FLUo7wYfa3gbf4flMwE/9rHeFVsaxPkbHMliTyySmXgBIrKGgtZiCErW1zH5CqYjneAg9xrmn3ReTSQAWuR1vlgmYdF1In/kADk5ltCaaQrY1qHEQfVyT6B8IpCsPXUJgJDU/L9K0isMc0J2MLVCIe1TSHX03c5epljEhxMrmF5yv8otOJYbpIgt6G/RbKAXok0HtHdzRf5iEvRb/bCV9WgW4w4xZf48e3374Ggr/iBm6V/rYfHOR5VBJPcVDu3u+6aDpVnyo+u2elf/VAfDDxWgsXSx9c94yNACEBa50z51tJU/UOjuwKv5t22WuOIXIRKx6HJ0u6C5ms3a/CaqUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agk/FSG7KifmpahEQyS43UYyQQj3aw4Bp4YOwpbd224=;
 b=BHuHt9xvz2HNgJahAd5/Xn904XTnirPF2XnKPmmMFCwkNr0B/EddEhEQI7nnshO7tnU7FFf5YSDYnYZ53kaBMQDTFEbkeEiQbjrtlnsILAFBaZp9fr5+H98j9cchSkGcQCNI2+21wDYEMNTYDSU3sXXcV1iDl4axFFR3Y9cT9th/ujxiqA+LVub7d6WM/J+XaSnsTVEuoqvCCGQo8S5zeKEyj+LmLeHRRfzDU7+xhyJQwsQdKpoZai9MuiQkLbJB4MiN58rFtIHhy+MmqW4kz3vS8K/gRopouJsWgSsFpND4jAXcaamvKdGbbd9uqkjAuKRe4y98dRgk4+d0IYtj8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 12:22:07 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 12:22:07 +0000
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
Subject: [PATCH net-next v22 13/14] virtio_net: Add support for TCP and UDP ethtool rules
Date: Sun, 16 Aug 2026 15:21:10 +0300
Message-ID: <20260816122111.2495240-14-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: e727f770-b2f0-4dc0-7984-08defb90fd56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|3023799007|18002099003|22082099003|11063799006|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	lDDtqjLc02O7X61pGYoqOLu4brepjDXMZqNH8G42NJzJLZJMiyiWB4hgcR6YKkm+DK4MYlXhvOVlQGzG1SS6x6fFAABfkG0KA9SRZspGnDuv/H6lcDmONOr46po+Al0hywyd2ZwRiEBkFMQL+szcomVDdpoyWr9ykGxrSybQOOXUcxtwW9WNh7966r+rF78mSFlg/6rOVTGSUkGTbQ11by5keC8ndLKF806iBqVUV8GS31u7Ncw8rWSASb40wOZO2yzxIf4uvM/vgL/L07pIGS7/5gAJBgJr/OksdowXV0gaerAeOf46v+rDq2tva+Iq5L94+k767BDV+pUgtxaVFUAdNS/AVa6WnjpM3/5qAShHiYy8jK45ufbSpJBMrjeZ4yZLHom3xcvIwvu+AvvuT5x5pOPxN5PF8xVfMD2BN3XL4FhxLOrs9uUlm+NynqlrhXJtCOdfZP4tIpf4hS+OoGr7/h+ZPh3FM+VsiZT+knJGvXfGUAp+xxWLfDI3aY1htPouBAWFlSNDdeLldBH1CXNRPSDYPEC2/1+ebRwUuXwHObohx70JXtZ3HRJ8a+Qdz9XVb4AFckMiBQ5JOfmULU7mnjkQPa6vbrimfkPAn+USBb6G98l/GHdsVA3UXAwueayik1MUZEZxri8E+ZylusCzFaFIPh+t03IqoYX2fh8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TlFb7Z5iD7+iUkL4Jv62fOUeLWymVt3sGB1MDuv2/OSeNcozDmlIUrkdfxMl?=
 =?us-ascii?Q?A4OPk1yJOAPMOsKWttDp4tHULxGRQznvVZewcr7HEJQAZxfp2pUMNWBnhhIO?=
 =?us-ascii?Q?Pbp0G0htQPHOJ8JhKgXl+K87y7uMBTmz5mcCsx+DFOg4sYV2t+XAalhihcUr?=
 =?us-ascii?Q?mImiFaoFIitNpjKUAP/Ysy/U1Cb2kjlKkm7K/SYC7zjdC7mp/y6fn17jdQOh?=
 =?us-ascii?Q?CrOzEPCEU3Ky3OkHbylSEld9sthQS2v2W3ndMzRvbFHCuOrtk1mnN10THKJw?=
 =?us-ascii?Q?7J9sJnUYq5KyWmTsK5oJv5jfgsfRqamw0okC5FTyyX62OvAX2dKZV6Vi26i6?=
 =?us-ascii?Q?2EPl+JRXz2cz4jk8VYbBrXE5zJpzprdZCRHQydFl/NiWpDmeone6Yfs+vTEV?=
 =?us-ascii?Q?SsT+1L0WJZEKzHjeAJfE+vJ1DAwgas0xpA79di3x0/EZuem/ocAXwaIHI20h?=
 =?us-ascii?Q?r9kVJ4KwjYr7tEfiwwYMFfSJzZO8R4ve9KCucko3keOH10qAhFRvg5Q08Qeb?=
 =?us-ascii?Q?DSaA2UwFOA+IxKgEZe0S6s5LDIapVdqtbvxsW0BvcnN5/VGQYKXjQb5KXSV4?=
 =?us-ascii?Q?7Bn3sDE/e0aaFsNeGPWZdX52z35bAXv2EIiiyAQRdvwh8hYO0rchd+lrkMsn?=
 =?us-ascii?Q?6l8di/SeE0elPC5pIq3v38enmz2LQQ21xSOrJICS2NMkG36tDL30E6yoXVnY?=
 =?us-ascii?Q?A3EYRsb8zMRysEsdkzGm2cJ0JXAS4FWnt5s87stwcru4lStllVUFTQwWcuTd?=
 =?us-ascii?Q?+s4O0HO0nYgzd/GvLPodJq7jmgv9GnxB7UVbdCThcThcEuLpd3nlrUq7XQIo?=
 =?us-ascii?Q?L2dto1yj62Zt/xGiVeCXelU2siAlklQ3VOH1HsDvMf47P2JSqW3M+cookUKy?=
 =?us-ascii?Q?aAc6KvUZ0/kuD7qDUdLRlhex7MJuUIZqpyO+ipHSRJkPlIAHwKwTsyb0GdtJ?=
 =?us-ascii?Q?cp01ZlWK+gzm5Khf1WOwdhtDw7FO+JVUhg9gPcSS0Yz70fGuug9oIh0ksKdR?=
 =?us-ascii?Q?f0dSPgw35JM/y1wSynUBkN5mPjF11hr0XjynvUUdU3E1guwMeEAG3P6EK5Yu?=
 =?us-ascii?Q?lzS2P+a5zBsGkWtTTsLQAlQbuYXF9izxrjlsfnmDdNTV7nrf4Oq45DEzwOeG?=
 =?us-ascii?Q?wf4fFdApDT7xG0Mk1O/faW/OxI2rkUXrDCh2CKi4cso7BlFFJox/CQ0LloXp?=
 =?us-ascii?Q?jT0S6pR/3lPdyyv+qculmmvnYKYirnQfPZ8M7QJAPTkc5AR6kS6HGPQFDtny?=
 =?us-ascii?Q?qks9zd41YeWFpsoA5vJuNswGfe2Ul+yEghYUInIt5a5YxmSxK/7vYd3s9pAn?=
 =?us-ascii?Q?x1u3JOsZk3+oU6sxSdmtlXoH7nx5qRAviVxX9pol8MdldMFlP9unarc2+9ax?=
 =?us-ascii?Q?EUwJ1dnLtTMWJvFCmS9v4/poJJ2m3wf7piTSiEuH+36TxA+D7REtc3PtrUfS?=
 =?us-ascii?Q?IzF+RdLFXp9H2soXvOcT/CHqIxkD6vpza8/DrtwLg35KZBdq71eNVcjd/PyV?=
 =?us-ascii?Q?xyf2o8OYQLIcYtOAj6NvVMLY2dqPjhUoqIDnkwL9DxdRblWBrSQWI5uEBfkK?=
 =?us-ascii?Q?I+50z1VSsinZkQJQ+WucsvJIiA18Z4A3Xr6P6LpQneANGD2GTLGpdPYJrdtL?=
 =?us-ascii?Q?K+TKqvRxyX0OqIDbzOvSaUhWN8bgRQ+ZjCIVtjif/z14E5dvXFraft7aZLf3?=
 =?us-ascii?Q?lhFDkxkcXRJKGF7/66FHFxeMfJ3Se7tK0G6fgFznsO68tKAohe4yl2Icyfgy?=
 =?us-ascii?Q?tizwBxDhzQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e727f770-b2f0-4dc0-7984-08defb90fd56
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 12:22:07.8963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tn5zkWNrdr5Ffce2nnpp0dRxXdRxdPNxqUSxi/G6/oarSckok/zIWMw1Lg5XLH4krKdQbrA+nQInul0g2SHwKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573

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
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 223 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 209 insertions(+), 14 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 110b2fc6680e..6cabd53481b8 100644
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
@@ -5863,6 +5865,52 @@ static bool validate_ip6_mask(const struct virtnet_ff *ff,
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
@@ -5880,11 +5928,47 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
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
@@ -5926,12 +6010,26 @@ static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
 
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
@@ -6066,6 +6164,10 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
 	case IPV6_USER_FLOW:
+	case TCP_V4_FLOW:
+	case TCP_V6_FLOW:
+	case UDP_V4_FLOW:
+	case UDP_V6_FLOW:
 		return true;
 	}
 
@@ -6118,6 +6220,12 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
@@ -6157,7 +6265,8 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 
 static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 			     u8 *key,
-			     const struct ethtool_rx_flow_spec *fs)
+			     const struct ethtool_rx_flow_spec *fs,
+			     int num_hdrs)
 {
 	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
 	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
@@ -6169,27 +6278,99 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
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
@@ -6232,6 +6413,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 	struct virtio_net_ff_selector *selector;
 	struct virtnet_classifier *c;
 	size_t classifier_size;
+	size_t key_offset;
 	int num_hdrs;
 	u8 key_size;
 	u8 *key;
@@ -6264,11 +6446,24 @@ static int build_and_insert(struct virtnet_ff *ff,
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

