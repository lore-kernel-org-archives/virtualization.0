Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E723CEBA6
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163133; cv=fail; b=OZQxAvvO0ZRbAJY5hcIVMDwGk9/cLr1A6H0mbZcbxrY8s4ermQcEo5xq7HrMwRS5CG9CLEuMb8VewPt4EuMlyISFv3ma3LZBmJSeXrixwki/WVFAXepweS/e2tHLk+CkhcnHFK1AcfuJ1IDTnrjv8bE24QWmTTD1hhENj91SW5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163133; c=relaxed/simple;
	bh=SGmp6YgOfgYJKhpdpYuJumREKpJ7tFyVj5u0dOI0rq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gq0XPPYum/h7Tl1GB0+nhcHMJ2b4Pkian3fpHcexVup+B/te5LH1TZ88ifKMaUFtN8fXQSHPoX07NsG6a9VJyX0Rp89rrB9F+qCVmJfJaNkkjubNzJBVCL/8YtxuwLVybRKWxnkvEmXvWF0/kKfvUuJAC9xzYN+/z5l287X4IP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PAO9Mbyh; arc=fail smtp.client-ip=52.101.43.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PAO9Mbyh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ioV8pIzahe5RDZUxOUfTxzdBX9B45UnYgNu3k9u+58pRQNvoxplQ07aTk92tPFCWWPU06Kq7CWslEYKPNb8m/DsQKJ2sTLCTJDAUmyafP7rWd7pKPRDMek8oQIKL1fuh00YNW1UcLoW7vYV6NDAyzlTw/vxHxyLMIdKTam9B8En+Ga3DIPVBm3V40mqCw6ZK3+/EfMSzLwf0i3mLSaT9KBD7C175oWyDIdsKVoGR6KXWQ2JlQ5MBsGE4RAkXkcvZESV57oAznilwJG+FAs6EBuLUYhAZgcB5Eg3hn36fJKPrk+UMpYYMwxtiZHZX6yjD5ajws5Spj2oD7aqvb5TiBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEuKWP2tXuczxQmLnXf1917tmhVKuYzbsP++gV/x6S8=;
 b=bOqWLTVpVbrIw0MeQCCmoDpJTcHtHqpHbGkxw3GD00b3Ec96lcpQoRos5yfx8Zy+n0p9ZxhqQf8vW4dcLZ6XE2bh6dhgciraPOgep/hDT5Jw4I7yNn85zRMtWohhew+pYiG46fM5zc7D26xC9I2GeCFjbMqO4vi7/zA8P9UtFgZSJWsiiN6fnVokvm+U9exbOb6GjEMj1S3OYUJ3zsfI7m8myP/r1w+hyDDVpZVJav4zR2WopiJhqTCmB1oHpABWXGQjcofU/Wh92uQ6HMcXEzNMvN5ZX6jJxlF3EL04rheY+hYWFYAR8rbCbEU7vryTAvOEtc7WrIUMpURShjYDdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEuKWP2tXuczxQmLnXf1917tmhVKuYzbsP++gV/x6S8=;
 b=PAO9Mbyh78wjjbsOMJegoYO6E/ATMP0UaKWvL3YkWAABqGNVTk8Xm1BkNfWl2VyVUIW9MvrSU4v8+xbBgqMTZUPxm3ncx3Y514BssmLsxdPepIpfnzCjnhJacqw8AvwBp6+QPyT02wNBxRgkFDD9Xrv7LtCki9tzdcq2+Unkuhly7QqbMFLpJwAcze+OTyxKjrKvoU0nTCLWZfn6JpE56mw1vULVejDsw1JksW5kYXs6fOD1FW87CJA0AcSZg9V5PmpAQHUw7EBuHKgLqqLi9+MMwHKwXlbO7WCjPojRBxt6JfMUJMYYPmZ9+3x8H4m3gWbWNhyyHxJ8eiY/OPMKgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 07:58:48 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 07:58:48 +0000
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
Subject: [PATCH net-next v22 13/14] virtio_net: Add support for TCP and UDP ethtool rules
Date: Mon, 31 Aug 2026 10:58:06 +0300
Message-ID: <20260831075807.2891426-14-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: ebac011d-7711-41fc-fde5-08df0735b022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|6133799003|22082099003|18002099003|56012099006|3023799007|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	bvLAgL6VHMFu7SrMRnY8JO0jLKCgDVPRm8arkHvphZpyHr00urApq1QrIXpEAGB6xd5FXTdTnN345Ftm96QkrYeh8Rw8I4tEutMdNfqL//GhjsISIYmmESvakw9PhCkEvR5Fu4whyaV/JbhbLTvBbGnf755ng5+IgL1pSWqseBPHNop9XlHodPx8ezLtlDA3p0LeMvfEdU23VmKQdGN1vzCCsMq4axRDK+mNyEFIsxwJGTSwN9qRLXIjqZngY7Hjl/9prbgQno+2/A8xPS/eKdaOWQCvi2EF61qx4CM9dau+0FWmG+RJyRzAkgKkzlKj60Su/o47TWfbA94dg/xUT8DZmDWcgjLUOapnAmuZr9OX2RuAv4SSul59PnNT3Gq4Ik3S/AKumx7BNWHde5lSYQqOJGWPwAO630gMh/pHexwBk0lN0vP6TEvXbIF4L4fIcbO/JdyBAsA7rMYxSleS91BaP39EGP1XjIXCeL8hFUsS+Afp4Y7JcE58QtE2X62bBVPVzXH/yhj027514CCb4UHaKT+PO4zhmfkykM4pT6mfCZz/XPNPNk7dhZop2S/voz3Tt5JQS8XMBH6HDwtjZeKAlQwE88XbiHHXJC1lNbnXbpnPOpFdvWHOOYdX3y+Roe2inVGAnGbA06m+s+h27litFndgux9EderqV3xVjmU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(3023799007)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+i4AuktrzTe1PoWZL6g0xgUo1s11QTr6iTWr5/FTxT7AoogEmG1WgMU0YUZr?=
 =?us-ascii?Q?4iBNT587sT4j6tyteudyu5dQasRio4S+Gm3LN/VyqYmKkZufskXpu45PcUFi?=
 =?us-ascii?Q?fslSj2MLlI4KQf3dBuJbtCTVh+do6HM7Kwc9OwjXGCkXXa6uzzrjCsAQrucF?=
 =?us-ascii?Q?7IHlMBCh3eHPcFljqls3xNCl+RFGmwovRAiChoTwwREz2kHSIFTEtK2l/yN7?=
 =?us-ascii?Q?Rh4Zw6+vdDsg7mYJCtM7TYABu2IqH1LW1ki7FwZvIntHw38UBy9Aix7lNeZm?=
 =?us-ascii?Q?cByBLFhQkNUUPyxmifbV5kcGDa6CreOQ/aGnBIEsxj/RRu+ACZ+qfxY/gYPR?=
 =?us-ascii?Q?J5JqRGIQbHMYbgm/DlWD+OCW6NI17EVhs8fDm4muT4d6a3SyDMbkmd2yEDb8?=
 =?us-ascii?Q?lCQB1GIi7D4b/sRoeBEKdYjYpqKjJO+8/9vmakhg+AnkHF+AIl0batqs0iuI?=
 =?us-ascii?Q?TkbkAlIzSG/5DgAN4jsDJdGiLCpxaW7/jn2R6nB2M0qoHKGqrxBYF7rP+RJP?=
 =?us-ascii?Q?tzcOl4jHebIqRz+rCUxk0xoGaU/CqWsbHWxtBReiUIRc+7L6JmDNPlVhSwwa?=
 =?us-ascii?Q?WEzwfzPQ3QXBK6XjPxxdsIXeM7L7yI7npptvxW10yp6s9qiC/GOBul3bMcAK?=
 =?us-ascii?Q?Hcnw6Q1Zv6Wl8nBdskiZpu2C8uWVt8PHuEwzsiUnxOUBoeJOaJgHqwlyGSjo?=
 =?us-ascii?Q?RGWIEZaNgzKBjB8ZR6nSy2i/qWCQ+Ud6dnn/voA/gWpxi3/R1E+Aw6Sku2Vj?=
 =?us-ascii?Q?ge2mptRT1niWz/YuHj3LUpdRj+5JLI52QS0CgUQWLlGseM62WPTXNzBJO9KG?=
 =?us-ascii?Q?QPXD3SvWIgDj3rsGX1zUB9jjUPS7n91PoXDdjlTDavjz9lYCOhHRRnHyfeHO?=
 =?us-ascii?Q?QaGA62oWQepHPnXuZ/xl7sq8cfP/Odccg0BIvYvo2IVtNf0PAYwyE5z5tUdv?=
 =?us-ascii?Q?zQdK8Zz1Wamgvb+gkYKdn7ZKuDpiOL0G8RbTukshGPH8G9YFlaX8FpEIIOQ0?=
 =?us-ascii?Q?4KI96eJaFdrolzXS7B36Cga3eYmlFkcZOm14I0nWK84W5/dVxFxhLL9i9mt1?=
 =?us-ascii?Q?GvicIKDvLkDKA6yVkxLC1kxcQbUX0kIfYgad+QWjzfARFT/8I1XzzEbYOdkN?=
 =?us-ascii?Q?p0AnpBf/8/gTVPyFxa4Ou5DS1Kc4KspBHG65L7Ilfhm4tth9ustfdYp8PZ0Q?=
 =?us-ascii?Q?cz4GlYV4Z15fY+lHu8FvP8wbhw6wiPU7CaoAlNSkktSQ9GeTgr70t8TKgpeS?=
 =?us-ascii?Q?OmxYLS58n2UrJ1fVPLgjn1W66+lQjVYQxbAfJQjHTMPGPszh7MNo2stJCvS9?=
 =?us-ascii?Q?ZnfS+Tm7osMaLfHWMNH6YHTrpKME9O+Cck7xQUFb8W2oZ/6wSETDePXZAC2Y?=
 =?us-ascii?Q?bDIaoxuTPqyci9Y0g9UvTTuYrivIVg9lRAorXle9NxyiF7VVSjoObyru2YT3?=
 =?us-ascii?Q?i9/jlf7AI3PP7mE4uvX+46gIAb2bIqStqdbJ8NBouZqtDEOlltqJOzWm0Lwp?=
 =?us-ascii?Q?VyfAMvqmEYtJgdaAc0/srxwZQkSbTP2hF8mjEUBvw+l6nbwVAF0/TKZfg43k?=
 =?us-ascii?Q?s3U7qEisGteZoe4tndTKgb94P3+7EXMybiqZzF7HuS6v4/X88Y65nQ2MvFYm?=
 =?us-ascii?Q?ZIf8Bk82O6mCqNxQ3XfHRzmrFDIj9R1e+C9mTGgGuOaNcGxQ1fmOW89FRd+g?=
 =?us-ascii?Q?QA9voLaCoyrFOhsOUI3M1f9yaOH0mWDbnhWxVuC3lFtV6qDbcoe/oIS3qiQr?=
 =?us-ascii?Q?MAKCepROLQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebac011d-7711-41fc-fde5-08df0735b022
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 07:58:48.0847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LjEThL2bo8ePmJWkDPPjMd1Nl6Ujz6FKMgbyoLmqEsyKGyWxOKBkNvKIBcvkfjwaN2HVweqEiwxpTDcdhSBO+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430

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
index a3be40663381..0bbbc3d33806 100644
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
@@ -6080,6 +6178,10 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
 	case IPV6_USER_FLOW:
+	case TCP_V4_FLOW:
+	case TCP_V6_FLOW:
+	case UDP_V4_FLOW:
+	case UDP_V6_FLOW:
 		return true;
 	}
 
@@ -6132,6 +6234,12 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
@@ -6171,7 +6279,8 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 
 static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 			     u8 *key,
-			     const struct ethtool_rx_flow_spec *fs)
+			     const struct ethtool_rx_flow_spec *fs,
+			     int num_hdrs)
 {
 	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
 	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
@@ -6183,27 +6292,99 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
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
@@ -6246,6 +6427,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 	struct virtio_net_ff_selector *selector;
 	struct virtnet_classifier *c;
 	size_t classifier_size;
+	size_t key_offset;
 	int num_hdrs;
 	u8 key_size;
 	u8 *key;
@@ -6278,11 +6460,24 @@ static int build_and_insert(struct virtnet_ff *ff,
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

