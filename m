Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601B0C433F5
	for <virtualization@archiver.kernel.org>; Wed,  5 Oct 2022 03:24:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F132860BA6;
	Wed,  5 Oct 2022 03:24:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F132860BA6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DoYVtEw7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9x64NNiKokOh; Wed,  5 Oct 2022 03:23:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3A75060B6C;
	Wed,  5 Oct 2022 03:23:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A75060B6C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22802C0033;
	Wed,  5 Oct 2022 03:23:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDE26C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9080B81489
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:23:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9080B81489
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=DoYVtEw7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7GHzDNktKBMb
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:23:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 385D6813B9
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 385D6813B9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:23:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyKT57hUL6ItsdcF1TrnBHmaqoFPWb8Hx6FfQbvb2FqeEnkuG/SPa0Pn2jMjZr/9XgtzjpJY/oLEIJRL6ndCMWx3PikpYbAvST5Ir9riioIB67Fe2ueuUdGNaD6LGc3ExTXGf79QPenZLM9FRCNvA5rp2/THbuqFiOrHSB9sAdsa47JXQtJIFzP6rl4l5+7JjCiui5ikUjwHBlhpfkPh3mCRvzeWa0QLH6UShvtoTr38HjTrUd44O63aTZpOpAajiBJqN7KixM9NLnrrzvqMvLgtE0GRMm7JrYpelw0AHXDQGXp6Oz/wm0qcDd4CB6VqkR4GaZT6cqR03sMNOq3BVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiHRxXlu1J1E3jUYjrj4eJw9ZFg+tt2MKuM9A19wDFw=;
 b=KsJ7iHWhFP4B4HNDKzyGpHRGy3qL0hE1Z661+giqKyc6IaUTc5FXmF7aBARJnV3tQE7/Iy4ZhajIFx4SwduvjGQPM8YiEMv47pLelJ4r3DR4+ZbOMAjCT3gmgd9HUDDDxj7W44RfIB7kqjzJdXMaFGbbq2+wvHCO+g81eM47j+OCPXe0seTXjWwc7NpvG1/gDcWREShhNapSBmefI4ezSnZBxbyBV7IGuT+UVffzSPrGia7JdVxYw8gChwmNalrdTp+qMIAW9hDyfsI0TI2RbwONT4sDa3dBhaOCPmMl4GuDIAUr2d5M01sT+nYWfM9IKmBm0uNIZo/vEShsPTvqJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiHRxXlu1J1E3jUYjrj4eJw9ZFg+tt2MKuM9A19wDFw=;
 b=DoYVtEw791EmsMdOG1OWHDqQg6qEQFrq2dzrnGsMcUfAjqvfAaE/QfUVZ1RlzvhQg7jMCwrnNJN8+KNLf58HkzzL49UUMdEehLOY6G4FouXH3oNT2ST/d2hT7CgpT4ojjWwpEb6HbDzkTtUf+JaU+x+XpGMudiOzMtg5VVtiCOSgnXaWx8/83znXOZCheygju+qros+hVQLz8h9Ejt4ufD941z2MrWCWbU1KY7bGFm8fJmZWrGrjTrdyaHhvF9dpBEAoyglok6NZdOLIvAXrG6HasK2Hd2PVfbRbXAlDI5NboUkLz59kt2eV9mAKXRz380MshI8ScM2AX5VO6bY4Gw==
