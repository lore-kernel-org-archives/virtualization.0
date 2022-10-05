Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE448C433F5
	for <virtualization@archiver.kernel.org>; Wed,  5 Oct 2022 03:24:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4438460BC3;
	Wed,  5 Oct 2022 03:24:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4438460BC3
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=txh88/V6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XOkjM-OLLgvT; Wed,  5 Oct 2022 03:24:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B725B606A9;
	Wed,  5 Oct 2022 03:24:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B725B606A9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90F60C0033;
	Wed,  5 Oct 2022 03:24:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41963C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:24:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1C6D260AEB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:24:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1C6D260AEB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zvJET0zfB4DQ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:24:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A4B64606A9
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A4B64606A9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:24:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEJzhJtv7KeHwSHv6LhGg+m3n+P3nvgkmf9fNdEd/R6KfD0UkAOyXxpDKnd3tLpHelgwvq9/tJFWWH2vThHJDyVOj5rcdumOdJMDkJh8pI4QmKCYb61Wsyf9ep6UdlunffRNLvFt2qSfb9FpxA650n5YCbIiXBWB+/9cXZwjCVN9M9yrVNZ9Dc0kUwmmlK3t3SuWqr7r3dzYpiFq4tg8ZMUTq3bB7JB7vSMppgx+nIC8ldKFpNV32M35613JrLtxaEo1hu0ib2BaItGEHOA/9Gj7+neFHgYIKdhdOO/Gqi6x6y4RI8tpK3vXkk1kkzmik+G5YJqg9vr63oEkQxmv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TkGj0VL9HqhEuTnfL0YyC2vFcckdgMqb6lAf6o0lVI=;
 b=eDMA2BvDQ5GI2xelmEbjwPSgtY/mr3Fsgl7eMhUPlH5BmL59lps5FXK2FW+WdJC/Iq3fGt9hCaPXfT2UfJG9yKuQY37PY49ZOzZHvd8e7yzBjTofvv1eXlHTWLUWhxglatk6zoBvPb9/T1gBYelI/dki5BBgDkgwhOOGRh/kWpBaN0OvZgNcK4LpvfoSRbPiY0C29VSdb/IpoRs9mEUcPTGqIHscIJ89sMbZC+D/WvfL4j6hbLVF6HejJBDTJIEypHoKgaAR8tLxDnmfZj+SsJ9QoioFlQn0G6e/Bo0ivnb5WLST18rA88ao4sF6L7mG5sWCQiMf80xr6sinpCI2Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TkGj0VL9HqhEuTnfL0YyC2vFcckdgMqb6lAf6o0lVI=;
 b=txh88/V6Y3XuTUrDB3OXcjW8uvHQzbL520zXv48MD1DIhqmNotnrrB7eUw1NLwXgJQKOMcC7l6u7+9Pb7tYVDprFWezKsSWbMTB4U0YRrVLIFHmOMr7w+s9tTJEvWyuXuDxShC8gs7jCnJUF6+k40UEKa6i//9DHeaNlia8I2jAxHRA+/NQItrjQkEOW82aB05vThp6ZjayqyKAEYnpVgkPFPLEAC16M95OOod05RWCSzXimliABQ9ZAzKQP1oFHf44bhgghttZgNOuGgpBqLPtj/A68dHrU9u6mVyg8Q6iJVsGGiE2ckvxLQZ+bBQDjcfadkd9txxxrA8N7aoK/6g==
