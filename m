Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6E8C433F5
	for <virtualization@archiver.kernel.org>; Wed,  5 Oct 2022 03:25:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09EAF81B53;
	Wed,  5 Oct 2022 03:25:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 09EAF81B53
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IRHoSE6o
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3COZnUE5riz7; Wed,  5 Oct 2022 03:25:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6D63181499;
	Wed,  5 Oct 2022 03:25:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D63181499
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49D94C0033;
	Wed,  5 Oct 2022 03:25:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 243C1C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:25:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E59D860AEB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:25:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E59D860AEB
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=IRHoSE6o
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 21peRvNu9xOL
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:25:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 16CDC606A9
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 16CDC606A9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:25:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPiqAZkAETcCrLJS+EYFp6t+y6gHMYPRg5Ql/Chv2fhgfCrEuFaFT59ZpvKk0KAX9FvLHZbd+bdCz1U+uo0z1MvG5q967SOEgoxpnHEXu3Zp0vCf0VsP3ZcI6prOaGtF7y9fbWlAD0QbqgCTLMrm+0xz6/L8laeNffOgIWlknlpdx+eWvvsUmpYuYyNCga5GXa4BLZzWrGxzNL77pnG45A16bX2yxfFDp/SZAWIXUqXyT7bdwCXTWgms8+rInFlpUfm7Qfts/fNCYu1rF4iigRuHbXb7S21aoNAyGW8BaGXQK8out7jD0XwVKmQFeIG8zPv+LML7eawSfnvhBB57xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIaJtCmyBtmwNvlfCfTaROuISj3wP2X90OGXdFQZG1s=;
 b=c8Z18CAdRVXB9IaWMD1lK100+6/W12Dr1jhyGiSWOUf5RM9dc29b1YAq6m1+R7x+FflOmE7NTa1uG0ZKlRJf8EqHu17A/8VhjlRjowXIcacVhGY4lLdnQsnvLHN0N8/G3Jdo8vLxVGxASH2o0P/5hYXmUqYF5gXrdwZmjguWEoTc+bUCQBOoqDr0A3f9WhqWzHNUSL+7M23sX6Gy7HHZ+4DKZdYhyGwYrgft+dMMcIkSeoHWLvhGDRMHKPPuIYh8xu0q3Eg5y9Dmw8aT+mTYYiBQochDNdZGQGBgbwyIaeaL7NJqoFru3R4CbSTlXqaY1z16gh9v4VBka3/e/3wgtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIaJtCmyBtmwNvlfCfTaROuISj3wP2X90OGXdFQZG1s=;
 b=IRHoSE6o4UX4VfbaZlGmjrcRVVCmghJqX408MMBzfknQwh89EVQGRE9gf5PZVavNij6pfR6793L0NG+pWzvWsWOEpgsAUhq9Y5WtwNDW7BUEHscf6OU76suDq5ScpOIEZ7hEp+rb45pVmDheSVs+uvJRQjQXyu1Q09MMZ7Xb8bJBzK0T9MIwj6AgptnMqCYoSyP6DF6PZ/CTI+1/cti/Rv1u8Zr0tDzKigG4+gJIXVsyWFexhYm5ROePf2EEZgQ1rrxm6QycgFS4UEmwTPloV/KGjWRgUZl9QnOx/qfxmGdO8sO6biqVaa02xqRn1FwsCqHgB/8yVaxnFctdAddnYw==
