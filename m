Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315A9C433F5
	for <virtualization@archiver.kernel.org>; Wed,  5 Oct 2022 03:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DAA4160BEB;
	Wed,  5 Oct 2022 03:27:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DAA4160BEB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Pi3gJ1rL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WVZfG14qVB4O; Wed,  5 Oct 2022 03:27:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 49C6860BD5;
	Wed,  5 Oct 2022 03:27:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 49C6860BD5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3359CC0033;
	Wed,  5 Oct 2022 03:27:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B2C7C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:27:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 596E48277E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:27:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 596E48277E
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=Pi3gJ1rL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J5W2aULvGu_T
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:27:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B22181D73
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2046.outbound.protection.outlook.com [40.107.212.46])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7B22181D73
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUCQ4Xnn4sD2QyrY2Vu5wJroCqd9EU4zgDNbpMr0Mwo7Vze2D/iv0a/VnhfqEoxUdsIPiguIfRI90ZZrX23jx0CjTgu/ViILtfUUERQD02Bbaa7c2KvADedUNADds6QMX84HlMiikoq8hwyQ5tXOA1kO9OVM9+/9Z1RmZvbO05HCTCoNvT1BN1fyy+sU61Vmn7A+qLolciG/LfnSgvAf0+FHWD7JPGdNhTNVmySf0P59kvlexZYPcu1yTAx+nNwb7MNew94/Jix+NQezjFwxbv/uBPPQ2a1oBdojAClKFJoXFaXpX1W9qORWzuKed7TpqFWD36lC2NeNdp5NI+2uGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tb/wwQvNf07yDtPUDm64uX8WlaDt++cz8quN/6R8z6Q=;
 b=TBKRyr1GlHxLinAffXtr6Qtlxx9pY03LFj/D9zpTffzsi3lhz+c5+ZWouNOVa1NAXJYB2CBLT6PoY4uPf4mFLsolpXa/VMkeISLVwvaqXP3Wj/aynRhrTP6jb6iGDNnpKsOKdFLsGm0FkUueXyyvFgJ/FDnmsrtWnevQYqBUDU6B5v0xHAxIo68ajMu/v/UkWt5Wqf0o9e1WuLYRfT9YjE9xOD1TL8TDBjhKNoM24QD86mlhpTFCt4ootcaRUaI/IQS9+JxUHkhJLEeFPOkE1D1tpR130i+9GyFCdY9t5UVGQdvoWqVzxM8cvtcpxQFfZRn2y2QwYZQBBa6epbfP6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tb/wwQvNf07yDtPUDm64uX8WlaDt++cz8quN/6R8z6Q=;
 b=Pi3gJ1rLN1Gv18HTXxXeJ1WFNR0+Yk/lC6W5FGNI49UDqhB0do8TENxR36hbluBiMmjkUnBCxKK7xFTKEf0t5kaAJPgjWNheX6zGJCugBxbvB1Xi41UGRYju4VtFYLWFsEXNrZXKnmVrNqpwc85z/F3OacUdmsVPoPQ6UUL0WI9pZpVjnbUmRAoJBldmb8LKmiWw7Rapeyd4yZL6B1ey6vX9qax/zItoJi5K0s9zg3xiLVDac0Zqv77ICBOgHr57TRT+XfF34kdp9vvxzBIq7VWek36SN8Cv8WkvZaucll5p2hwdcFbltkYvTeTmrTM+sn/ywZc/WeIbRoq6zsqunA==
