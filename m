Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B733C4332F
	for <virtualization@archiver.kernel.org>; Wed,  5 Oct 2022 03:25:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A43C74157B;
	Wed,  5 Oct 2022 03:25:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A43C74157B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JdicFUG8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V_KIxzGCv86G; Wed,  5 Oct 2022 03:25:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ED14F415FE;
	Wed,  5 Oct 2022 03:25:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED14F415FE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C74BAC0033;
	Wed,  5 Oct 2022 03:25:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F5C6C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:25:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0FA0F81B3E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:25:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0FA0F81B3E
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=JdicFUG8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aPHcgm3wEIt6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:25:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E53C81B10
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4E53C81B10
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:25:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsP9CuxPJtR/q9XS5KKaJXEvOi6BADmwLOjAlReHkmXHF63nglaj+3k4CMTARb7SPRbyiyxueGw6a+HTI3eC/0kNJc09JDk2GMJvYtUFsJe0/0J/X3nvJtFWM582oMOBrqMqv4XQFZZ2wEcRQLTXPT3cMdNQXd3n2MParjE8XEREjt5H+OZ2SR1k/2pDFuwqloUKz1XcwVXUq2r9T0k/M0oEOL6YaFcpf2Mgr7PDiekplDY5OQcPlwlYU+H3lwxYlK6OviWOXUjn5+BCwi7njRrx1ElnNnDsdCoeOwrjRB/p/fabLhfnBO0gfNKVh/r8OaDA1YKnwnqbB0eucqyecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwJoYyzzFtLJ6RYN8jm17eFSPpNKKb7Ir3gvcoHky7s=;
 b=I/elbQjDx9Hs+tsKJ50X7fdP0RdAlKW6n6rYJCyrSRaN1j2C9bGo2xLLiKmfAgqi/grAqNuqhRzk9WvoolEvwLQ7wNrRWmi+x0NFkJA9SEvEvDW6BpwWB3MUyiSneiJxPfiy5GR2MSVUZkZ6ioDExsXIz4s76IW1g1yPy6MxMbKvTsswl0tz0FIHtuXMu0215dBaefSue93kaFAQRPtWOmodZfmxE4ECzqrz8O118khaAI1AHi+W4U6bdeCdi3Ted8efjEVN3N5M411wvMh4b1WpC4Cl83C1pSAlU2AuLMZh9qz5lbSh90vF/oyqInSBoBpN0az8LTEGFjr54UxLUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwJoYyzzFtLJ6RYN8jm17eFSPpNKKb7Ir3gvcoHky7s=;
 b=JdicFUG8fzc8JW0qLJGYk2kcaMIlzPVt022pzB6MEtPRTX6X8T0xHzyTON4HeIoArTZEnvfFo87s+KCjXtg7sOsCQPBoYwYuFzmG4k/rvFtd5LHMWQSievHUejUWr5VJqN2sA1jVv+WOSJJR6AUsupRC4KINf3yG00mLBp9syazP0zj3IDGEvy/yMT4NzEgWPcH/W/y0cPGLAs3O6ocbXLYemRUj3BSmBMEKlzkjUelsOxT4/xt41bw6GYAtbojbk0Ve5rWNakUx+LiAlsCm682Y+x6FIfd5SbQf3/XKKCVLYoEJ1U3+2cGa9vjCVjmlyiY+WDfEmxQYHTgao/XEFg==
