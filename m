Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28D0C433F5
	for <virtualization@archiver.kernel.org>; Wed,  5 Oct 2022 03:23:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5AC564013E;
	Wed,  5 Oct 2022 03:23:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5AC564013E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pzmTm6Hk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IaTxablISGvy; Wed,  5 Oct 2022 03:23:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E6232400AC;
	Wed,  5 Oct 2022 03:23:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E6232400AC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF0C1C0033;
	Wed,  5 Oct 2022 03:23:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DC3DC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:23:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 488F84013E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:23:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 488F84013E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fq5aGpdq8ylD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:23:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 57E3F400AC
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 57E3F400AC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:23:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfhKkEgYv2aiNQEp3POyqtmYhWpzL5WgccX6YklyqA+GYvbaqcRS5cJlmb1QDwHxjSK0eSlZRZg0z7OHzPjtWJCtcLgj6f426N+pOZ4zEHn0GanIyvVCze1r9a+wWrUDrDiRJnh9Exdz5anBxwIuqyej06ZLpygPD115tHnaFYOZzwLSWyQZrGp7QxPc0lB5XNV9BPoiw8uWnMCOVHqZHvXcOnHx0J4JB4q6sZXuzU6DEXc4U9AkDDsHFMYnmh6a049gDhGQjQ7m1inQJNiW8Y54UAAyNTYz9anTLaqJ/p+hDCAr8zil0SujoaVKVF5mqkZX/uZ3Bu0s3kgXJkHsGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lChuMBUbOFhhqwMYG55HB+a43mZAtKoP2WF4KJFYW8s=;
 b=Q5VtezUk1JL04Mh/1YjitLKI9AgFxoxh1oTm3ks0XThwiZbRWUz7PxT89hq467nPnZqIgEK4GqdvPRSkSDj74NloZTtK5ARJook4dQJ0oaWl3bGdJaa/wMKCgFV+mhht7NuLIyx7a26pKCg7YIrF4fYQ9tU81u0Taa1q33LQnmfPdc8c3UXRJW6YIBRX973bcIzt/I8UReqNKEjH+4+sRoGiopoU19q9an4f+ApZZaUfR4IHbEdaX7719wL9BTOw8z9M3jAkrB0f3Br0bwsiYzp6BoBTyBpQ3LZkjWWc2IdTxBCxjP5TmF0rC9xmkCgbCy5jOmnqK1xXbYRzl6U6cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lChuMBUbOFhhqwMYG55HB+a43mZAtKoP2WF4KJFYW8s=;
 b=pzmTm6HkOUV3UVgyd5mMJFFUe/2vIyGMlnxER5JeWYVMUFHfe08nEQ4/VT+SCVOuZE73thu+aQhmAwdDVHwLl3BnaqHoejBMaxV88nuisJRQscpTDzyApQEFeqmp2ENnBe/JLeq1PaGUhzZv7u/8taN3F8if/XxI5K9NH2fP9IdYdhoSq4OmHs52xS3A2ZnGr+ZajYaOGW1KgN2lDYkb3cH6dYXc8R9ropyMtLm1cuR8CKEjP3I+GzeuzTNJjU8C9BIbKHFXKjj3srXiJvQV9LUGShaLpaiwVd00n4ASmV/KgVfVZq5jBJvbPM21Sq3u1qledUYx+t/doJEbMsV40Q==
