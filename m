Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012004.outbound.protection.outlook.com [40.107.200.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE29C47D46C
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192678; cv=fail; b=tdFYks+dJAckwpKJ3PIIAOkmuNtVcQNUubmkGWU8uhLxSOcZqtHl6QLY0TRbsyYxcu/HHq/6bPWvy3xL3+5PZ4UbuaUiwMO5iBCD0K+Ph2WnBIK2Zr8I5dPooAHXfd3InNbKFsaVeOT5JDsHcgUGwsv2hM1EI5gYuPMd8mJeS18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192678; c=relaxed/simple;
	bh=jayR55tE50PzgiZZacQjgEEUuTAyLLaRpclfWJkSFYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gxYMb1qBmBVUZEWTkdBVsVNFV5wVr8b1Qn7gyFk0p9p97O1HNC2cCpvr63yzbWwZ4ctgg5Qe3pc+UskDheh/Nn/vJs3ORW22F3LD4sjgwGQG0tGo8ZFZEXan2yN2o3yljeZC+aheJTrZxbKu89i345+LsDdDxqPFQsl4/NF+8lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TnmkE3I/; arc=fail smtp.client-ip=40.107.200.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TnmkE3I/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyEEohhxCmKf4ClmdcXifzhKc11k1Hlj1B3TSDuuIzDqXfyz6xBlag4q1VovW1r6yYeEy7/JrRH7+PT0fPwt7WgFe+UAsXMjDZ4i9a/mdbbLKPtP2HhPf/rjgnJqL340zuqXwglhDugbaKCEl39aangjoohqZC3G+fwIBjtpryQ89e/MVk9W2yhYF5dVOuTs1CS7O+7kIRVB79m7YbNdHwmb+uCWQShM6uWts+SzvinBgdQt0sDWtepPwntfODY8Z/zFF7DnC2QoKl53YG1QO3zyag4+yA8BFi68PnO62BiyNricIeMY/MiQbHyNRrLEaEZC14+NEfsaTFWXQEomBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLlYyJ/D+hsAZgXCKxOykXEhynWchWO8ysVpbEBwxPE=;
 b=AsoMcERcFYEz2dcntnaahgOF3rs17L5RRCQSNQBVHewkT0Wa0RMVh0+Pt0RlHAVHAhb5AOVZ6zZk3TNOVkTWpJEYeW1Re+CxECY4RPSUaS4rdVk2SB8rUOF6rcrUQGSSYGcBax8mD+UDiY26muCcMaWvIJAqGC9g0aRagdsbxew2IEwHdzz6MAvIsdCiwY2FScpNEOirrgI8NTnG9PD+W0UL5ZLv0ReokqIAT+kCZZwBxBgUVV1SpP9qUXoMLH8mAv8HqnALNDo6ixsYyPGLafhFsb6YcCod+lNOzCNqgEI6BzmNWVK9lmRqLpZIbjYURe/HwitPRydkxLlADZx1LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLlYyJ/D+hsAZgXCKxOykXEhynWchWO8ysVpbEBwxPE=;
 b=TnmkE3I/KMN7FlzkaX7cYjp+SN5PH8xI0euJttC1f29zx+bI9TI74VIz6m+gmUC89Z33ifJaCxfroasuRM+9gzDn2cpM4B8ebZzS/bkE6fU0Y1fRdLc1jkH08r9KVl+Rf3YjqcMgTV58LDk/iykYLj3a2wd4DNsWmBcRNspPONpZ4CnFDwHezwdm+hBeFYaMNyGwx9sD8IYcIKWE4EaBHX/Ee1vm029IuoRQMEeP41ivYCm8LqLLfVV/do8GDdXZcPuOmUEyKMqiSre3ratuIbdBcoEzSoInUWyRoTFN6PLIb7mobndNk1e3j8cr89acxqy8honnIjaWutF+rv7fcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 16:11:08 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 16:11:08 +0000
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
Subject: [PATCH net-next v23 01/14] virtio_pci: Remove supported_caps cache and build assert
Date: Mon, 31 Aug 2026 19:10:56 +0300
Message-ID: <20260831161109.2999926-2-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: a7d5ae87-8e25-408c-fe5d-08df077a777a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wSxRmpfgfAyM2LoNSr5AQk5q7jkFphNGMAuUr9MQtpz12E+QJjXZQ+1KAYQYeopsF/CurCx3JjXxHOTWZT14/ftgrJRwRjUd/4qk7nHdI49bQU7/82+fHzXVo2sR3UjA0J07AhOZUFWROMW2Ls3jEmtcq6panhtWRp01tuD9DOlWiQ+4lD3c9MEWkjwLQmlEvJLrN9hx4c6Swg0gbmgNjcPI9sQbofWLM8tCz6Mu+lzqC9CXs4qzCIR4zNs1bRS9QBIncTRvz52IfBlBdCpOSLhjf0OoDOf/r3sCHiugz7pS+5NPqWyw0oOWFaO9RFqIh+1O/GNCaAFZdrR+Ib78lTSfwapc870R4CdcNfDtHi9z9z+lqV/g8LdHkakZqenOpCC7PywXIh+Rcff9Arfnu2cv+J0ZE2d/5RhsTVuRD5N812xLjK11quCNSQc+Hgpmqz3SLWDCAI2d/0qLvqaW9liuBPx9O109cmLmWlOLIhhmMdr9kn0pIPkDgja+urYz+20c73T+R0kHAsoT7tgdQNET1ZA46i9synjJxSI9iY6M9n66S1DOGzseXEi7la0J+yUKL6hg8HZ6wtGff71XOyHfHGpFrbdQkF998Ut/liurRB2Yw5Ry/mbUVaSM2XxyzXo6I06ONnkYpSocPB7XAG8xKTlUZeouoEIOCCSL4mI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rfRAw3Dopv2ZCLkPCZkUn7g6yFf5HQM3d46XnFtUeDe5cnfUHmI7vLpSpo8X?=
 =?us-ascii?Q?8Z7uGhqRjgTqcYADJYTXT5CmPzxPGCZYQZ+29GOn226W5sDGrU8PLI5ruG3R?=
 =?us-ascii?Q?UMVoBsdVkkSLaUBKKubb/p/ubkoTMbrgoNyIv/ibi/13MJ5C0q968SUn3KWH?=
 =?us-ascii?Q?JBTUrMCPMgdXcOgQnj/xdXziP94uzbY2k59QZTOgUl9pVMlJRSQ+MIaa31Jy?=
 =?us-ascii?Q?SfUjrxiljNExO7+D+SB+Qkl6T8WMEUSqWFocWcCDT0+6DLNziZ9/cEzRckjz?=
 =?us-ascii?Q?XAJq68j12Te5ssfyIZN0FfMc60SDrMUXkAwbzHjYezXhJBNJjHJ21LU8haET?=
 =?us-ascii?Q?GdgzBS5Aps4MyGc25Ir4otJ1C+VywxRqZADgpiNI5H8SnnEe74BGypmUvs3v?=
 =?us-ascii?Q?KPq7+u0CFO1LsvQL6oXxUQUWUxwbXsU3Db2VSm4Z96Mf1m0qIxJDN0KKEC/H?=
 =?us-ascii?Q?CwNtbZMAwpmKpx+6HT+DSGDz/ERnqBtxelLXR/r8zG9Az8yBL3k3W2vmtOOQ?=
 =?us-ascii?Q?fhMBXVdSDatrPCCcjgBUB8sEFLjaNQq6sw5GGqAH4owQu84rhckg0caOBiNA?=
 =?us-ascii?Q?wG7QswfDwfSMsDqH8ss3bn6P/kL36jm7zWtlgKEU8ruksszC/9uIBHqrNdDZ?=
 =?us-ascii?Q?99xzjKD4ySa2GdsN4atzW3nYJ+v/aZ0qhGf1A08w9Oi2KT7em5pp/gmkmdA3?=
 =?us-ascii?Q?wLrxGcNv2XRZaGBVFWFfJQGS37+5vqGo9aKA6dNFtxPmLma2T5BNfeXqiuJZ?=
 =?us-ascii?Q?Ox6BzuW9jCQSHbBX3euefmhFI+zLbiaKdmAr4Jjfan9VROqnWgs2OSuQxjcu?=
 =?us-ascii?Q?yb4JPGZf/DZOr7/HGfOd8y5jbWbUNuD+kKwnjoR4sNsVW5MdrBx/Gh/GNfT/?=
 =?us-ascii?Q?nhbUJaIyw4nQvO0nEXs3qVAtmLJryOLcSVZQ7koTR6y0hENvQWuQXnlPVNua?=
 =?us-ascii?Q?0IJW6drUQgDtpmKD798P01rFnVlwsHfpO0A+WPtkFsQplzIYiExWbIJ+A3Ay?=
 =?us-ascii?Q?o6ZiovNG4ROkXPOsmfV8Y/BXZpJ0PJHm3PoiaPrDLyTsya0m3V2tdUPHnCW+?=
 =?us-ascii?Q?R6fcg+Z8lFich+t869GW0+LftmRxkE8Kehi6AJnUtAput76R1OXnJPEPofhH?=
 =?us-ascii?Q?p1ENCfAqWbqsrJg7rpqf1MERu/elFIoaPaOoNF5S6J89LWS5Felf6vkotY5t?=
 =?us-ascii?Q?Ut5pXUY40GoF5m5y5WZRbj42rebBl3ZwMB3VE4FnRjzzpaAjogcWxPzkx4yG?=
 =?us-ascii?Q?xWAcI6PTPqnH2dDbEMSHZiwmFNDIiu9bXo9xW/OxwIlIDr/s7EM7rcF4+Nv2?=
 =?us-ascii?Q?gh/zR/6VE2lZ1jtAK2dRnBjr+yJXmwgKg03nC8xNhEU5u0PgIn5JAzhINC7i?=
 =?us-ascii?Q?rNOc0NI88fCh4ksVi3t9dVcgchRrcHba1AXnYBeqVa8YKJofEKESTYvNPdF+?=
 =?us-ascii?Q?rryJL6avNyAP7OiIZX+JBfRlykypXG87QPD88Wgyc8ZZA5Is5cpoy2rSjMZA?=
 =?us-ascii?Q?nOrwAweOSx0hOlfJlr5vWn/ogsNANuezr8skKF6l/A6kfLKUuCD8vSUuAdfi?=
 =?us-ascii?Q?SQHOUtgHTQvmFY2ZJE5bCpq/ud4HfgdOXS1iaqD2mdjDDL8yVwMo5k7eSNyL?=
 =?us-ascii?Q?aYoCCzJCkfuzPmKLaZ0sk7Pt4D+RoxBgwy9576ZA50V/fLyqJyLYD56czTmE?=
 =?us-ascii?Q?A3iUlKF8N5Zz7XlY67N0M8FodKcs3IVMq95cFAdCxZHNXFmQaKZRUtjn6ips?=
 =?us-ascii?Q?7edQl2QbCA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d5ae87-8e25-408c-fe5d-08df077a777a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 16:11:08.3102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VWrPsx3sJOtCxiZou/NqauW9xsmCnjLRicWPbF1jA04PKVIyG4/wMca+txFQa785OFx7R9pOFFgC4WleGh8ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353

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