Received: from BN0PR04CA0071.namprd04.prod.outlook.com (2603:10b6:408:ea::16)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 03:24:20 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::f4) by BN0PR04CA0071.outlook.office365.com
 (2603:10b6:408:ea::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Wed, 5 Oct 2022 03:24:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:24:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:24:16 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:24:14 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-nvme@lists.infradead.org>,
 <linux-s390@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: [RFC PATCH 05/21] bsg-lib: use lib tagset init helper
Date: Tue, 4 Oct 2022 20:22:41 -0700
Message-ID: <20221005032257.80681-6-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221005032257.80681-1-kch@nvidia.com>
References: <20221005032257.80681-1-kch@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT032:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a9676d-4f48-4322-ab38-08daa68117e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iC1jgkGtbsfq5vcPXcyDmTK3H7PJgoR6iU1vIIfzOU4hILm7lSpHHn0icG1AsrmXPTUnCBMywJtTb9xuoDMsXUaenI07CbmWFiNv8Cmzypw+eSXjVKW1xGxrGCGf7v0pV0m+ZYyB4iTU8jgddDHQ9Vu3rLd55dLHKygzQx/YTz/Q9FhtQGPQAGRAWwwYd6mMF7PlDZQCCoDhHHdMBchf5gSUvVyY8jdQa9wPicaaCqxFeEfGNSnDSdSFwyJBI3lpjylh5cVMMs0H2wM49AvR3U5Rkm/sMfex/bmOY4ibLZTHz8Uh+kKzvSL4RCZ/jD4/bVctL6F0nTNLdhyZYRpihSCEzeWWEsXNP3kcTLyJfbtbnyLzlwiafsY9S/U2HpJwLRF/xLYcfrctl+X7IrIpq4zXVAjS/tOOSo0Aa+DeiyQDrmsxoxNL9BPs9Khg9MaBWjUpPs41pOAfrVpJiJYW+le21DwTjzyCB+8x6z1nIXNnBJ445JZmRi/6s/pGR5NprxkSg0u4IB3wutll7O0bb0jgr0e0X9oktAkEBgX9wfx+6fuJffIynmTYiz1/KEJOLwVbeu8YyvNtkrglMTyr69dKvhcD3nkOpAEtvsNiLX2ifk8hfltDD8HckP1u98yr3miFXZBn/LrwMpp8IOMiWznR5XcFe6KYBg4htVtHNvv7nF+Vf+OZINuiAPr7UdELDLrmuEsl0IB3ABkr5zk3A4eqyzMk3EW5wmzAifZOf+kHSCUaQdY5HcNQQ24/OQwWrLDh0uBBnib9/+ol4FdV+PhFOSz/+Gxa46Ru5Rl7vE9H/EQK9w+ixUEeY3qAjZz3dXQ6q0qmBxldeIH4H8YntRXWpieZVjfk0Rf0EYgQeOw=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(110136005)(36756003)(316002)(54906003)(70206006)(4326008)(8676002)(478600001)(7366002)(26005)(82310400005)(36860700001)(40480700001)(5660300002)(6666004)(8936002)(7416002)(7696005)(41300700001)(7406005)(1076003)(2616005)(83380400001)(40460700003)(47076005)(356005)(70586007)(7636003)(921005)(2906002)(336012)(426003)(16526019)(82740400003)(186003)(21314003)(83996005)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:24:20.6572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a9676d-4f48-4322-ab38-08daa68117e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
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
 block/bsg-lib.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index d6f5dcdce748..3f28e24faa50 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -373,12 +373,9 @@ struct request_queue *bsg_setup_queue(struct device *dev, const char *name,
 	bset->timeout_fn = timeout;
 
 	set = &bset->tag_set;
-	set->ops = &bsg_mq_ops;
-	set->nr_hw_queues = 1;
-	set->queue_depth = 128;
-	set->numa_node = NUMA_NO_NODE;
-	set->cmd_size = sizeof(struct bsg_job) + dd_job_size;
-	set->flags = BLK_MQ_F_NO_SCHED | BLK_MQ_F_BLOCKING;
+	blk_mq_init_tag_set(set, &bsg_mq_ops, 1, 128,
+			sizeof(struct bsg_job) + dd_job_size, NUMA_NO_NODE,
+			0, BLK_MQ_F_NO_SCHED | BLK_MQ_F_BLOCKING, NULL);
 	if (blk_mq_alloc_tag_set(set))
 		goto out_tag_set;
 
-- 
2.29.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
