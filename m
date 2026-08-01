Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103D731715D
	for <virtualization@lists.linux.dev>; Sat,  1 Aug 2026 06:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785565316; cv=fail; b=OEkBXLyydlLyatP5eq5mPJzXws5+LpHWTuHmyqIBzgnaWaCxkll8L4zxFLJJOxv/i0htPi8mBmE5E4GQRS5Yw83RQMu2DVIL8/4ky+/WihGU1BWqIxw7QB1F9bIQkPSoSwQ1RtqZqGxx64USfGNKW/Bd76sAvZEnVZSiF9+gRSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785565316; c=relaxed/simple;
	bh=yelI34RoFWDEX8zalzUFBrCTZj2ufsRlPowLXPmJbvk=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=PYvWb1Q7fetgzqZQkduC6hqPVsJShbofvmZcu98i26uaDUKu0dfBPsholvX1DS2GEhezubQZ4nn9LXvXCtrDZKA2XqnsY9qORCn5i9kh4tNXD2UOL4relfE0Dthtnh1n0MaP6A7+65unQ2hRXWVGwSpsxUGiVoNAm649aVxpeIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gZ+Sdx/U; arc=fail smtp.client-ip=52.101.61.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gZ+Sdx/U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIv1oIcvxXpwhTwoNFtlhQat1fNmCcXDxPsUdFRMbnSIckhDdc/rLU7Ww+ujxKR1nnkyFtXiN3ElU92fnIZnSO71Elw/FP1GTDaXuyQjRPz+zOlPvx62pC6cihtaknMHhfieIcHbgCzQU6X/IAHmOUj4wjlmRNBxb+CyShA3sxYNldILOMhnWRigyikRDe/h9Kl/7Y5VPfaPJodNWwXytkQTuCKNUuyfNcUOgZKPiHbUQ05KW5z0DwQhgaaX6awZJb+w1M4Kn7TR/vcTcseB7Sio5M4dLar0R4uSUUtrVjlinzMLa8uie5Dfe9V7MKuGfeZXEYXKGsNfkEBEZyFrFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbuecCfKwN6RgiNWCHIoPmG2NHJuJy1iITTgwYpTkUI=;
 b=Rpp/Ye0H4FQCyNEsc6yUc9rzC5SJ/S1RZqpoccGJojPhjMLJyTurVfEk67aZsLmQxsfNU7+970qx8TlZ0YXVAT4pBbPI4xI1NLB99DR4kIVMNV4xhqMmaW2XeYKwVscD27LFSagN50esVnEWWhE5RRCAQ4FeyFCAXAUCzOuololb4pt9WddPk6YFox9NNvS86zV3tGImvIRnV5+WrFMNKFIzyk3owblFdWzxT89KWxsDDwPQFQvtZ2R01BKxuQ9FoBXJ4MH86ndseJhEsLipg7Vvof7ODR9pd/wlHaAsI9tDRW7IDlOGgoswIp6CGB5ibEKV9vpCKywA7KSMq+eQBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbuecCfKwN6RgiNWCHIoPmG2NHJuJy1iITTgwYpTkUI=;
 b=gZ+Sdx/UHQ4TKCO5/5J32kwUj/ciImJjW6zfJDS0I8DwEVpG25QncUzAF32DbeVkH1yuI2Cqpra8VSqc/PiLyraDyewUs9D4CTP62lqSwEpABwVaq+LjBNn4K7kPNj8ERCn2new6TF/HC8X/NNXNXJFrVOmqH7EfCyyr32V8D08KOjYo1h2TdGwwY+eW5toBNuTNtAOdwxECdShbUe8i92pWnTFPCcY0ecR8qibvewA4hJlzF8J8UEGz6rf/3TmPcrpK6i936ZQX3DTLS5wqOEKccctEuohgMxmdNjKrQ2pKqmyRyo831WUnRxqDiyZjWMt4TK77773qHDlRUtqYcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PR12MB9573.namprd12.prod.outlook.com (2603:10b6:610:2ae::5)
 by DM4PR12MB6086.namprd12.prod.outlook.com (2603:10b6:8:b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Sat, 1 Aug
 2026 06:21:49 +0000
Received: from CH1PR12MB9573.namprd12.prod.outlook.com
 ([fe80::d88f:a143:5f79:c148]) by CH1PR12MB9573.namprd12.prod.outlook.com
 ([fe80::d88f:a143:5f79:c148%5]) with mapi id 15.21.0270.016; Sat, 1 Aug 2026
 06:21:49 +0000
Date: Sat, 1 Aug 2026 14:21:45 +0800
From: "Liu, Changcheng" <jerrliu@nvidia.com>
To: pbonzini@redhat.com, stefanha@redhat.com
Cc: virtualization@lists.linux.dev, changcheng.liu@aliyun.com
Subject: [PATCH] virtio_blk: add use_irq_affinity module parameter
Message-ID: <am2QeS/lS+Cova+I@yokbvdiprd370.nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: FR4P281CA0428.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::11) To CH1PR12MB9573.namprd12.prod.outlook.com
 (2603:10b6:610:2ae::5)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PR12MB9573:EE_|DM4PR12MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef0e748-cdda-47e8-423f-08deef952b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|6133799003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	tVHgUxtZ7e6FnwZsmxQPStuzOkigaTpyWmpzavui5pC/tldAr6swmztzcJpAaIrX+J1AiYnq6VrmfUB4SYyyuAYL5OxUqmtS6cOU0+6VBFgU5jAQJKAMEh1sqTF/9Z/ji6Gocniono+NrVb/KHg2b7GVcumnZVGt7f800+Z0qZoSuvgkHY+rpY4WptrIziJVgnaXqW7B/IWZLOAVd/BWJN5tO4aifDkunjdEM1OqSyyZqPSEuhId6Ao/SHu3NyI9Y4mbmOLZoF5kHUFW/6X1ZqmsWWZhIJ9NnM5rYy+3AX2bxui6jJhODDX6AlQ1Do+Osu0cR8IgU9kYrm0/op1uxEkfcLslYAKAHTpWrwNJMeh+MigcArSED0jmjiONLEhI2dCEw+8qI+dBcQn2ZxW/1eddVOzn8tuy0zOtamMtS8UvNrR2r5K8tLAnkeCVyg6Lb9KDm3O4KmYVQ3dIOpm5edhWJuV6/XgHZjcZ8jU7IvF+xaLYp6KC0MedWsdiF0hN4BSRe9vORHZCKdj4jc+Or9BB6FezasaKpXXFJdp4Kjm2V+VOL1w3YVRpw+4Huhj1CN/m3id4lM3Wn4DG1oXu81ppODvkgCgi461pmqwSiwbHBrcR/XIuRDvUov/Tnd0gHH+EWAiYZL9b0SiRdVf+Lp2wS+eAra7mcptF6povn6A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PR12MB9573.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(6133799003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cLMQZrRvIfvkSdN2l4D2ZtE5TEtTAU2JFYcM7zWYbCkd7v1vXICHT45WGb6M?=
 =?us-ascii?Q?axoMIi28t9PATOR0XIWCUHHUkZMKCgviAM954G6fuHFZf/qv8gp+NpEg6bVg?=
 =?us-ascii?Q?lu2jPU7KcKhaGwpXTVcsy0j5TpuRVLweb9o/jqM9VylpXetKP6pLGdn5ozbq?=
 =?us-ascii?Q?7Cv1JB3KoNL1O2bT2JUwtTNtWBFl1FpQZ2KEEJCcctfaKTlBqTuzK8yZhsls?=
 =?us-ascii?Q?nIog4qeVqV6z73odt9XNexHToM3S8jmnmMfHtL2DJyDGLgJohApAJ9YhL9Pu?=
 =?us-ascii?Q?8v9q+ZOJZ9OCUYfzzkk+xhVcP5Je0WkpYL6aEDG2XavzYYOIEOHt78unLrP8?=
 =?us-ascii?Q?YOOe2N15oZIBQ+XExzqNptv8sqXHBwByGdll5p+ogHY+chnMezleeBVFtmli?=
 =?us-ascii?Q?AZlYBe28D5yGYETf8lyj2bnPnYh/nrwZAxbkjF1G9s750bgAN30kDNJgz3in?=
 =?us-ascii?Q?gZ4rrnu5lZCBskWjNYIbzHCWTt7fY6ijYzEIDx4iczRk/QI4SFn0lcdk97aZ?=
 =?us-ascii?Q?qiWh0wBSy+yfbt1h7Ed9onm9lJ0OyeX4PyFPrnKvdh5aS545jsvxw0mpslUQ?=
 =?us-ascii?Q?gGSchDUJIBRCwCHZDtrmUOJBhe7GVSJOgejGbAOKH0Lfkma61Jrbm178cIYC?=
 =?us-ascii?Q?iM2KCSh1tTILKySkCI8ISsiMrTEZhq1dG2V+0Qrs7x6yjOD/amdbR3frYfIc?=
 =?us-ascii?Q?jbtkjrA/gw1srr7VkQzbfNylQ3jnyzFxi9lVaJ3gKz2x5H+Klc3o5eya8MKQ?=
 =?us-ascii?Q?96cQ66/BLUDxsRvsCoJjEQ5e7bMjbHGgkMi+8TRowh+4gTtf/z441XLrXcmJ?=
 =?us-ascii?Q?6GJxNvQJp0N8O1F62HpShVAphRxjsm6lp0HlUiFg3IHDXLdwq8tXO01xNLek?=
 =?us-ascii?Q?vqggCmopsFLEhlr0hArFPPd9HH2bt7Xxs1sFqAklKSmuhTFHHYVosn8TyxAH?=
 =?us-ascii?Q?10ZDFUsGHISWMaxiu+inlEzbyOXA84uQwE3jI0h0UxxLdUh/2OqF85TYEmPB?=
 =?us-ascii?Q?68QdYLrLluZeaRCSNT9R1ykm6soX++UFoy2z0Q/cX3cnzy+eIx4QZPNnUnPg?=
 =?us-ascii?Q?TtSMg2veqDG8iuLpbSriPIjWiIqsqkxjVs8HUnJFPPSkz2/U3pabh2SNz/JB?=
 =?us-ascii?Q?s1St88MyqaeIcuiXpw+m/EQ2TrI6Afc9dLmaN75ho1oIcDvxpr7f0UhAHuqK?=
 =?us-ascii?Q?5WP94hMkdqMK59uQs+CdZMVTa5qu3pVfD37TqOErZjKjYTko5OdM9CIQty12?=
 =?us-ascii?Q?/T3yfwN21t/3MOKQNtRBGuH3mXovI1OVTY1KTZ+bPu/10jAB0w4K9zw/+aSX?=
 =?us-ascii?Q?GBHGWdLNCvCoQGwLfZE2A8KOiVsfL4ZxJxE6huO2lDeVSnMd8OL+c3OtvA8g?=
 =?us-ascii?Q?SicomBFzvIyAhJSGo4iwyt0efeJOc4TIfkWBWFH+xsrLikzMcpykyfT5McjI?=
 =?us-ascii?Q?LO+yuzIfknaD3qryUa0HSZ1qTclCHCYhINSxc29Km37CqWdlL+Lrw1l8yGbp?=
 =?us-ascii?Q?KKZx0GJei77GMxmd9GXjGCdyDZv071I0N287VAWhzbSf9CLgStDQZiBeCUS4?=
 =?us-ascii?Q?EUmWKuEX4lGqe7fntfV6FhpiY8oVInuFKy14P5VslKcIBS/OB7PabJgIPPzX?=
 =?us-ascii?Q?Fu8BSSbqkP367mDN19gFgX/XqCMrmvTDD2JFs37H3K6fCx8OTibg8f8TmmJM?=
 =?us-ascii?Q?mfkCPOHd8VWJ3rbXULwto+pCEykOcwazfdATesTTdaaO+yDR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef0e748-cdda-47e8-423f-08deef952b41
X-MS-Exchange-CrossTenant-AuthSource: CH1PR12MB9573.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2026 06:21:48.9236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AryqUIW0zSFXmtwWV3vsy4p1oZGbCR3rNBuSO9pgXKsMnLc1w9qkosK/Q1wXMNl4GMk55PR251lLJWxkVj4bkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6086

When creating many virtio-blk devices, probe starts failing with
-ENOSPC (-28) because the system runs out of interrupt vectors:

  virtio_blk virtioNNN: probe with driver virtio_blk failed with error -28

By default virtio-blk uses managed IRQ affinity, which reserves an
interrupt vector on every CPU for each device (about nr_cpus vectors per
device). On a host with many CPUs and many devices this exhausts the
vectors long before all devices are probed.

Add use_irq_affinity (default true, no behaviour change). Set it to 0 to
use unmanaged interrupts, so each device only uses a couple of vectors
instead of one per CPU, allowing far more devices to probe.

Signed-off-by: Liu, Changcheng <jerrliu@nvidia.com>

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

