Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BE5C433FE
	for <virtualization@archiver.kernel.org>; Wed,  5 Oct 2022 03:27:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79CB7826C2;
	Wed,  5 Oct 2022 03:27:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 79CB7826C2
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Tmr/SE6e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DTqTj1fXcCI8; Wed,  5 Oct 2022 03:27:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0CF8F813C3;
	Wed,  5 Oct 2022 03:27:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0CF8F813C3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9765C0033;
	Wed,  5 Oct 2022 03:27:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE793C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:27:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7B8C060BEB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:27:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7B8C060BEB
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=Tmr/SE6e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KdYFf3lsSxUx
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:27:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A5FBE60BD5
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A5FBE60BD5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:27:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8H2u1KxEHKI2LjFt9JL+drdS75NF4+WC4MZWgDAo2TmTL3eyufnPg9FWUhHAGyg8lVPEGlFFKkTUoDI8ZgWxkC8wk7pGrchK81s0kyAwuceTOizGQlj4pLznUfLrBvsQva5kx9DkXU4XUucXeNUfehur50tEajyKZyEBOEXuRkrNoSRZC0lRRoxa/e0ipVCgo3J/pM9CpYoKipvqA+9W81YYC7WnRFzbkcA5MjxfkQCf4BUjAPwlcJsrvvGYNUIs9VdVpCfe5ZREn+C/Nx4NcNqkX4codvsDN9R41feKrt0dLipnHTuaSBxvkLTpBvpvN4zFpXgip0WIUf0ohHb0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzU7is90nHkqAaair9hffbX0RYMr1jeAzouRuVIbENE=;
 b=gAwZls/mDvxRvaxgdlgGl/SEujgeVdLfJX2SNBermn3pSBfNqCQgpHDEvWx4wFpLH6613Yw7POrY5L8bYTkCYddFEk7Ybdovv8jFtmjJJOSyjzn5r/KrMzsi/CJSbX8bEv45tYZF6LNEpfWGfU2LnfVuGjEwYl+iHQ9uR6bHWMBi6SIzNSiyA1JBWJztibAtqr8f6grVxZuxEc00z0WSg4jgoBZHPZJwmL7ACBb/M75xvYzJ4MHfWthmp8Z1JfLM0R3DRtxVviyO5wENJaOjrmq9hEdlz/IzdkvprevxlnxkoUp2DKwe70WtEEvofkMEs5pLR/YPKgeeE3tRqpd46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzU7is90nHkqAaair9hffbX0RYMr1jeAzouRuVIbENE=;
 b=Tmr/SE6ey+POHIS4LoeDJZhRIqwYUswyxP1bL82rRkZ/y6URv2wdrWabsEUuu5pMXHztJzRqGBCQG9wUihegYfm15rGN2XZxeTEcAL6bpHFD1GYrNG92g3p8zU6Oj0Hrv4YFXh3D7QS/13UF2caDCAcbHS652fPp2GfnsWu8kPbfikUJDicnnLLWzQz1NaK+HZIme2lzb3m/IMRW1e8H9STXV0026WlWNXtOa1yTDAODQS3PfrsOoHgJwN6WEiav4h8La0hnO0qfCR5tRblaARTstchS6JO9SR+qoC5YRzXcCTh37m+OUEZhYihTCjVkAc7qNAF1J3muNPKhINBkfQ==