Received: from BN9PR03CA0686.namprd03.prod.outlook.com (2603:10b6:408:10e::31)
 by DM4PR12MB5343.namprd12.prod.outlook.com (2603:10b6:5:389::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 03:23:46 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::d) by BN9PR03CA0686.outlook.office365.com
 (2603:10b6:408:10e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Wed, 5 Oct 2022 03:23:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:23:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:23:37 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:23:33 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-nvme@lists.infradead.org>,
 <linux-s390@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: [RFC PATCH 02/21] loop: use lib tagset init helper
Date: Tue, 4 Oct 2022 20:22:38 -0700
Message-ID: <20221005032257.80681-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221005032257.80681-1-kch@nvidia.com>
References: <20221005032257.80681-1-kch@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT026:EE_|DM4PR12MB5343:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb8e058-cf52-44af-d469-08daa681035e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N63D4c9Sqwhwd9gnirIdsjnXbpQpXuN3ZkesPglRqtt8pE3qiTm3uld9PDCR9Qa2Nx/t19Q0WG5hWcZb0r7coevO1VgcYZCJl/DpE6pEIPI1G3BRtSGa6blhImTbwes4m5ftw8+M2V0hQDrIVUBPbfMTyD7JoId9TYWh2GerO3708HILCtSj/911Sft9wvFGqXPtsDk3LZbQzh1Vd1QV6Ip6fd2E2vUl3eqyeWZh6rgM6YNUSZ2+MdeV3LTFqP2QpIEvNqsBHNSOsD8RuP89qwfk2RLdfCEk0BfGVaAAdThtnZYx+sqIDfd5JBaBoQ1SeRd08b/a3swgyg9m3gsJpG0yAnMpVlf+WeJwx59+91f6ZedfAAZVAc2flFfXniu1RlFW0tQoCRln/2+DpAnDn6mz9jVEIVQOrkV+OPhtfPfVm0AyB9cBt5PIw0DxgBCax52UiwSWlpklGwXwPP4nB4Fu5HqbzGJNlbcPJibYrR7bavmtUDxKulAdi/FfELrBKGUHZQnEiSzCNLZULkXmcDzvRRNNqZbRfeVw66Pzvb7mDwTsg/EwJgn2sK0J5gjnu1fdJzbKNAoBoggoYGsSFPwWvAhZ2u+MNzeFdfLuw0pLEedfXyn44nJ5/NqpR747j7yGR8w+256Di7Q3sA4VRm5SYRcJ9JLBT7t8jtUUvvR0eoNocYFiz8d9SBk15nTnD9syCqEfoSliDt+w7H+65aXgKSmcRJNTLE9x+UG2c8Yw4zUAOvjizvTsiCWXZsdf0I4qpXCqQfxiGjo7XTe52Fsd7jg770N6tkJdk1dicZDYPS6HyAli0Le5bPRLfOZfGnKNkqBgOjXAwZi9++9MrRgYKmkEZoeGLf6A6H4eAbI=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(41300700001)(478600001)(110136005)(8676002)(54906003)(4326008)(40460700003)(70586007)(70206006)(7406005)(36756003)(47076005)(82740400003)(316002)(7636003)(36860700001)(83380400001)(7416002)(7366002)(7696005)(40480700001)(26005)(8936002)(426003)(5660300002)(336012)(921005)(2906002)(356005)(16526019)(2616005)(186003)(1076003)(82310400005)(21314003)(83996005)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:23:46.1697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb8e058-cf52-44af-d469-08daa681035e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5343
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
 drivers/block/loop.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ad92192c7d61..a915f25b4410 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1937,6 +1937,8 @@ static const struct blk_mq_ops loop_mq_ops = {
 
 static int loop_add(int i)
 {
+	unsigned int flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING |
+		BLK_MQ_F_NO_SCHED_BY_DEFAULT;
 	struct loop_device *lo;
 	struct gendisk *disk;
 	int err;
@@ -1967,14 +1969,8 @@ static int loop_add(int i)
 		goto out_free_dev;
 	i = err;
 
-	lo->tag_set.ops = &loop_mq_ops;
-	lo->tag_set.nr_hw_queues = 1;
-	lo->tag_set.queue_depth = hw_queue_depth;
-	lo->tag_set.numa_node = NUMA_NO_NODE;
-	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
-	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING |
-		BLK_MQ_F_NO_SCHED_BY_DEFAULT;
-	lo->tag_set.driver_data = lo;
+	blk_mq_init_tag_set(&lo->tag_set, &loop_mq_ops, 1, hw_queue_depth,
+			sizeof(struct loop_cmd), NUMA_NO_NODE, 0, flags, lo);
 
 	err = blk_mq_alloc_tag_set(&lo->tag_set);
 	if (err)
-- 
2.29.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
