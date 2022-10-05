Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5153C433FE
	for <virtualization@archiver.kernel.org>; Wed,  5 Oct 2022 03:27:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3BF7740A19;
	Wed,  5 Oct 2022 03:27:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3BF7740A19
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=K0ZdxQrb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lQEFgti4K_Lx; Wed,  5 Oct 2022 03:27:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C2DCC408F2;
	Wed,  5 Oct 2022 03:27:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C2DCC408F2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AC96C0033;
	Wed,  5 Oct 2022 03:27:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D3C0C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:27:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6793F8271D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:27:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6793F8271D
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=K0ZdxQrb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KxlB4Le9H7kh
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:27:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F40F8813C3
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F40F8813C3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:27:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiVtJTW+oBh+kArG1fbzz2wSTi7APUws/Xy40O7+DN3s/E/jxabBHyePrtz6E3TX6GItVwmMGt2OTukdIVMRlX62xfACse6A5uLTkECdB3g5vVgCPZsYmLbrqdUCWhNH7FjQvDpvVWB3j9/XdAy4a+9eEIbQ+WiN4QlurZqLyB85NtqVtsV1e9hbJ04WA7b06ojBvS8NmI+DYKeM97GlA8LjRMYe5q8heIdDF6qmoR0mLqxCWA2d4w22fzO62cs91QDUC5MuxrliIFG4UGVxeYaE9+RJlHjDDsTVUE2HKwR5U0dy9dfbMgkTXMRNOjb4Q5FMtPhXXxtnbp8/wwIDIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXVYl4Xl/zgbwGuqkrsF2gd8c3ru2Bj/s3kt/V+4v50=;
 b=GpMLa9V3jmKKflMFYgzM8wMtKYQzooDz+XTe4Q9F5FHFLyjGYAnsn1m0SKPVw+qApCOWhZcy7L+EvwYvMjNRBwO9pL6bi0cyYB+SIPu2na08FYa9eq3Hwx0MNAERWK1w+pR7+eEsCrkA9fH4r3Bn/eLW91OtMazmXrsv420haPENN7SyIuQBrmDec5YKfkpVQHS/cwKUsTjBWPx3GZXRCJALAPL4uvqNIyRmr++TD/BwNelhTIErTfBhTIccUpOHOporZkrMNjxinryzI1V8H13AhWmOkjGDbQDowU544YNdPFz+TulCq9b7P1+PSO3uAjtm4ojLiKkenHaxFwPgVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXVYl4Xl/zgbwGuqkrsF2gd8c3ru2Bj/s3kt/V+4v50=;
 b=K0ZdxQrbmm5CPlX4VZZ6HT5iTMm+51AXdPahb0aloAfJIv2WLJD9lya+CaZpvyuZEBuRdvwLD0sVCQS1hJdeqlNC0aHPOeCW2ffLkDQX+q5KfpkXFFnKrxyrMzZF3ot4TusNIneghwYvZvAVV8vT6WOaIvy9h7TfPhWxQFwhGrwIvHE5xQ4j17T6qSU5jfc/1p6cGDQV7hD/mr88jrKddOmAvxpYwH/QatrCGb07UHBk95qxs9T42CuXsZU871OqQU7UypY/3CsSPy7VZd1KkLT3190kaAi+NadYSGWIFdP/plvK9sJG8f2WkUIktEoYUJTf8ilPgis4aLQmKNOhEQ==
