Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08F9C433FE
	for <virtualization@archiver.kernel.org>; Wed,  5 Oct 2022 03:23:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57CA881463;
	Wed,  5 Oct 2022 03:23:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 57CA881463
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WIeOhnvR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P2eW9zGhUT4j; Wed,  5 Oct 2022 03:23:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B92B48138E;
	Wed,  5 Oct 2022 03:23:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B92B48138E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94F62C0033;
	Wed,  5 Oct 2022 03:23:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4C80C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7119940861
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:23:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7119940861
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=WIeOhnvR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BZ9ezYlFY3Ij
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:23:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 80354401FC
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 80354401FC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:23:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbglDdDAmY6J90uXPtILOSouk8IdP/M07tZi979tt6d8gCw6mhOj2rPMOUIagshu+UHdesvfgRF45LdWV1gBgX2T1NyqffZesXP3I+1eGqvZ/obd0Jk1w+Wc9dyKDEPOm1nNmFmHUcBwQeXTAuBKfFSjQKgFjM4azrSHSRv8GWtymtr56pu5gRBJnOwwO3Sd6AFGCn3e6alZMyOxGAvyFDdHV2HtdqhvDTTKH5sT0G2LJFjCUiz44l/krQ54hGSh2JiGIv6lM7whxZ2ufHr0wF/nxJN1keAnvR/EZTFLrNOAtlGeSm8aiWAmD3ltmf48Uf3R8mtzeE/+DOkJeq0/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4qlNjHi3JY0sOhIfgnmcxhWd4Fx6Ycmkfd/Klj+n2s=;
 b=ZrgilvyjaiBktRF2FiwFf/tyvDQF3GtqQuCSwBG1HGchFw2NUJfHTB07puMjpjJFPdYifGUoZCld6txEtAxupMrhkecNykoaJxAt5R2Hhf11yE/JfWidkGvoXBtRMez0lnaBhGq65ePaNcxv/Xi73DuGdxZVKJZrk2vlpY0TMhL7YEFvdFAPjsEjfl2wAI0f0vE1zCyDt/Ka6OxFIp68EpB6y52p2F4VdZWt3ZvLRN4GPMXP2ft0YmMuSJkhkJbeSDMXylLWO2yrqkJzEFR2L+gCM68YrUFgjABckFNguQa+lUAXGNSdtZ/8SKV4Rv4iDPeUDnFBHQfYJPdb6DTGhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4qlNjHi3JY0sOhIfgnmcxhWd4Fx6Ycmkfd/Klj+n2s=;
 b=WIeOhnvRfHhYxvIVBVoW/XosBKfTmfyda9YPdX1Wss1uRnin1yGp/jDSSOf+03XdSSxJKkZuvrWklcoqBzS6peIuIkK0qEHG+jIxnPi3BG2dyEyCzhUEhSTMz7Arf4rrNSACPfbbf8Y3lZ85Ijzr6tjKMzbnNWxzlpsXx2gDCS6evf6qvh5XUaBhXiIPRlgkITIzVbN5wCIOuwq9a53l6eLcKGBUY/p/P6TLStu7Bcz9uIB18+YXzjXOghl9tvoKaRGaVEA4o6wAlyZ8MAggaRsGbmn5b6edHpfWQAv7zNm7VZDpH+1OVrBhNr64ByaV8oJ4pY+wafZbttVgf+xigQ==
