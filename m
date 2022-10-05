Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3AAC433F5
	for <virtualization@archiver.kernel.org>; Wed,  5 Oct 2022 03:25:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E932416C9;
	Wed,  5 Oct 2022 03:25:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9E932416C9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ff9/qLkZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yAA24TOtwswe; Wed,  5 Oct 2022 03:25:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BAFBD41674;
	Wed,  5 Oct 2022 03:25:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BAFBD41674
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94C18C0033;
	Wed,  5 Oct 2022 03:25:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A8FBC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:25:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 67EE4408F2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:25:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 67EE4408F2
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=ff9/qLkZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6C92giDx18Al
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:25:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0E9F5400AC
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0E9F5400AC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:25:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0EFrnMvjmeHElekGRfFUfAPqjKw03WXi9kznPolvF30FOwvCPYSerAoG1cFO62J9rEH9x0irB5gmlWufF2OsYUom+i73q7BUT33yVPEkoBerUrFcxdVeqcD3GcfHnXNIlTmXrp7UjOVS62wkpwGUzsjKY9nyK9K+hck3rk1UCOn8UWda5l1DTToEwqSk75ILTBnDEj5gwwnSJcUQl7tWuaTfVoDI8VJ7d/kC0CBMdpIoCwvyifx+z8xU2tnwOYUU5kmU4PDiClmhWQDCZNdmMa0Ugb6uNEv2XNCqjY86dFLeO4+M4It2kVGULDuLoS+NGdch4yO+13R7EG4TSC+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07P3J3AZWbX1SNZwgGbcXr4rBnSoEcLpJ/DhCt+E8FY=;
 b=HQQ3Pu+sTAmLAOS5kogJLwsmHITkPn9pPHd/3LL2c/VW+wnidYb2CWw0LvMOHKfNq6Nr59FYjxOIsYpElk6ROLCYi/LlPwgol8LvWNiggv+5J4Hrmq8nh/tTQfCu6QOdVF0o3O9G74TK3HSIrBR3e8+CKIiAy20DFMVxgpDwA6oU4U1cThP20yzBV7tMPDcGJTehbT1iI/lPeH8ayq45J/GokWcOmZ8dO8bUtRnrNFFjKk7oTaQuWAyYBS07CM2IifK4waZfa5SvfnsU5ainYTcxHb/g8eRbHPu7qk7Uk/wIqqlyHzWzCQ626BwotgXtePQE9uJpAN/HZbUuM4H9rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07P3J3AZWbX1SNZwgGbcXr4rBnSoEcLpJ/DhCt+E8FY=;
 b=ff9/qLkZ6ZiB4AAWkBEMh93fFLshKb6QhYS/O3oPi1kCq2EH2vGBl+M+fIqTeTe4J8ipNHr2zqFHGV/ScmkZOLwp2affME5UkfR207oovlOyoMntu9v0qVDlbhl7XHzXPLxmlVQkXG8V7eWX0WVv3lb3yoWAidi0g9XEFBs4l5EEM+wRNaG5QHIw6sXRd7kbyyADIcW5V4auEKLynTGPg+TxZ9hR19eyYvoajmv/42/v02WRpjeAlOFTTugKAEP0WjilXiCOQBeKAW156b/nnPO7du09822cCbm1IaMzL4MYrtVBkJFGkiN3O3QcAJKcJvH1Jx5qFEgvswL5wcUalQ==
