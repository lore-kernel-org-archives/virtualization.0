Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68FAC433F5
	for <virtualization@archiver.kernel.org>; Wed,  5 Oct 2022 03:25:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91A0581B17;
	Wed,  5 Oct 2022 03:25:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 91A0581B17
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OKEv6Bt7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V6vcmPuskJBG; Wed,  5 Oct 2022 03:25:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2010181B10;
	Wed,  5 Oct 2022 03:25:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2010181B10
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08D0BC0033;
	Wed,  5 Oct 2022 03:25:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA50AC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:25:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9496F81B17
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:25:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9496F81B17
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i5QeuYDQ2m0P
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:25:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AEF9D81B10
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AEF9D81B10
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:25:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUVpAbkDVN4IreVchS+eUx1cBYyco6Hutl7neHXyGGVfkFem5tBrs3RAOUJEJT8wqs9jyhztBYob9/t9Xo9RV6j1VGSMvDEulWM3TwJxJaD7hae4cUxeqiNxRFtgbeabnP3qqyjRakFLigEeHAof5OiE0q+tJOc2tVpFiRlJQQN3zBz9h9+KkK5TCbh5NgkWAo5g2fFj3JN8qUpkfds5A9RZ1B2kLgQ0eiNlC9IBHI9QdxUXfysYLHJP2WDB1EZD4NkOcXrkkcoJjYB2Z0a7vRGfckpaykwtHz4+aVECHgAqa+ovZV9oHlPENZl02LZPIjhtyMvhT9RVqMe9PWdCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gT+10pDQC1w6Tn1sBgYEJpAeTubFKXdAduf8ubzbV8=;
 b=a/FsFjHNRGu0oRUth3ul+zlnbOX2BSScqj6BVllaxcLX+fR2E7X1a0Mi5M89SHH2K2qr10ypVG8KccUssEDvlOjfrEKz6eJrSBRHUpb5Negb0f5puoAyIrId9bkF+D/1MblbTBunFWLDkXXzHLwCcvT2ZLMjkYtkyRxOFF871Q6EoFR9hVjUA4J6wruZx8KkUNi3MDmFDkL807QTliY5A7xujlhbqbw+cr8ryMbfujGh6JNr43CVSKbs+ULmmP+fsRvbhuBeJUXntGomyrDpGFXJ7kLupVQ2eo9Wc7iTQmExnIjaEN3QkGdvz5EPhIBqSzhp7gLX/J9n6kag+v+WhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gT+10pDQC1w6Tn1sBgYEJpAeTubFKXdAduf8ubzbV8=;
 b=OKEv6Bt72J3itoNcQrdY+zvtAZIXLrgqVXp9renFaH3jM7+y1R4FNlJRQT/zFXV1PvWvtonLed2ZBqKyQEUjZU4pio2DSTAKYun3lizRp/CBFQGfqjzL58QPn/oYvLId4vFx0A/4FfgbCKWh0y6dmIjUDPenqDjpHQl26uvQceSCIxJuBNqH7qe4YA1QRWMQKfxhL00Kx8mF4/GWu0nQxIPOq7ZMlObOmd8APFJqSG2jD/jPc+9uWk/oJpXdZckGkSdsJVDaxyNL0DrO+a58XX36Ab0Nix5DxuRWMln3/l3cGAktCER2ue+WxZ/dArOCOn/DXJ77Oyh7oiMa0lLGlA==