Received: from BN8PR04CA0037.namprd04.prod.outlook.com (2603:10b6:408:d4::11)
 by DM4PR12MB5916.namprd12.prod.outlook.com (2603:10b6:8:69::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 03:23:24 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::65) by BN8PR04CA0037.outlook.office365.com
 (2603:10b6:408:d4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Wed, 5 Oct 2022 03:23:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:23:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:23:22 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:23:19 -0700
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-nvme@lists.infradead.org>,
 <linux-s390@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: [RFC PATCH 01/21] block: add and use init tagset helper
Date: Tue, 4 Oct 2022 20:22:37 -0700
Message-ID: <20221005032257.80681-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221005032257.80681-1-kch@nvidia.com>
References: <20221005032257.80681-1-kch@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT030:EE_|DM4PR12MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: 550229cf-3ca7-4a46-32ba-08daa680f5e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TCBU5hYTks2cz4q+8GY5aqi1NxVCX4sK/xLIvlsir3K0NBWSc80Z6hInbNhIrawuc5X+MzftYJPzZyE1RWgQsc+GNT1puaDegzjT/VBKdWYv8vtXZFoomd3knJMXPlUOyjt9yjWkRMTjQaJVIXmCeRPT7oJpyMnmTHt388aqeX5PmLe8hoQwYWLHX/VnixHIo3/xJtWdWJaDu7AZmyPJ07wNEHLIgfA900meOadPqEo1Vozy3Xfrt1F+FMgtuG9fp1pDlTNLqfoOrWwM1Pi828uK/pd+j5YDGG7/XP15znfexE0LZPANMptN5T3FpszNVAi0zvFeMZ5XVRm4Gkl2BxaPP8sLSuf4Y8Ck4yWvtW9L1L7UGjDztzf1wzlKedwbyERtKopLlwH8vY/vfcYiAplQRf+o+pi+3sBsuFl7asG380/568iNZ49VpsjP/YNmpSu7XGl60BIPXtaZdOhhtoL2RKLv1XNLqHZahfAMePzqzhSVct+hsr5qwDkdjVIojwz7FogMKTJ5FEVHoiqP4slSif3r0pTd5vQDosK2aIBdO9GNA1db2+3dtYH8unQE8Ccz8b3Fhq3C3Vrek767MkT3VZs4TI+ZI+DM7z95ffde1TPJtwlZUMie6FcV4QEhTs8xHs2M4F7+X2ufz0EqaISCa+cqWPQeC43u2hlqn4wLQNtvjPrIkWKdyPcIkyNIBninDfIKILsKuu3KNU9/XGihbCVvkdLNVtGaWcqh9+vCNnTR08eleAwPhtLF96fkQSgMkzEdmhLPTy8Eu44DHUK5FJZzDPjyrkWYSRPBAXuzvTpnb2cWWTRbdvhzx/oELN9hNwR0gb4gTMVWfvl8IPWBhSNiH2DrZ7s3CX+AJqI=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(6666004)(54906003)(2616005)(82740400003)(70586007)(8676002)(70206006)(316002)(7696005)(36756003)(478600001)(40480700001)(110136005)(47076005)(82310400005)(4326008)(26005)(356005)(83380400001)(336012)(186003)(16526019)(1076003)(36860700001)(7636003)(426003)(40460700003)(921005)(5660300002)(7406005)(7416002)(41300700001)(7366002)(8936002)(2906002)(21314003)(83996005)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:23:23.6181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 550229cf-3ca7-4a46-32ba-08daa680f5e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5916
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

Add and use the helper to initialize the common fields of the tag_set
such as blk_mq_ops, number of h/w queues, queue depth, command size,
numa_node, timeout, BLK_MQ_F_XXX flags, driver data. This initialization
is spread all over the block drivers. This avoids the code repetation of
the inialization code of the tag set in current block drivers and any
future ones.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-mq.c                | 20 ++++++++++++++++++++
 drivers/block/null_blk/main.c | 10 +++-------
 include/linux/blk-mq.h        |  5 +++++
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8070b6c10e8d..e3a8dd81bbe2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4341,6 +4341,26 @@ static int blk_mq_alloc_tag_set_tags(struct blk_mq_tag_set *set,
 	return blk_mq_realloc_tag_set_tags(set, 0, new_nr_hw_queues);
 }
 
+void blk_mq_init_tag_set(struct blk_mq_tag_set *set,
+		const struct blk_mq_ops *ops, unsigned int nr_hw_queues,
+		unsigned int queue_depth, unsigned int cmd_size, int numa_node,
+		unsigned int timeout, unsigned int flags, void *driver_data)
+{
+	if (!set)
+		return;
+
+	set->ops = ops;
+	set->nr_hw_queues = nr_hw_queues;
+	set->queue_depth = queue_depth;
+	set->cmd_size = cmd_size;
+	set->numa_node = numa_node;
+	set->timeout = timeout;
+	set->flags = flags;
+	set->driver_data = driver_data;
+}
+
+EXPORT_SYMBOL_GPL(blk_mq_init_tag_set);
+
 /*
  * Alloc a tag set to be associated with one or more request queues.
  * May fail with EINVAL for various error conditions. May adjust the
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 1f154f92f4c2..0b07aab980c4 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1926,13 +1926,9 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 			flags |= BLK_MQ_F_BLOCKING;
 	}
 
-	set->ops = &null_mq_ops;
-	set->cmd_size	= sizeof(struct nullb_cmd);
-	set->flags = flags;
-	set->driver_data = nullb;
-	set->nr_hw_queues = hw_queues;
-	set->queue_depth = queue_depth;
-	set->numa_node = numa_node;
+	blk_mq_init_tag_set(set, &null_mq_ops, hw_queues, queue_depth,
+			sizeof(struct nullb_cmd), numa_node, 0, flags, nullb);
+
 	if (poll_queues) {
 		set->nr_hw_queues += poll_queues;
 		set->nr_maps = 3;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ba18e9bdb799..06087a8e4398 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -708,6 +708,11 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 		struct request_queue *q);
 void blk_mq_destroy_queue(struct request_queue *);
 
+
+void blk_mq_init_tag_set(struct blk_mq_tag_set *set,
+		const struct blk_mq_ops *ops, unsigned int nr_hw_queues,
+		unsigned int queue_depth, unsigned int cmd_size, int numa_node,
+		unsigned int timeout, unsigned int flags, void *driver_data);
 int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set);
 int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *set,
 		const struct blk_mq_ops *ops, unsigned int queue_depth,
-- 
2.29.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
