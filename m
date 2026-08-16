Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F7D3DD846
	for <virtualization@lists.linux.dev>; Sun, 16 Aug 2026 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786882924; cv=fail; b=NBAGRgM4gYGKl92MIZ3Nu/frdAA/HYjPgY6xPDPa84Wcs3q/pozjKshgjW4tYBJoS+Ov9aK5y1svq07XQB4fjSWKyzkggg1syWXFQO9KUmQ7RBZoI6G0shpb+eT22NMNfF06ZTbLw31uD41MoBAreXUQSkT5ZzJrH4pjtn/4wUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786882924; c=relaxed/simple;
	bh=P+xxXJqfHDnY4U5s0G36F+6YGhZ8kl1rb4wWZs8Vx6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gnh5CEW16hBisLsP6U6ADjzqoZYZ9AKz+2kBvtptL9lwc6rgzyGZ2i0iicKfh3v+9QiHPh7j3e2Smqyj9kiO5n6X7NL5KgP5GtYU+JHljl0UYCElJjerw58jW/0sFYD9KIiJ2PfD/4vzb6OMkkBRW41wZ0B1AbaNB8mI208MfFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=joBkT0f0; arc=fail smtp.client-ip=52.101.52.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="joBkT0f0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtsfEGwaLFTB1Qyypy4nlQcMWx6fIEfkjwAPWIQYClrNL1TYkqDnq6TpZVfEKX+jkxap046sZhd223M2RoCj7uXH2vVpoH0kIOpcRWItflPR/P0e7As9tvm+wRQ4PTZrPN9cMYmwi15lcyAz6aUL0GkK5XSXH64sxZzZen1crJQ1juaBUSbwgKZC4cGN6bgAwUi1EMfdyEM/A/ZV+oiGUrzdS/9rO1SwBVyg0n7PAYDHlAxsS7ipgueQXL+bljTgvdbTGVjSI3zdsujB3/RNbmbN8pvY1KtjAoC4ymSYaI1iPgY55q0vEJJWIziBmMkje+RKQD1Wp2THJkullhq7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Azb8RgR4ZbLSAsSRr/BDaulHXOAHu3NTWj7XAWGMXw=;
 b=oMLMKn8S/WUVVg8ytDXSgD7U4jBwL3c2ad/37yUN/cq5LVrLJSurlFG6xsWV2duv2ZN7RIIp8tCbnLmM77LFCoO9OzMbj2HVRIC5aG+rfwEyIwxbfvilDGNvb+EOpNj7Fm/beT+yVdInlHxeNeNtmJ+s135+UgDB2oUi26ZoRYv0TEDegElwxk7fT8hca3HOaXLsocjY/oQLvCNgPNtu8rbiRzxdvqX8glUC/H3TA8Of1ngQaAKXORftXQA9lTY54IGwfTGmrpiHSp0K2eqBp55HPQq7NQMBSib0sFslMm3RYxHI9ukkzZtJ1IruIcLJd5qpxrv2pj/LjmaMKA2Xlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Azb8RgR4ZbLSAsSRr/BDaulHXOAHu3NTWj7XAWGMXw=;
 b=joBkT0f0gW0uWKnN5YWKR3yd1mOfbHqmkMqlzmTuQsHT1rLCNQV8o6iUlBiR4vfHlsho0rYIdfzkM3UIEXHcszb2p5OATOtNphOYhoEjRHF0erBQa7YVkLZjG9KtXB3Nj7aDmQ7b234lLI3YgVgVC1khGzs/LJIvkp00vIvM8hHLKH4K1KmrDs1u4gRxCSX/MTnkgq0JoK/4MvXmOAw4NWC1Udo8mWB+QJ7TeuTGHA0AyGwrj751PaBjj7Ql4d21Dt2TrVDypOIkPTv78gBytp9Go8Vn2ip29LjCaYdj3gMulgP2goOWKTBVlWokPsLG+4/5vbAGF6IfbqPM4a4UfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 12:21:54 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 12:21:54 +0000
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
Subject: [PATCH net-next v22 09/14] virtio_net: Implement layer 2 ethtool flow rules
Date: Sun, 16 Aug 2026 15:21:06 +0300
Message-ID: <20260816122111.2495240-10-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: ca52b37b-7081-402f-a365-08defb90f573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	Lvqrp5mgSIIzKEKr1v/YdKp7hZ7rBQjri6sW0Po+R4tl3m+PFKLDPxeZJirPFhJkxzmcZFQNCUDr8DXjojtuUP/Q4UUzry0QJbkTDPn/tuaWCkbJXCeL/HNfS31i8qNLNInIKeXzwswR4GwVSSLaRP6BIrfZPsBfBoVLupivSJ3zgSW9lF3kB3VfMLzyo+MOFdq2yL7jfEv9ApwDx71rg/yVibKdqo8yKD4bU8/MZJWsWpNCnymPQKCIHLtpDOpl69EUdERLV/l4IxeOCytXRfjZ42+hs8iIbLVzi/kmuhyl6VI3lcmHcsegeCA/RX5GWdYCkwS9MCP8AIXWKfXM+hP9V/UrfEPc5dXG1WB5M+aST/mmqWYnCSaDMReRH9wWCoD/pMMbJBDfCCEz6jKuGRDteC943xfT5Iyf2iaJY48Vu83Vd17vh/FjuTR6D7EIY2ciNjNDwk6M/gJgKUE9pOKi40fHVKNn2sI8shiCamLYxAGuH2j4zRWxxxqRBabYF25jP/tx0gjZw0G5B1AVQpMXSwbIELYSe2iVrlIZbVeExuUS5IDBQp2fCOWNCc4tYvi2RNjGA5Dtv4eT98Dorr39qWqa2cUn0p/BdU1GdEQbAjJRx41LPlQ1DYXrZdbEjcPD6eFPOABstN0RYUw8dq+B6l9ii7B8LCWQn5L8Yc8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kZoKDzeb3Mrz7vJ4Cu/MT8eSKH8ECtWXTRmnsgbktl6tmskJqFuACJRlES7E?=
 =?us-ascii?Q?QRo8qk2//D60chsl7PwcfS8apMKWFvH9rCsEKF6hqho4KORdTuH5E3Iuj5ca?=
 =?us-ascii?Q?ytUTLd7LZT44Phr1t027P3NYAri43LfZs+Q9zMr+MNFMxILxCWLUanG5wlX9?=
 =?us-ascii?Q?9l33BGXK46btwK9c8JuBFat1/+YlS+bB3AttCTNAvaMLvtYK7bboeOMRv0XV?=
 =?us-ascii?Q?nHWXtyHd7hGXwxJ0G4vzgEzyJvDb3fKkPdU/5v0sPsLmXMm93sHaM9w0hgRy?=
 =?us-ascii?Q?fBsTIBXlF5w9bgt6+X27xNVrau5qjz7Vr9hcvdN99VGb5HcsbpyVZMztqzFL?=
 =?us-ascii?Q?+IfnbN2dfnsi35MD/BdeBUxoISF9goBpghvTC3oZUxB/dg8V0cq/xa8hlNZ/?=
 =?us-ascii?Q?TVIXmkYIBat2dE30mqhKuyKBp60FPryNiVyitMoqC23TXMDs7cU9zu7mecuU?=
 =?us-ascii?Q?5pGLzHNIINdAAC1R5MANoeS1F55tj8Mr9daGujoDO63EHVbq+aKPO1YC9VM/?=
 =?us-ascii?Q?rc7Zp5cXNHQ/yM6BkhSGVmj4D1IPEzD0s7QpSN7nrEy0fNmhccj73D93bkPl?=
 =?us-ascii?Q?xor8KRz4GSvPezA2t5Q4Q8242z9kEljb4Jzzuk8BSYT4bdI1KsdFON8y5Es0?=
 =?us-ascii?Q?DIyGX+ZVo56qi/9HvJoL1l7MrYN13tOvKmejuxdleC7+6o4vrKXYD+5cOcEy?=
 =?us-ascii?Q?gFkNB0iI9U03abw0gfzxDhAJ/Un+RWC5lOVU1fbHvpKh45MRM2NP+1WUw+Bt?=
 =?us-ascii?Q?VkPy5qMaGVHPl10OjDLuNDTlTlGjUCewiYRbwB2hdbvdg7OS9lYhwVSHOwrF?=
 =?us-ascii?Q?OiZoQcwcNpHuTjnGVj/AjusGewjbDTmlHTDYoY4F2qQ/MdBSRXrIE+Ml6PAy?=
 =?us-ascii?Q?loW6AaDyt76Iw9uP2jtSAQgHudOj6T2T092cE1dBgp4bYzpnK2/trPSfpRoP?=
 =?us-ascii?Q?xzsJny93uu1wDV5taG2mvD+gRHUOmZxWcEgoeyErbPiIRL5zybRv8w8haTh/?=
 =?us-ascii?Q?jPr4WD9h3Pkx98AOisajpdnI9VPEH+24XDfvDr+8BAPxQX7ruTTDBqD4y5eE?=
 =?us-ascii?Q?elICzC4PaJq6itBlCEHtHf8s1aRILXdaPfs9JW4KOGLlrdLa3VQHM5BfjhwI?=
 =?us-ascii?Q?5v2306ly0XEexVma/ab10aRkPO1B9xECUc9XrZVWdPXJW9++FAgytzNJk+lx?=
 =?us-ascii?Q?zXAJ6W8VWiAVvwY+kXQKzTr+fw/2k+YDk4usvW7A2Jqvi1z3NmulT1M1VfYq?=
 =?us-ascii?Q?egr2yLl2ayR73Pqkv39YPRqHa1+uhRZcnot32yTMf/SsZ1DYU/P6kWpYjB+x?=
 =?us-ascii?Q?gmYl6It6y8Bt1cyj8filJPwA7MFQ2vVbqBHRUnPm2b3czDQIvSDQiY1Nu3VZ?=
 =?us-ascii?Q?IE+Jfm2ifHU8nItBIOZaCdj/S4bzcce5fhlYKa5s+F0+9AyRjxJNrEJ7UoUV?=
 =?us-ascii?Q?LGUq8agHwwRb0xqQOr01vf4JW8blzo6EcvYU2encUaMhjm8BtoTB2yTZsB4q?=
 =?us-ascii?Q?FiGIjcKirNw9NfyGMbwmRK/dF94ituxkoQ3m57jIeERIaZEyq4OPKnitTm+C?=
 =?us-ascii?Q?+Ad0GbxkKRNFOBWVp0LK8dhuG6HgWJJxZ2A4VR6Ykdk7LvKnC0ZGfU+dmluP?=
 =?us-ascii?Q?FcOmh+TMxS29bukd2SfiNwExsQINKuUxojqxv/oyH0DfjiLQoe8WNKTOO6/W?=
 =?us-ascii?Q?DCN7hxvKLFpo/CeO4WCvIkYc2UklRSUQMQy1rSlbanffCzo6u3Db2jzRANOi?=
 =?us-ascii?Q?w7xPkZHrCA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca52b37b-7081-402f-a365-08defb90f573
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 12:21:54.7253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2d0cxUs6yWCEfhwhzACGNMVMLusnzBlDWU8C7Pa1CRoAVrGfJzSteKtPE8sKQN15dE9U21uSBZ5KheRcJ2rZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573

