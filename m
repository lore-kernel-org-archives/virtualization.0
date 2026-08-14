Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD92A4756D4
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786724759; cv=fail; b=MVJqEFpBbE6q8y4FiWhUxpp4ttGGhRMCweKs825qb+eH1yQ+1pnvewK9KFJHwGVlc517HRjAMiTNMHy/6F8Y963FjzDukIEI5vl83z7+ZVDIu+rYOm4Kr4exBgCflc9NmVq1jlgYr3XAN34HkFzrpZya50I8TF5XgdnidUWQnMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786724759; c=relaxed/simple;
	bh=nrHpL/PUGQRdbFUXOKIzuMDW3jlpK5MmHVwmo/s4tD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cUDirtfrlW/jESZcY4o2GrwriP+3p42crqfbL891UtEOSrWeL4PrP09xAMW5NE9gU9a/tSMd7RKq6gQ6yMqaUs3gG677rBQsaOs0OiNF/scgTSl4OifkAVPVliFH7JhMprJaiq3PVLdj2our93BMXSKjCxGo0FPQl3HLmcKRUVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sbjL02SN; arc=fail smtp.client-ip=52.101.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sbjL02SN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WY8oQk6ZqH5teceRaxq6KdZsfiEYFYwo+1NS1M4sUC3iC2TSqdpP9rjh0hYs67CVSP+EkyFtUpSfu+vjWxadkR4ndo8VpvtqjvlAHYGasj2vHBPdZzMu62XgIbgr/n/14T6455TmK0tNrWYcvhrh8VD9/RLzH28HJ7hxUMxU/HgJ1iVaYhyU7X5+J6yCGRPSNWWES+UH02anQiofJGTQmK7s3uYeAGC/FYMWtNyumwnQkZNA25LlAZA7Gb5PXeG6ScNuQaTiDheLRjzpirW3DEcG8hHNF07eVydR2S2T0+9IkBhIMSnZioZcEDCCfm1lQl6cuX6Fk7w9FX9DVatk9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCdiQnWZRHYsW5933frXmJw4AcAMfBbjsdIYuV1qQHo=;
 b=JIAYxtes5ac6Pxz4RqWIaQ2tFZsIs+jGsDV/5or9IvLYBTQWWy93nhJUkqPuw7Pg/M5D6VDhhP/NDiHgOMH+2djXuIEa3pjey5f6rtTdR2EyBeWDlvKF9LHnfF9ig7ChiRHfm6bmNxMZHZbcPboDpUfpLFND/2boJaT06Wmsg/Bgrvdiycj28ksSzYvvk8JB42JWbGCJduZRNuB5eRSPq/9yt7g7l//ROXc3w9Ml3C+iIiORjjkkWNj6l15Tmw/wvz8D4KvzQOICubS3YO+RLVIc5D5WfU4akmn28dMoHhzUjS49xNeqvH1noPrREi7hLj0bT4Gcus89eGDLqEEsig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCdiQnWZRHYsW5933frXmJw4AcAMfBbjsdIYuV1qQHo=;
 b=sbjL02SNDEzoPnT+rEULq5ITV2fX1JjJjzei7dvZcO/e4z+Fe7mP9VmAS9/vrCGAIVt1FJz0Rx67dNwC5UmQtB+XFg7JRMuWD9xnqHlMxrSf33ndGKtUqZ8GUYOTEk2PyfCc7JCq7Vn8er27SIUmvS23UJ1UZDlVMFqkQfOJeTiwLR0kyCjLBBLWz7IunXlNEqt6F3G0bgSba4oUzj1xJ/lzSsS5tsXPIzaq3L4ltC3I4l8xVD0pGKhWGCqvD2YCc4I1O9ylnFdCfEKk4jjRTrb+QdivBiyUU46zM2bkM2hFR8XeOOzG3XRfu2gdkoQXKyUn4ReNFnKTePw8D3jqcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PR12MB9573.namprd12.prod.outlook.com (2603:10b6:610:2ae::5)
 by DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 16:25:52 +0000
