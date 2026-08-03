Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABC041D11A
	for <virtualization@lists.linux.dev>; Mon,  3 Aug 2026 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766086; cv=fail; b=G0s0RGVrrf4V3Pihr16voHZUPfmbXEgYIyhESIPN4qATTMglg/hFoBBmwZwnOhnaviFwURccVDldgrLs7P+t8bBa2z/Dc253WjqEDLJ3uvrmBNC3mdW5HVUwGNxdDwKywn5mmhVp8siuv4zI5Cvx+gXrwzlUThG+D6Aetwfe9do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766086; c=relaxed/simple;
	bh=w+sbI0ie4crsT2fa6BopzF06W6eSjjJs42PTLC+u3mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mnrnbX8yYw/dR+dyVLiaikteOyRxdMPgV1o8MwrWR0lZu/ayVjBXtUSCS04BcXNqPMncQpGXCy/w9rj1j5S8pRPa1a5iesoJ4BjWoxve4u/rhyk5NKP7oSANyo8YNjMLZM811KYWRdgHtOkmN5szCpzZ2NqvRJHirBdP906yfWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eOjk9dDs; arc=fail smtp.client-ip=52.101.56.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eOjk9dDs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ko0m+KBRqGat36WH3TrxbQH2SWcVmaR5+B8TY2EigcU5T9+O4OQzUycbZMkdC2mML/m9/pPBkaf/BCr7tIVhKRjvOVbG4DLdYBpViHkYRqzKSfZwbveGvAG6PnoJNUBJP3x5OWW1UkzVo5eLypkW/JcRY03RYtecDTnWA33tNeWMGF23Kql+sc57U/htQi8dCpIlb1QYTr/RGNts8kHPM1Ypx2tdZw4dSjChpYyIonp8mN7NAdJ2MCK+dgM8bwGNFMcjGlsCdczKm3izFaT3g+Ud2pZ8MHFgXWuam6BS+IE7jlSacf6/MVux1RU6vxyMRQ3iy1sZTVlq6D3o4woU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2WJoznzGB072gkkI9WIdCGNHg02c1t948HaW6N5Z94=;
 b=fM3n4/7HqXFzOwYogjUKPoS2/BkZTwF8rDWvUMnxQYuPxt7YydsbnqqVFn4Yew8u9qDux+PVExLsZYOWixda8uT1yUCSHztWmRInbQpI8vmqwPgEQAiRf9L4M2uejjZ77uYd2Yara6cBmABOb0NUmyipM6zyhlCkzzYKzxLeJpdlxkPWk/ACZuYweTPnqd0IUrjTodi7iL3B+gPlv9vqX/7yi3s4jC396uRPRFoKbDy3Ei45MbwbXXo/UTIwPNxarLnPyBQnunGCYgkU1GNX92SqJCZd/MQbAWMPSCCkQcucM9vDuqF/4vQccG3QZpw5hUSU3BMC4vVXtk4hErARtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2WJoznzGB072gkkI9WIdCGNHg02c1t948HaW6N5Z94=;
 b=eOjk9dDsVifOZkorjru7ro70K1K5JbIR8Aj4ISTRSHG6iMeL0VZ6iYgXsEXaXE35A/xj1x78i1gjRBDNN5D46aplLxH4H3ltyEgPO3eHGEMYZZ+o51Eux1C8l/KR9s/ZwjC1AkbAsv45V7rKXlAVtw1XC9CkhB7qOCzBBGlzIF1nPL9aAGkLeJluRjluAeK3rwE3vKUDR6TOHl5LuwcvzRlm/poVg4iIUkGBFHoFbhQt06++k9o8IHF7MGajUTcosn6NnC4EgDixN0d7WWcuCvhd2qEKYlVoraucmZ6EfLpprVUmlk1sSMDqn4F2hJU4FrTznXi6BMdVM4gSHbtLfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 14:08:01 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 14:08:00 +0000
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
Subject: [PATCH net-next v21 13/13] virtio_net: Add get ethtool flow rules ops
Date: Mon,  3 Aug 2026 17:07:21 +0300
Message-ID: <20260803140721.1871678-14-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: ef115e30-c1ee-42bb-9a56-08def168a078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|21046099003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9+Y1+n6FSh0pdPDGj5YCANEq7R8Hqpt6p5zDQrI3a1oL9lPOGwFZQ7YCFjGYa6WB/w04xAItbN/7kcpF+SeC09e4hdY04xtl7FHvqLjflyjtfjb9nuDh34D3BD5WKdvoXZzvJ3dPwINASJX5VG4DcqQ0BllqxR1NjcXEmXAzbEZgFA95TeLfBtvrojDQ0OFzpU4WPjkmwaxle5gtx/z6AsijSLKjGymEMIuhFY7S54aPSbwbtCBc89rclmDwm441sizIwZFPRdNsVN4L6vaLjup4DA/tl+xmH0hKCHf9TTGg8Nvz705XwKQkgKV7JQ7viggSeRa2CWVmUvp97ltveiDVxef4/XlcLHLZBXEUH/gxqoCjZoPnm6JaoqPrQA/++cpQiZsebOGNa2iHNkOodz7M+kKFsIcshsbojJrk5GK7dheaAVOv3R/EC5TmRCRru8NURaADMV/+SykZ7Id26oNyPfi/On3Il9qo9cTswHG16/+dpVvsoKBjW7wn4jv4hFaejC3I6DzCpZkq4loCveDNLbrdOjHCuYli0PfdXz+DDuHgkbpBAwNuRLUmS3pOGWKX3EWZRmlWMnYzJq7fV4xep2LG8eemyb92gM7NEnFEg1yIu9JtP16jCk4iB3N3bmsSszk2ZoGuH9/nm8cj4Hn1tTL6K6XbRbX1ai314Ss=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(21046099003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sn7sO0A/+EkN6KuQDLZ9kUhiOFyFSl3tH26KFZUDHOpOf6oYa9AYfIyyAq/X?=
 =?us-ascii?Q?VC/V5KJcJeq7rj68ZRZfRCv9BSnpskv87NS+8fWDQND8/P6E/RWEC+OF7kS2?=
 =?us-ascii?Q?7gnh1bZpkN342FpzgJhK1Wxs0YwRFWQLET/if1Zs1OcEIv6gJXeAXIpNmUNU?=
 =?us-ascii?Q?ABxbfhAzgxyelktiL/ORCDq/llsjx8lMODj/HN8OsYYsdRmKNJuw9KntE58i?=
 =?us-ascii?Q?qNY2bxRT3tbuECCCQ0z5JBdpXXjmP5qeV4Bd2D2IDKDnYvj9OPFMb8kVrhtO?=
 =?us-ascii?Q?3AWuBtSnbQXbS4n20GFSKI6aREsMYAdb4RzZalFyTgGSFC6B+/UN7NmeLSUz?=
 =?us-ascii?Q?qzH94hUwv7ia5y61Xm/YUVhYIjjSWPfS9YxZWjNb1nPbpS+8b3Grl2ZiqH9E?=
 =?us-ascii?Q?MblKCVOQdFHVo7J3H0nW+Z2VjBV5VIvygXer+d/RdAOTS/CtdEo0RD33E7eJ?=
 =?us-ascii?Q?X8xuNUKh/fOWFeyb0nlXeJQrriBAs4fGxcHLLOx6lQDvsG5SLn1k0hstVQnI?=
 =?us-ascii?Q?awoUwk4mKiNn+vY3qH9ozYz20QAT6EP0JdpzTxM7MbHhKByIDvpvdRO76Li/?=
 =?us-ascii?Q?GlIHRrXb1ksMh2n4Z0HghltaII5QAGDZcnFILGHG9vMMKbHdTIaBqAHWuGv4?=
 =?us-ascii?Q?c2Hl3CwN2Rv/cUtXA/I3IdsQTw2oX4+RPc4PmL99uOGXFNQBv8bNef/GYhUJ?=
 =?us-ascii?Q?UQo2Mg2UYKgtYD4oqndLg25MahJUgYEzx8/KBGekeKDvwuAjWreT50TEC26v?=
 =?us-ascii?Q?Sq51YQasDYPbpX6MSc8IWCzso1r5ys7AX33sEm52TcSPpicJjH3EvGwIHYRL?=
 =?us-ascii?Q?06pjldXAfp2tWRr6QHPaiKAVfxUPy3eSsEp5cjneUZtfFUWV2y1pz/+wq/0A?=
 =?us-ascii?Q?q+Dl1CqGIrZJoz4NePKJORgEoaSeuvxy112uOqmHwjARmUhKSuSH7ZBwapYU?=
 =?us-ascii?Q?K+QkMpbmiWrGeTV/8IC71dgLGsWfjrVqOSuoikSSyZ5D9Mt6hKf9vviQd6C9?=
 =?us-ascii?Q?sIO0z0gIsuk4v6fNzRyfFCtyeBYPuX7zGRqXImmYWrZfGCIMAi1yjSitDeEE?=
 =?us-ascii?Q?i6idOsBKcjEsvskVRUXk5fWufqxo9KU0HFgV2/aSXWt/hmQulXqSvfyDbhv9?=
 =?us-ascii?Q?zOMb3fDc8KgnoTNidGAwTGb+Cx8OwY+cSctPs3WfJYBxunZpS4Os0DyehPyI?=
 =?us-ascii?Q?ibDIxAyIudriiu0RBgd5TjSePJ8kfDFezLOrl0/TcNI4PK8IxuQ/eu3wN0yZ?=
 =?us-ascii?Q?6kdb8XE2anFIDlpkdtxNXDtd9Gg+2D6sW4HsuvJBD9crleNa+CBUtl0fj66m?=
 =?us-ascii?Q?whX7pv6HbuoIPgxnstWoBuwU6tQOoFhPNBuyRFw4qpE6OYGKutPO08DPYtGx?=
 =?us-ascii?Q?lRGK0BXyw/Z2M3krsWjHZtKzgCxXuxmvt9gHdOVg3HOA+e6btXzFXgpCC/+i?=
 =?us-ascii?Q?Avi8xUOUslMoGjxc/rR3VndyXxXWsbBYYwOUCJxfJKJrXPAHQiaL/txHA6Zb?=
 =?us-ascii?Q?MwAAW4EhCMI2ldU1p9coTaTROeXHNN9Zb5TcjXMJPOEouNY1wo+X3VMx59jV?=
 =?us-ascii?Q?C6Vm3JQgRRVn3mrhCvGsKr933rk5doRt2pxkEbB5WR9pjQnD0GnLPv1oWIVV?=
 =?us-ascii?Q?ygBZphKBqAhVnudMog6O0X66KOVT985qTA2zU/raEQxlI1MSUaCTsxBtjolr?=
 =?us-ascii?Q?4Tch5JkysNosjgHLic3y6fhqcSdFHzdefqHAnQVddU39fv4iJfWWepEICbcD?=
 =?us-ascii?Q?wbwMMhPUVQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef115e30-c1ee-42bb-9a56-08def168a078
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:08:00.6211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YeG+33NiJjrVD0TuM3l3dzYc+falA3mLFmsTLSFZnB33PvLUl4nyAmi2g6hLUi5YXpWAtDj4F9VIrsBjTnDm7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459

From: Daniel Jurgens <danielj@nvidia.com>

- Get total number of rules. There's no user interface for this. It is
  used to allocate an appropriately sized buffer for getting all the
  rules.

- Get specific rule
$ ethtool -u ens9 rule 0
	Filter: 0
		Rule Type: UDP over IPv4
		Src IP addr: 0.0.0.0 mask: 255.255.255.255
		Dest IP addr: 192.168.5.2 mask: 0.0.0.0
		TOS: 0x0 mask: 0xff
		Src port: 0 mask: 0xffff
		Dest port: 4321 mask: 0x0
		Action: Direct to queue 16

- Get all rules:
$ ethtool -u ens9
31 RX rings available
Total 2 rules

Filter: 0
        Rule Type: UDP over IPv4
        Src IP addr: 0.0.0.0 mask: 255.255.255.255
        Dest IP addr: 192.168.5.2 mask: 0.0.0.0
...

Filter: 1
        Flow Type: Raw Ethernet
        Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
        Dest MAC addr: 08:11:22:33:44:54 mask: 00:00:00:00:00:00

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/net/virtio_net.c | 75 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 236887c7976d..3d5eb716361a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6552,6 +6552,58 @@ static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
 	return err;
 }
 