Received: from BN1PR10CA0002.namprd10.prod.outlook.com (2603:10b6:408:e0::7)
 by BL1PR12MB5096.namprd12.prod.outlook.com (2603:10b6:208:316::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 03:23:52 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::2f) by BN1PR10CA0002.outlook.office365.com
 (2603:10b6:408:e0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Wed, 5 Oct 2022 03:23:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:23:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:23:50 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:23:47 -0700
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-nvme@lists.infradead.org>,
 <linux-s390@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: [RFC PATCH 03/21] nbd: use lib tagset init helper
Date: Tue, 4 Oct 2022 20:22:39 -0700
Message-ID: <20221005032257.80681-4-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221005032257.80681-1-kch@nvidia.com>
References: <20221005032257.80681-1-kch@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|BL1PR12MB5096:EE_
X-MS-Office365-Filtering-Correlation-Id: 785fbad4-5890-4cdc-8a27-08daa68106ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k2vi/KkKbm/nmuZraHEIir02mBSVgMOszxQbXhXuWKCY2Kq4MchHGd6/uqRbaZAVmtVtFBJ43pwLICzBWt+ggwkC+MVj4y4B1haU3rA+fNvruNt2pmxq2gRBj9CpyiGbhpeRL19OJgpQlv+ufyig6kchSEXWO/J3IbSphyG4n14sntJJVekNz1c4uKy6XcjeDSyPb/KVNWuf/lLZNppiBNZVdcfkW/tV6DGkBcTp45+n2MB9mLYWZkGtz0f+KkIbhRIN8YYE3ABlIvA0sCigaYPBZlUKjFZl3tpKnXAEt6WUIdWLHPvtt1PVIImN1M1Z2BU8rDiB31GzqvrS3VIxA8h+6xSB9+feKnTtVSpGwAIrOd4yrGUOeM02eYTOI85oBoDFGbNNEVIPhzEA9vXdSblhrb5Pp2IHDWKPe96QSTK+ngs3jqU7tPab8ZXWEniNFYvSlH70ViUouxZYcX47oxZfuHybfw12K6Ft7sLk1Mtkaz4Z3Bc3gWjLVaAYUn5iun9iBMRIlJebTH562bzpl7q/03eQucHtblOPNvi58uTK89m7bqh/xPzDEiarzir6JocaMl9fqSTOchduvBCt23Ya7bKOv+WMRxZxEKw3/g8AVv5mKj5/jTby2mAEI/NR1l0Sm7sEZSVYck2aCalcUEIFXpC2SPtDkCRA/vwV4e0O34pdRZzDP9T0lj49XMIcRdVL7n1yaFjKqvoLhh+WMTd0L8zAsPkxH/3Y2dAYnu6jvjSss+BeI6RggjqS8J2ugN5wEsg60vlkBJNgLgu8K+EvKn629oLUy0ckTvQ+Xe0wQbbIxwgjvWDB+rAT8W17X5teSkOcWKXNq/p2xkCk5rDKQW0MvM9ZoMZRzGg8yfQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(40480700001)(36860700001)(478600001)(110136005)(54906003)(316002)(8936002)(7636003)(5660300002)(70586007)(70206006)(186003)(82740400003)(7406005)(356005)(26005)(36756003)(83380400001)(7366002)(921005)(7416002)(8676002)(82310400005)(41300700001)(1076003)(2616005)(7696005)(2906002)(336012)(6666004)(4326008)(47076005)(16526019)(426003)(40460700003)(21314003)(83996005)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:23:51.8664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 785fbad4-5890-4cdc-8a27-08daa68106ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5096
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
 drivers/block/nbd.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 2a2a1d996a57..01be68d1f722 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1749,14 +1749,9 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 	if (!nbd)
 		goto out;
 
-	nbd->tag_set.ops = &nbd_mq_ops;
-	nbd->tag_set.nr_hw_queues = 1;
-	nbd->tag_set.queue_depth = 128;
-	nbd->tag_set.numa_node = NUMA_NO_NODE;
-	nbd->tag_set.cmd_size = sizeof(struct nbd_cmd);
-	nbd->tag_set.flags = BLK_MQ_F_SHOULD_MERGE |
-		BLK_MQ_F_BLOCKING;
-	nbd->tag_set.driver_data = nbd;
+	blk_mq_init_tag_set(&nbd->tag_set, &nbd_mq_ops, 1, 128,
+			sizeof(struct nbd_cmd), NUMA_NO_NODE, 0,
+			BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING, nbd);
 	INIT_WORK(&nbd->remove_work, nbd_dev_remove_work);
 	nbd->backend = NULL;
 
-- 
2.29.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
