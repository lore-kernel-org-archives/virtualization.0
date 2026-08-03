Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B3941A923
	for <virtualization@lists.linux.dev>; Mon,  3 Aug 2026 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766079; cv=fail; b=Q9ctB6eKeKKWaKUIHltpgzjrVMryw6+jikYmPZcFzRkKNJc5BpvEzVqWRFRAZTxuytG9HWyhJ3/tTjq0Rn2OO/7+V+Zwbk9x9K4BT4xCFKRjmLH7i/BCU8X27xxrwOkznIVq+W2UhnBLw69EPTGkd0zZ03RfN5+mmJ76Sj65ux0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766079; c=relaxed/simple;
	bh=8gsgM4NjbWjsMLME7dke8+dCRgq9x90ZXWSZVk3oXj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D9cNA0XuwISixWZ26GHlpiPPICfif7yoGBYUote3I3MhnTiFLoR1quz1IReKj4+HXJ2LcVaP3cDja/eaWYuel/CtcBTUROkWZ0AuAFr2OCMTsjuNeA01hw3sGIwguiuR0G+7P1g9MSmRigx9zSQdHzniOaiTfpI4569kZZqpgzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oZz3WLka; arc=fail smtp.client-ip=52.101.56.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oZz3WLka"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/s7B/D2zBz5U+epKv9W9/11RvnBRKXbgU2VfcKSJMVK8RB8S+/m93Q46yJK8A0dIFTGOCCiKtraexdWZwF0KDtdb7Fb/RNoQ/rheiNge7i5Yk7pNTtWHhTUS3K86ZTSjcAPgVbWtXV4Y+ypZEGgL6Ti1SDDAHzWwwhcwstLbhcMLeL3Xlou8Gm7l0xW5yuj0cdQ0WvToJ9wyu25L9Ez47dxjNumHnpnnS2wDvaySaB11DhdJ2ncswgZBfAGVc4MiQpR04EyMEurWOrb6gpYVav2htu2F/Vm2mkPTBGiicXE8G3oH0uXueIk/USjmDSAGEt2HF04NgyoqiTyccSTVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5T/e2pWzT0zUykMrDgIEOj+0BzNIz43kSEao7L6hXPc=;
 b=uV8DrOniNVG/Qy2+7zk0YkNBsSWbCqN2YUOfIBTTGo/vLdE7rg8MyRL5kmnOPpd8WEKY7JAE9v8FSaxnveYj5e5o47RNrQNcHd9qZ7MUzXbV/7bmWUv47RgnHClYN1CKsWbXIXnpnEQm2xs9vu/V5X6Wy/f2zItGOiFlZCn/D6j1nmiXVDuX2VTZY/4JbyjpA14/PVw8xyfdXN7yn5GxIi8DSFg03Exdor3Nw9lme/poKt1ccyUAqoPk91Poz3oz4n/22yadiVIdFaVbmmenEVq+rrHwW8T4CCQ+uGDo66TnucbfKITDEz91YL+6TWP+rxU9m2ZmMHV8Q8ewCqb6EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5T/e2pWzT0zUykMrDgIEOj+0BzNIz43kSEao7L6hXPc=;
 b=oZz3WLkatnM4tfWHtYqLnpyP50hK//aCf/e0MSAViR96f6W1YN8LFkmZbYcqIe4e2VWE1U6VW9gp3PrOnQtw0iTRIeI5hlUZk/acWnCsub7s1AnRBvGNtAE0H6Efw/MG3ozYHxvZ1wVyG24jd1lMouqPs/IZQAiPj1PK+m/nXN2hruYV1e7mzTgIYTEMx2ED9VKe2sowhNygYPh1dig+8yenb/oTPsjQ13kzpSEylkGEQg2VrSzJ7gEOr+fLtrJEEHqqHdNlheCj9a3dGJI90Usmwj5XXuT1D+YAdTl/fxR4hx0jxscF0AdM6N7SloSd12ef4Y6i/4DL+aWK4w7b1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 14:07:47 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 14:07:47 +0000
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
Subject: [PATCH net-next v21 08/13] virtio_net: Implement layer 2 ethtool flow rules
Date: Mon,  3 Aug 2026 17:07:16 +0300
Message-ID: <20260803140721.1871678-9-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 913f20a6-14db-455c-99e7-08def168983e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fu5vCLPMZXmRzCVQPQ0MKL5HPbhZ2PuH/murLMdi3iYvteMVbgU8etqf5EvCrUwYhz1xTOw1iFrJ3mSc5jfxPOByg2eGdkGaN7J9QBX1jdcEf8ymXLl5EGqwov9SfEgmtu02T2KFyLMk0qf1KOuNq7lDg/eh7QQq5FlsF0Tpg7cMd3INiVvS8pwqOJu5WyR65A1hQG5qAaqBHBfoxAovk0Y2v+RYAPMqgNLNQvLtb5yBeV6TYYB+tYvZ2pJ4x/+npKSHF+vXgZX/pv6fxvrKr/2dimKt6sz+fdFmE2eHZy6dojKsdSqy5YhAgqCtD1TRor+j+A4RwP/28W/tf6jCQ/ksExp8/3k9hva9Wo4RC/LeHR4otQuPhKAH4OXcqpWFBzLMQ1EI9XBi2zGyZprny8tLgZYo1JMY1ZwnIO81OcL/Zg4wjZPugDdarEOHeeX82LXMI5Nt+OFmRYkucB53dikRQqmeaRYIYSP8aUhEsNh1jaVc/BIvNnHB+Hk47xviHF9evGBwH4RrkeKHKdFXKEH2mZ7cpv4FAO4DcefN2eVY7MJ4hbFJxIv91HLFLrJWj32+TT/4rJAxFW7GfLQtuY/4iEiRx7x3WJ0c0nbvRObrHvIS9+DqV2PP34ecgUB8QszOI9+WHcU7fGCKj6EnUTDtFwYMmuw+fvSc19slANs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jZHmeQv7Lnn4g/u7DXniWFusnA1BqiDJ+f/MINY+cE74+Tr3z1UaSbBtNm8/?=
 =?us-ascii?Q?Avqz+inT/+uQDSTEcRO+xMnoiFx05kzGs6hGyd8fL3wa9WtC+6vmMS/KNbwn?=
 =?us-ascii?Q?JTOmn+1MRi82Ii+OxUvCQ2gFiES0rzeVrtii9IItVM8ctxZ7NIP0vIrBscOS?=
 =?us-ascii?Q?IxrGvcjPQtw9d2rzviBb8TS2NQnatqm4+XneNXa+/tvvt1TlAwK8sqmECmbp?=
 =?us-ascii?Q?NNu9JDrVbIsRRY6962uteSk8DpePduYW0sEBCnxwlNQCA6NIt14zYkt4COZ1?=
 =?us-ascii?Q?R1ELNoC9lsUAU177yHIYZDhCUus+A7AUamCKjjf3FIo8qANuxO8r1KIJU0X3?=
 =?us-ascii?Q?gDGSVVrQeNVEvljGbsE9aSN8aDYQ/J0PBBOVxaMmIaD+ti16za0eaQ7+H1pn?=
 =?us-ascii?Q?lodOJRvPb3UWxLBq+azshuAuiPUyW+/xxaNFmlxBZjw9rA+cNTkuIX0ep6Pk?=
 =?us-ascii?Q?sSrtxO3Grc7m3pqJTxtM5cmRGbCA9K+nUY98Yp+/bfKpcBjcD7GKUMt9VanY?=
 =?us-ascii?Q?Z3ImPNaVpK9GjgZhAWzbW/4Jn360GCM1s57GuGCpguoRGtnYiQMWkPQMVzZl?=
 =?us-ascii?Q?GPhbMgpF15iRbpxTUiZ5VeVGdSIRMDkHQzPMYQmg+bUx1iE/9R0ddJwEOu97?=
 =?us-ascii?Q?1Xmrn73dHkqf2FK8OpjBYKTxWOrS2ry+FzjRURgymZ2BS8kqbOkBCBgSMFb7?=
 =?us-ascii?Q?MTgNTEyyYe1+e+k0hMH03/IK+94Snm27NP2QnaxcTTDYnv58XVLnjwxeqFMm?=
 =?us-ascii?Q?7gR0dEss2IyOTcapUtQTPteXR37X4dceNy0hyBZnIkkNoehnNKmYI+ahKa5Q?=
 =?us-ascii?Q?wdBNhZXXU88J0aWUsMDyr63+RhubJlAAa9GSTQ18U8VN1D2DH4z2A3ML/LoP?=
 =?us-ascii?Q?701k8x3FtEXtLSAcWFjEAWxLXGPV2sTyTBcQP4pJ/ET8T6oVXn6v96Iv3Tns?=
 =?us-ascii?Q?qiwa5qhPkiMnN9fcNk/p4DmcL9tUr+cO2ZVoP8F//02xNYUxkTXlimU3sTNM?=
 =?us-ascii?Q?9oNdd6GUcqXUTPNAm+EqkDbu278fG6ByMA8ppSDcNpu78+OtSSlMgq+xdwt1?=
 =?us-ascii?Q?5Cz4f6dt416/Csox0+Qgqsg8Xm/AiQWgCDHE8yDAfPaNmrhX72FCS1QwknSe?=
 =?us-ascii?Q?sPa0UV8HdFNwOglSUTavn8j9XBf8Atp7nsWV0QY7zczruobAsmfDEkAj5xT1?=
 =?us-ascii?Q?F/u4KZoTZkf/nAv/L/6+Ut45AxqcmPveH0UCFO1sa2eEvXBrzzABoUuUag3m?=
 =?us-ascii?Q?y/WAM0txt17kp7hQIutjNYYiNTyYMs8Xp/Hglh3/XzeVYm6kVsUoHj1f/4jW?=
 =?us-ascii?Q?ZPrLdo5FEsLaCyMoC0mKnHtj7r6H1uWeI0HsURfWoj+h6a2N+mljx6mXfxUG?=
 =?us-ascii?Q?jUxZV0XpGe0tB+J4fOhG0+vWukIneFSKxbUB3aPh30+YF7wxI6lMy51qzGEX?=
 =?us-ascii?Q?oGoajLR79VmkyXheyiCME4kZUjqEaWG7XhahT0WXv7hLeFGjy8QhUgNM+Tjn?=
 =?us-ascii?Q?2y+W4rW2FLQjAwsRNLXDL1Hb3ulrqSmdpQl1vpsy6obdxT4bsRR/yGLbJIDs?=
 =?us-ascii?Q?ZxriCDhCJX2gL5/GWCnVPqY+ZoLOJRvr9PsdZfGBXtdz2go42gybLWJM5Ebe?=
 =?us-ascii?Q?XlWoF3F4NNXSqZUt0L5sZBFGyq4f1hRirW9rTRdSio7MShxVtAPD4ZbQSZGY?=
 =?us-ascii?Q?lDbruyjQofxFoq9JHk1GEwAPOOwp1a8G8IWkMkyW+8mIvF13ySQy76KPHcYE?=
 =?us-ascii?Q?mpV4dyW4rg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913f20a6-14db-455c-99e7-08def168983e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:07:47.3733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FoBp8wuDLsEFPIWcSYU8H5pz5Oh2kd2fXsWpgO6B0yfteDR/XTMJfp7TrkAhc4R4clT/Gms4geQ5hbMz7KGOzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459

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
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/net/virtio_net.c           | 521 +++++++++++++++++++++++++++--
 include/uapi/linux/virtio_net_ff.h |  50 +++
 2 files changed, 543 insertions(+), 28 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e11e42583243..2540b9a23e5b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -32,6 +32,7 @@
 #include <net/ip.h>
 #include <uapi/linux/virtio_pci.h>
 #include <uapi/linux/virtio_net_ff.h>
