Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5C147F784
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192704; cv=fail; b=lHAnUu/8/KkS+dbUoxdFdfU7gL3i0en3Fu2ti4mLCR342mgWLCTEFWUwhd1bCpIVZutGd5CVsfoZVRTlZuWlXI+0NIADw99/1TmlSZj920AfqfmXWqskADY7vUqUIrPgL1GwXQiNR2AU+N7f2kTGrRVU+Z2NpFOTVElT0oW1R+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192704; c=relaxed/simple;
	bh=ZIeBBxBnXbRxNUNci1HziM/Z7uq6u0DV5oPWtf52/vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AfJ25pmed3AFYTEX8Cex/SebQnwf09v37t41YvRoBQJoHk64Fp4NsR2WA8eVELv7hFjncGx042chD9gaP10tifGnV6KSZcZNb8aDgO2KwC8dwGcSq4CuC61GmB3dX1VJgTuH2Wdc1Lffxa6/ZZ7WOBpSZlxuKOEz+ttRITMGgz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Awqy6Yp0; arc=fail smtp.client-ip=52.101.52.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Awqy6Yp0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0JBgUoaD74O4qwZSpWuftrJ41H5JXZSksU1+euw+JkR8hKP4CP6uJ1/wmzpCl/YRSVAmPLXJRZ7VGZbVJsxcMi3rTehCpINbziaabR0eS264KTS3z8sqFtWBf6Z+XK+igwBR8IAmjwoyeErKxrgA9aSZLEE10LSISEuXo2Sih5NWGn6ZPW+M0d213bmgvbQDSsTuPzxzw9alsAFkl3duWz8FiV9BWUaZrKis6mOOpDiTW/dnQSxugPp6wZ6J0TBD+M0HpyZT94/Y+0mj2UiQscdPC643zEswjJd9hxk1y/7nk5MVMiP3SXbp3tMDeWALsv40DKXzsqHGjEydrcI7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjvM537YW2YOmXOz4Sv0+J6kYzqIuaQcHKiooCGuZas=;
 b=e0OVhxomgjpSRO5nwgxOwJfn7CWv7770zDe4Yj8lmNlpCaZs1ADucWRUkqVj5laMdnLpoNgk7UHFsDd2aq8pjZTuTYRFyn3/WPB38YWoeOvpeBufG+jch7YAS6EV22Ah1bbt+Fk38LMRJwQy0CYNJMNAwvvN1EXdEW4KYWD2T1toTX3zB3sZGFjunYQ5GH4kX9DLy/xe8wPWb9OqjcqBul33uZrNMc0vY2KDFHoN+DL5EnT9DLegvFO1HAlvCbvkLPRX770qbFtPcal+dEpXqyTXXV7Ji4oXeP0FKgPdilBhSepAOlWb6PKu0xlhaGo+LrRv3IMZsZ8ZeuLy8mlWQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjvM537YW2YOmXOz4Sv0+J6kYzqIuaQcHKiooCGuZas=;
 b=Awqy6Yp0CfbltJrZBwTou/M9mkQL7Rw/z4SR+xFjv9HeJdGgKXB31wcywXPLvEDTcP+oiwvPTEgQ9PerbL7XhZrY33LLmbJqJtSYPQOCGALwvd1Je6n9TV7ti9wfPVmVyFftz0xeYBSeEpPz1QpuwsfcBSLYEeZW5kTXwcrZ+daudgJN7wYUZ51pxAcoAwcQxOHr4ZOtASD1hU07Uk4p/VD3VwyiXYherH0142sQ9ej1oJ0+V7Fz/nPjHU9qdOUXGhZqa4SCzHokK5XMZcNsWN/ZCy6Jcxzv7VEwlMibI7gF79cIsQGtw8iXqC2oyxdlJAj63wcqfvVBJwusg4qX+w==
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
 16:11:33 +0000
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
Subject: [PATCH net-next v23 11/14] virtio_net: Implement IPv4 ethtool flow rules
Date: Mon, 31 Aug 2026 19:11:06 +0300
Message-ID: <20260831161109.2999926-12-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: f21e2b0f-60f9-41f7-b3d4-08df077a86bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|3023799007|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Wj2GdomPLUIGvkqYYZNtJVqnvJYD/m4Ovmaa17x8fewYHWDNvjbVw4wsggqrkLbMC3IPiSlZxXMoazA7qpsYqoRAst/VSWicZ3mGtHgkO0MzwMvR7N4//RScDZu/jJBrOgZpO5aWKzWBy1DLD7DMFVVvQpXS06mhiDoVQVu8op0/eA0UhJsMo/eNyApoZ4L9bDpWErz5/MuNsVCCP2CX8h8LdGfcqxERIUKQuUIFD0xG/36ZFFhj0AKzLbLSgevAZ/WTIaIwZaiJvOw/eRyrxox4AnppUX5V6pImSwpmi1oRTe3dp6ESfcUURpOVFUUqria0NirUZq4r7S4jXUntIUCJrPSQGKXPA0xB2ziXZtAQQimWnHtsre2LilVlKUdFkhvTQpww6aQ/FS9nip2o9WbFSX51HEMmbEHvlYykluBmHC68bpr9Jgjgoi0Z0ydYbImbtG2gXkP2PGq9r19Ej1e1zbXUnwKbPBZ4QwcX0WkQ7baKS5AZeCjL2l3wZjbXQnBCYW6C5rMvX4VmcYRYpwgVNTTQGiJXHXNoQXKWOQkBfQCu1t4GBI30GMvJ88hOjhy5tojlcSjPZ8mZ7wOEAvj5tmrLhKHuy5zgzjVmZxqXmX70eQYEQ7LSLnXMx4YD25V+mQO4Mzt0Yocrp4q2nvXE6HNbtwAtzZfNZ41Vys8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(3023799007)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OgYt34DPEEp8TLFeDUOhnBCwFGiBt1O8TSJjTbYv0aZTitLFBHbUUHzTdbbC?=
 =?us-ascii?Q?k2cwhTLnEWsAaU5g0yi+o3HubBZamK++SVn9e02e85ylyzlIiH2Iytkcw890?=
 =?us-ascii?Q?nTB/g6GikZXgA0sCRrRWRn/EfzxnvVoKVWdiH+rWij3sGB4L+Mrrr6XxsuXt?=
 =?us-ascii?Q?QMPwnQM0xtgH3SL7tN1jjX44KCgi2N6y1yE4FlyL1WkPIJI0ziOin6Zn/8nJ?=
 =?us-ascii?Q?5aOqN0I11vacTIMzybBKHR1bSSKca+7WKlmP4F1b8eegeJW6VhrCEb24bhV2?=
 =?us-ascii?Q?6c9vLE9aRu3STIHEWlGRcgGf0lEWgHuWg4PHVj1GIg+BXE+fIAwbV0HZii+2?=
 =?us-ascii?Q?CY7+9oz1efaNEsTacjG+AKNGJCNzD72uW7IhJ2EI5EdeMhkopvyZ5fqmFO4O?=
 =?us-ascii?Q?zDUTvvu/IxfeZot1LYzTat8+nkWsD4b71ZDMayagl9JSMa7soBqfi9WsHoju?=
 =?us-ascii?Q?mox0NT7OSXYsV6U6b3jTTLj6JYNcnyJPOyc9tbVVpV0scNCNhJTXQ0FFSfgW?=
 =?us-ascii?Q?yvH4dOSPigK9iHAr5/l0XSenX5fviiKk4pq5KXBGlgIMMlx5LKMimh/CiAAw?=
 =?us-ascii?Q?QNrGL0cIge8AuscmQx7Pg0y9vO6+o1kgm+65C7qb2InjG6Hbvp7uDUeyGzUM?=
 =?us-ascii?Q?5tbGEErAlt0+sqT6WGP7HYyiBMhyzQFiM7FTG3LhXY7K8MgZyP32cnKW1W/4?=
 =?us-ascii?Q?ZUKzuQKtX9awhrmGvYhd+4lLAFwwwrsmz6sAyxHuh1j5D4G4M4cqJsQJEh3K?=
 =?us-ascii?Q?lgZv0ovtRQaFxJ6O9FKwHKLhhkzuPEuFhJCwKl0sty9KA3KIJGjLogdtL7Hm?=
 =?us-ascii?Q?obd8ZTSJ36leyv4eghvOIGCH4yaa2JDXsYLgGr19KauPmSahTIaHjIOVWPO5?=
 =?us-ascii?Q?aRnrQ0CVO8C9cAPPN3oxxbcyF5iF4bqjYAGiw/KB2FW0RL5mUx9uelWyRj8d?=
 =?us-ascii?Q?pD/BbllbyTFrYuEyZXILdY+1sjlHtJrNQK93q7AhESjJBTE3LaRYLxnk2DfA?=
 =?us-ascii?Q?Kh1Z34k+ht4sqXKw0AP6kHnNYDTroLv43JaBgiHI8gk+2ixppLz+mI/uYvVh?=
 =?us-ascii?Q?mtVC6aAEjCQSNrJgFgY+CHskYB3hViK38w5P3Ozt5xcDX5u5oy0qp0mNbpxk?=
 =?us-ascii?Q?DaI54iVhWyKFvbQLaC1DjB/qvUk8iXGz4wCurMFUORsOBlXTsbMSGpF/pTLL?=
 =?us-ascii?Q?Q4iMA8jo+VazNJXTbQ2z6ly84qey5XgaqgnMYyBmhlWWakfScmC4m29RLIfJ?=
 =?us-ascii?Q?GQplt7NBdyoOgw+NSIN3+2o1Ve+l4fLXxigLpr+LJexaSNFW/fOShbFHw0GA?=
 =?us-ascii?Q?pSQJ7JNt/3AHZzCpyD7EvMP+3JAW8VPU1/atYRxLCQbfNKij3hXoSypHWKHp?=
 =?us-ascii?Q?JQYqzLnqPRU51MACQZ7B6yVes4oc+L7L5KGU85Oe8lg21cdpdjFSvrhZbMQY?=
 =?us-ascii?Q?5bmObMK46VOt8nML1YLKeoJHLxbeAe5o8TBT4ZhuO/yDjipi3mlPJN9bIKIf?=
 =?us-ascii?Q?hzUxRna34VTkzSnpPzTn4ERzOzowr6NCl1ifpsaFQoAizkoMB1zrpo6AglRf?=
 =?us-ascii?Q?yytmCW7+EdSuOR4M9xKlcyDfGbBiiRoQPrO7iQ55LACM6Sen/mW4TqdKUKOk?=
 =?us-ascii?Q?RkqobaG77wpLNIG5B97TOttJcgYcO1xd4ep+xNl7Ol5UmwL1FexpBPPupano?=
 =?us-ascii?Q?+YuTVuueMWLKaanNNjAN0M2UJnmoMNn7Q+nv38eEj9xwn+GpCc7NB9oukdwu?=
 =?us-ascii?Q?zozT5rSOUA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21e2b0f-60f9-41f7-b3d4-08df077a86bd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 16:11:33.8720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxBTBHwlOxsdbQlHJAcCD7rhEdF53k0pAs/eWUt4CsCDAc+XRN5GCuBCcjgu5nvgHxrK7Iy+POMlI+vE28EBLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353

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
index 6c07eab047af..c33bbdda7559 100644
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
@@ -5961,6 +6025,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 {
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
+	case IP_USER_FLOW:
 		return true;
 	}
 
@@ -6003,8 +6068,18 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
@@ -6016,8 +6091,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
@@ -6025,8 +6101,35 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
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
@@ -6051,6 +6154,13 @@ validate_classifier_selectors(struct virtnet_ff *ff,
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
@@ -6088,7 +6198,15 @@ static int build_and_insert(struct virtnet_ff *ff,
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