Received: from BN9PR03CA0454.namprd03.prod.outlook.com (2603:10b6:408:139::9)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 03:25:45 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::34) by BN9PR03CA0454.outlook.office365.com
 (2603:10b6:408:139::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Wed, 5 Oct 2022 03:25:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:25:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:25:39 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:25:36 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-nvme@lists.infradead.org>,
 <linux-s390@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: [RFC PATCH 11/21] floppy: use lib tagset init helper
Date: Tue, 4 Oct 2022 20:22:47 -0700
Message-ID: <20221005032257.80681-12-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221005032257.80681-1-kch@nvidia.com>
References: <20221005032257.80681-1-kch@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|DM6PR12MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b57df4-117c-4e22-28c9-08daa6814a4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: guM/R1/cRXzBKw3iPcsYx6a8B3EskUdDsmquewC+QvnCRhyD4rGzoT315bufk8BxayV7Kw6MxleXXs5wtKSR8MoPzoZ5V9pTv+irrZj0NdTabSwgs0MFZyGNfFS4EUEkS+++aeHudUWd05XY0f0PKO8NNePvgDsAIOk5AnklK8u3skPV1bo/y7i1ppiCn+yPW/aK+dnGqRl4Q65NKXS1I+pcpG+H+PN7GtjxL36xQqDWk5xxOViwwdJJLd/7se3qrZeyssPMdQNCXrKN5gaXof1htBtrTv5uu/UwEDx/caHGcxqVyI14iyj/qFMQzvE/xEc1xMNVSSeC83GHM2iUx3I+kpsZ5JVybb+776XngxgentFZPpkIH52CXz7Z423a5nn3A9cPngRTCJnhkOeLGkXcM/6be43+ctZSc2erD+qmy50konaqtfvZQ/iSWheiAGaCFOfmz8QC5jtL7iGZbOxhR+PLuwotG2ZA+P9U3r8i7r7Mzskn+qMh4aB0yLPuGKn95TLJZNccma6Y+J1jKqhS9EFbLq+M3YD9h7R4ITeRmWgaFM6J/DDhCirv5XlFViKTFL4sOA6xgwbmyq7R4Hhd2lfJWfyQld2WkWP2c9HG0RD82gr86SHzr/tlVFbtXIoUvyjkRly5Ga/2Lwc3MzrhHztKxQy1BOaNLoM1Hxnbcky3jL8uLc+phK2tCmmHCapzbtfKwS+tFATbmULrcw4KbJdtyst2IGnapyRuQnDziV3hSgt8GQV9VThqe+qfTE7cHg7lBaTNp6LD6lcLTGel+d/goNRpFLHi/OEFMK1lFOx2/BeHqelyinpt2M3ZEiYzUAOElPDP3gvHfegqnW+wVMe2xAfP/T/mtQvhUEI=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(7636003)(921005)(40460700003)(186003)(356005)(82740400003)(40480700001)(8936002)(6666004)(82310400005)(7696005)(41300700001)(7416002)(4326008)(70206006)(70586007)(36756003)(7406005)(5660300002)(478600001)(7366002)(16526019)(26005)(110136005)(54906003)(316002)(8676002)(426003)(2616005)(1076003)(36860700001)(83380400001)(47076005)(336012)(2906002)(21314003)(83996005)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:25:45.2477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b57df4-117c-4e22-28c9-08daa6814a4f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
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
 drivers/block/floppy.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index ccad3d7b3ddd..3a3260e6ac5c 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4582,12 +4582,9 @@ static int __init do_floppy_init(void)
 
 	for (drive = 0; drive < N_DRIVE; drive++) {
 		memset(&tag_sets[drive], 0, sizeof(tag_sets[drive]));
-		tag_sets[drive].ops = &floppy_mq_ops;
-		tag_sets[drive].nr_hw_queues = 1;
+		blk_mq_init_tag_set(&tag_sets[drive], &floppy_mq_ops, 1, 2,
+				0, NUMA_NO_NODE, 0, BLK_MQ_F_SHOULD_MERGE, NULL);
 		tag_sets[drive].nr_maps = 1;
-		tag_sets[drive].queue_depth = 2;
-		tag_sets[drive].numa_node = NUMA_NO_NODE;
-		tag_sets[drive].flags = BLK_MQ_F_SHOULD_MERGE;
 		err = blk_mq_alloc_tag_set(&tag_sets[drive]);
 		if (err)
 			goto out_put_disk;
-- 
2.29.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
