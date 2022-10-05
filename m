Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0E4C433F5
	for <virtualization@archiver.kernel.org>; Wed,  5 Oct 2022 03:24:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4398841583;
	Wed,  5 Oct 2022 03:24:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4398841583
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nr+mqRLa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SL8GoGdBvmwq; Wed,  5 Oct 2022 03:24:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 82371402B9;
	Wed,  5 Oct 2022 03:24:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 82371402B9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B980C0033;
	Wed,  5 Oct 2022 03:24:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34526C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:24:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F3ABC4157B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:24:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F3ABC4157B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RPUg3g4eVfen
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:24:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EE372402B9
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE372402B9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:24:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bS0JfTcNGucfNfmXnvtdBWY6rMhYDg7JqYoM5DutQ+ASBUE37JLyEKv8HZDiAgN5aUjCxHcXcQrvgKuauHxE3OPRSjep8LmXftdfD2jPYAyDPFRrasuEGPMhZzB9SKtYU3rqOL8m/MtvoLd4sA9myl2QWhkf/TQ1a7dqkY7oBivmYCU89mlMogh846C/RIiAjmw8FrUrxfFmbe9a3BBsF1QahGjrHW4w9cZMQx/LSwYGH3vNmXO8B37ImxNhTOXS9cvNRkuMS5Qq6Uty4RFfp+DjJGiDEGePEdEbkZ/OzZv6PA9WpZLoeB2we6dGWIbe6rDwZjk8m0rjx0S0Mne2kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pirAfU4FfXwMh3u28xo2OzxHQCAPZFaBgDu7+URsTqM=;
 b=nB4wRUcE4chrL9/bEX+apYzGQeDQLQRnrK69vU+vyH0nAyeGwGe3PVLMbsu9mXm74oISSKyKDGb9QBX2ilJTfe0WRR9VikyINAgm/mHDuX9h7mESvHXSsR6a3IRmNo/1sYoCtKi7APEvKHfbHhIccp5lRdyea00jPXSXQxjqBMfXYYrwSnaG4Gxsh9xLJbvWKUzi3wf3RiSRuliwA5XSvHWYZ4n9dm38YW4s2MpiUqZXiwAEXz8NzftmNffu5yWUlWBbLvrADWsFNuvsfTXyCAZ5aObGWHPTEo4Nfu1N7J0CbTdaIBBWl8gy2WJs0VXSwrJNB0Q6mENzKAkrLWehVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pirAfU4FfXwMh3u28xo2OzxHQCAPZFaBgDu7+URsTqM=;
 b=nr+mqRLaJGYAkpuYd5Wg2V79uttwWuSKyYteaSGl6etEvNYfrZL7uNvjXdp+pNx9Q6lwP8sXM3qKDTKZu3pSQYRRkzW5t4Y4j7t59CykXSk6L8TN4OjD3Ze3uBuXOo/txSXiDoY9veZFJJEcc8Q3Lk2L663MT/CF1kPeccgrkKlCekguJ1PwkqC5K/2AFkonJOYkqLdVMgkS9L8RW4u0IKcCPLaON+boOLK92ZfjFrUkEmalptth3idy/5muOl/OdhPJ2dH38RP0AW5ES4x+YItMgP+sKovQtLFaosq8Ymvn1pkiQl+QemBdHzsDvx58y0KCnskzXcAQ66CvRymDwg==
