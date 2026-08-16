Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175053E168F
	for <virtualization@lists.linux.dev>; Sun, 16 Aug 2026 12:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786882927; cv=fail; b=ER+7uz2mjsfize9l+odV/bFRh/Ac4Npk4XUMwT2sM76hRoqu3dROeiitn+LV55FhrZx231C4kcsBvtfEytKQJj2xFTy1u392wpcwLnbvXQKl5Smb0p7DGhz+OZNLOtLmUrruu4+49OyjGpP7TWkaU/JXn91TBW2/QOx9Q27yz6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786882927; c=relaxed/simple;
	bh=EthsskDDXfRiLqcArwpeWcO3/tuLjsBn53bS94GRmcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WxCVxzU5ulVXA4G0Ro80X0/lAgmNjmngEF7lMTelXPMtR9cVXEM6zS0FA6O/EG+vqvF3nrPn8fa0Q1qAJisAyWUBU9a41R3+ddHmfLuLkMOxXuZDri4J75uyo/m13bw7LYPptxPkbiljntZm28y2PVnk3yzBjDrrmXmVziuGJ0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OZRYh/nT; arc=fail smtp.client-ip=52.101.52.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OZRYh/nT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eX1fLOEnQo72c1N7O0NleRbyCGUlg5juo371XBL4WVrKRPhY2mTID4R7udWzJY+gy81NPZPsvbATsNLFjD5f5fOJCeAEgWc449IuRLaaG6hhQRDy0xRH1vl55h3Lc3LgdmyZy5cVlGx37ibDmIUNryuqbJZXwrheDVXoLWhZqtbx/FITMVsiPR7spBXSsweguj2yo7SW8NKh09lQL6B/Ea7FnBfxyLUJDBocHe9UGZU77R8VLtgiC41P6EmuJ+ce1OKJTqRTsZC7DBo0SqpEPw6l8rOosgQfSvg6Si8MtxmiVAZvsbUqukQj/xhb/T8x/vrl2L4tT0YiAaY95VAxCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ackhRt7clUOPbIsKfYTC9EjNr5ifAUJ2k2jvoqK54to=;
 b=eT/P2PB2Q3aGfUbZotB6FzQR2g9doWjT264aH9EaQhf5Da9y9I05AZx9MOWwxFmuM4UrHn5HeP0wx1xjsQi78upq/xXJWeDTAfTB/nYy3ySfBtNkj6B+6ev7T/KvphfabVPCGcenqGreBwfMH1YzFV5/U+SofOXnr7wTnLIEzGBQz/sHimicVsylmQClasQZTFOK1Z68U1MXwrclE2wkh1nbFtAl2DxHQAU+r5z1FBg7DlsvGUNTSF0oAUjUGp7tdVO/EBXlEOEq61FXbSs/qly0Eeyq7aVz8r1rDk+guwiQHC0nbf/xY+EgqiFeKUzGvx0GjGSXB2o2uUJBcHGroA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ackhRt7clUOPbIsKfYTC9EjNr5ifAUJ2k2jvoqK54to=;
 b=OZRYh/nTO54NZijLWUByuOBJGGwshZq6CBjCYSrx2bmrxUyauOyw+pzi/Y52fas7RWKmuRG/WJyuiAuPS6Zcwf7nhmpVkuOounnY/51MnQ8DXk5TR87NiD5CJ/dNzawUa1LW2fqsPDq7rBzIh19KR7TJDrzu6ZaXwT7T+1ZZj8ZrsExN6co1xnfvw2TA6/DUh8QmOci08QHA3RKcoOma8E0xm9pnbo3GEwyxR4df08AIHvfPZXcXncN9GMf8r0FxtBvSebTmpgk4LW54alwsn8Cn90vN8pbwhxoYAAGyhvH5imVPUrIaJz2a6SUVupvoi31tT/3H2S2MvKZr816lXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 12:22:01 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 12:22:01 +0000
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
Subject: [PATCH net-next v22 11/14] virtio_net: Implement IPv4 ethtool flow rules
Date: Sun, 16 Aug 2026 15:21:08 +0300
Message-ID: <20260816122111.2495240-12-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8820cb22-5bf8-4ffb-dff5-08defb90f96c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|3023799007|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	OshHh6NhPipwmJUOZZB3G6zPmsRX6fCKS0b8to0M1afrArft9dgiVYVTIJA4SU+GuubDiwlYzDl44tEAt5JTif3MErZrsuj+q/tMD2E1d0g+etgh2Iw5Mrl18/voHCldZdNKu0FxwVojI4mG4br20/be8DEuQTVTxDuC7bK6E9twAeuNqLTCjKzBrp02qCOdhknmnPu7qDMAmS4MbOB0AlK0RgYjyPRRDJu7zgZ6f/r+VBrs6VqdLCgjKa0y8h/A4ddnHgdfRGz2fde4yf4Z1+29NLcYRXno/QtXf6CvCU1uvwHneP+pVLwldBC8IKOG2t0KECNadt9mD7zH9EuH6umau25l1HCk3kQ1FAoCBVuMm/nBZHcgctJvgVXmhIIqU6Prr0hG26BmPbBcEbRFH+CGH2cW6h3ck/9uXBfVxThY3AGkICAUJWaK7lvjgoe7HEtStt0fByijRR2ERZONQoEMMkNTh/Y8FMU/LXfFHCR1a/gyyZDRWdAOi7hMgUI6mjerI0EeCnM/cPZ07ezUXCdfdPn5VbwSy4zmfRtZORVDN5893VpLhscqYWJMaexZJu6sjB8p3NlY+86VtF0u1l41Don9dALgz9YgpdKDikAqJCW1O/ZP3j43eByMFetoys17woQ1gFXbQCKM3l3ZErJwHNHAC+Lbo54QzSsAefU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U+dP6Ff9CYSRYMP5Jha2XJmteKWuccb2Vp9yZTkrwOnmvZc7XxjfkJg/pXev?=
 =?us-ascii?Q?Oh8fa/GL1eB2yfHFPzn6yQfuI/yOnwPM5ZFiUSmuaCQSSJ93Qx8D/Fmt0WmI?=
 =?us-ascii?Q?1suhh2I0mIECRjUrTBqZLBXtlmrj433/lKTBUbsg4RugYzSyRNH7Ycg+cF2M?=
 =?us-ascii?Q?zf3E2EqzXWKiPcFE2dCXJ8MlTyrdr74IHqzzqraG50ZtpF7GeX0Z/W+czUxK?=
 =?us-ascii?Q?UY56G2W7j+yAmZrUcjI8fueP97y6RD/1TFxL6sE+cIc/mI6Pk/tljcOKftok?=
 =?us-ascii?Q?a7j0TeF7+tLAmmZe6J40BiWV1MHb0lODWog2zGNebJGrCS4AGhoh+MBpuseP?=
 =?us-ascii?Q?6Sy3g/mHD9nJOyEcL0m17SPqkplmYYJAgRoYvRJMrjC+5iJFzfrQ9VNoDib4?=
 =?us-ascii?Q?+5yMgSLW5Db7TAt7LfHbiM9L/Ztm5t+JQgSBiUW0OrD8Ri4kdWsmGJ+0o2Rf?=
 =?us-ascii?Q?5Wd6BR0fIgNJ9laXSYmefZoOk0iznNjLbGOf2OZP77pJroV4wx1WjTvoSN+0?=
 =?us-ascii?Q?Sa4eW8ih+huMisSwNSeM5vVoW573RDTT8x58/CRwweVTDWpP7sod4vBDI93E?=
 =?us-ascii?Q?QnCkSkowwZBqHA2JRpFFgWE6RZutsXLxoUySBQTvIxwralBFbAab+b7rVl4J?=
 =?us-ascii?Q?VF3uVxv3Ex1HJU8mcfTu7sRcZHt353NcjUZr3RLG4nJM8Znc3jn20iczGiBf?=
 =?us-ascii?Q?M2jW8wUuV5d78/PgBNwK7YLTq9aVITeTxyD/nwcEk0KZuWnI63DP2sFJTQaW?=
 =?us-ascii?Q?3jGz12mLXseRciOUhe7/MIkAXLt0gNXlsSq7LekLcOtJbE7kjsuhLlAxJhoG?=
 =?us-ascii?Q?dCMAtYkuq79+/DlIouJJQKJVD7V88ZvqIvzni97Q9uQALdQ0IzQGlzce/wNx?=
 =?us-ascii?Q?VFWzewjNIygXB/0RvSatooRhTyuz2dqwW408ZioXh6bBO+rdIzGRJdLapfzj?=
 =?us-ascii?Q?UwOzKR/zvGgBejXUlRL1BhSLJGrG1wz239COfsy5ZKvb4A3B6ieX/O2cW5tk?=
 =?us-ascii?Q?q1j9wFZYoto3wmA5+SQa5jKJZyDtMofLcxzNKHDz0x5pmU89prOq1cl9KwE1?=
 =?us-ascii?Q?1gkxQybDCtyHr/SX8Me8WGJlblcyTrOjSe2GhgymIhPicCnYqVP9h5wMw+3K?=
 =?us-ascii?Q?RNsidkwfoUfpgts10fdsxhI0iUnctclB4q6NyEZMrvVlWbhy4EPRGSF/uorR?=
 =?us-ascii?Q?ExBtpn10PpdbR+yA04XpI3NYjESinnuMV2NTmzvZlL6+5f+9DHV0cJfidLUn?=
 =?us-ascii?Q?8f2XX93Ssm6NL1xnBxJFVrIfPy37aKgkxSZlSq4x1/hVI1PR55vesRvE0duy?=
 =?us-ascii?Q?CyzPL5dz+a017PrWFMvfyyRUW0awBjrDChX47IVXlzFoHKllnZrMmuv/M/8Y?=
 =?us-ascii?Q?UlBjWBa6RlIzXvrabj3bjbjocQVbkxBhXk9cdSWvkjCQcmUMs3SfB+3aI5PK?=
 =?us-ascii?Q?eep9UXEsf2tGOB7LL4tZ5Ekq32Avg0vPzAaLrlz24t2N+D7koDbEqsGDWqkU?=
 =?us-ascii?Q?y6ee1F2+6ASXQtIRvqsvVhK/IHDjrRWYcg9Qf8cHATM/q0NdtXksz72UmGGh?=
 =?us-ascii?Q?u7PXSVYrmkTAV9ydsVL4qbD3GEnbxPWg+Jf5BxD9qxcksWtpFHAHNVUvJdPX?=
 =?us-ascii?Q?0Pfs5psu1swrY91bOnW6Uf3WFk3kHTInsQ0yYnPJLr4eLM4PU3ADm8qTh+6w?=
 =?us-ascii?Q?jflGwEdyv2MdxMtquM3qLVFGpyYi8X6bjsxStfPsGy91+L9Ttul6xGSPuqQH?=
 =?us-ascii?Q?bXdJQVquuw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8820cb22-5bf8-4ffb-dff5-08defb90f96c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 12:22:01.3029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sGrHpL3p0nSr7ym5R6OqDl33Z91wJqWeHEtCS+dcmPr8KcWd6Ixmw03KnkOBFyBaIoS1eH0leTieiiHNqUuvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573

From: Daniel Jurgens <danielj@nvidia.com>

Add support for IP_USER type rules from ethtool.

Example:
$ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action -1
Added rule with ID 1

The example rule will drop packets with the source IP specified.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 130 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 124 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9d58ac0b96b2..1b4673a3962a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -33,6 +33,7 @@
 #include <uapi/linux/virtio_net_ff.h>
 #include <linux/xarray.h>
 #include <linux/refcount.h>
+#include <linux/unaligned.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -5795,6 +5796,39 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
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
@@ -5806,11 +5840,41 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
@@ -5941,6 +6005,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 {
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
+	case IP_USER_FLOW:
 		return true;
 	}
 
@@ -5983,8 +6048,18 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
@@ -5996,8 +6071,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
@@ -6005,8 +6081,35 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
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
@@ -6031,6 +6134,13 @@ validate_classifier_selectors(struct virtnet_ff *ff,
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
@@ -6068,7 +6178,15 @@ static int build_and_insert(struct virtnet_ff *ff,
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