Received: from BN1PR10CA0011.namprd10.prod.outlook.com (2603:10b6:408:e0::16)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 03:24:59 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::57) by BN1PR10CA0011.outlook.office365.com
 (2603:10b6:408:e0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Wed, 5 Oct 2022 03:24:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:24:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:24:58 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:24:55 -0700
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-nvme@lists.infradead.org>,
 <linux-s390@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: [RFC PATCH 08/21] scsi: use lib tagset init helper
Date: Tue, 4 Oct 2022 20:22:44 -0700
Message-ID: <20221005032257.80681-9-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221005032257.80681-1-kch@nvidia.com>
References: <20221005032257.80681-1-kch@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 2abf6aa3-a07f-4b92-c659-08daa6812ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lO7XEwWXA1z04/6uQNT2ClHlA130jYGz/M9PpTeM3PWZNymRpv9Ccm+e3zypkzSBUDKuCw5avmnkgxh+iFOtpnTkAPA/Fl/2uOYOSnoaWlg1Zef/N+TOI9JbAVCYHm2LPBKEMGEW+QzZtFgHgMx6dt4j6iybU0Bd7b3qqMZma8zHUcu6YX9nD0nxhFo/K9kbjxJww0Uo7Q3hGVmXpLo1uv5YiAJ/GMFD/yNdM+4k+BPnEXqDz4p2aSFHyxHYnPCHimpyfOy0JDvEyAsX8mewzPJOf1mtUBSTDdMRolyMsA9q4Ua3RVStN9ePhVS4ZiY+exR47w7bFqg42JT6cL4HYbnj2hQ9PoLY2zf9K6sqNPFv3LdtJG3q6uau3swhAFw7S0tpg83ZkrRXY5auTP0gvvk75AW0aKFB/ynmM65aOIYAGrH1WDGDOa13KwJL8wEyLAT5sz9DwBStrtvFUueUZcH+5HQP+n/mpkFZ5jdlvFFXOpQkBVLZTiibIixSQw+x2QzSM3zcES9gENk9at+fO+h5nrzxwCmJ/sTyDiDX9W7w4NBq9eCDrG8pAK6BGQHhpiBRNG8aE9CYy6bVTDk7oeOaXf4GG7Vx8Wct9c0ahXeT6Xb/cSTWeOTWBJkIM4vxkCEr4RuClZIZmPQsa7EILNHEIy+ClheydPS4N+kTd3dcktO6QE70uHZbpAwIIlS9ZJqkSwQDJdhE8u9ISs+vHLOCfpE7GTWLW28atyr63OGzE1iAegnqc9+CAhQVl4mzmxDtHo6gviJSL/Bd/wbbB6ru1eNpSZeOjnstE2Fsn3fMscjdhpucXxeuzecGeBxbKWWSSZCc8DiEzEhXVcXw2msH283OzzydmdZvc8zj9Cg=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(40470700004)(46966006)(36840700001)(16526019)(36756003)(47076005)(7636003)(921005)(36860700001)(7696005)(82740400003)(356005)(26005)(336012)(2906002)(82310400005)(110136005)(7406005)(7416002)(70206006)(83380400001)(8676002)(70586007)(5660300002)(7366002)(8936002)(426003)(4326008)(40480700001)(186003)(41300700001)(2616005)(1076003)(6666004)(478600001)(40460700003)(316002)(54906003)(21314003)(83996005)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:24:59.3635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abf6aa3-a07f-4b92-c659-08daa6812ef5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360
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
 drivers/scsi/scsi_lib.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index d7ec4ab2b111..121f292ba0d8 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1955,6 +1955,8 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
 {
 	unsigned int cmd_size, sgl_size;
 	struct blk_mq_tag_set *tag_set = &shost->tag_set;
+	unsigned int flags = BLK_MQ_F_SHOULD_MERGE |
+		BLK_ALLOC_POLICY_TO_MQ_FLAG(shost->hostt->tag_alloc_policy);
 
 	sgl_size = max_t(unsigned int, sizeof(struct scatterlist),
 				scsi_mq_inline_sgl_size(shost));
@@ -1964,19 +1966,14 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
 			sizeof(struct scatterlist) * SCSI_INLINE_PROT_SG_CNT;
 
 	memset(tag_set, 0, sizeof(*tag_set));
+	blk_mq_init_tag_set(tag_set, NULL, shost->nr_hw_queues ? : 1,
+			shost->can_queue, cmd_size, dev_to_node(shost->dma_dev),
+			0, flags, shost);
 	if (shost->hostt->commit_rqs)
 		tag_set->ops = &scsi_mq_ops;
 	else
 		tag_set->ops = &scsi_mq_ops_no_commit;
-	tag_set->nr_hw_queues = shost->nr_hw_queues ? : 1;
 	tag_set->nr_maps = shost->nr_maps ? : 1;
-	tag_set->queue_depth = shost->can_queue;
-	tag_set->cmd_size = cmd_size;
-	tag_set->numa_node = dev_to_node(shost->dma_dev);
-	tag_set->flags = BLK_MQ_F_SHOULD_MERGE;
-	tag_set->flags |=
-		BLK_ALLOC_POLICY_TO_MQ_FLAG(shost->hostt->tag_alloc_policy);
-	tag_set->driver_data = shost;
 	if (shost->host_tagset)
 		tag_set->flags |= BLK_MQ_F_TAG_HCTX_SHARED;
 
-- 
2.29.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