Received: from BN8PR07CA0018.namprd07.prod.outlook.com (2603:10b6:408:ac::31)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 03:27:40 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::81) by BN8PR07CA0018.outlook.office365.com
 (2603:10b6:408:ac::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Wed, 5 Oct 2022 03:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:27:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:27:27 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:27:24 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-nvme@lists.infradead.org>,
 <linux-s390@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: [RFC PATCH 19/21] nvme-core: use lib tagset init helper for adminq
Date: Tue, 4 Oct 2022 20:22:55 -0700
Message-ID: <20221005032257.80681-20-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221005032257.80681-1-kch@nvidia.com>
References: <20221005032257.80681-1-kch@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: db4832a3-7c98-439d-1e96-08daa6818e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a0B4uVwG6AnIzPBsM6zm98BEgwW+kRuL9A00MlfmYAjd2HFWunBR0YUFWplrJix0G5AM6qYXWfMRn4/jve1yCalT/ZwcZeiE75RCBFHatt7bZbH2kGNgzQ3oxE4Pykp+apDXjeGcnGd2t1bnSVAmMKvVtTdCELq+eD/ia8nP9N/KWHIqF/VTZdyrpVhtoEvDnyQgi9t5O3Ojupo0Y6whGwaY28zB+PMhfCjsqQIKbGFprknHNW4iFvnyr/QMMF3LxLtJybTNUFF0Dea6NYN2YTNnyZwVSbPye+kI6QxFZL+w1ifqFHTwB1yFt+vEEOfinPkvk5Ii1dIo2NsCowSDZ5Q93aALP07RhB8v4tmyMZC7ojFQ2338UxzGh6RvSSi2nORyPgKD/UScIAZc3FcjFJxwAr7Vmg72ge+F8aAjRUKKoJujHOSknsGq3SUtI7mJqiQGYGM2kAz4dIM3P29bsUosNLsm81RhZOZwV/BO6PC31iR+NAJZJlCLe8FxZp84cwrlJlZbBFYKqwT0OgqECRS7Y94vj2vSEErp3Rdoo9Ydpn5Q6fioNehqzJG1oxw7AVH99DkLeHYpTbBLaHbclC/WX04VArPVY56cJ2uEAu1su1jDkN4r3JL6qMJw7cfrdaW4TuPhLZ3kxqJI7kuQC/xeTUNIxnIe3O5YSkZ4hBoQWiEn40gjBjT6QTAP2sqegZm7e5vZQFXGdjDYMQdITGLtJ+7uc6kL872DjNP1CWHAkdbjEqNdL1vPBO003/T/4D0HC8nOhy8Y/DF8htwj1zOLyTKSDoF4+R3+m3ZikvMsf8Tzy93e41hxLI4EzVKrrehO3wFKfQ+zmUDa/MCtnedsck9x84j07oG1AuO2NhY=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199015)(40470700004)(36840700001)(46966006)(8936002)(1076003)(7366002)(7406005)(7416002)(5660300002)(82310400005)(336012)(83380400001)(426003)(2616005)(186003)(16526019)(47076005)(40480700001)(4326008)(8676002)(6666004)(26005)(36756003)(7696005)(70206006)(36860700001)(41300700001)(70586007)(478600001)(7636003)(921005)(356005)(40460700003)(82740400003)(54906003)(316002)(2906002)(110136005)(21314003)(83996005)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:27:39.4243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db4832a3-7c98-439d-1e96-08daa6818e5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196
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
 drivers/nvme/host/core.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 639767759c41..69789c2c1ba1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4814,16 +4814,10 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	int ret;
 
 	memset(set, 0, sizeof(*set));
-	set->ops = ops;
-	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
 	if (ctrl->ops->flags & NVME_F_FABRICS)
 		set->reserved_tags = NVMF_RESERVED_TAGS;
-	set->numa_node = ctrl->numa_node;
-	set->flags = flags;
-	set->cmd_size = cmd_size;
-	set->driver_data = ctrl;
-	set->nr_hw_queues = 1;
-	set->timeout = NVME_ADMIN_TIMEOUT;
+	blk_mq_init_tag_set(set, ops, 1, NVME_AQ_MQ_TAG_DEPTH, cmd_size,
+			ctrl->numa_node, NVME_ADMIN_TIMEOUT, flags, ctrl);
 	ret = blk_mq_alloc_tag_set(set);
 	if (ret)
 		return ret;
-- 
2.29.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
