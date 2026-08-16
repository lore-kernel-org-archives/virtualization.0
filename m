Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013065.outbound.protection.outlook.com [40.107.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8093E1693
	for <virtualization@lists.linux.dev>; Sun, 16 Aug 2026 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786882936; cv=fail; b=o7p+2obif6ny+4C25xu41Z1VzWEEyc/DVNpGwrZ4BAwjXmqrbA1AZkmgdjS7beOft4DNebTxk/kPI1bl6Z2UcmVbKZXoF0gcJ27zM23v1uaMtY0YOjym5JpEs73ynzm536+VT36NQsPUVMVi6Zkh8abFn3uCotrkZpVTYOXd6nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786882936; c=relaxed/simple;
	bh=rPkR0qyxxuT2uhltaP+s5qajndAg/QfGKZ7ZjNMOreE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S7XaAjGZFXKVnFA5RJK5o8GcQpttr2qdopz51pjG7gKVYMotuxtSxoV+U/5IM6KjoEPa2sKonCPTMr4h/T2tivFR4PYUcXKsufcK7zeaYlC4krBdChxKU6Uq6RvJDxPoiO7JqiS6ywY7QE1y0aJ0ZIScUL5C2VT1/KDR+roCBYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bExFRzZF; arc=fail smtp.client-ip=40.107.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bExFRzZF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6/gChiwrlOMe6a3fLxVN8+PwcuUiLV27J0S7kiDVEulu9ldaUxKZ8stpPUU0E5isGWKUoegErJR7DOJAJpOxXgOHhJq1NRvq23DwjfTcSqf8k87XuBHKluQUOJb9qWUPsLVzH+h0z0fFyF3mBhpIKTYuizSGRSFytyHssPaEin82id0CgPdzlzOYW9cOCwNsAQefixVw65vcT/uPLvjr8oCbYEKeM/oer+EhKewBDDhkzNRiUgBbjt99HMm1UCkYJy0HBPGBfrnzpzdiYo/Pg3nXEX7QnEysmubsav3zOs3knwDBB30eiZ4eNABlWRzJN9rtvQrVEiFfq47ixKndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzhBV9YHVzbOJS42c3yfOjo5lhIQFsXqGKmzPjy2YZk=;
 b=wWHTT8APQ0jCWRDPcE40IDtk4Nx33rKnMkBaY6J+mbHzqUsebUrEyO8mO3ZBW5yM/CWLVfKXwkw6NpFBCDt98yE+wvIxOwqSUURKbKtBrjRp3vG2eHr3001WelFzqYJPFEiVxGOOFrOR7ZK3UvDjDnyIKinE5xgk3Aetkd782rBHdSjWBwPQviwGGX8PQODogar0K2UIp7PG1QDm219GvkOG8zQaUNI2Lzxtcubd5HyGyVO+3OYJeiMhgTq5ApwCHSLdDbel9J9az0m0fn8PI9DgtNPN+EVLu6xguvG29egyak2mvpxYOkd7QbQKUqQ+448HgtZNrAThw/uMLOSaMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzhBV9YHVzbOJS42c3yfOjo5lhIQFsXqGKmzPjy2YZk=;
 b=bExFRzZF1ptUiRm+DjDqTzDfwpMUU2C8XAzhU2+VXjqk1PcU1kf0y0+igXFY92ircPhwDm1COfVRyCR8I6qPgoMSjdvQ03I56xHySMdMasMcZLGmIfmLOs5HYkqGgGDIhZr/TXH3bAI87K+lHqAOygPl86bT007oDFVYKf0nVb5Bm/dYZ5qpsXBzthWBKDzR8+0tkn+ecEUaCu4M/9U4a5uh6XLeHAal5opLpCNsv6Dh1lOFm15/b7orgbatVI0l2SvhuoQUcK6C+bSMNSnbVB+J1StNlVeigBwb3uFYsEDFxW+BbXosULyN9oSnJOQkMPg0F3TChubwCx3ZrXoQOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 12:22:11 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 12:22:11 +0000
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
Subject: [PATCH net-next v22 14/14] virtio_net: Add get ethtool flow rules ops
Date: Sun, 16 Aug 2026 15:21:11 +0300
Message-ID: <20260816122111.2495240-15-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3da15f84-9e35-47b3-08f5-08defb90ff50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|21046099003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	iLBLPVvkR9E4rP1m/7kTNgoWYxkQb9iSJ4qjK7RR6Xu3YOhb6VHrrhXvv6Mcen2+OA47pnk7lYLu5VI8FFUnOFJH4dMoJPZoqIvuvQOG7Zyc7hsw/mZPW4MOw5AVRUrOYhQIxR61vOywzia7SXi5c9V3/oZtd5fC5A2EpXejDMHRnAdeqtErjDI8e3PRr05bWGlTSkUB3tXjNO6Nj2kpjLIPpLY8GBASPE+kF1hUhcTWncofbHct8tpFDq8mQU7a3bRSlJE9BRol/e8beekmUwu/ugFFHxWZyAMMe1/fkzy202lV/bHzB3lT+JAY7wRL+PV8fDS7qvnlu7TXTpi2s6+W58+O4ehd8UnEIy0zS6VLRPl2xpKwGjkAXxuJ7FHX64teOJ5Yajo7jaLHfLbRaBk8EvvVbn0ohkXQRrCpZkT/loOUS4CoqW4clysIisfW35ifDEO98MFxHUfyC5RdisWy3Wbp4KwfCQetsx+gKv7ZfOt6noSS8JoV/kub9OMO8b7SszXeDzUIY6vq3VyIWL8X5zN+dsVHXTw3DHd6Kdikleg0oVjuBg2aOYgqN39B/QXshlvPxFzTAR2mGxANgXK+ZrVhPOmbDxnWid8mK2xd8mFpO99CHFGq6FfFnNqendvYjEhSG+lqfCa4e9ZBnYTPTQrBri2dPObFB2e81bY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(21046099003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KNxgXctXZScUXRs/jZ4+s6zDnqU/dFz/zhmEADeJZ0lrGX1Q1mCK0snXLNxn?=
 =?us-ascii?Q?D6fTEIeYvP7DPtRPSjgVJvjKVaoMX8l8BIyR0U5S7RnhDM9/9W3kvF05XGPS?=
 =?us-ascii?Q?iEX0HnSgrL89DI0BpSP/c+VLV/wX+Z6pP8GYT4JuDzKTs7s4FPn2f6u0YrKv?=
 =?us-ascii?Q?3j7OgUAvX983G7DkviKhVwBzhAfZAxjaMJjgaODqCROFlkK5dpS2yKtxrLjw?=
 =?us-ascii?Q?eGiRRJ0L0Z7yPXS4FoHG9t4SBi/6/WUTUG0Ek6JtUhuwYjvQzlQnDSrLZu+9?=
 =?us-ascii?Q?TDufvQNV+HdDGuYsgggrDMiNESJ35vWgHDrj+7DD8uRh7OyWLfOdY4zcSr84?=
 =?us-ascii?Q?JR/9L7iTmmLnVtbsFN8xDCcNW0du8sc0VL7phF12hsg1fKInhS7KcL7ymiaf?=
 =?us-ascii?Q?yVm1fHcRRtP72P9v4EA6Fuznu6orN0+nDooNZz9SD81RIc/BcLOYHJhhrj3Y?=
 =?us-ascii?Q?OSNYeEnJNosdM+/xORN87m/WGqMpFcijxZxtkMdptPLmNi5uyfaWGxhMbrWB?=
 =?us-ascii?Q?FX9b7HNSyzDWyHqBbBzYeYcPJObFbqqkPChxucLLNUXT/dWkExzVlvUywcY8?=
 =?us-ascii?Q?Ms5uMOnVojbjpKxhYnsXTtb557dSuOjK4OgX8J5i3FQrVvaRvt/b/PhOTtsx?=
 =?us-ascii?Q?E6sysnvDDnpGW2ZQe3iMgq5kF03l0TDpSblI1G5nao1fSdxZaNqVgHRo5t7o?=
 =?us-ascii?Q?2W9Kyqnw5ksJl6RTh7clVdJDEO7afieRLkbBcy5bWGk8S3Enw7vRRk6kPG3d?=
 =?us-ascii?Q?fCgewwV7BvsgV2irWWXsCoKFbCSjvFSnjWW3TwzRnZBesR6bf02tmBILmOq5?=
 =?us-ascii?Q?+0c+qwjkVhsecAoTIQ7txn+3KPa9V9yz/zbo+tDyWHbcHXYMZQXHpv5c7EEg?=
 =?us-ascii?Q?4OjZ4WOzCFi5TEQtreopig1iPa3ba89IOC5XncFIIvG/dlh4c8jdn1dFv1j7?=
 =?us-ascii?Q?XDNhFKCN+RlaNBYNVFlaEvcGooUGf84GpgNivIcipmo3q8rvwTN2YfjKEutd?=
 =?us-ascii?Q?PmjqO+7QotU1q0gKEdr7STfOGbeLyEskGmSDy1eM44XbWBoCbJhlte5yh0us?=
 =?us-ascii?Q?DTBolD2XsBHmKX6j+d5deFvnhWV6cWZ04s2zLw7VlZzE5/TFmzGMwVv8tAYc?=
 =?us-ascii?Q?X6yO3NRYqIlyjT/M7TMAvJ39pMlz4UkIe7fSubxj+Tsp4t79MwWasKotA8Sj?=
 =?us-ascii?Q?BVqWLd1PE5B2h76RMFR1ebC3ZHBCGDuSHtxAUEO+ORsF77oDw+sF9RVIXLR6?=
 =?us-ascii?Q?mKCzv+bQECoQE3WzdrBQZrAGi4a5G4YpyXkHNKH5SpT+8Fzy08eRCjN30BGe?=
 =?us-ascii?Q?8ZUG2Ye5FYG7JArPTT2AuGWi1TTuLhkAE/4/4l1pc2L9KMEpkUexlSrAxAhS?=
 =?us-ascii?Q?rkIeQ7dWw3PWmORycNiwMVumAcGtbebtTd3xzhB7QLTX3u2Z2a5US8OC20ox?=
 =?us-ascii?Q?MPPpW7ewJoc+kcOy3zEQOUQL9d0LAOaGCQU7wj8tozHuQi6XiquLdBU5Aqdy?=
 =?us-ascii?Q?9jDsrXTEztXFmvzajqTWoTLnaE1rLT4MyREDkYXRG3EtzAQl+luSwIYBBGbi?=
 =?us-ascii?Q?8qGvT1nVestXUguo4jKNA4cJv7AawHZEAXx/HQ7zflYBbn90Tqg9anWmf8Wk?=
 =?us-ascii?Q?9lLM9CEyiYcOy5YVH6O6rNoMFMNipSYUfSaQiRbuw+FlmxwB1w4ZwjDplgEV?=
 =?us-ascii?Q?Oy7ZSdUCWWsQ1Cbt2MquifYgHUEprBjCMpeBnRf3gUIQQytDkLpLhYG8dyU+?=
 =?us-ascii?Q?PmXHC37UqA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da15f84-9e35-47b3-08f5-08defb90ff50
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 12:22:11.2159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgCNYowxHaz6BGAE+KqYyFyJn/tu0WCCbh4AikiDwr2mj9LcCI3zCHvshX7uV5Oiaj7POo3Kf1rgelJ0xuHTEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573

From: Daniel Jurgens <danielj@nvidia.com>

- Get total number of rules via ETHTOOL_GRXCLSRLCNT. It is
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

Signed-off-by: Dniel Jurgens <danielj@nvidia.com>
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 77 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6cabd53481b8..87365ca05c25 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6554,6 +6554,60 @@ static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
 	return err;
 }
 
+static int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
+					  struct ethtool_rxnfc *info)
+{
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	info->rule_cnt = ff->ethtool.num_rules;
+	info->data = min(le32_to_cpu(ff->ff_caps->rules_limit),
+			 le32_to_cpu(ff->ff_caps->rules_per_group_limit)) |
+		     RX_CLS_LOC_SPECIAL;
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
@@ -6572,6 +6626,28 @@ static size_t get_mask_size(u16 type)
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
@@ -6613,6 +6689,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rx_ring_count = virtnet_get_rx_ring_count,
+	.get_rxnfc = virtnet_get_rxnfc,
 	.set_rxnfc = virtnet_set_rxnfc,
 };
 
-- 
2.49.0

