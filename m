Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013034.outbound.protection.outlook.com [40.93.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A8F3DD52C
	for <virtualization@lists.linux.dev>; Sun, 16 Aug 2026 12:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786882897; cv=fail; b=TiJI+IsEWIiBX8eB6NlULnq4uUg55cT/sjYnycR0I7nPsyuyecjlSdnHJH0JZsaW7kjrPDIeDiW8GIqZU5E46sO+hFEwi+pDotYEIz74FnlN97k3IvvPZ9RYrzxZXQsSZv7Q5tIbdC12bhDRYNPxbPL+LpCXxYQjlsMSQnV/lwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786882897; c=relaxed/simple;
	bh=jayR55tE50PzgiZZacQjgEEUuTAyLLaRpclfWJkSFYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aOU62xV5giz7wWX2OhbcqK3XWh/k2jtwH+wAPDnIxyQLlPswS52UZnj39umhqiI2EdV1+yhRN9YlGFmeoi6x5ffmkNYrIM9z3CJ6N7ejbYdZAA7kAyhd6F7rVv3LGaFXa12G33GHimIhp6/iGcFiqE0vUamJjox10BaY9oxb6DU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jLkiEn4I; arc=fail smtp.client-ip=40.93.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jLkiEn4I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKoZovoUffpCVaGHBcJ8Gvhjq/eZz1sC9jZYmB5rPeqmY8klaOlvHtJzWPM39f7J20lxCvg5lnOgkmfX59wtqvEx/rNvil+HzmS0rvLV3fTQzgoiDrgOJWiBuceZqP2yK+4KPgBB7hVYHsw4umQF9FNp2s4uRb9iUO6b0JuUYqrhedWwn4mijz4uc+3nKiBoNP7U51JPWZSJCfaXA5lcB0GwMQ63Tc0xfofiCLSTX2GvaxmzinNL3Ny7FyDT1ZZykUJomM2kzi29VqE5d7JUwzm7fvFxb7HP/VrJKEuWzSTloDEnoGBJimzzT3mdW/oS9WDEs78f+W8Ty2I+Pwr8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLlYyJ/D+hsAZgXCKxOykXEhynWchWO8ysVpbEBwxPE=;
 b=T6YcW3biHTbo3U+lkw4VuRK7QJoBD4E8EgRbIznYqrtgd9PyNizrBYbSgZbFu6eMSXlw4YHvHiJPrlQUSCqWY/rmzFnyfi84Mzs2DXs59++Z+VaIG7urbZAiGUxFoEj4xEFOvtYNXZAVCHkbXydQc1YkVYt465wWRnkMX67dTnVyGKf/fXGSPkwRHKhPLBGbwpvAHQnMM9JKBC0T6u4uoLgtogseP0WllcN5JZ64SK9w5hRTM52ieFgfzsMaysZzSkjgKTfrqB4AMkLcwPEG8OnG7vZQo4Cc/CAq2P2/QptUpt38uuaMX85V7ZxQbEAa1cOlBPG6Vus+nTNZKsG4nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLlYyJ/D+hsAZgXCKxOykXEhynWchWO8ysVpbEBwxPE=;
 b=jLkiEn4IA7bScRv7nvL7Nu5kPd/wc9LJE9SFW/QbksHymUesXMdO0wY7u2hczZnXSg9vbXXaXVVPXV/m7mQDNyYiaVzIX2vFkmR6VVlm1vFXZpXofKPcBeobhPycfYSvxbWWMOYW2VPDYp0rdnBvE9Di6VXg+Iu7VmdSzk6DI+B0T2+ULrsDlFhPyt6wo/NO0s5SoEN695dA5z7vKv3EsLARA5vJnibg9tvTQdLMycweZUDtQd8Ar+FG+broBW+tcoXsBKwMRb4i26H9xZtAeoiB2/APfvede4OzqDT8rBdNT9JpJ6VEhILnCOOKyJyYWNjcnzsmcCkWCan7L6TrQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 12:21:28 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 12:21:28 +0000
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
Subject: [PATCH net-next v22 01/14] virtio_pci: Remove supported_caps cache and build assert
Date: Sun, 16 Aug 2026 15:20:58 +0300
Message-ID: <20260816122111.2495240-2-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 030d2d18-ca0d-48ce-9357-08defb90e5a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	0OPRGMOqxfIoEwIv8oPC9Yxpq+8EoN7NU16+ddoiSRUPRGBaGzoCWMeJ/8qzD+MDz2S56bG3VzSq1oLrBbUJFkMHK8GGFzv7oXdCUl2kvmtfvZO3XrKuhQa9jGT5SiLiRr+F+36sLpMFtpYC/tZ8FeiA00nteKX2JEQ4V3vGXlisUnRyBr8VrQZ5GOSWjejUlHmkSo37p71Stiv/JVyXB4QDKq7fiMLMdqVih5HEC2f9OIB35PIllZ+btlMjL3M3Z3II+AfNCIEF6wg7liN5+VlR3UodiPMUoaB/zi2KSKR0ADkTHcih8vimyVUKV6PfDnSfgjnJbdhRGUfYJQ0SeHpmhhZ0lg1OfaMPBMUs8hJuCRSQUo6n+FOD3Q6pX8Uc3fxivfPCHg60wBt5HsDfZJm3AnlFe6CDpvLcRTfpPHENipqCPhEyOUrddcC9XXnj9bGBrF+3TE//xIji5DHyRzj3WG53LAGAqUx6OBs5h6gW0Ijnhv9JTItcWBnhFuZo0/xeKnIRv9esueaD83kKOzF+f7pa09d/egtIVfkNCT1SBZoctOU+GOt2N5p2HPVveCixzPK1oA5wK1MkLyfDarxMWIjsn1g+t6jRs1TSTj7rEhGfR5efFMQPa1PBm4NNn9h8TU3okZY12XO9I+CRPYMQNnDRxf48JPWGxaNfa0Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?285500qrXwTYMdyc/RCQwhN9EzLYZe6nZuIL23yFSLzq9jubAdIyAdRBzoVl?=
 =?us-ascii?Q?qHRyeJ+h3m2clvw2TvxxBeK9WuaLZeQO8fpjZUum/+pZDIlKebMqOW6l3395?=
 =?us-ascii?Q?uPn79T8C09RFt7ahwFuDW+IfSCipAGJ7mguxfK0QWRuYy/mRNBHZAjchmlZd?=
 =?us-ascii?Q?pU/tB4eI5Dlx2HpFeAGPcwMuWP9BU++8UC2MOOHx6/Pry24N9W5vu7t6ru72?=
 =?us-ascii?Q?P9mjgANwMo2mOZlBTyyyb6LCeqfGNFguPoOJl8jgqL8U3nNlMha3GIHhasAs?=
 =?us-ascii?Q?GzfJ9qO3E10KzawKjvU4hEss+0Nth5ummhLRr0wzMFUwn6NLggIh8mj8LDCN?=
 =?us-ascii?Q?SADyCicGqgALwiq4uWMKPT4dbBsRXVjKyKssr+4AxLsu5scM521wLMxvsYI1?=
 =?us-ascii?Q?dksfPpJvrMgSRZLi4EDDNw7h+I8V10hBOgIRUTqbGDFYg0oEdOxuXtkNuJ++?=
 =?us-ascii?Q?jCDluFTHdvfAVsU2DKrKRae8bPn1vVSwOi0A8iovm7f2QWbdLRQkJ6Tt+8bX?=
 =?us-ascii?Q?6dPXkbQ2+E17EKUhttsqEtpvl/eCcNNhqassvbYTCW91+DVsV5FodgysDR0w?=
 =?us-ascii?Q?vdQ5nO0IfJJJFblr7bmnHZVOAqIy52KVaY9F/2+M/1CIMKKOlYRg2W2c2t9D?=
 =?us-ascii?Q?+voStsbBFrYc6NSzlbb+PsghZWzq2UAlupMEmepzc2srI77yR4kVoUjCnK5u?=
 =?us-ascii?Q?UJ4IpNFwbpFKm/+SViqfSE+L1oppnuqWcWHXe4ZTZHvWln5Ip1MbRRAoyT8T?=
 =?us-ascii?Q?6ZK6qgUKa8en4FQR2h+HvQmmdiytk5EZnowdW+Aor3HlOrA1wKFFJhnTbhp9?=
 =?us-ascii?Q?5HaLz9AQ7tS95Ps3P4buXypEdzA/OiZbzRyvcwovbzsTZRdsSZaUMwCkJs00?=
 =?us-ascii?Q?E/1Fye+x0zDcG8tfWP3qnznfT7f5Nov/Q6yZpT8XZwFU7pD3roMSo2WlVGDR?=
 =?us-ascii?Q?uU3ixDNm+pQ+VeIiZIAw98hT3d/BQsJUdO+pn37jSXyP8JIV53r9UbcPp+gt?=
 =?us-ascii?Q?yUwb4oGa4wU5jZ76lu3wdgrFzxlqx6GD4Xmmmunr4RijKv1nF3IeYA4GpDeH?=
 =?us-ascii?Q?AtzRzXp/3z/3lKnDhTRir261Xey0VGIut6VKVP+sGS72qJecMeUkJaONITbM?=
 =?us-ascii?Q?bSd04nKgw/yIIjrj+/JqwB2ueHvyEDuOCrneop532ME2nKbrlBreGbGUnPE8?=
 =?us-ascii?Q?DgYsrjNLG3PpCMQ4VF/HrJjbXysXRz+Kxh3f+vTL1xVaAxIqu7jStb++xS6I?=
 =?us-ascii?Q?1vjOuAjGjzd+vGeTVlmYwKelxat+IFEfTxEQBopjRjkhh4r7YHtnNEzWZ/U5?=
 =?us-ascii?Q?loz56zTqtLqTwxNKd0fzS0FDKZ3cjLyFDOeOeFKjiMMDfgXHzeefCGC7uejA?=
 =?us-ascii?Q?u1GZhzmiGRsypMwMRGylO6msOCOaY4lRDhR9rrsAgTHLtdkZxzpca9qrZWba?=
 =?us-ascii?Q?nmYkb3kXC5dHrHn+oVLQq2u2XTNYqwSVFA83ZsQgVfrdjb0a6+g7y396rJSi?=
 =?us-ascii?Q?XyCE7ZINvu+/4K/ZwR0PUPGmMmrXAWCgr84fVuLzlWFjnq6WsH77NCY0w1p2?=
 =?us-ascii?Q?pM0eLECucyhI2vnnmEHMRBG5mRIYwmTgSDPL9BiZWcXL2so55B4HirvMIv/t?=
 =?us-ascii?Q?upxnETjd9RhHLuqKUBRibm0EywcpnJEnA4mG/aeizAVzh0zCcDvmnSv0SZjF?=
 =?us-ascii?Q?Q+J4xZSHyhFqlad7/2/M7vdkFJ9nMUi5QKwikMnx/0/5e2PRi9VJ2SGEOwOi?=
 =?us-ascii?Q?gPOQ091sRw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030d2d18-ca0d-48ce-9357-08defb90e5a5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 12:21:28.1241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URc5CJCBWicPSiBMGEJXAgdN84NlIVW+/CAL84lYjGpLbh7K7ZiEwAnq5qR5GfQ51vdLvuORz/SC4GRaKGexUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573

From: Daniel Jurgens <danielj@nvidia.com>

Following patches introduce capability IDs above 63 (e.g. 0x800),
making the capability ID list larger than a single u64. Remove the
cached supported_caps field so the code uses data->supported_caps
directly, transparently handling a bitmap of any size. Remove the
build assert that enforced the list fit in 64 bits.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/virtio/virtio_pci_common.h |  1 -
 drivers/virtio/virtio_pci_modern.c | 10 +++-------
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 8cd01de27baf..fc26e035e7a6 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -48,7 +48,6 @@ struct virtio_pci_admin_vq {
 	/* Protects virtqueue access. */
 	spinlock_t lock;
 	u64 supported_cmds;
-	u64 supported_caps;
 	u8 max_dev_parts_objects;
 	struct ida dev_parts_ida;
 	/* Name of the admin queue: avq.$vq_index. */
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 6d8ae2a6a8ca..ef4a64eb9982 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -304,10 +304,10 @@ virtio_pci_admin_cmd_dev_parts_objects_enable(struct virtio_device *virtio_dev)
 
 static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(virtio_dev);
 	struct virtio_admin_cmd_query_cap_id_result *data;
 	struct virtio_admin_cmd cmd = {};
 	struct scatterlist result_sg;
+	u64 caps;
 	int ret;
 
 	data = kzalloc_obj(*data);
@@ -323,12 +323,8 @@ static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
 	if (ret)
 		goto end;
 
-	/* Max number of caps fits into a single u64 */
-	BUILD_BUG_ON(sizeof(data->supported_caps) > sizeof(u64));
-
-	vp_dev->admin_vq.supported_caps = le64_to_cpu(data->supported_caps[0]);
-
-	if (!(vp_dev->admin_vq.supported_caps & (1 << VIRTIO_DEV_PARTS_CAP)))
+	caps = le64_to_cpu(data->supported_caps[0]);
+	if (!(caps & BIT_ULL(VIRTIO_DEV_PARTS_CAP)))
 		goto end;
 
 	virtio_pci_admin_cmd_dev_parts_objects_enable(virtio_dev);
-- 
2.49.0

