Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012023.outbound.protection.outlook.com [52.101.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402663CB911
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 07:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163127; cv=fail; b=SGz8McFI+RV9HLifzpP2bo4O31JR3P/7xlk/TME3isQNvwG48zBiyXpc2TwCHa2hs5WNYeOa0FnHVuyET593pvufhYnb++m5n/GpXwIEQB+AJq1d4rrNBiDfUT4ZBwQwD9PX6tM8SLtiGzaBwPxBbZlpY4LhCQamKIn7DyStSOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163127; c=relaxed/simple;
	bh=BDS/xB6If4rok93KzyhhUy2k3Y2LqtpB5yqtaQECVbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cgg/YbvmCpoc/00AWl0DyQJVBBCPoqx8M6cKoq83V3fDqzot5/h/Ov+NlkqMNUIbSm/bRpoPiR5uPEWY9kj2yTJnslgwLmaiP1MLXN+6kO6JjmWa6iJ6yBtv2kQFPY4SIDF3n6rWfhyjNl8OHFbp3GB7Q4LmipK3YvJzw7DnsFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jG0TvsKk; arc=fail smtp.client-ip=52.101.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jG0TvsKk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkMf8E6utMv+w/ryHkKVqV0gcNkLRRyQZDz4vdxDcNOfcHei4eIFiMs7087//Nz3PZtdzqrUt201qdo7ePpFW4y13UsvLCgDfzlh04ccgfouRCMJ7alTpYz9INf+rAsCCVgmcR8YMg8CyXmgXpQuXeok2EQaxvSksHGynvtKZFsQg9WhXSUlT/h0oSpEg+U8ynsSQ66u/Ha2iN86xjjsHjIStticpEWXajfc3zghlNZ2h8crW1m096+pr4X3OMgaUovKbS8uwKl37sxuCyTJWR1uBMxoUiKLJbur+D8XK/9MzZ5ah0TVAXLymIVA8hvhIKUTV5ltGmoQJJX3D9waKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0m4JY2G3YC97OK3KPwP9fgjbQdXcaNR9JM/SqFbDZs=;
 b=mnzthg5+fPYgM906dbkDDuRI6DKbVR8VMB/PYm93l1EYxyDcA7z4uHsmUGQFfFQ3wy/zLIu5iYxR4CnBWoprYFcn6A03hHNminK8DVGYK9rJtBd/hAbNDlp5gnVJ26uIM3ljis+KrWHTPO/8A1Gi+Q+n3D0PRRT+eFJBF02Gmi7vAiA9nx4T0hMlDSio/rqv2alur3Zhe1/5EeiF9Ffpw8JOAfl4gm1nTHkFHvBZT/tR6TaVYGn74a5Ul2BAqKZtCQwLuO0NrQxwl0FhJFGHsiV527YealgAW8Vz0o9pgnItHN8F8oG0cPXvt+pEFxHd5NfaI2SGWYvkbIIYXX56kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0m4JY2G3YC97OK3KPwP9fgjbQdXcaNR9JM/SqFbDZs=;
 b=jG0TvsKkwbmeJs724XO/3Fav7ieuHY58Y1dmO2G74hJP+jrox28+d1ffQdu8uH4ZkXeZVbMUwPjPfHTUbDgtqpLvZJMxNxmTV/G/mhIwv2knwsxMc0gC2GmlviJAPbpTe/P1oYPoJD5Vg0PXQh6DEbWp3PUfwFnjvp9+1yobI3lPEWQD440HCN8aJXUdYfQtK081SHdRf7FliHLjGWv2XOyLdIKW4b4T877zW5s2NotSzLloLJm4a04iM5aN3Hajdz1w6XVZr7fQj1NpNwyRWsR9uDp5K7WkeMdir+hdNRwaHyOzMLom1voM6dWPQfooRtU1aK9S6rc51izWmlwADg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 07:58:42 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 07:58:42 +0000
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
Subject: [PATCH net-next v22 11/14] virtio_net: Implement IPv4 ethtool flow rules
Date: Mon, 31 Aug 2026 10:58:04 +0300
Message-ID: <20260831075807.2891426-12-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: bcaa019c-6333-4b0e-c7fe-08df0735ac87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|22082099003|18002099003|56012099006|3023799007|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	T+BOdRUISIjcyaYhy6ArWG3/hTm95QPPd22ACBalHMzIMN6NwIUknp9JCKAc2il4oytsSgcRvrRBB1NpcUPTwMf2T4epu1BWdJfO88YJrkBkILkN7HOv5vkFrgCmaPWXFloqVISqf+gRj8SI+/Zfp+zBnAPc6Dw1oUIK0vrcpWi50rzYxUVJ6qckbB5K0s3UK5bdoxTeIsDJza6sOdS9q041+UFfK+pN3pfs9vq/BOdl4cIN2v4IUFVk7jaw/oP5wJdynBsIUoQJF+EgTdBcTWwRj2nTR2KV72kUPDjkYpLpBG4f7200OA66PrQg8LXf8S1XJcHMLfIY9U8g9ZQht0KLwCTI59gOyhAH5PME5D7IB6/f593uOdcjp6LPGHLwUq4lN2wQv6aou4/vOhdksJEdPIi0Jyyqwtp0aBrxotrtWLIdNLJNyW74JYuBXILd1V+cx1mlLOhufBbRfd8ROKU9OEGsITOsuvxrrLIc1lncLWIGkQthUxLnxLAkTL2tWsYwZjqWXAxwGcI7zYqgG8q1+LLX7qge0m5+VRedq6FSuUe56IZ3hB7dgr6PnaZV/JwjH6FA90s1BZNbfspvuMy29uyKIo2iv7/i15EKrCu5jFoxK89FquLfg+PsBCgSS3ob9GuUPSGjNE/EqhViNjyNGuAhclGzmvBNj+jZ4yg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(3023799007)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FGGZ7t1wYw3gEB+GhFrr6u16Unp6pZWzytJ7LMKL1bvPG+QzIE6soLjsJ3W4?=
 =?us-ascii?Q?KPpJEMkfdiyhsCqleEpSi+Cyno24sROdnwP6hOKhiQ3UonfcGX2JTPuwW/RQ?=
 =?us-ascii?Q?poBwlRfz8xmflT7+Z1K6JuBxdfVxw53mZ4szTI5miD3V66zqwIlwWFP4a211?=
 =?us-ascii?Q?Tasz9lPmWcMWfByNMs7op/RLysUcetRwHIHpScHJtm4wtQ1gfKE4C2UHn/9+?=
 =?us-ascii?Q?i9nqlDOnxCmX7RyTMOeYkCMEjU1XatUf3yE//MiXcWgBnoOBoWeqfYziNLqj?=
 =?us-ascii?Q?S/pHoOP7o5v4m3QVIfSQbu8I/BypVV/BnOZN3U3DWrhrwd+OMA2x7LZCpPvY?=
 =?us-ascii?Q?BXv4qNLXTRf21gXs9a/KmNaTUXIDI0SP5un5hMK6mADixRqdHeS6QHFojF+1?=
 =?us-ascii?Q?02qfL6OVZLUiNRmMxzzhUXm3f2XYG+eq9G2us/OtROkPdT0DVYNqycYOGcWf?=
 =?us-ascii?Q?OUNDSGS1hfmn9fH5FaQYhzplr1G7QxwYJ6XHuGQPHhqXbx63Zs+jubbH5MAf?=
 =?us-ascii?Q?aFVGrVwbYb7fkBadIVOiUU4W3Bvh3Mhrmhw+ZLIzkr7z1ZkIulKs+QOv+iUe?=
 =?us-ascii?Q?ALHhHWOX79UBDyDABOELpMqRgiuWll2XZNhXZ/kflFiphtCA1kJnyvORwtMM?=
 =?us-ascii?Q?Vn6imx2d0zbE73fnNSWIoWiKfEyK0+j1kAHpgyOUeOX1bXJpm+kxmpwO7nQ+?=
 =?us-ascii?Q?onN2Ay50xuGGIZ8RuZK3pO8Mmqh4kPB13lGnxgZ/3Lek7NsbJufA8NY9+yIq?=
 =?us-ascii?Q?r2dl427JjcCCZPw4qH1ky5wGrdE3qLjcbrjwFC5VaFhqtkBo5snZrDTos8w9?=
 =?us-ascii?Q?HYFpy4oOPNY11bBsVEQMNHnk02/5fUljNK5Xc94al/r4g2k3iOMY4zIGDuH5?=
 =?us-ascii?Q?/EFfKcsAIj2qbgnfbx2ZKF6FahqCU6C9U7mwsWrpjwQp/QMUgMVrTOxEYK7E?=
 =?us-ascii?Q?WLrTN66/e+hfHagqmUnrQTXVxjILmttlknTp1YUakne/bJegvDC5MAKflRGT?=
 =?us-ascii?Q?BNThkx5ORIsRbwQO/suRdXYYqlbkY1R+OCK49W16DD0WdJuCxSYl/0GG/Jsp?=
 =?us-ascii?Q?mG7YHoreyLennQIwInsOJgjzV8U0OW3qs4q0UrQsfK5MoiWWvmavHtI+vrWe?=
 =?us-ascii?Q?yBzwKGEKF/SCi3VQ+MSALXF2ewiBPLjnZqlUvUiFOvORRcI+afYRYOPtU8up?=
 =?us-ascii?Q?v/1FEhDoYdckRqF5YS80fdwpV0e4DrvAjp2ZCcF3SNtTFon17yk/rqcGjXJH?=
 =?us-ascii?Q?Hn9UC5m29bGU4IfoTV/xH/7VvphucSoyuzFNUKbHpKFAX2DmPt+S4g8C2TiG?=
 =?us-ascii?Q?Wavn/E21aUvhw6ZEFjrRU310OeXErFx6uic5bsFhKyAjeBIv/v4MsXOMbFcK?=
 =?us-ascii?Q?Pq/ezqeI5JHOoDhj/zH1rFMlV6lrTBADSFF7KvrStLO6TXDVoJIaw8GGwsuY?=
 =?us-ascii?Q?yGsrORManmbXXhn/KVOPtcwSNVtP5J2MgiCDbapJnFbqOi9ptQ3ZlAn8JaTk?=
 =?us-ascii?Q?XQnc2416baExy0bxlBK2SrKPTBl4n7jim6lutNphz9SCuj+JW/1or5uUZnjS?=
 =?us-ascii?Q?z1xZJRhLq03Q3h/yIjP9dBoZ/UVcq3Q+/lLqblseHRn/KO8+sxtGktajWFcQ?=
 =?us-ascii?Q?/G1VmmsA1wVy68tHIY1ayRUiNNHs9IYrvVkJpI3fRYtpcF0SQdEeXPbJIYgE?=
 =?us-ascii?Q?GZn/X9o+6VHB8EAguLSABF6x75xaxORU1Qy6mJYL+cCOR7Q4fdnEWb8yL9xT?=
 =?us-ascii?Q?BtJDR8d7cg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcaa019c-6333-4b0e-c7fe-08df0735ac87
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 07:58:42.0621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7U+PefnrXGK2tuDN0g5PuY/6BSBOOaj44XA4nUMEZoZlFWNawMcY2bPCOMi9SxEb2B+oiMTnlAMu5ZYzx9ArtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430

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
index 72c0f40e7282..40397bd1bd38 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -33,6 +33,7 @@
 #include <uapi/linux/virtio_net_ff.h>
 #include <linux/xarray.h>
 #include <linux/refcount.h>
+#include <linux/unaligned.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -5809,6 +5810,39 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
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
@@ -5820,11 +5854,41 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
@@ -5955,6 +6019,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 {
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
+	case IP_USER_FLOW:
 		return true;
 	}
 
@@ -5997,8 +6062,18 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
@@ -6010,8 +6085,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
@@ -6019,8 +6095,35 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
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
@@ -6045,6 +6148,13 @@ validate_classifier_selectors(struct virtnet_ff *ff,
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
@@ -6082,7 +6192,15 @@ static int build_and_insert(struct virtnet_ff *ff,
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

