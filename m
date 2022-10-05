Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346EEC433F5
	for <virtualization@archiver.kernel.org>; Wed,  5 Oct 2022 03:26:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7CA881BF4;
	Wed,  5 Oct 2022 03:26:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D7CA881BF4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AtW4vIqM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WEc7RRntwBmS; Wed,  5 Oct 2022 03:26:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7E42081C58;
	Wed,  5 Oct 2022 03:26:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E42081C58
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 582BAC0033;
	Wed,  5 Oct 2022 03:26:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82E65C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:26:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4FF0481C58
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:26:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4FF0481C58
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5CWL9pnpMBoG
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:26:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7963681BF4
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7963681BF4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:26:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOSlGVdhtbWhv9zc9OBAMWfJ2IgvxmsYv42nd7Qu83Kw2TR2rro15qdTIOj+pGYVGCnehMpg/6ieoOQ6GqUfzLlMsUvwAHzl5crcCkfVEay2isetOMIuSIMOz4kmq2KM4Md134wYAPP4DtHAj62JgqlhhXChprcvwSXwXdhYEimxvwfM14nT+2cMHT57lJDKH4wr1GyfM+hVCrPiYn2yotB2ekBU7TPSVLhKKbMrV4PHFgcOyL9HYR5r4hGS5yggDtjmHR1B+0gLPrRUw+Ruhb/McyT12OO4NKaNMSd+sVXA94qJustB1C6DzcONeuMCIBw1IDbDr+9ySAmPoggtJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvtQcSSmcWDhZX+0HVfQ6RZlEwn8RRcIZqLXHF2Ix7U=;
 b=NU1v0V5a8IT4+bkIeniofqBvhKAvLZAxzDv4Jk7/PVZcSbPos4j7+rWaLRu4M/MRRKefmBTFdxp4CJlpBrgSOBB/31ledRXDOSG9NZ05e9YhZbrunGgQEQr9ageAm1BhlzIyYlRdWJLgH8+0IORu+JRXrQP3826rZtnAXv/oYJQjJnLX9GPxJwcFUTCJj1P7h6GFU6HP4RrqIDP4YRIUf/sRhMNRXQzG3C+aw4rEnd5sZZJ3IM03jI6fsPLIPOQUazD880SWOf0CuVzwfBrL089Ba2mJArQC8idZn4THLv6mVofNG8ofwTEEnLZG09GJFZEDKXyv8nfI/WyqgqQTIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvtQcSSmcWDhZX+0HVfQ6RZlEwn8RRcIZqLXHF2Ix7U=;
 b=AtW4vIqMOeFcNJFz7XfEWrBEmoOr3v+xxL/sEPHYhRFETRp2OXtiFuB53At1Aq24BgosUeQABdVA8lvi8a6ki4Llvl7aLwhxRU+gcjV/DTuImg7CkoEURTdVvvbkaCX86K72DjuD48MmOJUa2ZbTfTl0rPf+gYotWKZZGh2+K3QpDRAiLq3lvlz+QNrzrw1MnGspL0Dd6PVD/RECs/RfUoSjscxR/PlN90pTQ1Ljy8NgRkN6OBA25S8FzCMdr7qC+GBStWicXmRmuI4xYYxmmDoKyNo5p7HMhH8IlpvB0R7yQNEfcQFyivuXYmnEtbkkFWXN99UwQ/bqsSu36dUGww==