Received: from CH1PR12MB9573.namprd12.prod.outlook.com
 ([fe80::d88f:a143:5f79:c148]) by CH1PR12MB9573.namprd12.prod.outlook.com
 ([fe80::d88f:a143:5f79:c148%5]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 16:25:52 +0000
Date: Sat, 15 Aug 2026 00:14:56 +0800
From: "Liu, Changcheng" <jerrliu@nvidia.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: pbonzini@redhat.com, virtualization@lists.linux.dev,
	changcheng.liu@aliyun.com
Subject: [PATCH v2] virtio_blk: add use_irq_affinity module parameter
Message-ID: <an8/AKBnqAAa6y7M@yokbvdiprd370.nvidia.com>
References: <am2QeS/lS+Cova+I@yokbvdiprd370.nvidia.com>
 <CAJSP0QVSBsg0_pCaxy8Sar3=G+sdj5Z8R5yNmUomGy+C5YrHJQ@mail.gmail.com>
 <anP0FimfttCpDMKW@yokbvdiprd370.nvidia.com>
 <CAJSP0QV1=SUYFy3XKe8tWeore3EVQEjN7EWfLZ8QLm8qY4rEtg@mail.gmail.com>
 <anvZfVak5FVjuJSZ@yokbvdiprd370.nvidia.com>
 <CAJSP0QU0Ys6Kb+hbftW1CaWT9pyZ31VzUJfTYmVZGqHGubgsXw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QU0Ys6Kb+hbftW1CaWT9pyZ31VzUJfTYmVZGqHGubgsXw@mail.gmail.com>
X-ClientProxiedBy: FR0P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::12) To CH1PR12MB9573.namprd12.prod.outlook.com
 (2603:10b6:610:2ae::5)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PR12MB9573:EE_|DS0PR12MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1a4042-9ddb-4296-824f-08defa20b52d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|11063799006|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	5lTs1VjNG4VGlUtRsrl+O4IThCOUtHz0JRAjjxtLZJH7QU8yAs+t0FkA7Gqx/B7kjxHCdo63Q5m00FtEbRxNEvBydmHREr/W/46Bc4hKhiEVuwhK3TRQ+Aq8WIQfwVB1uPIGL5fzr8Jqp95wB6yfS9fCCP4S5Vth3PijkWSgAtIqlxF1qoJtLuIHhNyN4RpKVp7gWhtR7RvR6IImIyDsr4PtzYpU+ZvWBqVNmcOZiNyf/1wN70hsQ78NM5cV9XsbQdQeQdiPQWsinwepWaX0Ey+jp8tSOyNjK+vAvtqVarUnzRZhpw/oYF3U42tMJahQO6Yny5O2XWFIXCBOqmiOZkhGd3OC7HKiUur4XaZtZyGqvmgnHRZqCkE4Rxszm4WcaSVVvmQXTmD53Jh/SEdAaQ//db/Tku800U2OwxeanQsrnJKe3twAxCN4LKl8wyqQSe1tEFbNuRE/WeemliOShsDrdzd//gUo0RjetxvwEolt/aSv8ILAa78rLcIdW0I9F+P6NUlqvfgBHdvF3SV3ue2PgkIEQ51HUkihWlUD41dH47WhsUXA0kDJea6Vhy6qwXh9qwLxWr97KiloX1cDkFvNP3aDtNCyKFf5YuvBAuvBqFQZuQYSFJdMNGL+L7Q09UHrRNkzsrUC+C9lIrBG3wuumnGmOg8nP4/jMvMx6SY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PR12MB9573.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?USh2faYHQbF1+o+nFxakk1YTLK7HXAj5TWVkZZ+pt+U0B/B54vWPKGxQT9d4?=
 =?us-ascii?Q?C0ATaRoDQekluYgMi6I0mxt5HfFklYAnY7wNt3Dd4LAHZ0ogsAwCYuZoLR2B?=
 =?us-ascii?Q?sv45lvfvLa+Xo8lwl9nO89LtBzaBpFSbp7KMorEQzpnIFPJivxsGuI1N6COO?=
 =?us-ascii?Q?XIylubgxjnGe0lDi9ulMoG+CoLT+QTCNrgvKH6z6RxPXjTJ3OmydVQ5K1OpJ?=
 =?us-ascii?Q?JFq1igq9+EA6KTpeL/CkgT2Y4hSlG8kQClAkpravwYTUQZheDNw6X/iEdm61?=
 =?us-ascii?Q?PsXI/0Cj3EF/LgDGS5nTwLFlL5PQ3bsiNRKOXnR80OYxD1f4G2SxsZM+ky6B?=
 =?us-ascii?Q?Ug/vkqR99OAMhXhJ3p3uLlbJbJfK9QpZM5Ga8BFp7s6DM5nh6/bk6nr6EfDq?=
 =?us-ascii?Q?TLsUQSWb2kZPXrI8sOgXYWoFbIbgBckSILczYJWpRJWuZw4yor2/uKzYLjBJ?=
 =?us-ascii?Q?aNZB3qbrwmP2r3kmR8WRwR+ChhMR6gqHTh9ApWe+GvRlo+bJhD4gaUdbQcoT?=
 =?us-ascii?Q?/prAaySWHU8C+HDvTIdOCFqDVQG1kJ60V/9glFEkFr+8GhuYLzsF1TPRxsw2?=
 =?us-ascii?Q?1Y1SNhJyzqw2ddJdqmFDMIvA70TPiJA9rtLXpZoYg60bMonBQdC88VXaCn6C?=
 =?us-ascii?Q?ul1vuGu4Z+saG5TB3xYkxAcpthLfuaDHuMxrwpLH1jMuGjmeC9YD0GlxTUkJ?=
 =?us-ascii?Q?hk8+USsJaSIGX0hcL7CbhAijGBkhSoxae7IQ4UXQvTNhc+TcgNRmcrMC7T8H?=
 =?us-ascii?Q?aLevZLJCZ3rV6iht7zTJ2RmP9F/PvjvcHuOWna5wApBdOp7AGA1nLmmZHMKm?=
 =?us-ascii?Q?bXhxYtIF3HsUmhI0bMmwXYZHIhEFqHj1PI4Y3Vvg8VjoY5IBtF1988atA5Jv?=
 =?us-ascii?Q?XzcriEZZ0Vnh9KOLw1r197PhU+efZquC2kOsMkw2TCYaHBKxDqH2XzZCbeDL?=
 =?us-ascii?Q?EsvsceGVsLABhXtdG1UF6Aj4s1/vezuMV/2t4zrD4bOSObCe81wn3MThDph8?=
 =?us-ascii?Q?2aFQMJ+oUgyIUIEX83XgMCbUQD6u03O+mdkhSc9rBEFQ1aLLGgc6logTn+Sm?=
 =?us-ascii?Q?KjqIA5OJpdpaCC1D3/vuDSAtGT/ADYDYxEtqZpuNEyNVUep8AHqoGwrd/FxQ?=
 =?us-ascii?Q?//f8cYF7nPedG9Ds6OA6A+1NVqJauakw6d6QuT04ct7umOmWPML34WKqub6S?=
 =?us-ascii?Q?GAPgRTHFlh87tq4FzAnnNVjg9+OV148KZ2o70Frfs0e+zD8P4Mt9F5er6Cr6?=
 =?us-ascii?Q?IPf09fJ4IL9jY3bJj+MGWnylEDWObQkbZ9fQFE5bOnTQA2hVyewE2AVUs5Ep?=
 =?us-ascii?Q?C+S7YmxlxkWotE3w5bw8TdOGo+vx3+6xo+8hFMzkaf4kXO0wEpG1/JyLaKcr?=
 =?us-ascii?Q?XpGcg9TOgTifhCjpxPCRWVoWdS6UYkeRdeCWVyMNLNt0AKXEO32kippgzl+9?=
 =?us-ascii?Q?19ocVDXS5konyQMOyatVtuJDnZzs7gqS1/wkWSXS56yWN/yqOJ76Gl7OIeVN?=
 =?us-ascii?Q?DBE5WwY7qyxYibu1JnvEBdNzbn3aCobgZzcFQwjYjP8o+4eJnQsZfNIrpxyQ?=
 =?us-ascii?Q?xZiy1vVI5qkoQ58iANO4UiuE6+lWR/Qz+AANbouKHWmrGYKIWfebqW+vMGvJ?=
 =?us-ascii?Q?ARkDf0dni6/iuP7aVI0akxJCUOrCkZwmKqVFGNFYUcx757SXnCoF81iXydCT?=
 =?us-ascii?Q?7a6stXAFMzSCitaAV5xlkAaWCcOqlEVoLybrTlUjqWFTsCJ5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1a4042-9ddb-4296-824f-08defa20b52d