Received: from DM5PR07CA0077.namprd07.prod.outlook.com (2603:10b6:4:ad::42) by
 CH3PR12MB7689.namprd12.prod.outlook.com (2603:10b6:610:14d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 5 Oct
 2022 03:25:29 +0000
Received: from DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::6a) by DM5PR07CA0077.outlook.office365.com
 (2603:10b6:4:ad::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Wed, 5 Oct 2022 03:25:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT100.mail.protection.outlook.com (10.13.172.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:25:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:25:26 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:25:23 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-nvme@lists.infradead.org>,
 <linux-s390@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: [RFC PATCH 10/21] amiflop: use lib tagset init helper
Date: Tue, 4 Oct 2022 20:22:46 -0700
Message-ID: <20221005032257.80681-11-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221005032257.80681-1-kch@nvidia.com>
References: <20221005032257.80681-1-kch@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT100:EE_|CH3PR12MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: b706260a-84d9-4945-0731-08daa68140d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qaLD80h+r+AI/5ufb/enJLpaqCCOh4b3Rak4Zo+0qBI4SfshnOJHnnYCHodzIeaE+KkAoMJHzFkZ7lFTUHjq33FL00Rw2VtMqJGiqn9eZq8YPPi5wDr6IADXjmPabyL50hN4jJwYK4f1IiH9bJAcPHvcAvonFinGIOBuubttRsERKQC7biX2nVTUeXpD9UlXelMM1wbbGkjEJs9X7qhS79acHxZpFu11eyiZa+RPNs21l2wejLpyOe9E/RMUj3/c7XdgXVpfVuz6TPtqhfS4BvBgKlHkE7tO5a02jF529MJ8UfqAMCKCoBH69ovSJlYlJCQ4dt7GdNDK6Vyc3OZEcHeceVg1kWrukYe8UaWR1urHd9gXiWyOLt3qjxKOacr7R+lyInSm0SUT9ULGnX3d+HLJYhaOeOQsY32XE6pm77a9EOC2M/DAhYh8HB42h1/Tko/WSrxwzP04v8RmE5mEl1oYxyLM3JSo2hAZnrkVV3VRX7b60t6Y5QTiZd3peFDm0kw4Whnt1h7BzDRLgNDXN1xDAArqEE6R9Zo8+ibnygb4Yd79WZsi9wxLPred57ejxexCx8ZvzU5ibd1UyHAh10GOsvAUz2+ZfZqdSEwQzsq4UrJAgQeJQCWiWuoaXmYuK192Bp5rLpTX9lxO0VLLilOSINaef/CIItHwUlxCd1yga0VhixPrv7b+nzN4+7HLotZIRcDWudMtsywafqAHKPM1yKaMQ7SP4BD/eWvywpAeYQ4EPhlp+MniyeOd/tzyAUyRsOe4wCtL9eYLT2gO+iCISW3ZS2djqr/CWEbivtM3B3E9/YE948bA41tULWwyxMFNjyFFt+cUUHpwvk/QKBaFY+tw3o/0kAT3U3Nwi80=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199015)(46966006)(36840700001)(40470700004)(83380400001)(4326008)(7696005)(186003)(6666004)(82310400005)(1076003)(478600001)(8936002)(110136005)(16526019)(54906003)(70586007)(7406005)(336012)(47076005)(426003)(2616005)(36756003)(26005)(70206006)(2906002)(7636003)(41300700001)(36860700001)(356005)(7416002)(40460700003)(8676002)(316002)(5660300002)(7366002)(40480700001)(82740400003)(921005)(21314003)(2101003)(83996005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:25:29.3504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b706260a-84d9-4945-0731-08daa68140d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7689
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
 drivers/block/amiflop.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 4c8b2ba579ee..af3f9a4b46ab 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1813,12 +1813,10 @@ static int fd_alloc_drive(int drive)
 		goto out;
 
 	memset(&unit[drive].tag_set, 0, sizeof(unit[drive].tag_set));
-	unit[drive].tag_set.ops = &amiflop_mq_ops;
-	unit[drive].tag_set.nr_hw_queues = 1;
+	blk_mq_init_tag_set(&unit[drive].tag_set, &amiflop_mq_ops, 1, 2, 0,
+			NUMA_NO_NODE, 0, BLK_MQ_F_SHOULD_MERGE, NULL);
 	unit[drive].tag_set.nr_maps = 1;
-	unit[drive].tag_set.queue_depth = 2;
-	unit[drive].tag_set.numa_node = NUMA_NO_NODE;
-	unit[drive].tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+
 	if (blk_mq_alloc_tag_set(&unit[drive].tag_set))
 		goto out_cleanup_trackbuf;
 
-- 
2.29.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
