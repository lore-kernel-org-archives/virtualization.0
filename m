Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A1841D23D
	for <virtualization@lists.linux.dev>; Mon,  3 Aug 2026 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766088; cv=fail; b=AlrZNuOuUeO5wx4+QclUUHg6TmhMwam1OF+nb/v83PkXe7qwiWVL9+0XEI9EE0tgkt+V0ex/UDvOzAA0eaQbQECDvnhgWXbOvbJ60riw8zZbtCCEPjoar/sOEhQEuoiFDzcspZtAW4e/1whsbJE2lJ+UWHDK4B9L9N9VZGvSXoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766088; c=relaxed/simple;
	bh=InCEvwV2smwR2Lo37npMe++tbIsqZzZwn27IueUhZjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WhMKgAC1RdZuDZEmOuH7mNxTyyQhH5hZTtcoCdp2T3oHFvVGCYNl3UL28aatuScO0V92O2OvheV5e6fh11YhkZo8/Q/ltgA4SLYI4A7vtDZQ8X6w7DJrY9r0hOhORarRJtct8L0iUXsSL6XXVi1RV4UTu2ZgCshM1HbM3xTg9Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nRqwLpUe; arc=fail smtp.client-ip=52.101.56.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nRqwLpUe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbTQBOzG+Sn2d4wNpe+JaucApm8JZsrtk0g8MiGK01f6bQLDw4T8nKyV8VcIB653kAy8rX/zGxyIXMuIGS0qttgYcIugPQw3YrgD/am8WYZ6hHn3afNw7CnOq0e7iZLxchwuUCGctn4eYwPpiPtYT+ICkm9tIFzRLslyGTzFWrW1gFfmpWMhA+dwmbZwF+ijjzIwCzvuCvZ5EEblZxOCqURC8HQ9yEf5OJSunfgRkIHKbuwZOqFQaTx5twqO2zN1yBUkBPyL2iUkCV/TyahHo5MZKiH5+36Dj2mZ3PjAtz3y/9Zf3UIsmAT1WoEBZfEH5vefqimV0nUKbxiznRTmsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VG3lqAU5vKX+hWk/BrCOoynfaMCLk1esltoe8q8pWoM=;
 b=lmfq8XBCULfylrfU9GYY8Riw//Ycx0ECC2Ku1wTI+fWWFyo8MX9gy1N2EaakCcGRtVwlhmcFitSuBxE/Eyuhk4xFe7RANhokaJAAJfNsBQbQVIPvrHW52InVUQY6b2Sul30/nMUX37s7+np1XYAFBzxuTtxfvXm3XptSH8By8ncx47HJpPGnJz/QOsMHpUEXcDh+dn3DGv6SE4dih01j8BRvMiwwbYADQo7DGDyyRXM9sU1NoIljNW46eyUCGp4QCDyf5g64Qu0hZOosoxD6Um2onP7xek/pUAJado6QsHterq+p9vADuXP8LOxSvgSX4Uy3tiJndz//QqEedXO5Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VG3lqAU5vKX+hWk/BrCOoynfaMCLk1esltoe8q8pWoM=;
 b=nRqwLpUeuJTkM6+ofgwKnW1MF+NTgAOCxssQsTFyozc9VD/OIv3V14e3AjGOkF5JeF5JI1X06WaKpwCBRCUwJovQHFp47RZWnL/GTtiA/+RIdGL6GQAyzHwMBLNJ7UBsP2O6giVbbDW4s2Jwg0NoAQB+LzMu5f/1D2C1LB6vLtWE8XXIHLtJ2Fe6WeaO7FOZhcZSx9uoyVX1BcTt3lCzu8REx95cJ6SlPuoWdzuSSPzc2mGE72vACu7hh+Yt19doVQKFzrJIEC7uhL7DSnCmNmqSXVDp25bGsJZ0HNEkKK+q+mKCO7Gt0e/1yZPcenLDlzNuyKrroMPPkREcx3HmJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 14:07:58 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 14:07:58 +0000
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
Subject: [PATCH net-next v21 12/13] virtio_net: Add support for TCP and UDP ethtool rules
Date: Mon,  3 Aug 2026 17:07:20 +0300
Message-ID: <20260803140721.1871678-13-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2dc3575f-304e-4e8d-cb93-08def1689eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	lliQNLOUVKGQRoFtWEASFGT4xSr5xR3AhubomXsG3QYGCPCfuJNNnNMcMSaaRqsfM3+WKykNmcqsuyfDZaxZBOU/HRMar306DVm87fSzNCsVQSlzA9DnssMpVZBc3yw8tcZQ4Cixf24o2XPsp9JGUsYFiSxduApF4pI3W0Z1Lft5W+XXVs72aidHmul7a2GpO4Npf5J8NpM5Iz+7VhhA9tE4zvonsNekt+j+RFTgrJGCLzk9sm383mZ3xWsKKGKGDf+mSgs+ardTlM7GQLJ/nTx6wRa4HrzZsGuN63dxwleap54SZogUFPquhzpEv9MdIG2wQS2KVXR0oUEfsuY5OeZDxDqEWBvqnS4NbSpJnczbKml9Z0BWqUGG5kgUfPzzbj9ZpqRY9oYdqDVUSKmhXjOHvm3vitbMltwuYo9Dz1pfzQwrDAv+akpLu27Sk4QLVPT4AbEueuZc9tn68Df+bdpujb29OMU7dc0J4iJogbapGNX+IhAifJjjz/KDvFdFVDXBzpJ33BM/RLfYgDzBLjkkxYOBkJlMLbfePrOKFemPaaHko1BVEtPXk+infhJhSgKnkUrATXyvHn/VrYsZbtIH5IoK8pRk8H5qUgAn7aUFub0ai9qEoOy5uaLuU5dVnJZSNcBBPuyzjEexsSjva6VWODrZZdBvTj/mcKsjeVI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1uBxNprUTnchjJSv5KOA8ZVdRvrTuCthgOnNEUO/eXyP6NYa6p1A5DNvle60?=
 =?us-ascii?Q?K4gY2ojb5it7vMONcF7t407iKVTTWQmTMc2iiKoN2QuNGkK8gwOjA69x3J9T?=
 =?us-ascii?Q?N3L0RpeuQsaMDzM/hbz3+7xSa5klcQuf+wjcuYa4vpYXIc/MGxB68OiYDfF5?=
 =?us-ascii?Q?oNdvylc4lMKr3ZMMbq8FsAln4dZqBbT3VSaaTcNfQ/8Rk2DYHraXC1zzY3Od?=
 =?us-ascii?Q?iL61Q9YAWcDEVYczh0qnmnhr2uZ6+XNhRlRb5RqH+pPLjaQx3V86MlqT5COt?=
 =?us-ascii?Q?6d8xF2uhjFL3w9DZNHR1DvX3+dj20YShuGKppDyJ1bfoEAS2K3OrGGq/n1NT?=
 =?us-ascii?Q?veUMmCxF9hQNk3Sg5yddpACf+KsLqm9czl4OZTnoHrxTWZSM3U61pYjx2oGV?=
 =?us-ascii?Q?bCvwT02OGvGj3/e9CwKg1i2jv1raDzqBJlkVVcvH3xhfa5MQZuX95IiHyP9Y?=
 =?us-ascii?Q?AppugCLx/ZDvsnS3jfs7COUaTSGAKhhxZvo2rqE9ylAdbz6BjNEGecHZ1OBh?=
 =?us-ascii?Q?1I1kSi3OJqBrZXwvXlJsDpnNa46zbKDfOK8sq7fp9D22Enr4GPXngkQ8w2Gm?=
 =?us-ascii?Q?pAWTRGvirZ3m3Iu6GI544g+78B70GsNn0/mfRkkrGYEO5yJMXwFF2p6eZDmM?=
 =?us-ascii?Q?8VzRnXCCsBmB5mN9S7pMihHC/5lqDMChnBcSMo7E3SVtSdkyp5K4xwwaqptW?=
 =?us-ascii?Q?SGOwke6ZdW64yZ5xlaAlmw57r9nmWAu5fVTOCVvhm7iEjLr+5K7KbKV2Zq0Z?=
 =?us-ascii?Q?MBJmLfa7HKoKqrpMyNwQFHnMtKec7MAsLqPsSEAOmlWgI4Vf0xBgJ1/STPcN?=
 =?us-ascii?Q?wRLju9KccY3nVHWVEATEXWRJDkjPtg9DHNqoMUI3OYpSHwzaif7UqZB6eZn1?=
 =?us-ascii?Q?UpRDBRxBcBxaIIRRcd7a5S57DfKxJPi9atDahSZYhnZoII9pMwj/ow1tLeTc?=
 =?us-ascii?Q?7xa0NAWdwShZiic+SwinnKpx/0EUmdExbZxfOjOOSerncDK8PVoCssi8w5Uf?=
 =?us-ascii?Q?owhjqRBRElE2sgETejg+VDxpTriy5ckdFU457/C1e9Z2Zd/jHO554vOxokW2?=
 =?us-ascii?Q?sM1p71Rs9/tlSUyImZvMxsmbvFyuibJdvFda9PCoLGujX5PgmlxO6ixjqY4p?=
 =?us-ascii?Q?oI12ivdoui7hNNsHIX7RYFoir8xpE6W7OOlInqlOP/yPg8jDahovKsp3YPke?=
 =?us-ascii?Q?WmkCR0Ebiatu+92fJu88QNSAnfFd2PH20UEKKy1FEdHlkccQMZW+zxAAqYFc?=
 =?us-ascii?Q?Eo/UEj8huFgp/Omn4YimsSfybIAX+/O/kFBA7S9Sm+TPZF54qH0UBT6ByrT1?=
 =?us-ascii?Q?0kApvTnaS1TUMhhjPWLYDeE7gQTeyxfZAgWYfpZsMK5cyBd4gbs7ywZ1uV5z?=
 =?us-ascii?Q?4S/3/dmmoXrLs9nJWH3eTZH4c0pOfrsbiIWlTejwxBG5Eh1xxZdrwJP/bQiQ?=
 =?us-ascii?Q?xPZ4KIxzo/5KujGiXlDQjRZcBHcvhdxmcH+TEOnR8s1xlhUyBW4esp4QTLSf?=
 =?us-ascii?Q?iv/0SkRaHjHH/fPdIB2wqztPr92aTXAO8os2+jIgKjrab4fGcGh9LNiwgMZk?=
 =?us-ascii?Q?i2OALYlNdGoY6PyHUl8/mItBI6lhF4/U2yIr4D0N3QjK2jA7BoMenp0CtPvx?=
 =?us-ascii?Q?9qCL7Vc44O21pXNd768LjsyBIbEIHoMD8q88R0INY64AV1HKnRNWAbqdI6VY?=
 =?us-ascii?Q?wVq2CcW9vBNRIjCB2lIzNcZwoiDtBDb04UtLaEStpS3fHSN24yWWbz8SQS6e?=
 =?us-ascii?Q?MNJYMKaTqA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc3575f-304e-4e8d-cb93-08def1689eec
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:07:57.9875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +plujI/F7oj1znPrxDGe/fImkqm0lKPbky0vCe/uitimspKRhK7hy5y3IQMOMRDk5RWBI6kpbV9WPX28GqdK/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459

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
index 7750447bbb34..236887c7976d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -32,6 +32,8 @@
 #include <net/ip.h>
 #include <uapi/linux/virtio_pci.h>
 #include <uapi/linux/virtio_net_ff.h>