X-MS-Exchange-CrossTenant-AuthSource: CH1PR12MB9573.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 16:25:52.1129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8bVlfvRAR6l6s902sZIoSgmXfksBALQe0QD6t9Qgx6178Rg+p4Z58ItdMRBFwiab42XwFE33SJOkg/kcUN4AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319

When many virtio-blk devices are present, managed IRQ reservations
can exhaust the per-CPU interrupt vector space and cause probe to
fail with -ENOSPC:

  virtio_blk virtioNNN: probe with driver virtio_blk failed with error -28

On x86, the affinity masks of the managed request-queue interrupts
collectively cover the possible CPUs. irq_matrix_reserve_managed()
therefore reserves one vector slot per possible CPU for each device,
even when the device has far fewer queues than CPUs. Once a CPU's
vector space is exhausted, further managed reservations fail.

Add use_irq_affinity, defaulting to true to keep existing behavior.
Setting it to false makes the request-queue interrupts unmanaged, so
each interrupt consumes a vector on only one CPU. The vector allocator
places each unmanaged interrupt on the least-loaded CPU, allowing the
interrupts to be spread across CPUs.

For example, the reported 64-CPU system used one request queue per
device, so each device needs two interrupts (config-change and
request queue). With managed affinity disabled, 800 devices consume
about 800 * 2 / 64 = 25 vector slots per CPU. This stays well below
the per-CPU vector limit and allows more devices to probe.

Signed-off-by: Liu, Changcheng <jerrliu@nvidia.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 32bf3ba07a9d..184f1c1f4485 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -41,6 +41,11 @@ static unsigned int poll_queues;
 module_param(poll_queues, uint, 0644);
 MODULE_PARM_DESC(poll_queues, "The number of dedicated virtqueues for polling I/O");
 
+static bool use_irq_affinity = true;
+module_param(use_irq_affinity, bool, 0644);
+MODULE_PARM_DESC(use_irq_affinity,
+		 "Use managed IRQ affinity for virtqueues (default: true)");
+
 static int major;
 static DEFINE_IDA(vd_index_ida);
 
@@ -1016,7 +1021,8 @@ static int init_vq(struct virtio_blk *vblk)
 	}
 
 	/* Discover virtqueues and write information to configuration.  */
-	err = virtio_find_vqs(vdev, num_vqs, vqs, vqs_info, &desc);
+	err = virtio_find_vqs(vdev, num_vqs, vqs, vqs_info,
+			      use_irq_affinity ? &desc : NULL);
 	if (err)
 		goto out;
 
-- 
2.43.7