Received: from DS7PR03CA0090.namprd03.prod.outlook.com (2603:10b6:5:3bb::35)
 by SA0PR12MB7004.namprd12.prod.outlook.com (2603:10b6:806:2c0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 5 Oct
 2022 03:27:07 +0000
Received: from DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::8) by DS7PR03CA0090.outlook.office365.com
 (2603:10b6:5:3bb::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28 via Frontend
 Transport; Wed, 5 Oct 2022 03:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT111.mail.protection.outlook.com (10.13.173.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:27:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:27:01 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:26:58 -0700
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-nvme@lists.infradead.org>,
 <linux-s390@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: [RFC PATCH 17/21] dasd: use lib tagset init helper
Date: Tue, 4 Oct 2022 20:22:53 -0700
Message-ID: <20221005032257.80681-18-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221005032257.80681-1-kch@nvidia.com>
References: <20221005032257.80681-1-kch@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT111:EE_|SA0PR12MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a0f5998-fcd5-4800-6db9-08daa6817ae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HmFdWdkVIaUwa279eRdbBxBAj67RNgjbT2j2HrUQhZD2HMg/5GcNl5P6P9V3GSyNiJPB5ViFej3iS91K03DEsEvUN6c6/qq3LR/UxKg3JGT6KlTC1t2mzxWBleBZbkIHPbUlMLaQUqcqWbUmcYf7YAXsw1dzfPLCr1bo+P1GLJV3BwoY2GtZAzgh762rlBxgFz15AQuUlfkl830SijeWc8VzosixZI4hyeaVJvvvpaUVH1qQ0smP+vnBcD7tIVdAXQjHOQTmdaoypYQk2pMB97483eVu5HyO+uqmhqn82wQ6+Q+4iRDxK3h7lnljvXVt6LQ21uDNLmX8VVdpcj3+P8VL9r0i4ff4reMyP51L39j8irLs5xSLpZIHdDWtw4A3YlWWAeFQ/LbZr54sMpaet6mMdj6GmJUc31Aqd2iToig76yI9iXQYvK4lGHvimc3C7ROUsBohvV6LeVN4NFydpTunW4xgewotUwijNCX2KqTKsw9P/YFSgWn69UaW0H3fChGtOgHV5o9GkfhwFNx+rU2Jo4aA31uv5LFxh+wPlMGL7sZfeYNQoC+trzIi0riEftKBRTyqWraw/yAnMiPpJeEtmz1GUuC68xj+oJPkXeu1IgBlJ3h3MjRT9pIikFzWfC/gpC/SaLLfsID+AkvW5te0UV+1EQqzkLMThYgeD6o14Z9IxY2uH7SBkUCGR/XOJAFTlwPakSH3Au7NzQQ5R+kWt83C2cbcpOyKlnXIebG14hvceyTnclzlh50qk+5K0LQv6c+UGufEyrqfgXTfSLToC+E9Ggn3KmCebAjq18g90kB0bJWfqAY3wq0gifYBzpwn9E/ZtzuzsIjbbRZaWQM+cc3CATw1XVihalmnHec=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199015)(36840700001)(40470700004)(46966006)(7696005)(40480700001)(82310400005)(2616005)(36756003)(40460700003)(478600001)(41300700001)(6666004)(26005)(7636003)(83380400001)(70586007)(47076005)(2906002)(1076003)(186003)(426003)(336012)(8936002)(5660300002)(110136005)(7406005)(7416002)(16526019)(356005)(316002)(7366002)(36860700001)(921005)(4326008)(8676002)(54906003)(82740400003)(70206006)(21314003)(2101003)(83996005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:27:06.7985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0f5998-fcd5-4800-6db9-08daa6817ae8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7004
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
From: Chaitanya Kulkarni via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Chaitanya Kulkarni <kch@nvidia.com>
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
 drivers/s390/block/dasd_genhd.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 998a961e1704..a7c55b7e5f6d 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -48,12 +48,9 @@ int dasd_gendisk_alloc(struct dasd_block *block)
 	if (base->devindex >= DASD_PER_MAJOR)
 		return -EBUSY;
 
-	block->tag_set.ops = &dasd_mq_ops;
-	block->tag_set.cmd_size = sizeof(struct dasd_ccw_req);
-	block->tag_set.nr_hw_queues = nr_hw_queues;
-	block->tag_set.queue_depth = queue_depth;
-	block->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
-	block->tag_set.numa_node = NUMA_NO_NODE;
+	blk_mq_alloc_tag_set(&block->tag_set, &dasd_mq_ops, nr_hw_queues,
+			queue_depth, sizeof(struct dasd_ccw_req), NUMA_NO_NODE,
+			0, BLK_MQ_F_SHOULD_MERGE, NULL);
 	rc = blk_mq_alloc_tag_set(&block->tag_set);
 	if (rc)
 		return rc;
-- 
2.29.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