+#include <linux/tcp.h>
+#include <linux/udp.h>
 #include <linux/xarray.h>
 #include <linux/refcount.h>
 #include <linux/unaligned.h>
@@ -5864,6 +5866,52 @@ static bool validate_ip6_mask(const struct virtnet_ff *ff,
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
@@ -5881,11 +5929,47 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
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
@@ -5927,12 +6011,26 @@ static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
 
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
@@ -6067,6 +6165,10 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
 	case IPV6_USER_FLOW:
+	case TCP_V4_FLOW:
+	case TCP_V6_FLOW:
+	case UDP_V4_FLOW:
+	case UDP_V6_FLOW:
 		return true;
 	}
 
@@ -6119,6 +6221,12 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
@@ -6158,7 +6266,8 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 
 static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 			     u8 *key,
-			     const struct ethtool_rx_flow_spec *fs)
+			     const struct ethtool_rx_flow_spec *fs,
+			     int num_hdrs)
 {
 	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
 	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
@@ -6170,27 +6279,99 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
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
@@ -6230,6 +6411,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 	struct virtio_net_ff_selector *selector;
 	struct virtnet_classifier *c;
 	size_t classifier_size;
+	size_t key_offset;
 	int num_hdrs;
 	u8 key_size;
 	u8 *key;
@@ -6262,11 +6444,24 @@ static int build_and_insert(struct virtnet_ff *ff,
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