Received: from DM5PR07CA0095.namprd07.prod.outlook.com (2603:10b6:4:ae::24) by
 BL1PR12MB5364.namprd12.prod.outlook.com (2603:10b6:208:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 03:25:21 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::ca) by DM5PR07CA0095.outlook.office365.com
 (2603:10b6:4:ae::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.18 via Frontend
 Transport; Wed, 5 Oct 2022 03:25:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:25:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:25:13 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:25:10 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-nvme@lists.infradead.org>,
 <linux-s390@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: [RFC PATCH 09/21] block: use lib tagset init helper
Date: Tue, 4 Oct 2022 20:22:45 -0700
Message-ID: <20221005032257.80681-10-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221005032257.80681-1-kch@nvidia.com>
References: <20221005032257.80681-1-kch@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|BL1PR12MB5364:EE_
X-MS-Office365-Filtering-Correlation-Id: d8da00c9-ac73-40dd-3068-08daa6813c1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FmfXgqIfG85vTqQrmAn2WzVvy8HFgobYx2GHXKBE5jt7XZuYALCV1d7rS6iKDNa59r5nd06Mlsiz08R786oPlVXzt+wlTaRAulVu8jqNXZ/97YrRCL2xI0wmXPVY63XZm9Fz+OhJYiUEZ11Zl/UR+LcOhNjZJPMixIpEZYDCykihldmtPHRCMjpAG5Fokr0K0nWsr8rouV5S1ZOqWBTZYCM28YL0LO5T1fAspFhXqg0RI8Poip4XujmFSi6ghSSBsIj/zUoz0u9ZmQd9s6OrynIQoT5ICD/LbHo8fFT1Kzwdqsoz9Z1kurYGPclySrAn1AtpTzWhC69qEeSeQSoqFmcENi8iCEKD7ncnuunD8uqfFSlFC7A5aWhjK7MRsX4jVqxfCgTIjykpqhHfSh+thZYjTKBFiC8EhGi/J0qfhRSab6vhmKlzw0cu+m/AlmtBz4GHESVCyv9tD+z6cWgiAyQUFL0K0+kWsl9EbhJuOqo6ZNx3Njbku/zSl55lt46ob7wiGOR6ejfY56r7PCUUAv4W9Fr6wQK1gq0ra4foGyxFmwClljZJD6S2BpveHeD7LVPJls+hye9NWKr2zX5RVyQZzafKVrO679kJ80g+fTuWKUdCu+cxgaCki8j9hpL8nIA9AGvIWEaEbmUP6kJK0b2bsES6Rx7Ky/06UlA6ljcZJIE8CpNPudlazqjVpr5BUdpQSwR8cVLQS9MM2+TauF+z21auxfORHpai/2+gLt+r9RWXZU5GPksyZY75jiGmADUtsV3l4i65oDkMyfqrd38C3YlaqQevnMyJ+UoCUzHqC4oxcJHONU0wO0DwyLktd7wNaWVT0d++7+djVeO8utMWsCx0SWnwm8zTRA2E2c8=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(7696005)(41300700001)(36756003)(6666004)(82740400003)(5660300002)(7366002)(7406005)(7416002)(8936002)(26005)(8676002)(316002)(70206006)(70586007)(4326008)(336012)(40480700001)(83380400001)(47076005)(426003)(82310400005)(16526019)(186003)(1076003)(921005)(356005)(7636003)(40460700003)(2906002)(2616005)(36860700001)(478600001)(110136005)(54906003)(21314003)(2101003)(83996005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:25:21.4347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8da00c9-ac73-40dd-3068-08daa6813c1b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5364
Cc: vincent.fu@samsung.com, vincent.whitchurch@axis.com, stefanha@redhat.com,
 mst@redhat.com, hoeppner@linux.ibm.com,
 virtualization@lists.linux-foundation.org, bhelgaas@google.com,
 haris.iqbal@ionos.com, miquel.raynal@bootlin.com, agordeev@linux.ibm.com,
 jinpu.wang@ionos.com, hch@lst.de, alyssa@rosenzweig.io, vigneshr@ti.com,
 sagi@grimberg.me, richard@nod.at, damien.lemoal@opensource.wdc.com,
 vaibhavgupta40@gmail.com, joel@jms.id.au, shinichiro.kawasaki@wdc.com,
 idryomov@gmail.com, jejb@linux.ibm.com, asahi@lists.linux.dev, ohad@wizery.com,
 gor@linux.ibm.com, sven@svenpeter.dev, hca@linux.ibm.com,
 john.garry@huawei.com, josef@toxicpanda.com, efremov@linux.com,
 ming.lei@redhat.com, christophe.jaillet@wanadoo.fr, sth@linux.ibm.com,
 baolin.wang@linux.alibaba.com, kbusch@kernel.org, ceph-devel@vger.kernel.org,
 nbd@other.debian.org, bvanassche@acm.org, axboe@kernel.dk,
 martin.petersen@oracle.com, wsa+renesas@sang-engineering.com,
 johannes.thumshirn@wdc.com, andersson@kernel.org, marcan@marcan.st,
 dongsheng.yang@easystack.cn, christoph.boehmwalder@linbit.com,
 mcgrof@kernel.org, svens@linux.ibm.com, pbonzini@redhat.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Use the block layer helper to initialize the common fields of tag_set
such as blk_mq_ops, number of h/w queues, queue depth, command size,
numa_node, timeout, BLK_MQ_F_XXX flags, driver data. This initialization
is spread all over the block drivers. This avoids the code repetation of
the inialization code of the tag set in current block drivers and any
future ones.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-mq.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e3a8dd81bbe2..d4cb5c44a53d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4455,12 +4455,9 @@ int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *set,
 		unsigned int set_flags)
 {
 	memset(set, 0, sizeof(*set));
-	set->ops = ops;
-	set->nr_hw_queues = 1;
+	blk_mq_init_tag_set(set, ops, 1, queue_depth, 0, NUMA_NO_NODE, 0,
+			set_flags, NULL);
 	set->nr_maps = 1;
-	set->queue_depth = queue_depth;
-	set->numa_node = NUMA_NO_NODE;
-	set->flags = set_flags;
 	return blk_mq_alloc_tag_set(set);
 }
 EXPORT_SYMBOL_GPL(blk_mq_alloc_sq_tag_set);
-- 
2.29.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