Received: from BN0PR04CA0178.namprd04.prod.outlook.com (2603:10b6:408:eb::33)
 by MW4PR12MB6975.namprd12.prod.outlook.com (2603:10b6:303:20a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 03:24:08 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::a5) by BN0PR04CA0178.outlook.office365.com
 (2603:10b6:408:eb::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Wed, 5 Oct 2022 03:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:24:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:24:04 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:24:01 -0700
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-nvme@lists.infradead.org>,
 <linux-s390@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: [RFC PATCH 04/21] rnbd: use lib tagset init helper
Date: Tue, 4 Oct 2022 20:22:40 -0700
Message-ID: <20221005032257.80681-5-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221005032257.80681-1-kch@nvidia.com>
References: <20221005032257.80681-1-kch@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT027:EE_|MW4PR12MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc9ef70-cc37-44f9-7a0c-08daa6811063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bqeaBh+FDtob0efTfDjtCRGnAXvQeAEebwQeqecTFRGQoNwz2Ia/r7kE7afGzq5zJ9UufOr1tk6zq8KFI1uzi8vd231QcXnbgqQo1hvAvpiBwafMb7gfxX0yWQ+xQUf/OsQS3yohtECZqw1LosaoxS5bhDA6s60CjNP+Ul3+5t1jBgk6tNF3+FyA5NLzLlA0cyYKuoAknhw5GUWfoe/AVL2Z+s8U6A0Dgwf4XPdL5acdyOMrW7fis5T2PlOVaxxwUiesO3k/x19LrjGHkVSVC7pYNNqkTGtgpJfZ1B3EGcm+tNn1SkrzqkqVjiQAqr9yNZF+WiZms6dBTRcNsdFa8j+VFA0QeycDcjFJaBOpGh9Nlm8mgpF/CwuFxnTCDFGvJGh3kHSq06ADQAXSaaW70pOJg/3nCPy/aUufegygG1+au7RE3L01RSl8NNJRjq0q90kqvkznNikwRCRTMjavRSAAdFnOMFb96ePChrD1JfoURRwcrlV0G6qT5DCWe2/wbZk76D6v2abVhBozax3ulqiaG+B5yf95zuX/SO9IVorSEOPL7/EY9eGUtrZbj02u//KRX+67Wfbkd0tUZo+9ZgvPpugD+/CxRvQ5Wu28xQpHXbZ11LDIATaxk6Z1OoB7e5gH1V0k9JZfzk3v6YnPKJHb7m4rzVo1h5/DbGuncuSgIRWaNh0OSIGD6amgehUAv24lJPpqUyebRwLifp3mA6FtQ5G6PwD1mpHOdojG4yG5qNAIjbmj8yZEbvwLeXqaLgTbEt68LFvlkPLKn70B/h7VTA7u3OmOBpa1whuntrBlFWw7qD8eB0L4uyDPekJmbBg9Myh5OUiibu5cGkXkzeo2461XYHHVUVfJ7v5lfwQ=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(70206006)(2906002)(921005)(41300700001)(7416002)(7406005)(5660300002)(8936002)(7366002)(36756003)(478600001)(82740400003)(40480700001)(316002)(8676002)(4326008)(6666004)(7696005)(54906003)(82310400005)(2616005)(110136005)(26005)(36860700001)(16526019)(70586007)(7636003)(356005)(186003)(336012)(83380400001)(426003)(47076005)(40460700003)(1076003)(21314003)(2101003)(83996005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:24:08.0730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc9ef70-cc37-44f9-7a0c-08daa6811063
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6975
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
 drivers/block/rbd.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index f9e39301c4af..c666692955cd 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4901,12 +4901,11 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	int err;
 
 	memset(&rbd_dev->tag_set, 0, sizeof(rbd_dev->tag_set));
-	rbd_dev->tag_set.ops = &rbd_mq_ops;
-	rbd_dev->tag_set.queue_depth = rbd_dev->opts->queue_depth;
-	rbd_dev->tag_set.numa_node = NUMA_NO_NODE;
-	rbd_dev->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
-	rbd_dev->tag_set.nr_hw_queues = num_present_cpus();
-	rbd_dev->tag_set.cmd_size = sizeof(struct rbd_img_request);
+
+	blk_mq_init_tag_set(&rbd_dev->tag_set, &rbd_mq_ops, num_present_cpus(),
+			rbd_dev->opts->queue_depth,
+			sizeof(struct rbd_img_request), NUMA_NO_NODE, 0,
+			BLK_MQ_F_SHOULD_MERGE, NULL);
 
 	err = blk_mq_alloc_tag_set(&rbd_dev->tag_set);
 	if (err)
-- 
2.29.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