+static int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
+					  struct ethtool_rxnfc *info)
+{
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	info->rule_cnt = ff->ethtool.num_rules;
+	info->data = le32_to_cpu(ff->ff_caps->rules_limit) | RX_CLS_LOC_SPECIAL;
+
+	return 0;
+}
+
+static int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
+				    struct ethtool_rxnfc *info)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	eth_rule = xa_load(&ff->ethtool.rules, info->fs.location);
+	if (!eth_rule)
+		return -ENOENT;
+
+	info->fs = eth_rule->flow_spec;
+
+	return 0;
+}
+
+static int
+virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
+			      struct ethtool_rxnfc *info, u32 *rule_locs)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+	unsigned long i = 0;
+	int idx = 0;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	xa_for_each(&ff->ethtool.rules, i, eth_rule) {
+		if (idx == info->rule_cnt)
+			return -EMSGSIZE;
+		rule_locs[idx++] = i;
+	}
+
+	info->data = le32_to_cpu(ff->ff_caps->rules_limit);
+	info->rule_cnt = idx;
+
+	return 0;
+}
+
 static size_t get_mask_size(u16 type)
 {
 	switch (type) {
@@ -6570,6 +6622,28 @@ static size_t get_mask_size(u16 type)
 	return 0;
 }
 
+static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	int rc;
+
+	switch (info->cmd) {
+	case ETHTOOL_GRXCLSRLCNT:
+		rc = virtnet_ethtool_get_flow_count(&vi->ff, info);
+		break;
+	case ETHTOOL_GRXCLSRULE:
+		rc = virtnet_ethtool_get_flow(&vi->ff, info);
+		break;
+	case ETHTOOL_GRXCLSRLALL:
+		rc = virtnet_ethtool_get_all_flows(&vi->ff, info, rule_locs);
+		break;
+	default:
+		rc = -EOPNOTSUPP;
+	}
+
+	return rc;
+}
+
 static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -6611,6 +6685,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rx_ring_count = virtnet_get_rx_ring_count,
+	.get_rxnfc = virtnet_get_rxnfc,
 	.set_rxnfc = virtnet_set_rxnfc,
 };
 
-- 
2.49.0