Received: from BN9PR03CA0152.namprd03.prod.outlook.com (2603:10b6:408:f4::7)
 by PH8PR12MB6915.namprd12.prod.outlook.com (2603:10b6:510:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 03:26:04 +0000
Received: from BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::55) by BN9PR03CA0152.outlook.office365.com
 (2603:10b6:408:f4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Wed, 5 Oct 2022 03:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT085.mail.protection.outlook.com (10.13.176.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:26:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:25:52 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:25:50 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-nvme@lists.infradead.org>,
 <linux-s390@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: [RFC PATCH 12/21] mtip32xx: use lib tagset init helper
Date: Tue, 4 Oct 2022 20:22:48 -0700
Message-ID: <20221005032257.80681-13-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221005032257.80681-1-kch@nvidia.com>
References: <20221005032257.80681-1-kch@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT085:EE_|PH8PR12MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: b078b526-cba0-4bc8-c179-08daa6815568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1/Xa07vnXheFjMI29181xjPf/HsR552nO/ZLrcMiuv8HhqrNBHwGHlNwGEmYKb2WaiBZB7BnLJOdsdLoZi+/BhWDfAfGzAP7ANPvw5FGFk5kTGfA23LDHbL38TRZRmoW776iNCzU1G5FINarCHbPXDHLj9BabKKVDJJSOb3psqBn7yiC3xACg/msz2IbAESsS5w3nclPkttiHl84bKwD07KzeXSnSTbpNO4RVe4wspfi4yIw/tgRks/C5FpSPc0vLIAfLPINdknc2Vv8NPba9QgmppE69a83TnjP6rVfCqfkD1fFGsO4YMKUw6CW7Xy3uh4NcDgWtUts2m8YsCIIk+bx8nw/1RW7ViKCa9baIs7Itpj+c7rqbMv3B0GNCTpKsWAaw/mQbD0K/xb+6RatPFWW8MykTQHiAC32naFwPJ8kF0rxrpvFh/AfG8f0LX6GSylDv5/bjezQ501GYZnvaXy0VcT83HDOsE1SqU07sPq+BhcYjTu6ILHLkz5HqcHNXgjFcRDqtzRcfM/JbPGyr+EBWT0dkL5QZGSMmOseW435lBQNhj/eOt7zK4Uwc8+lpI2rOajfa7TJtYyoxnS92UTZi5d5HkTeOStel0HBb8/vUiRF8ixfUZcD2h+HvbJaQekIyWk6K9/fQ6/vau+J7baj4MeUkAPspsIrIskc1Ucj0OoAz/waxp4Q0EG2z3ldZoq2kJU1peOT7x7QSWd5mvHCmRZZcLBrC/M2kq2Ts+ZCU7Cdw1QIvcGR7wfjBFIdag/Jqy9wyX8INgkg8In/1b9dFRgFMr094WVwfSZp6eUmTirRgx40vHap5UbdliyEAXSFLuGcpmvbJVDhO+hn0OgsbXrH0Cz22Ccsj/NEvkk=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(40480700001)(82740400003)(36756003)(40460700003)(356005)(7636003)(921005)(47076005)(2616005)(83380400001)(1076003)(186003)(426003)(26005)(336012)(16526019)(7696005)(478600001)(316002)(54906003)(110136005)(82310400005)(4326008)(70586007)(8676002)(70206006)(2906002)(36860700001)(8936002)(41300700001)(7406005)(5660300002)(7366002)(7416002)(21314003)(83996005)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:26:03.8704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b078b526-cba0-4bc8-c179-08daa6815568
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6915
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
 drivers/block/mtip32xx/mtip32xx.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 815d77ba6381..43727c526edd 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3414,16 +3414,11 @@ static int mtip_block_initialize(struct driver_data *dd)
 	}
 
 	memset(&dd->tags, 0, sizeof(dd->tags));
-	dd->tags.ops = &mtip_mq_ops;
-	dd->tags.nr_hw_queues = 1;
-	dd->tags.queue_depth = MTIP_MAX_COMMAND_SLOTS;
+	blk_mq_init_tag_set(&dd->tags, &mtip_mq_ops, 1,
+			MTIP_MAX_COMMAND_SLOTS, sizeof(struct mtip_cmd),
+			dd->numa_node, MTIP_NCQ_CMD_TIMEOUT_MS,
+			BLK_MQ_F_SHOULD_MERGE, dd);
 	dd->tags.reserved_tags = 1;
-	dd->tags.cmd_size = sizeof(struct mtip_cmd);
-	dd->tags.numa_node = dd->numa_node;
-	dd->tags.flags = BLK_MQ_F_SHOULD_MERGE;
-	dd->tags.driver_data = dd;
-	dd->tags.timeout = MTIP_NCQ_CMD_TIMEOUT_MS;
-
 	rv = blk_mq_alloc_tag_set(&dd->tags);
 	if (rv) {
 		dev_err(&dd->pdev->dev,
-- 
2.29.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