From: Daniel Jurgens <danielj@nvidia.com>

Filtering a flow requires a classifier to match the packets, and a rule
to filter on the matches.

A classifier consists of one or more selectors. There is one selector
per header type. A selector must only use fields set in the selector
capability. If partial matching is supported, the classifier mask for a
particular field can be a subset of the mask for that field in the
capability.

The rule consists of a priority, an action and a key. The key is a byte
array containing headers corresponding to the selectors in the
classifier.

This patch implements ethtool rules for ethernet headers.

Example:
$ ethtool -U ens9 flow-type ether dst 08:11:22:33:44:54 action 30
Added rule with ID 1

The rule in the example directs received packets with the specified
destination MAC address to rq 30.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c           | 523 +++++++++++++++++++++++++++--
 include/uapi/linux/virtio_net_ff.h |  50 +++
 2 files changed, 545 insertions(+), 28 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1029742b19f3..eb2e5e92c786 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -31,6 +31,7 @@
 #include <net/ipv6.h>
 #include <net/ip.h>
 #include <uapi/linux/virtio_net_ff.h>
+#include <linux/xarray.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -286,6 +287,11 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
 	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
 };
 
+struct virtnet_ethtool_ff {
+	struct xarray rules;
+	int    num_rules;
+};
+
 #define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 0
 #define VIRTNET_FF_MAX_GROUPS 1
 