+#include <linux/xarray.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -287,6 +288,11 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
 	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
 };
 
+struct virtnet_ethtool_ff {
+	struct xarray rules;
+	int    num_rules;
+};
+
 #define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
 #define VIRTNET_FF_MAX_GROUPS 1
 
@@ -296,6 +302,9 @@ struct virtnet_ff {
 	struct virtio_net_ff_cap_data *ff_caps;
 	struct virtio_net_ff_cap_mask_data *ff_mask;
 	struct virtio_net_ff_actions *ff_actions;
+	struct xarray classifiers;
+	int num_classifiers;
+	struct virtnet_ethtool_ff ethtool;
 };
 
 #define VIRTNET_Q_TYPE_RX 0
@@ -5606,34 +5615,6 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
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
@@ -5729,6 +5710,435 @@ static const struct netdev_stat_ops virtnet_stat_ops = {
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
@@ -5747,6 +6157,50 @@ static size_t get_mask_size(u16 type)
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
@@ -5909,6 +6363,8 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	if (err)
 		goto err_ff_action;
 
+	xa_init_flags(&ff->classifiers, XA_FLAGS_ALLOC);
+	xa_init_flags(&ff->ethtool.rules, XA_FLAGS_ALLOC);
 	ff->vdev = vdev;
 	ff->ff_supported = true;
 
@@ -5933,9 +6389,18 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 
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