Received: from DM6PR02CA0124.namprd02.prod.outlook.com (2603:10b6:5:1b4::26)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 03:27:17 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::96) by DM6PR02CA0124.outlook.office365.com
 (2603:10b6:5:1b4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Wed, 5 Oct 2022 03:27:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:27:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:27:14 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:27:12 -0700
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-nvme@lists.infradead.org>,
 <linux-s390@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: [RFC PATCH 18/21] nvme-core: use lib tagset init helper for I/O q
Date: Tue, 4 Oct 2022 20:22:54 -0700
Message-ID: <20221005032257.80681-19-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221005032257.80681-1-kch@nvidia.com>
References: <20221005032257.80681-1-kch@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT039:EE_|MN2PR12MB4389:EE_
X-MS-Office365-Filtering-Correlation-Id: 2538d598-661b-4606-71f4-08daa68180f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3wHmtuFdeOlFnBqmD18gkfRN/dllDv09VcQHumRdGr42yeJUnDN8h1ySQq2hhWGm7OrvsWbr7G1D9vWa8Gbe8SQeWQBkI7WAb1JSFBWWkxjTquYyACo/FJz65sztfFSNaXZMYOw0rGrcdX+wliJyATtlraeYq0P0hP/WPW/wP1oiJ1w18iw31O7lvEExadRFrmP40t9dA9F5D46GsNundFL1UXIWR8HyAgE5KPrYCt4L4FnYtCVxTSV0gKmtrSHo4NwUW28wV23x4eF/OPi/E7mDw8/b8I3Quu6MC/yTl36PTUeLZVCNO/r0098QnijojCXz2caBZgTELZHxZCHCk42CFym9mZrRcPdTNyqJwXJIODIETd3mF9XJ5kagsA5g7ZYLfDPyJiSDBuf71Gf9udIRNIAh9S3DRbZpP+cz6Vqp2vVnTFLfffVAR3KTwtlLcLqoynbH1j2fKFpd6YD2k8FZI6yjLFvRmpnE0wq3POGoql03m1WWSgvifIniEsfAZsOsen/ewgVCAvz+IM+/MguPIJF9LAsuPIGDRWbGtKDFBCR3WZQC6EZ4EcjrRU27DILpTGaq0JgWEQg4hI4Fp579iN/oZUNGL8X5mRv03qbZTBU/jsGEZggIl0UlGO03nEK/BOjBe/U/pf/n4Czgsbebg6k7+fvYqrRP7uHCyCT4nGhhA6mlv5hnl1+R7JhKI6gp20ncdXneViYvSpwDEFY6g822c/HHER2vwba1b/cvLSKJ1fhylozi4+8/C7Rp+n2buFD/aDGoHSG0X2tiS5Vs4lhlhGHaiboqWnEulJsK67RnmASRRO9u6e6hgS+r2/B9lf5V3rMjU0jd3zAdRac/78Fw4qzcwWwQuJNcHGc=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(7696005)(41300700001)(110136005)(478600001)(8676002)(4326008)(6666004)(70206006)(316002)(36756003)(40460700003)(7406005)(70586007)(54906003)(47076005)(426003)(82740400003)(83380400001)(7636003)(36860700001)(7416002)(7366002)(5660300002)(26005)(8936002)(336012)(82310400005)(356005)(921005)(186003)(2906002)(1076003)(2616005)(16526019)(40480700001)(21314003)(83996005)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:27:16.9632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2538d598-661b-4606-71f4-08daa68180f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389
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
 drivers/nvme/host/core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 965a4c3e9d44..639767759c41 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4869,15 +4869,10 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	int ret;
 
 	memset(set, 0, sizeof(*set));
-	set->ops = ops;
-	set->queue_depth = ctrl->sqsize + 1;
+	blk_mq_init_tag_set(set, ops, ctrl->queue_count - 1, ctrl->sqsize + 1,
+			cmd_size, ctrl->numa_node, NVME_IO_TIMEOUT, flags,
+			ctrl);
 	set->reserved_tags = NVMF_RESERVED_TAGS;
-	set->numa_node = ctrl->numa_node;
-	set->flags = flags;
-	set->cmd_size = cmd_size,
-	set->driver_data = ctrl;
-	set->nr_hw_queues = ctrl->queue_count - 1;
-	set->timeout = NVME_IO_TIMEOUT;
 	if (ops->map_queues)
 		set->nr_maps = ctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2;
 	ret = blk_mq_alloc_tag_set(set);
-- 
2.29.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