@@ -295,6 +301,8 @@ struct virtnet_ff {
 	struct virtio_net_ff_cap_data *ff_caps;
 	struct virtio_net_ff_cap_mask_data *ff_mask;
 	struct virtio_net_ff_actions *ff_actions;
+	struct xarray classifiers;
+	struct virtnet_ethtool_ff ethtool;
 };
 
 #define VIRTNET_Q_TYPE_RX 0
@@ -5605,34 +5613,6 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
 	return vi->curr_queue_pairs;
 }
 
-static const struct ethtool_ops virtnet_ethtool_ops = {
-	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
-		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
-	.get_drvinfo = virtnet_get_drvinfo,
-	.get_link = ethtool_op_get_link,
-	.get_ringparam = virtnet_get_ringparam,
-	.set_ringparam = virtnet_set_ringparam,
-	.get_strings = virtnet_get_strings,
-	.get_sset_count = virtnet_get_sset_count,
-	.get_ethtool_stats = virtnet_get_ethtool_stats,
-	.set_channels = virtnet_set_channels,
-	.get_channels = virtnet_get_channels,
-	.get_ts_info = ethtool_op_get_ts_info,
-	.get_link_ksettings = virtnet_get_link_ksettings,
-	.set_link_ksettings = virtnet_set_link_ksettings,
-	.set_coalesce = virtnet_set_coalesce,
-	.get_coalesce = virtnet_get_coalesce,
-	.set_per_queue_coalesce = virtnet_set_per_queue_coalesce,
-	.get_per_queue_coalesce = virtnet_get_per_queue_coalesce,
-	.get_rxfh_key_size = virtnet_get_rxfh_key_size,
-	.get_rxfh_indir_size = virtnet_get_rxfh_indir_size,
-	.get_rxfh = virtnet_get_rxfh,
-	.set_rxfh = virtnet_set_rxfh,
-	.get_rxfh_fields = virtnet_get_hashflow,
-	.set_rxfh_fields = virtnet_set_hashflow,
-	.get_rx_ring_count = virtnet_get_rx_ring_count,
-};
-
 static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,
 				       struct netdev_queue_stats_rx *stats)
 {
@@ -5728,6 +5708,438 @@ static const struct netdev_stat_ops virtnet_stat_ops = {
 	.get_base_stats		= virtnet_get_base_stats,
 };
 
+struct virtnet_ethtool_rule {
+	struct ethtool_rx_flow_spec flow_spec;
+	u32 classifier_id;
+};
+
+/* The classifier struct must be the last field in this struct */
+struct virtnet_classifier {
+	size_t size;
+	u32 id;
+	struct virtio_net_resource_obj_ff_classifier classifier;
+};
+
+static_assert(sizeof(struct virtnet_classifier) ==
+	      ALIGN(offsetofend(struct virtnet_classifier, classifier),
+		    __alignof__(struct virtnet_classifier)),
+	      "virtnet_classifier: classifier must be the last member");
+
+static bool check_mask_vs_cap(const void *m, const void *c,
+			      u16 len, bool partial)
+{
+	const u8 *mask = m;
+	const u8 *cap = c;
+	int i;
+
+	for (i = 0; i < len; i++) {
+		if (partial && ((mask[i] & cap[i]) != mask[i]))
+			return false;
+		if (!partial && mask[i] != cap[i])
+			return false;
+	}
+
+	return true;
+}
+
+static
+struct virtio_net_ff_selector *get_selector_cap(const struct virtnet_ff *ff,
+						u8 selector_type)
+{
+	struct virtio_net_ff_selector *sel;
+	void *buf;
+	int i;
+
+	buf = &ff->ff_mask->selectors;
+	sel = buf;
+
+	for (i = 0; i < ff->ff_mask->count; i++) {
+		if (sel->type == selector_type)
+			return sel;
+
+		buf += sizeof(struct virtio_net_ff_selector) + sel->length;
+		sel = buf;
+	}
+
+	return NULL;
+}
+
+static bool validate_eth_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct ethhdr *cap, *mask;
+	struct ethhdr zeros = {};
+
+	cap = (struct ethhdr *)&sel_cap->mask;
+	mask = (struct ethhdr *)&sel->mask;
+
+	if (memcmp(&zeros.h_dest, mask->h_dest, sizeof(zeros.h_dest)) &&
+	    !check_mask_vs_cap(mask->h_dest, cap->h_dest,
+			       sizeof(mask->h_dest), partial_mask))
+		return false;
+
+	if (memcmp(&zeros.h_source, mask->h_source, sizeof(zeros.h_source)) &&
+	    !check_mask_vs_cap(mask->h_source, cap->h_source,
+			       sizeof(mask->h_source), partial_mask))
+		return false;
+
+	if (mask->h_proto &&
+	    !check_mask_vs_cap(&mask->h_proto, &cap->h_proto,
+			       sizeof(__be16), partial_mask))
+		return false;
+
+	return true;
+}
+
+static bool validate_mask(const struct virtnet_ff *ff,
+			  const struct virtio_net_ff_selector *sel)
+{
+	struct virtio_net_ff_selector *sel_cap = get_selector_cap(ff, sel->type);
+
+	if (!sel_cap)
+		return false;
+
+	switch (sel->type) {
+	case VIRTIO_NET_FF_MASK_TYPE_ETH:
+		return validate_eth_mask(ff, sel, sel_cap);
+	}
+
+	return false;
+}
+
+static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
+{
+	int err;
+
+	err = xa_alloc(&ff->classifiers, &c->id, c,
+		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
+		       GFP_KERNEL);
+	if (err)
+		return err;
+
+	err = virtio_admin_obj_create(ff->vdev,
+				      VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
+				      c->id,
+				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
+				      0,
+				      &c->classifier,
+				      c->size);
+	if (err)
+		goto err_xarray;
+
+	return 0;
+
+err_xarray:
+	xa_erase(&ff->classifiers, c->id);
+
+	return err;
+}
+
+static void destroy_classifier(struct virtnet_ff *ff,
+			       u32 classifier_id)
+{
+	struct virtnet_classifier *c;
+
+	c = xa_load(&ff->classifiers, classifier_id);
+	if (c) {
+		virtio_admin_obj_destroy(ff->vdev,
+					 VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
+					 c->id,
+					 VIRTIO_ADMIN_GROUP_TYPE_SELF,
+					 0);
+
+		xa_erase(&ff->classifiers, c->id);
+		kfree(c);
+	}
+}
+
+static void destroy_ethtool_rule(struct virtnet_ff *ff,
+				 struct virtnet_ethtool_rule *eth_rule)
+{
+	ff->ethtool.num_rules--;
+
+	virtio_admin_obj_destroy(ff->vdev,
+				 VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
+				 eth_rule->flow_spec.location,
+				 VIRTIO_ADMIN_GROUP_TYPE_SELF,
+				 0);
+
+	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
+	destroy_classifier(ff, eth_rule->classifier_id);
+	kfree(eth_rule);
+}
+
+static int insert_rule(struct virtnet_ff *ff,
+		       struct virtnet_ethtool_rule *eth_rule,
+		       u32 classifier_id,
+		       const u8 *key,
+		       u8 key_size)
+{
+	struct ethtool_rx_flow_spec *fs = &eth_rule->flow_spec;
+	struct virtio_net_resource_obj_ff_rule *ff_rule;
+	int err;
+
+	ff_rule = kzalloc(sizeof(*ff_rule) + key_size, GFP_KERNEL);
+	if (!ff_rule)
+		return -ENOMEM;
+
+	/* Intentionally leave the priority as 0. All rules have the same
+	 * priority.
+	 */
+	ff_rule->group_id = cpu_to_le32(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
+	ff_rule->classifier_id = cpu_to_le32(classifier_id);
+	ff_rule->key_length = key_size;
+	ff_rule->action = fs->ring_cookie == RX_CLS_FLOW_DISC ?
+					     VIRTIO_NET_FF_ACTION_DROP :
+					     VIRTIO_NET_FF_ACTION_RX_VQ;
+	ff_rule->vq_index = fs->ring_cookie != RX_CLS_FLOW_DISC ?
+					       cpu_to_le16(rxq2vq(fs->ring_cookie)) : 0;
+	memcpy(&ff_rule->keys, key, key_size);
+
+	err = virtio_admin_obj_create(ff->vdev,
+				      VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
+				      fs->location,
+				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
+				      0,
+				      ff_rule,
+				      sizeof(*ff_rule) + key_size);
+	if (err)
+		goto err_ff_rule;
+
+	eth_rule->classifier_id = classifier_id;
+	ff->ethtool.num_rules++;
+	kfree(ff_rule);
+	kfree(key);
+
+	return 0;
+
+err_ff_rule:
+	kfree(ff_rule);
+
+	return err;
+}
+
+static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
+{
+	switch (fs->flow_type) {
+	case ETHER_FLOW:
+		return true;
+	}
+
+	return false;
+}
+
+static int validate_flow_input(struct virtnet_ff *ff,
+			       const struct ethtool_rx_flow_spec *fs,
+			       u16 curr_queue_pairs)
+{
+	u8 required_action = fs->ring_cookie == RX_CLS_FLOW_DISC ?
+			     VIRTIO_NET_FF_ACTION_DROP :
+			     VIRTIO_NET_FF_ACTION_RX_VQ;
+	int i;
+
+	/* Force users to use RX_CLS_LOC_ANY - don't allow specific locations */
+	if (fs->location != RX_CLS_LOC_ANY)
+		return -EOPNOTSUPP;
+
+	if (fs->ring_cookie != RX_CLS_FLOW_DISC &&
+	    fs->ring_cookie >= curr_queue_pairs)
+		return -EINVAL;
+
+	for (i = 0; i < ff->ff_actions->count; i++)
+		if (ff->ff_actions->actions[i] == required_action)
+			goto action_ok;
+	return -EOPNOTSUPP;
+
+action_ok:
+	if (fs->flow_type != ethtool_flow_type_mask(fs->flow_type))
+		return -EOPNOTSUPP;
+
+	if (!supported_flow_type(fs))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
+				 u8 *key_size, size_t *classifier_size,
+				 int *num_hdrs)
+{
+	*num_hdrs = 1;
+	*key_size = sizeof(struct ethhdr);
+	/*
+	 * The classifier size is the size of the classifier header, a selector
+	 * header for each type of header in the match criteria, and each header
+	 * providing the mask for matching against.
+	 */
+	*classifier_size = *key_size +
+			   sizeof(struct virtio_net_resource_obj_ff_classifier) +
+			   sizeof(struct virtio_net_ff_selector) * (*num_hdrs);
+}
+
+static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
+				   u8 *key,
+				   const struct ethtool_rx_flow_spec *fs)
+{
+	struct ethhdr *eth_m = (struct ethhdr *)&selector->mask;
+	struct ethhdr *eth_k = (struct ethhdr *)key;
+
+	selector->type = VIRTIO_NET_FF_MASK_TYPE_ETH;
+	selector->length = sizeof(struct ethhdr);
+
+	memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
+	memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
+}
+
+static int
+validate_classifier_selectors(struct virtnet_ff *ff,
+			      struct virtio_net_resource_obj_ff_classifier *classifier,
+			      int num_hdrs)
+{
+	struct virtio_net_ff_selector *selector = (void *)classifier->selectors;
+	int i;
+
+	if (num_hdrs > ff->ff_caps->selectors_per_classifier_limit)
+		return -EINVAL;
+
+	for (i = 0; i < num_hdrs; i++) {
+		if (!validate_mask(ff, selector))
+			return -EINVAL;
+
+		selector = (((void *)selector) + sizeof(*selector) +
+					selector->length);
+	}
+
+	return 0;
+}
+
+static int build_and_insert(struct virtnet_ff *ff,
+			    struct virtnet_ethtool_rule *eth_rule)
+{
+	struct virtio_net_resource_obj_ff_classifier *classifier;
+	struct ethtool_rx_flow_spec *fs = &eth_rule->flow_spec;
+	struct virtio_net_ff_selector *selector;
+	struct virtnet_classifier *c;
+	size_t classifier_size;
+	int num_hdrs;
+	u8 key_size;
+	u8 *key;
+	int err;
+
+	calculate_flow_sizes(fs, &key_size, &classifier_size, &num_hdrs);
+
+	key = kzalloc(key_size, GFP_KERNEL);
+	if (!key)
+		return -ENOMEM;
+
+	/*
+	 * virtio_net_ff_obj_ff_classifier is already included in the
+	 * classifier_size.
+	 */
+	c = kzalloc(classifier_size +
+		    sizeof(struct virtnet_classifier) -
+		    sizeof(struct virtio_net_resource_obj_ff_classifier),
+		    GFP_KERNEL);
+	if (!c) {
+		kfree(key);
+		return -ENOMEM;
+	}
+
+	c->size = classifier_size;
+	classifier = &c->classifier;
+	classifier->count = num_hdrs;
+	selector = (void *)&classifier->selectors[0];
+
+	setup_eth_hdr_key_mask(selector, key, fs);
+
+	err = validate_classifier_selectors(ff, classifier, num_hdrs);
+	if (err)
+		goto err_classifier;
+
+	err = setup_classifier(ff, c);
+	if (err)
+		goto err_classifier;
+
+	err = insert_rule(ff, eth_rule, c->id, key, key_size);
+	if (err) {
+		/* destroy_classifier will free the classifier */
+		destroy_classifier(ff, c->id);
+		goto err_key;
+	}
+
+	return 0;
+
+err_classifier:
+	kfree(c);
+err_key:
+	kfree(key);
+
+	return err;
+}
+
+static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
+				       struct ethtool_rx_flow_spec *fs,
+				       u16 curr_queue_pairs)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+	int err;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	err = validate_flow_input(ff, fs, curr_queue_pairs);
+	if (err)
+		return err;
+
+	eth_rule = kzalloc(sizeof(*eth_rule), GFP_KERNEL);
+	if (!eth_rule)
+		return -ENOMEM;
+
+	err = xa_alloc(&ff->ethtool.rules, &fs->location, eth_rule,
+		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->rules_limit) - 1),
+		       GFP_KERNEL);
+	if (err)
+		goto err_rule;
+
+	eth_rule->flow_spec = *fs;
+
+	err = build_and_insert(ff, eth_rule);
+	if (err)
+		goto err_xa;
+
+	return err;
+
+err_xa:
+	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
+
+err_rule:
+	fs->location = RX_CLS_LOC_ANY;
+	kfree(eth_rule);
+
+	return err;
+}
+
+static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+	int err = 0;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	eth_rule = xa_load(&ff->ethtool.rules, location);
+	if (!eth_rule) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	destroy_ethtool_rule(ff, eth_rule);
+out:
+	return err;
+}
+
 static size_t get_mask_size(u16 type)
 {
 	switch (type) {
@@ -5746,6 +6158,50 @@ static size_t get_mask_size(u16 type)
 	return 0;
 }
 
+static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+
+	switch (info->cmd) {
+	case ETHTOOL_SRXCLSRLINS:
+		return virtnet_ethtool_flow_insert(&vi->ff, &info->fs,
+						   vi->curr_queue_pairs);
+	case ETHTOOL_SRXCLSRLDEL:
+		return virtnet_ethtool_flow_remove(&vi->ff, info->fs.location);
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static const struct ethtool_ops virtnet_ethtool_ops = {
+	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
+		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
+	.get_drvinfo = virtnet_get_drvinfo,
+	.get_link = ethtool_op_get_link,
+	.get_ringparam = virtnet_get_ringparam,
+	.set_ringparam = virtnet_set_ringparam,
+	.get_strings = virtnet_get_strings,
+	.get_sset_count = virtnet_get_sset_count,
+	.get_ethtool_stats = virtnet_get_ethtool_stats,
+	.set_channels = virtnet_set_channels,
+	.get_channels = virtnet_get_channels,
+	.get_ts_info = ethtool_op_get_ts_info,
+	.get_link_ksettings = virtnet_get_link_ksettings,
+	.set_link_ksettings = virtnet_set_link_ksettings,
+	.set_coalesce = virtnet_set_coalesce,
+	.get_coalesce = virtnet_get_coalesce,
+	.set_per_queue_coalesce = virtnet_set_per_queue_coalesce,
+	.get_per_queue_coalesce = virtnet_get_per_queue_coalesce,
+	.get_rxfh_key_size = virtnet_get_rxfh_key_size,
+	.get_rxfh_indir_size = virtnet_get_rxfh_indir_size,
+	.get_rxfh = virtnet_get_rxfh,
+	.set_rxfh = virtnet_set_rxfh,
+	.get_rxfh_fields = virtnet_get_hashflow,
+	.set_rxfh_fields = virtnet_set_hashflow,
+	.get_rx_ring_count = virtnet_get_rx_ring_count,
+	.set_rxnfc = virtnet_set_rxnfc,
+};
+
 static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 {
 	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
@@ -5906,6 +6362,8 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	if (err)
 		goto err_ff_action;
 
+	xa_init_flags(&ff->classifiers, XA_FLAGS_ALLOC);
+	xa_init_flags(&ff->ethtool.rules, XA_FLAGS_ALLOC);
 	ff->vdev = vdev;
 	ff->ff_supported = true;
 
@@ -5930,9 +6388,18 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 
 static void virtnet_ff_cleanup(struct virtnet_ff *ff)
 {
+	struct virtnet_ethtool_rule *eth_rule;
+	unsigned long i;
+
 	if (!ff->ff_supported)
 		return;
 
+	xa_for_each(&ff->ethtool.rules, i, eth_rule)
+		destroy_ethtool_rule(ff, eth_rule);
+
+	xa_destroy(&ff->ethtool.rules);
+	xa_destroy(&ff->classifiers);
+
 	virtio_admin_obj_destroy(ff->vdev,
 				 VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
 				 VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
index b0780e49df9f..9152021c99ba 100644
--- a/include/uapi/linux/virtio_net_ff.h
+++ b/include/uapi/linux/virtio_net_ff.h
@@ -13,6 +13,8 @@
 #define VIRTIO_NET_FF_ACTION_CAP 0x802
 
 #define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
+#define VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER 0x0201
+#define VIRTIO_NET_RESOURCE_OBJ_FF_RULE 0x0202
 
 /**
  * struct virtio_net_ff_cap_data - Flow filter resource capability limits
@@ -103,4 +105,52 @@ struct virtio_net_resource_obj_ff_group {
 	__le16 group_priority;
 };
 
+/**
+ * struct virtio_net_resource_obj_ff_classifier - Flow filter classifier object
+ * @count: number of selector entries in @selectors
+ * @reserved: must be set to 0 by the driver and ignored by the device
+ * @selectors: array of selector descriptors that define match masks
+ *
+ * Payload for the VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER administrative object.
+ * Each selector describes a header mask used to match packets
+ * (see struct virtio_net_ff_selector). Selectors appear in the order they are
+ * to be applied.
+ */
+struct virtio_net_resource_obj_ff_classifier {
+	__u8 count;
+	__u8 reserved[7];
+	__u8 selectors[];
+};
+
+/**
+ * struct virtio_net_resource_obj_ff_rule - Flow filter rule object
+ * @group_id: identifier of the target flow filter group
+ * @classifier_id: identifier of the classifier referenced by this rule
+ * @rule_priority: relative priority of this rule within the group
+ * @key_length: number of bytes in @keys
+ * @action: action to perform, one of VIRTIO_NET_FF_ACTION_*
+ * @reserved: must be set to 0 by the driver and ignored by the device
+ * @vq_index: RX virtqueue index for VIRTIO_NET_FF_ACTION_RX_VQ, 0 otherwise
+ * @reserved1: must be set to 0 by the driver and ignored by the device
+ * @keys: concatenated key bytes matching the classifier's selectors order
+ *
+ * Payload for the VIRTIO_NET_RESOURCE_OBJ_FF_RULE administrative object.
+ * @group_id and @classifier_id refer to previously created objects of types
+ * VIRTIO_NET_RESOURCE_OBJ_FF_GROUP and VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER
+ * respectively. The key bytes are compared against packet headers using the
+ * masks provided by the classifier's selectors. Multi-byte fields are
+ * little-endian.
+ */
+struct virtio_net_resource_obj_ff_rule {
+	__le32 group_id;
+	__le32 classifier_id;
+	__u8 rule_priority;
+	__u8 key_length; /* length of key in bytes */
+	__u8 action;
+	__u8 reserved;
+	__le16 vq_index;
+	__u8 reserved1[2];
+	__u8 keys[];
+};
+
 #endif
-- 
2.49.0

